local M = {}

local BBT_URL = "http://localhost:23119/better-bibtex/json-rpc"

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Zotero / BBT" })
end

local function rpc(method, params)
  local payload = vim.json.encode({
    jsonrpc = "2.0",
    id = 1,
    method = method,
    params = params,
  })

  local cmd = {
    "curl",
    "-sS",
    "-X",
    "POST",
    BBT_URL,
    "-H",
    "Content-Type: application/json",
    "-H",
    "Accept: application/json",
    "--data-binary",
    payload,
  }

  local out = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    out = (out or ""):gsub("%s+$", "")
    return nil, ("BBT JSON-RPC nicht erreichbar. Läuft Zotero mit Better BibTeX? %s"):format(out)
  end

  local ok, decoded = pcall(vim.json.decode, out)
  if not ok or type(decoded) ~= "table" then
    return nil, "Ungültige JSON-Antwort von Better BibTeX"
  end

  if decoded.error then
    return nil, decoded.error.message or "JSON-RPC-Fehler"
  end

  return decoded.result, nil
end

local function is_key_char(ch)
  return ch ~= "" and not ch:match("[%s,%{%}%[%]%(%)<>]")
end

local function get_citekey_under_cursor()
  local line = vim.api.nvim_get_current_line()
  if line == "" then
    return nil
  end

  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  col = math.max(1, math.min(col, #line))

  if not is_key_char(line:sub(col, col)) then
    if col > 1 and is_key_char(line:sub(col - 1, col - 1)) then
      col = col - 1
    else
      return nil
    end
  end

  local s, e = col, col
  while s > 1 and is_key_char(line:sub(s - 1, s - 1)) do
    s = s - 1
  end
  while e < #line and is_key_char(line:sub(e + 1, e + 1)) do
    e = e + 1
  end

  local key = line:sub(s, e):gsub("^%s+", ""):gsub("%s+$", "")
  if key == "" then
    return nil
  end

  return key
end

local function open_uri(uri)
  if vim.ui and vim.ui.open then
    vim.ui.open(uri)
    return true
  end

  local opener = nil
  if vim.fn.executable("xdg-open") == 1 then
    opener = "xdg-open"
  elseif vim.fn.executable("open") == 1 then
    opener = "open"
  end

  if not opener then
    return false
  end

  vim.fn.jobstart({ opener, uri }, { detach = true })
  return true
end

function M.open_pdf_for_citekey_under_cursor()
  local citekey = get_citekey_under_cursor()
  if not citekey then
    notify("Kein Citekey unter dem Cursor gefunden", vim.log.levels.WARN)
    return
  end

  local attachments, err = rpc("item.attachments", { citekey, "*" })
  if err then
    notify(err, vim.log.levels.ERROR)
    return
  end

  if type(attachments) ~= "table" or vim.tbl_isempty(attachments) then
    notify(("Keine Attachments für '%s' gefunden"):format(citekey), vim.log.levels.WARN)
    return
  end

  local uri = nil
  for _, att in ipairs(attachments) do
    if type(att) == "table" and type(att.open) == "string" and att.open ~= "" then
      uri = att.open
      break
    end
  end

  if not uri then
    notify(("Kein öffnbarer PDF-Link für '%s' gefunden"):format(citekey), vim.log.levels.WARN)
    return
  end

  if not open_uri(uri) then
    notify("Konnte keinen System-Opener finden (xdg-open/open)", vim.log.levels.ERROR)
    return
  end

  notify(("Öffne PDF in Zotero: %s"):format(citekey))
end

vim.keymap.set("n", "<leader>co", M.open_pdf_for_citekey_under_cursor, {
  desc = "Open Zotero PDF for citekey under cursor",
  silent = true,
})

return M
