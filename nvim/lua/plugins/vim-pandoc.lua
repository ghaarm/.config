-- https://github.com/vim-pandoc/vim-pandoc/blob/master/README.mkd
return {
  "vim-pandoc/vim-pandoc",
  config = function()
    -- globale Default-Marge (kann später pro Datei via YAML überschrieben werden)
    vim.g.pandoc_pdf_margin = "top=3.5cm,bottom=3.5cm,left=2.5cm,right=2.5cm"
    --
    -- Automatische Erkennung von pandoc Dateien aktivieren
    vim.g["pandoc#filetypes#pandoc_markdown"] = 1
    -- Verwende pandoc als Compiler
    vim.g["pandoc#modules#enabled"] = { "formatting", "folding", "completion" }
    -- Konfiguration des PDF-Exports über LaTeX
    vim.g["pandoc#command#latex_engine"] = "xelatex"

    -- Optional: Standard-Margin global setzen (kannst du auch weglassen)
    -- z.B. in deinem init.lua: vim.g.pandoc_pdf_margin = "top=2cm,bottom=2cm,left=1.5cm,right=1.5cm"

    -- ======================
    -- Neuer Command: MdToPdf mit relativen Pfaden - funktioniert
    -- ======================
    vim.api.nvim_create_user_command('MdToPdf', function()
      -- 1) Pfad der aktuellen Datei
      local file = vim.api.nvim_buf_get_name(0)
      if file == '' then
        print('❌ Fehler: Buffer ist nicht in einer Datei gespeichert!')
        return
      end

      -- 2) Änderungen speichern
      vim.cmd('write')

      -- 3) Verzeichnis und Basisname extrahieren
      local dir            = vim.fn.fnamemodify(file, ':h')
      local basename       = vim.fn.fnamemodify(file, ':r')
      local date_str       = os.date("%Y-%m-%d")
      local dated_basename = basename .. "-" .. date_str
      local engine         = vim.g["pandoc#command#latex_engine"] or 'xelatex'

      -- Debug: zeige, wo Pandoc später sucht
      print('📁 Arbeitsverzeichnis: ' .. dir)
      print('🔍 Resource-Path: ' .. dir)


      local margin = vim.g.pandoc_pdf_margin or "top=3.5cm,bottom=3.5cm,left=2.5cm,right=2.5cm"
      -- 4) Pandoc-Kommando mit resource-path und datiertem Ausgabename
      local cmd = {
        'pandoc',
        file,
        '-o', dated_basename .. '.pdf',
        '--pdf-engine=' .. engine,
        '--resource-path=' .. dir,
        '-V', 'geometry:' .. margin, -- <<— kleinere Ränder
        '--verbose'
      }

      -- 5) Job starten
      vim.fn.jobstart(cmd, {
        cwd = dir,
        stdout_buffered = true,
        on_stdout = function(_, data)
          for _, line in ipairs(data) do print(line) end
        end,
        on_stderr = function(_, data)
          for _, line in ipairs(data) do print(line) end
        end,
        on_exit = function(_, code)
          if code == 0 then
            print('✅ PDF erstellt: ' .. dir .. '/' .. dated_basename .. '.pdf')
          else
            print('❌ Pandoc-Exit-Code: ' .. code)
          end
        end,
      })
    end, {
      desc = 'Convert current Markdown to PDF with pandoc (inkl. Bilder)',
    })

    -- Shortcut für Markdown-Buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "pandoc" },
      callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>p', ':MdToPdf<CR>', { noremap = true, silent = true })
      end
    })
  end
}
