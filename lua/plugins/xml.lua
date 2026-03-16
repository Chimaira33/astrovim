local pattern = "line (%d+) column (%d+) %- (%a+): (.+)"
local groups = { "lnum", "col", "severity", "message" }
local severities = {
  Access = vim.diagnostic.severity.INFO,
  Config = vim.diagnostic.severity.ERROR,
  Document = vim.diagnostic.severity.ERROR,
  Error = vim.diagnostic.severity.ERROR,
  Footnote = vim.diagnostic.severity.INFO,
  Info = vim.diagnostic.severity.INFO,
  Information = vim.diagnostic.severity.INFO,
  Panic = vim.diagnostic.severity.ERROR,
  Summary = vim.diagnostic.severity.INFO,
  Warning = vim.diagnostic.severity.WARN,
}
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "xml", "html" })
      end
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     --stylua: ignore
  --     if not opts.sources then opts.sources = {} end
  --     opts.sources = vim.list_extend(opts.sources, {
  --       nls.builtins.diagnostics.tidy,
  --       -- nls.builtins.formatting.xmllint,
  --     })
  --   end,
  -- },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        gjb_tidy = {
          cmd = "tidy",
          stdin = true,
          stream = "stderr",
          ignore_exitcode = true,
          args = {
            "-quiet",
            "-errors",
            "-language",
            "en",
            "-utf8",
            "--gnu-emacs",
            "yes",
            "--tab-size",
            "2",
            "-xml",
          },
          parser = require("lint.parser").from_pattern(pattern, groups, severities, { ["source"] = "tidy" }),
        },
      },
      linters_by_ft = { xml = { "gjb_tidy" } },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters = {
        gjb_xmlformatter = {
          command = "xmlformat",
          args = {
            "--indent=2",
            "--preserve-attributes",
            "--outencoding=UTF-8",
            "--selfclose",
            "-",
          },
        },
      },
      formatters_by_ft = { xml = { "gjb_xmlformatter" } },
    },
  },
}
