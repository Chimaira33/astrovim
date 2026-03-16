---@diagnostic disable: unused-local
local types = table.concat({ vim.fn.stdpath("config") .. "/types" })

---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  -- opts_extend = { "library" },
  opts = {
    library = {
      { path = types },
      { path = "neoconf.nvim" },
      { path = "tokyonight.nvim" },
    },
  },
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = function(_, opts)
        opts.sources.default = require("astrocore").extend_tbl(opts.sources.default or {}, {
          "lsp",
          "path",
          "snippets",
          "buffer",
        })
      end,
    },
  },
}
