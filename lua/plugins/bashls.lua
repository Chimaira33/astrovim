return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "bashls" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = { shfmt = { prepend_args = { "-i=2", "-s", "-ci", "-bn" } } },
      formatters_by_ft = { sh = { "shfmt", "shellcheck" } },
    },
  },
  -- { "mfussenegger/nvim-lint", optional = true, opts = { linters_by_ft = { sh = { "shellcheck" } } } },
  {
    "nvimtools/none-ls.nvim",
    -- dependencies = { "gbprod/none-ls-shellcheck.nvim" },
    opts = function()
      local nls = require("null-ls")
      nls.register(require("user.shellcheck"))
    end,
  },
}
