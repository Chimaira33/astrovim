return {
  "folke/trouble.nvim",
  event = "User AstroFile",
  cmd = "Trouble",
  opts = {
    auto_open = false,
    auto_close = true,
    padding = false,
    height = 10,
    use_diagnostic_signs = true,
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["zd"] = "<Cmd>TroubleToggle<CR>",
        },
      },
    },
  },
}
