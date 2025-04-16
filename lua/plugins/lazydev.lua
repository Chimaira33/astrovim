---@diagnostic disable: unused-local
local types = table.concat({ vim.fn.stdpath("config") .. "/types" })

return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = function(_, opts)
    opts.library = require("astrocore").extend_tbl(opts.library or {}, {
      "lazy.nvim",
      types,
      "neoconf.nvim",
      "nvim-cmp",
      "tokyonight.nvim",
    })
  end,
}
