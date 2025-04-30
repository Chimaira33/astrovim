---@diagnostic disable: missing-fields
return {
  {
    "AstroNvim/astrolsp",
    opts_extend = { "config", "servers" },
    ---@class AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "bashls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ---@type lspconfig.options.bashls
        bashls = {
          filetypes = { "bash", "sh" },
          ---@type _.lspconfig.settings.bashls.BashIde
          settings = {
            ---@type _.lspconfig.settings.bashls.BashIde
            ["bashIde"] = {
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
      formatters = { shfmt = { prepend_args = { "-i=2", "-s", "-ci" } } },
      formatters_by_ft = { sh = { "shfmt", "shellcheck" } },
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
