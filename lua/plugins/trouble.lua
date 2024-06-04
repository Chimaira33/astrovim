return {
  {
    "folke/trouble.nvim",
    event = "User AstroFile",
    cmd = "Trouble",
    opts = function()
      local get_icon = require("astroui").get_icon
      local lspkind_avail, lspkind = pcall(require, "lspkind")
      return {
        auto_open = false,
        auto_close = true,
        padding = false,
        height = 10,
        use_diagnostic_signs = true,
        keys = { ["q"] = "close" },
        icons = {
          indent = {
            fold_open = get_icon("FoldOpened"),
            fold_closed = get_icon("FoldClosed"),
          },
          folder_closed = get_icon("FolderClosed"),
          folder_open = get_icon("FolderOpen"),
          kinds = lspkind_avail and lspkind.symbol_map,
        },
      }
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["zd"] = "<Cmd>Trouble diagnostics toggle focus filter.buf=0<CR>",
            },
          },
        },
      },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = { trouble = true } },
}
