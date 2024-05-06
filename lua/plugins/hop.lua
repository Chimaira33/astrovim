return {
  "smoka7/hop.nvim",
  version = "*",
  event = "User AstroFile",
  opts = {},
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-h>"] = "<cmd>HopWord<cr>",
          ["<C-l>"] = "<cmd>HopLineStart<cr>",
          ["<C-p>"] = "<cmd>HopPattern<cr>",
        },
      },
    },
  },
}
