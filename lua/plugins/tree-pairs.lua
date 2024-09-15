require("user.tree-pairs")
---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
      n = {
        ["<A-q>"] = "v<Cmd>lua require('user.tree-pairs').match()<CR><Plug>(nvim-surround-visual)q",
        ["<A-a>"] = "v<Cmd>lua require('user.tree-pairs').match()<CR><Plug>(nvim-surround-visual)a",
        ["<A-[>"] = "v<Cmd>lua require('user.tree-pairs').match()<CR><Plug>(nvim-surround-visual)B",
        ["<A-b>"] = "v<Cmd>lua require('user.tree-pairs').match()<CR><Plug>(nvim-surround-visual)b",
        ["<A-p>"] = "v<Cmd>lua require('user.tree-pairs').match()<CR><Plug>(nvim-surround-visual)p",
      },
    })
  end,
}

-- return {
--   "yorickpeterse/nvim-tree-pairs",
--   event = "User AstroFile",
--   dependencies = { "nvim-treesitter/nvim-treesitter" },
--   config = true,
-- }
