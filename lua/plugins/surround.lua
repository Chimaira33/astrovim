return {
  "kylechui/nvim-surround",
  version = "*",
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        v = {
          ["z["] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>b",
          ["za"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>a",
          ["zb"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>B",
          ["zp"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>p",
          ["zq"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>q",
        },
      },
    },
  },
  opts = {
    keymaps = {
      normal = "zs",
      normal_line = "zS",
      visual = "S",
      visual_line = "gS",
      delete = "DU",
      change = "cs",
    },
    aliases = {
      ["B"] = "}",
      ["a"] = "'",
      ["b"] = "]",
      ["p"] = ")",
      ["q"] = '"',
    },
  },
}
