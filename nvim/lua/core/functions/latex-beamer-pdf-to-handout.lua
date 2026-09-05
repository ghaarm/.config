local function build_beamer_handout()
  local texfile = vim.api.nvim_buf_get_name(0)

  if texfile == "" then
    vim.notify("Aktueller Buffer hat keinen Dateinamen", vim.log.levels.ERROR)
    return
  end

  if not texfile:match("%.tex$") then
    vim.notify("Aktuelle Datei ist keine .tex-Datei: " .. texfile, vim.log.levels.WARN)
    return
  end

  if vim.fn.filereadable(texfile) ~= 1 then
    vim.notify("Datei ist nicht lesbar: " .. texfile, vim.log.levels.ERROR)
    return
  end

  local texfilename = vim.fn.fnamemodify(texfile, ":t")

  ---------------------------------------------------------------------------
  -- Prüfen, ob es ein Beamer-Dokument ist
  ---------------------------------------------------------------------------

  local file = io.open(texfile, "r")

  if not file then
    vim.notify("Datei konnte nicht geöffnet werden", vim.log.levels.ERROR)
    return
  end

  local is_beamer = false

  for line in file:lines() do
    if line:match("\\documentclass%s*%b[]%s*{beamer}") or line:match("\\documentclass%s*{beamer}") then
      is_beamer = true
      break
    end
  end

  file:close()

  if not is_beamer then
    vim.notify("Aktuelle Datei ist kein Beamer-Dokument", vim.log.levels.WARN)
    return
  end

  ---------------------------------------------------------------------------
  -- Datei speichern
  ---------------------------------------------------------------------------

  vim.cmd("write")

  local dir = vim.fn.fnamemodify(texfile, ":h")
  local basename = vim.fn.fnamemodify(texfile, ":t:r")

  local date = os.date("%Y-%m-%d")
  local handout_name = basename .. "-handout-" .. date

  local handout_pdf = dir .. "/" .. handout_name .. ".pdf"

  local handout_synctex = dir .. "/" .. handout_name .. ".synctex.gz"

  ---------------------------------------------------------------------------
  -- Sioyek / SyncTeX
  ---------------------------------------------------------------------------

  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  local nvim = vim.v.progpath

  local inverse_search = '"' .. nvim .. '" --headless -c "VimtexInverseSearch %2 \'%1\'"'

  ---------------------------------------------------------------------------
  -- latexmk
  ---------------------------------------------------------------------------

  local cmd = {
    "latexmk",
    "-xelatex",
    "-interaction=nonstopmode",
    "-file-line-error",
    "-synctex=1",

    -- Hauptoutputs (.pdf, .synctex.gz) bleiben beim .tex-File
    "-outdir=.",

    -- Hilfsdateien nach ./auxiliary_files/
    "-auxdir=auxiliary_files",

    -- Bei TeX Live getrenntes auxdir korrekt emulieren
    "-emulate-aux-dir",

    "-jobname=" .. handout_name,

    "-usepretex=\\PassOptionsToClass{handout}{beamer}",

    texfilename,
  }

  vim.notify("Kompiliere Handout: " .. handout_name .. ".pdf")

  local output = {}

  vim.fn.jobstart(cmd, {
    cwd = dir,

    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,

    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,

    on_exit = function(_, code)
      vim.schedule(function()
        ---------------------------------------------------------------------
        -- Erfolgreich
        ---------------------------------------------------------------------

        if code == 0 then
          vim.notify("Handout erstellt: " .. handout_name .. ".pdf", vim.log.levels.INFO)

          -- Prüfen, ob SyncTeX wirklich erzeugt wurde
          if vim.fn.filereadable(handout_synctex) ~= 1 then
            vim.notify("Achtung: keine SyncTeX-Datei gefunden:\n" .. handout_synctex, vim.log.levels.WARN)
          end

          -------------------------------------------------------------------
          -- Sioyek öffnen
          -------------------------------------------------------------------

          vim.fn.jobstart({
            "sioyek",

            "--inverse-search",
            inverse_search,

            "--forward-search-file",
            texfile,

            "--forward-search-line",
            tostring(current_line),

            handout_pdf,
          }, {
            detach = true,
          })

          return
        end

        ---------------------------------------------------------------------
        -- Fehler
        ---------------------------------------------------------------------

        vim.notify("Handout-Kompilierung fehlgeschlagen", vim.log.levels.ERROR)

        vim.cmd("new")

        local buf = vim.api.nvim_get_current_buf()

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].swapfile = false
        vim.bo[buf].modifiable = false

        vim.api.nvim_buf_set_name(buf, "Beamer Handout Build")
      end)
    end,
  })
end

vim.keymap.set("n", "<localleader>bh", build_beamer_handout, {
  desc = "Build Beamer handout",
})
