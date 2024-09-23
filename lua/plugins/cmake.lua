return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "neocmake" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- formatters = { gersemi = { prepend_args = { "--indent", "2", "--line-length", "80" } } },
      formatters_by_ft = { cmake = { "gersemi" } },
    },
  },
}
