---@diagnostic disable: missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "bashls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ---@class lspconfig.options.bashls
        bashls = {
          filetypes = { "bash", "sh" },
          ---@class _.lspconfig.settings.bashls.BashIde
          settings = {
            ---@class _.lspconfig.settings.bashls.BashIde
            bashIde = {
              backgroundAnalysisMaxFiles = 0,
              enableSourceErrorDiagnostics = false,
              logLevel = "debug",
              includeAllWorkspaceSymbols = false,
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        shfmt = { prepend_args = { "-i=2", "-s", "-ci" } },
        gb_beautysh = {
          command = "beautysh",
          args = {
            "--indent-size=2",
            "--force-function-style=paronly",
            "-",
          },
        },
      },
      formatters_by_ft = {
        bash = { "gb_beautysh", "shfmt", "shellcheck" },
        sh = { "gb_beautysh", "shfmt", "shellcheck" },
      },
    },
  },
  -- { "mfussenegger/nvim-lint", optional = true, opts = { linters_by_ft = { sh = { "shellcheck" } } } },
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      nls.register(require("user.shellcheck"))
    end,
  },
}
