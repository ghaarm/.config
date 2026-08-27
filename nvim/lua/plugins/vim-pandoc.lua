-- https://github.com/vim-pandoc/vim-pandoc/blob/master/README.mkd

return {
  "vim-pandoc/vim-pandoc",

  config = function()
    -- Globale Default-Marge
    vim.g.pandoc_pdf_margin = "top=3.5cm,bottom=3.5cm,left=2.5cm,right=2.5cm"

    -- Automatische Erkennung von Pandoc-Markdown
    vim.g["pandoc#filetypes#pandoc_markdown"] = 1

    -- Pandoc-Module
    vim.g["pandoc#modules#enabled"] = {
      "formatting",
      "folding",
      "completion",
    }

    -- PDF-Engine
    vim.g["pandoc#command#latex_engine"] = "xelatex"

    -- Wordvorlagen für docx export mit ui-select
    local word_template_dir =
      "/Users/g/Library/Mobile Documents/com~apple~CloudDocs/!Docs iCloud/pandoc-icloud-vorlagen"

    local word_templates = {
      {
        name = "Calibri 11",
        path = word_template_dir .. "/reference-calibri-11.docx",
      },
      {
        name = "Helvetica 11",
        path = word_template_dir .. "/reference-helvetica-11.docx",
      },
      {
        name = "Times 11",
        path = word_template_dir .. "/reference-times-11.docx",
      },
    }
    -- ======================
    -- Markdown -> PDF
    -- ======================
    vim.api.nvim_create_user_command("MdToPdf", function()
      -- 1) Aktuelle Datei
      local file = vim.api.nvim_buf_get_name(0)

      if file == "" then
        vim.notify("Buffer ist nicht in einer Datei gespeichert!", vim.log.levels.ERROR)
        return
      end

      -- 2) Änderungen speichern
      vim.cmd("write")

      -- 3) Pfade / Dateinamen
      local dir = vim.fn.fnamemodify(file, ":h")
      local stem = vim.fn.fnamemodify(file, ":t:r")
      local date_str = os.date("%Y-%m-%d")

      local output = stem .. "-" .. date_str .. ".pdf"
      local pdf = dir .. "/" .. output

      local engine = vim.g["pandoc#command#latex_engine"] or "xelatex"

      local margin = vim.g.pandoc_pdf_margin or "top=3.5cm,bottom=3.5cm,left=2.5cm,right=2.5cm"

      print("📁 Arbeitsverzeichnis: " .. dir)
      print("🔍 Resource-Path: " .. dir)

      -- 4) Pandoc-Kommando
      local cmd = {
        "pandoc",
        file,

        "-o",
        output,

        "--standalone",
        "--citeproc",

        "--pdf-engine=" .. engine,
        "--resource-path=" .. dir,

        "-V",
        "geometry:" .. margin,

        -- "--verbose", -- sonst wegen stderr sehr viele fehlermeldungen
      }
      -- 5) Pandoc starten

      print("📄 Ausgabe: " .. pdf)

      local stderr_lines = {}

      vim.fn.jobstart(cmd, {
        cwd = dir,
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
          for _, line in ipairs(data) do
            if line ~= "" then
              print(line)
            end
          end
        end,

        on_stderr = function(_, data)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(stderr_lines, line)
            end
          end
        end,

        on_exit = function(_, code)
          if code == 0 then
            vim.notify("PDF erstellt: " .. pdf, vim.log.levels.INFO)

            -- macOS: PDF automatisch öffnen

            vim.fn.jobstart({ "open", pdf }, {

              detach = true,
            })
          else
            vim.notify("Pandoc fehlgeschlagen:\n" .. table.concat(stderr_lines, "\n"), vim.log.levels.ERROR)
          end
        end,
      })
    end, {
      desc = "Convert current Markdown to PDF with pandoc",
    })

    -- ======================
    -- Markdown -> DOCX
    -- ======================
    vim.api.nvim_create_user_command("MdToDocx", function()
      local file = vim.api.nvim_buf_get_name(0)

      if file == "" then
        vim.notify("Buffer ist nicht in einer Datei gespeichert!", vim.log.levels.ERROR)
        return
      end

      vim.cmd("write")

      local dir = vim.fn.fnamemodify(file, ":h")
      local stem = vim.fn.fnamemodify(file, ":t:r")
      local date_str = os.date("%Y-%m-%d")

      local output = stem .. "-" .. date_str .. ".docx"
      local docx = dir .. "/" .. output

      vim.ui.select(word_templates, {
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

        print("📁 Arbeitsverzeichnis: " .. dir)
        print("📄 Ausgabe: " .. docx)
        print("📝 Word-Vorlage: " .. selected.name)

        local cmd = {
          "pandoc",
          file,

          "-o",
          output,

          "--standalone",
          "--citeproc",

          "--reference-doc=" .. selected.path,
          "--resource-path=" .. dir,
        }

        local stderr_lines = {}

        vim.fn.jobstart(cmd, {
          cwd = dir,
          stdout_buffered = true,
          stderr_buffered = true,

          on_stdout = function(_, data)
            for _, line in ipairs(data) do
              if line ~= "" then
                print(line)
              end
            end
          end,

          on_stderr = function(_, data)
            for _, line in ipairs(data) do
              if line ~= "" then
                table.insert(stderr_lines, line)
              end
            end
          end,

          on_exit = function(_, code)
            if code == 0 then
              vim.notify("DOCX erstellt: " .. docx, vim.log.levels.INFO)

              vim.fn.jobstart({ "open", docx }, {
                detach = true,
              })
            else
              vim.notify("Pandoc fehlgeschlagen:\n" .. table.concat(stderr_lines, "\n"), vim.log.levels.ERROR)
            end
          end,
        })
      end)
    end, {
      desc = "Convert current Markdown to DOCX with pandoc",
    })

    -- Shortcut für Markdown/Pandoc
    vim.api.nvim_create_autocmd("FileType", {

      pattern = { "markdown", "pandoc" },

      callback = function()
        vim.keymap.set("n", "<localleader>p", "<cmd>MdToPdf<CR>", {
          buffer = true,
          silent = true,
          desc = "Markdown → PDF",
        })

        vim.keymap.set("n", "<localleader>w", "<cmd>MdToDocx<CR>", {
          buffer = true,
          silent = true,
          desc = "Markdown → DOCX",
        })
      end,
    })
  end,
}
