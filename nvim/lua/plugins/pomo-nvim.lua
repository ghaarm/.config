-- https://github.com/epwalsh/pomo.nvim
--
return {
  "epwalsh/pomo.nvim",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  -- UND zusätzlich beim Drücken der Keys
  keys = {
    { "<leader>p1", "<cmd>TimerSession pomo1<CR>", desc = "Pomo: Session pomo1" },
    { "<leader>p2", "<cmd>TimerSession pomo2<CR>", desc = "Pomo: Session pomo2" },
    { "<leader>p4", "<cmd>TimerSession pomo4<CR>", desc = "Pomo: Session pomo4" },
    { "<leader>p5", "<cmd>TimerSession pomo50<CR>", desc = "Pomo: Session pomo50" },
    { "<leader>pf", "<cmd>TimerShow<CR>", desc = "Pomo: Front (show) Timer" },
    { "<leader>ph", "<cmd>TimerHide<CR>", desc = "Pomo: Hide timer" },
    { "<leader>pp", "<cmd>TimerPause<CR>", desc = "Pomo: Pause timer" },
    { "<leader>ps", "<cmd>TimerStop<CR>", desc = "Pomo: Stop timer" },
    { "<leader>pr", "<cmd>TimerResume<CR>", desc = "Pomo: Stop Resume" },
  },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  opts = {
    -- See below for full list of options 👇
    -- How often the notifiers are updated.
    update_interval = 1000,

    -- Configure the default notifiers to use for each timer.
    -- You can also configure different notifiers for timers given specific names, see
    -- the 'timers' field below.
    notifiers = {
      -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
      {
        name = "Default",
        opts = {
          -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
          -- continuously displayed. If you only want a pop-up notification when the timer starts
          -- and finishes, set this to false.
          sticky = true,

          -- Configure the display icons:
          title_icon = "󱎫",
          text_icon = "󰄉",
          -- Replace the above with these if you don't have a patched font:
          -- title_icon = "⏳",
          -- text_icon = "⏱️",
        },
      },

      -- The "System" notifier sends a system notification when the timer is finished.
      -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
      { name = "System" },

      -- You can also define custom notifiers by providing an "init" function instead of a name.
      -- See "Defining custom notifiers" below for an example 👇
      -- { init = function(timer) ... end }
    },

    -- Override the notifiers for specific timer names.
    timers = {
      -- For example, use only the "System" notifier when you create a timer called "Break",
      -- e.g. ':TimerStart 2m Break'.
      Break = {
        { name = "System" },
      },
    },
    -- You can optionally define custom timer sessions.
    sessions = {
      -- Example session configuration for a session called "pomodoro".
      pomo1 = {
        { name = "Work", duration = "25m" },
      },
      pomo2 = {
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
      },
      pomo4 = {
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Long Break", duration = "15m" },
      },
      pomo50 = {
        { name = "Work", duration = "50m" },
        { name = "Short Break", duration = "10m" },
      },
    },
  },
}
