-- braucht: oil.nvim, fd, telescope.nvim

local M = {}

-- local search_root = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs/!Docs iCloud"
local search_root = "/Users/g/Library/Mobile Documents/com~apple~CloudDocs"

local function to_absolute_dir(path)
  if not path or path == "" then
    return nil
  end

  if path:sub(1, 1) ~= "/" then
    path = vim.fs.joinpath(search_root, path)
  end

  return vim.fs.normalize(path):gsub("/+$", "")
end

local function get_target_dir(selection)
  if not selection then
    return nil
  end

  return to_absolute_dir(selection.path or selection.filename or selection.value or selection[1])
end

function M.go_to_fuzzy_dir()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  builtin.find_files({
    prompt_title = "Oil: Gehe zu Verzeichnis",
    cwd = search_root,
    previewer = false,
    find_command = {
      "fd",
      "--type",
      "d",
      "--exclude",
      ".git",
      "--hidden",
      "--no-ignore",
      "--strip-cwd-prefix",
    },
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local target_dir = get_target_dir(action_state.get_selected_entry())

        if not target_dir then
          vim.notify("Zielverzeichnis konnte nicht ermittelt werden", vim.log.levels.ERROR)
          return
        end

        actions.close(prompt_bufnr)
        vim.cmd.enew()
        require("oil").open(target_dir)
      end)

      return true
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",

  callback = function(args)
    vim.keymap.set("n", "<leader>cp", function()
      M.go_to_fuzzy_dir()
    end, {
      buffer = args.buf,
      desc = "Oil: Go to fuzzy dir",
    })
  end,
})

return M
