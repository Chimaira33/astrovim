return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "neocmake" })
    end,
  },
  { "mfussenegger/nvim-lint", optional = true, opts = { linters_by_ft = { cmake = { "cmakelint" } } } },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- formatters = { gersemi = { prepend_args = { "--indent", "2", "--line-length", "80" } } },
      formatters_by_ft = { cmake = { "gersemi" } },
    },
  },
}
