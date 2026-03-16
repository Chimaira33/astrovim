---@type LazySpec
-- perlnavigator
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "perlnavigator" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = { perl = { "perltidy" } } },
  },
}
