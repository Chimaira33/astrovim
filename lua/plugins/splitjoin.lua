return {
  {
    "Wansmer/treesj",
    event = "BufEnter",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 840,
    },
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["zj"] = "<Cmd>TSJToggle<CR>",
          },
          v = {
            ["<C-j>"] = "<Cmd>'<,'>join<CR>",
          },
        },
      },
    },
  },
}
