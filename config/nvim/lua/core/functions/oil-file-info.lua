local M = {}

local function format_bytes(bytes)
  bytes = tonumber(bytes)

  if not bytes then
    return "?"
  end

  if bytes < 1024 then
    return string.format("%d B", bytes)
  elseif bytes < 1024 * 1024 then
    return string.format("%.1f KB", bytes / 1024)
  elseif bytes < 1024 * 1024 * 1024 then
    return string.format("%.1f MB", bytes / (1024 * 1024))
  else
    return string.format("%.2f GB", bytes / (1024 * 1024 * 1024))
  end
end

local function mdls_value(path, attribute)
  local result = vim
    .system({
      "mdls",
      "-raw",
      "-name",
      attribute,
      path,
    }, {
      text = true,
    })
    :wait()

  if result.code ~= 0 then
    return nil
  end

  local value = vim.trim(result.stdout or "")

  if value == "" or value == "(null)" then
    return nil
  end

  return value
end

local function format_date(value)
  if not value then
    return "–"
  end

  -- mdls:
  -- 2026-09-23 07:42:18 +0000
  local year, month, day, hour, min, sec = value:match("^(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)")

  if not year then
    return value
  end

  return string.format("%s.%s.%s %s:%s:%s", day, month, year, hour, min, sec)
end

function M.show()
  local oil = require("oil")

  local entry = oil.get_cursor_entry()
  local dir = oil.get_current_dir()

  if not entry or not dir then
    vim.notify("Kein Oil-Eintrag unter dem Cursor.", vim.log.levels.WARN)
    return
  end

  local path = vim.fs.normalize(vim.fs.joinpath(dir, entry.name))

  local stat = vim.uv.fs_stat(path)

  if not stat then
    vim.notify("Dateiinformationen konnten nicht gelesen werden.", vim.log.levels.ERROR)
    return
  end

  local kind = entry.type == "directory" and "Ordner" or "Datei"

  local size = entry.type == "directory" and "–" or format_bytes(stat.size)

  -- macOS Spotlight-Metadaten
  local created = mdls_value(path, "kMDItemFSCreationDate")

  local modified = mdls_value(path, "kMDItemFSContentChangeDate")

  local width = mdls_value(path, "kMDItemPixelWidth")

  local height = mdls_value(path, "kMDItemPixelHeight")

  local content_type = mdls_value(path, "kMDItemContentType")

  local dimensions = "–"

  if width and height then
    dimensions = width .. " × " .. height .. " px"
  end

  local lines = {
    entry.name,
    "",
    "Typ:          " .. kind,
    "Größe:        " .. size,
    "Dimensionen:  " .. dimensions,
    "Erstellt:     " .. format_date(created),
    "Geändert:     " .. format_date(modified),
    "Content-Type: " .. (content_type or "–"),
    "",
    "Pfad:",
    path,
  }

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"

  local max_width = 0

  for _, line in ipairs(lines) do
    max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
  end

  local width_win = math.min(math.max(max_width + 2, 50), math.floor(vim.o.columns * 0.8))

  local height_win = #lines

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width_win,
    height = height_win,
    row = math.floor((vim.o.lines - height_win) / 2),
    col = math.floor((vim.o.columns - width_win) / 2),
    style = "minimal",
    border = "rounded",
    title = " Datei-Informationen ",
    title_pos = "center",
  })

  vim.wo[win].wrap = true

  -- q / Esc schließen
  vim.keymap.set("n", "q", "<cmd>close<CR>", {
    buffer = buf,
    silent = true,
  })

  vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", {
    buffer = buf,
    silent = true,
  })
end
-- ---------------------------------------------------------
-- Oil Keymap
-- ---------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {

  pattern = "oil",

  callback = function(args)
    vim.keymap.set("n", "<leader>i", function()
      M.show()
    end, {

      buffer = args.buf,

      silent = true,

      desc = "Oil: Datei-Informationen",
    })
  end,
})
return M
