local marker = "% NVIM_FLOAT_OFF "

local float_envs = {
  figure = true,
  ["figure*"] = true,
  table = true,
  ["table*"] = true,
}

local function is_blank(line)
  return line:match("^%s*$") ~= nil
    or line:match("^%s*%%%s*$") ~= nil
    or line:match("^%s*%% NVIM_FLOAT_OFF %s*%%%s*$") ~= nil
end

local function begin_env(line)
  return line:match("\\begin%s*{%s*([^}]+)%s*}")
end

local function end_env(line)
  return line:match("\\end%s*{%s*([^}]+)%s*}")
end

local function is_multicols_begin(line)
  local env = begin_env(line)
  return env == "multicols" or env == "multicols*"
end

local function is_multicols_end(line)
  local env = end_env(line)
  return env == "multicols" or env == "multicols*"
end

local function add_marker(line)
  if line:find("^%% NVIM_FLOAT_OFF ", 1) then
    return line
  end
  return marker .. line
end

local function remove_marker(line)
  return (line:gsub("^%% NVIM_FLOAT_OFF ", "", 1))
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

local function set_float_comments(comment)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local i = 1
  while i <= #lines do
    local env = begin_env(lines[i])

    if env and float_envs[env] then
      local float_start = i
      local float_end = find_float_end(lines, i, env)

      local block_start = extend_block_up(lines, float_start)
      local block_end = extend_block_down(lines, float_end)

      for k = block_start, block_end do
        if comment then
          lines[k] = add_marker(lines[k])
        else
          lines[k] = remove_marker(lines[k])
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
