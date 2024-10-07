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
            ["<C-h>"] = "<Cmd>HopWord<CR>",
            ["<C-l>"] = "<Cmd>HopLineStart<CR>",
            ["<C-p>"] = "<Cmd>HopPattern<CR>",
          },
        },
      },
    },
  },
}
