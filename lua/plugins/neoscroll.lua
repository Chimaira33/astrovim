---@type LazySpec
return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.mappings = {}
    opts.hide_cursor = true
    opts.stop_eof = true
    opts.respect_scrolloff = true
    opts.cursor_scrolls_alone = true
    opts.duration_multiplier = 0.5
    opts.easing = "linear"
    opts.performance_mode = false
    opts.ignored_events = { "WinScrolled", "CursorMoved" }
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        --stylua: ignore
        mappings = {
          n = {
            ["<C-u>"] = function() require("neoscroll").ctrl_u({ duration = 150 }) end,
            ["<C-d>"] = function() require("neoscroll").ctrl_d({ duration = 150 }) end,
            ["<C-b>"] = function() require("neoscroll").ctrl_b({ duration = 150 }) end,
            ["<C-h>"] = function() require("neoscroll").ctrl_f({ duration = 150 }) end,
          },
          x = {
          ["<C-u>"] = function() require("neoscroll").ctrl_u({ duration = 150 }) end,
          ["<C-d>"] = function() require("neoscroll").ctrl_d({ duration = 150 }) end,
          ["<C-b>"] = function() require("neoscroll").ctrl_b({ duration = 150 }) end,
          ["<C-h>"] = function() require("neoscroll").ctrl_f({ duration = 150 }) end,
          },
        },
      },
    },
  },
}
