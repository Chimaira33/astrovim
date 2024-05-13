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
          ["z["] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>B",
          ["za"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>a",
          ["zb"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>b",
          ["zp"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>p",
          ["zq"] = "<Esc><Cmd>lua require('nvim-surround').visual_surround({ line_mode = false })<CR>q",
        },
      },
    },
  },
  opts = {
    keymaps = {
      normal = "Y",
      normal_line = "zY",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
    aliases = {
      ["b"] = "}",
      ["a"] = "'",
      ["B"] = "]",
      ["p"] = ")",
      ["q"] = '"',
    },
  },
}
