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
      formatters = { shfmt = { prepend_args = { "-i", "2", "-s", "-ci", "-bn" } } },
      formatters_by_ft = { sh = { "shfmt" } },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "gbprod/none-ls-shellcheck.nvim" },
    opts = function()
      local nls = require("null-ls")
      nls.register(require("none-ls-shellcheck.code_actions"))
    end,
  },
}
