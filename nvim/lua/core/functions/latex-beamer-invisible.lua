local M = {}

local function is_commented(line)
  return line:match("^%s*%%") ~= nil
end

local function comment_line(line)
  if is_commented(line) then
    return line
  end

  local indent, rest = line:match("^(%s*)(.*)$")
  return indent .. "% " .. rest
end

local function uncomment_line(line)
  return line:gsub("^(%s*)%%%s?", "%1", 1)
end

local function line_has_invisible(line)
  return line:match("\\setbeamercovered%s*{%s*invisible%s*}") ~= nil
end

local function line_has_transparent(line)
  return line:match("\\setbeamercovered%s*{%s*transparent[^}]*}") ~= nil
end

local function find_beamercovered_lines(lines)
  local found = {
    active_invisible = nil,
    commented_invisible = nil,
    active_transparent = nil,
    commented_transparent = nil,
  }

  for idx, line in ipairs(lines) do
    if line_has_invisible(line) then
      if is_commented(line) then
        found.commented_invisible = found.commented_invisible or idx
      else
        found.active_invisible = found.active_invisible or idx
      end
    elseif line_has_transparent(line) then
      if is_commented(line) then
        found.commented_transparent = found.commented_transparent or idx
      else
        found.active_transparent = found.active_transparent or idx
      end
    end
  end

  return found
end

local function buffer_is_tex()
  local name = vim.api.nvim_buf_get_name(0)
  return vim.bo.filetype == "tex" or name:match("%.tex$") ~= nil
end

function M.toggle_beamercovered()
  if not buffer_is_tex() then
    vim.notify("Aktueller Buffer ist keine TeX-Datei", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local found = find_beamercovered_lines(lines)

  if found.active_invisible then
    lines[found.active_invisible] = comment_line(lines[found.active_invisible])

    if found.commented_transparent then
      lines[found.commented_transparent] = uncomment_line(lines[found.commented_transparent])
    else
      table.insert(lines, found.active_invisible + 1, "\\setbeamercovered{transparent=18}")
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.notify("Beamer covered: transparent=18", vim.log.levels.INFO)
    return
  end

  if found.active_transparent then
    lines[found.active_transparent] = comment_line(lines[found.active_transparent])

    if found.commented_invisible then
      lines[found.commented_invisible] = uncomment_line(lines[found.commented_invisible])
    else
      table.insert(lines, found.active_transparent + 1, "\\setbeamercovered{invisible}")
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.notify("Beamer covered: invisible", vim.log.levels.INFO)
    return
  end

  vim.notify("Keine aktive \\setbeamercovered-Zeile gefunden", vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function(args)
    vim.keymap.set("n", "<localleader>vv", M.toggle_beamercovered, {
      buffer = args.buf,
      desc = "Toggle Beamer covered invisible/transparent",
    })
  end,
})

return M
