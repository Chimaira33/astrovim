return {
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "User AstroFile",
    opts = {},
    specs = {
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
  },
}
