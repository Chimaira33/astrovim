return {
  {
    "Wansmer/treesj",
    event = "BufEnter",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = function(_, opts)
      opts.use_default_keymaps = false
      opts.max_join_length = 840
    end,
    specs = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["zj"] = "<Cmd>TSJToggle<CR>",
          },
        },
      },
    },
  },
}
