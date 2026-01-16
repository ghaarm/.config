-- https://github.com/chentoast/marks.nvim

return {
  "chentoast/marks.nvim",
  config = function()
    require 'marks'.setup {
      default_mappings = false,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      excluded_filetypes = {},
      excluded_buftypes = {},
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        annotate = false,
      },
      mappings = {
        set = "gm",
        set_next = "m,",
        next = "m]",
        preview = "m:",
        delete = "dm",
        set_bookmark0 = "m0",
        prev = false -- pass false to disable only this default mapping
      }
    }
  end
}
