return {
  {
    "kylechui/nvim-surround",
    -- version = "*",
    branch = "main",
    event = "VeryLazy",
    opts = {
      keymaps = { normal_cur = "Y", visual = "S", visual_line = "gS", delete = "ds", change = "cs" },
      aliases = { ["B"] = "]", ["a"] = "'", ["b"] = "}", ["p"] = ")", ["q"] = '"' },
    },
    specs = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          x = {
            ["zB"] = "<Plug>(nvim-surround-visual)B",
            ["za"] = "<Plug>(nvim-surround-visual)a",
            ["zb"] = "<Plug>(nvim-surround-visual)b",
            ["zp"] = "<Plug>(nvim-surround-visual)p",
            ["zq"] = "<Plug>(nvim-surround-visual)q",
          },
        },
      },
    },
  },
}
