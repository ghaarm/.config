local marker = "% LATEX_FLOAT_OFF "

local float_envs = {
  figure = true,
  ["figure*"] = true,
  table = true,
  ["table*"] = true,
}

local function strip_comment_prefix(line)
  local s = line
  s = s:gsub("^%s*%%+%s*LATEX_FLOAT_OFF%s*", "", 1)
  s = s:gsub("^%s*%%%s?", "", 1)
  return s
end

local function is_blank(line)
  local s = strip_comment_prefix(line)
  return s:match("^%s*$") ~= nil
end

local function begin_env(line)
  local s = strip_comment_prefix(line)
  return s:match("\\begin%s*{%s*([^}]+)%s*}")
end

local function end_env(line)
  local s = strip_comment_prefix(line)
  return s:match("\\end%s*{%s*([^}]+)%s*}")
end

local function is_multicols_begin(line)
  local env = begin_env(line)
  return env == "multicols" or env == "multicols*"
end

local function is_multicols_end(line)
  local env = end_env(line)
  return env == "multicols" or env == "multicols*"
end

local function is_captionof_float(line)
  local s = strip_comment_prefix(line)
  return s:match("\\captionof%s*{%s*figure%s*}") or s:match("\\captionof%s*{%s*table%s*}")
end

local function has_caption(line)
  local s = strip_comment_prefix(line)
  return s:match("\\caption%s*{") or s:match("\\captionof%s*{%s*(figure|table)%s*}")
end

local function add_marker(line)
  if line:find("^%s*%%+%s*LATEX_FLOAT_OFF%s*", 1) then
    return line
  end

  local indent, rest = line:match("^(%s*)(.*)$")
  rest = rest or ""
  rest = rest:gsub("^%%+%s?", "", 1)

  return indent .. marker .. rest
end

-- local function remove_marker(line)
--   return (line:gsub("^(%s*)%%+%s*LATEX_FLOAT_OFF%s*", "%1", 1))
-- end
local function uncomment_line(line)
  local indent, rest = line:match("^(%s*)(.*)$")
  if not indent then
    return line
  end

  rest = rest:gsub("^%%+%s*LATEX_FLOAT_OFF%s*", "", 1)
  rest = rest:gsub("^%%+%s?", "", 1)

  return indent .. rest
end
local function find_float_end(lines, start_idx, env_name)
  for i = start_idx, #lines do
    if end_env(lines[i]) == env_name then
      return i
    end
  end
  return start_idx
end

local function extend_block_up(lines, start_idx)
  local j = start_idx - 1
  while j >= 1 and is_blank(lines[j]) do
    j = j - 1
  end
  if j >= 1 and is_multicols_end(lines[j]) then
    return j
  end
  return start_idx
end

local function extend_block_down(lines, end_idx)
  local j = end_idx + 1
  while j <= #lines and is_blank(lines[j]) do
    j = j + 1
  end
  if j <= #lines and is_multicols_begin(lines[j]) then
    return j
  end
  return end_idx
end

local function find_center_block(lines, idx)
  local start_idx = nil
  for i = idx, 1, -1 do
    local s = strip_comment_prefix(lines[i])
    if s:match("\\begin%s*{%s*center%s*}") then
      start_idx = i
      break
    end
    if begin_env(lines[i]) or end_env(lines[i]) then
      break
    end
  end
  if not start_idx then
    return nil
  end

  for j = idx, #lines do
    local s = strip_comment_prefix(lines[j])
    if s:match("\\end%s*{%s*center%s*}") then
      return start_idx, j
    end
  end

  return nil
end

local function find_brace_block(lines, idx)
  local start_idx = nil

  for i = idx, 1, -1 do
    local s = strip_comment_prefix(lines[i])

    if s:match("^%s*{%s*\\centering") or s:match("^%s*{%s*$") then
      start_idx = i
      break
    end

    if begin_env(lines[i]) or end_env(lines[i]) then
      break
    end
  end

  if not start_idx then
    return nil
  end

  local depth = 0
  local started = false

  for j = start_idx, math.min(start_idx + 80, #lines) do
    local s = strip_comment_prefix(lines[j])

    for c in s:gmatch("[{}]") do
      if c == "{" then
        depth = depth + 1
        started = true
      elseif c == "}" then
        depth = depth - 1
      end
    end

    if started and depth == 0 then
      return start_idx, j
    end
  end

  return nil
end

local function set_float_comments(comment)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local i = 1
  while i <= #lines do
    local block_start, block_end

    local env = begin_env(lines[i])
    if env and float_envs[env] then
      local float_start = i
      local float_end = find_float_end(lines, i, env)
      block_start = extend_block_up(lines, float_start)
      block_end = extend_block_down(lines, float_end)
    elseif is_captionof_float(lines[i]) then
      local s1, e1 = find_center_block(lines, i)
      if s1 and e1 then
        block_start = extend_block_up(lines, s1)
        block_end = extend_block_down(lines, e1)
      else
        local s2, e2 = find_brace_block(lines, i)
        if s2 and e2 then
          block_start = extend_block_up(lines, s2)
          block_end = extend_block_down(lines, e2)
        end
      end
    elseif has_caption(lines[i]) then
      local s1, e1 = find_center_block(lines, i)
      if s1 and e1 then
        block_start = extend_block_up(lines, s1)
        block_end = extend_block_down(lines, e1)
      end
    end

    if block_start and block_end then
      for k = block_start, block_end do
        if comment then
          lines[k] = add_marker(lines[k])
        else
          -- lines[k] = remove_marker(lines[k])
          lines[k] = uncomment_line(lines[k])
        end
      end
      i = block_end + 1
    else
      i = i + 1
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

vim.api.nvim_create_user_command("LatexCommentFloats", function()
  set_float_comments(true)
end, {})

vim.api.nvim_create_user_command("LatexUncommentFloats", function()
  set_float_comments(false)
end, {})
