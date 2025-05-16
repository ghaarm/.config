-- https://github.com/vim-pandoc/vim-pandoc/blob/master/README.mkd
return {
  "vim-pandoc/vim-pandoc",
  config = function()
    -- Setze den lokalen Leader-Key auf Komma
    -- vim.g.maplocalleader = ","
    -- Automatische Erkennung von pandoc Dateien aktivieren
    vim.g["pandoc#filetypes#pandoc_markdown"] = 1

    -- Verwende pandoc als Compiler
    vim.g["pandoc#modules#enabled"] = { "formatting", "folding", "completion" }

    -- Konfiguration des PDF-Exports über LaTeX
    vim.g["pandoc#command#latex_engine"] = 'pdflatex' -- oder 'pdflatex', 'lualatex', etc.

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
      local dir      = vim.fn.fnamemodify(file, ':h')
      local basename = vim.fn.fnamemodify(file, ':r')
      local engine   = vim.g["pandoc#command#latex_engine"] or 'xelatex'

      -- Debug: zeige, wo Pandoc später sucht
      print('📁 Arbeitsverzeichnis: ' .. dir)
      print('🔍 Resource-Path: ' .. dir)

      -- 4) Pandoc-Kommando mit resource-path
      local cmd = {
        'pandoc',
        file,
        '-o', basename .. '.pdf',
        '--pdf-engine=' .. engine,
        '--resource-path=' .. dir, -- hier sagst Du Pandoc, alle Bilder in diesem Ordner zu suchen
        '--verbose'                -- extra Ausgaben, um zu sehen, was schiefgeht
      }

      -- 5) Job starten (korrekte Pfad- und Leerzeichen-Behandlung)
      vim.fn.jobstart(cmd, {
        cwd = dir,
        stdout_buffered = true,
        on_stdout = function(_, data)
          for _, line in ipairs(data) do
            print(line)
          end
        end,
        on_stderr = function(_, data)
          for _, line in ipairs(data) do
            print(line)
          end
        end,
        on_exit = function(_, code)
          if code == 0 then
            print('✅ PDF erstellt: ' .. dir .. '/' .. basename .. '.pdf')
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
        vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>p', ':MdToPdf<CR>', {
          noremap = true, silent = true
        })
      end
    })


    -- ======================
    -- Neuer Command: MdToPdf mit absoluten Pfaden - funktioniert auch
    -- ======================

    -- vim.api.nvim_create_user_command('MdToPdf', function()
    --   -- 1) Absolute Quelle
    --   local abs_file = vim.fn.expand('%:p')
    --   if abs_file == '' then
    --     print('❌ Fehler: Buffer ist nicht in einer Datei gespeichert!')
    --     return
    --   end
    --
    --   -- 2) Speichern
    --   vim.cmd('write')
    --
    --   -- 3) Verzeichnis + Name extrahieren
    --   local dir    = vim.fn.fnamemodify(abs_file, ':h')     -- z.B. /Users/foo/projekt
    --   local name   = vim.fn.fnamemodify(abs_file, ':t:r')   -- z.B. materialliste
    --   local engine = vim.g["pandoc#command#latex_engine"] or 'xelatex'
    --   local out    = dir .. '/' .. name .. '.pdf'           -- /Users/.../materialliste.pdf
    --
    --   -- 4) Debug-Ausgabe
    --   print('📄 Quelle:       ' .. abs_file)
    --   print('📂 Output-File: ' .. out)
    --   print('🔍 Resource-Path:' .. dir)
    --
    --   -- 5) Jobstart mit absoluten Pfaden
    --   local cmd = {
    --     'pandoc',
    --       abs_file,
    --     '-o', out,
    --     '--pdf-engine=' .. engine,
    --     '--resource-path=' .. dir,
    --     '--verbose'
    --   }
    --
    --   vim.fn.jobstart(cmd, {
    --     stdout_buffered = true,
    --     stderr_buffered = true,
    --     on_stdout = function(_, data)
    --       for _, l in ipairs(data) do if #l>0 then print(l) end end
    --     end,
    --     on_stderr = function(_, data)
    --       for _, l in ipairs(data) do if #l>0 then print(l) end end
    --     end,
    --     on_exit = function(_, code)
    --       if code == 0 then
    --         print('✅ PDF erstellt: ' .. out)
    --       else
    --         print('❌ Pandoc-Exit-Code: ' .. code)
    --       end
    --     end,
    --   })
    -- end, {
    --   desc = 'Convert current Markdown to PDF with pandoc (inkl. Bilder, absolute Pfade)',
    -- })
  end
}
