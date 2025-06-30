---@type LazySpec
return {
  {
    "Wansmer/treesj",
    event = { "User AstroFile", "BufEnter" },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = {
      use_default_keymaps = false,
      max_join_length = 840,
    },
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
