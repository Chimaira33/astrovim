---@type LazySpec
return {
  {
    "kylechui/nvim-surround",
    -- version = "*",
    branch = "main",
    event = { "User AstroFile" },
    lazy = true,
    opts = {
      -- keymaps = { normal_cur = "Y", visual = "S", visual_line = "gS", delete = "ds", change = "cs" },
      aliases = { ["B"] = "]", ["a"] = "'", ["b"] = "}", ["p"] = ")", ["q"] = '"' },
    },
    specs = {
      "AstroNvim/astrocore",
      opts = {
        options = { g = { nvim_surround_no_normal_mappings = true } },
        mappings = {
          n = {
            ["Yss"] = "<Plug>(nvim-surround-normal-cur)",
            ["S"] = "<Plug>(nvim-surround-visual)",
            ["gS"] = "<Plug>(nvim-surround-visual-line)",
            ["cs"] = "<Plug>(nvim-surround-change)",
            ["ds"] = "<Plug>(nvim-surround-delete)",
          },
          x = {
            ["z["] = "<Plug>(nvim-surround-visual)B",
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
