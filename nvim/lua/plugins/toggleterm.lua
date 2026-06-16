--https://www.reddit.com/r/neovim/comments/116pu76/adding_toggletermnvim_to_lazyvim/

return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader><leader>t]], -- Definiert die Tastenbelegung zum Öffnen des Terminals
      shade_terminals = false,
      -- add --login so ~/.zprofile is loaded
      -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
      shell = "zsh --login",
    })
  end,
  keys = {
    { "<leader><leader>t", desc = "Toggle terminal" }, -- Nutzt dieselbe Tastenbelegung wie open_mapping
    { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
    {
      "<leader>td",
      "<cmd>ToggleTerm size=40 dir=~/Desktop direction=horizontal<cr>",
      desc = "Open a horizontal terminal at the Desktop directory",
    },
  },
}
