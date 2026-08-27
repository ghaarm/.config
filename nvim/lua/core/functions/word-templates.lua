local M = {}

local template_dir = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs/!Docs iCloud/pandoc-icloud-vorlagen"

M.templates = {
  {
    name = "Calibri 11",
    path = template_dir .. "/reference-calibri-11.docx",
  },
  {
    name = "Geist ExtraLight 11",
    path = template_dir .. "/reference-geist-extralight-11.docx",
  },
  {
    name = "Geist Regular 11",
    path = template_dir .. "/reference-geist-regular-11.docx",
  },
  {
    name = "Helvetica 11",
    path = template_dir .. "/reference-helvetica-11.docx",
  },
  {
    name = "Times New Roman 11",
    path = template_dir .. "/reference-times-11.docx",
  },
}

function M.select(callback)
  vim.ui.select(M.templates, {
    prompt = "Word-Vorlage auswählen:",
    format_item = function(item)
      return item.name
    end,
  }, function(selected)
    if not selected then
      vim.notify("DOCX-Export abgebrochen", vim.log.levels.INFO)
      return
    end

    if vim.fn.filereadable(selected.path) ~= 1 then
      vim.notify("Word-Vorlage nicht gefunden:\n" .. selected.path, vim.log.levels.ERROR)
      return
    end

    callback(selected)
  end)
end

return M
