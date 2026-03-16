---@diagnostic disable: missing-fields

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "vtsls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ---@type lspconfig.options.vtsls
        vtsls = {
          settings = {
            typescript = {
              npm = "/data/data/com.termux/files/usr/bin/npm",
              check = { npmIsInstalled = false },
              format = { false },
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              locale = "en",
            },
            javascript = {
              format = { false },
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            vtsls = {
              enableMoveToFileCodeAction = true,
            },
          },
        },
      })
    end,
    specs = {
      { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
      {
        "yioneko/nvim-vtsls",
        lazy = true,
        dependencies = {
          "AstroNvim/astrocore",
          opts = {
            autocmds = {
              nvim_vtsls = {
                {
                  event = "LspAttach",
                  desc = "Load nvim-vtsls with vtsls",
                  callback = function(args)
                    if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
                      require("vtsls")._on_attach(args.data.client_id, args.buf)
                      vim.api.nvim_del_augroup_by_name("nvim_vtsls")
                    end
                  end,
                },
              },
            },
          },
        },
        config = function(_, opts)
          require("vtsls").config(opts)
        end,
      },
      {
        "dmmulroy/tsc.nvim",
        cmd = "TSC",
        opts = {},
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        gb_oxlint = {
          cmd = "oxlint",
          stdin = false,
          args = {
            "--format=github",
            "--threads=8",
            "-A",
            "pedantic",
            "-A",
            "nursery",
          },
          stream = "stdout",
          ignore_exitcode = true,
          parser = require("lint.parser").from_pattern(
            "::([^ ]+) file=(.*),line=(%d+),endLine=(%d+),col=(%d+),endColumn=(%d+),title=(.*)::(.*)",
            { "severity", "file", "lnum", "end_lnum", "col", "end_col", "code", "message" },
            { ["error"] = vim.diagnostic.severity.ERROR, ["warning"] = vim.diagnostic.severity.WARN },
            { ["source"] = "oxlint" },
            {}
          ),
        },
      },
      linters_by_ft = {
        javascript = { "gb_oxlint" },
        ["javascript.jsx"] = { "gb_oxlint" },
        javascriptreact = { "gb_oxlint" },
        typescript = { "gb_oxlint" },
        ["typescript.tsx"] = { "gb_oxlint" },
        typescriptreact = { "gb_oxlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        biome_js = {
          command = "biome",
          stdin = true,
          --stylua: ignore
          args = { "format", "--stdin-file-path", "$FILENAME", "--javascript-formatter-enabled=true", "--javascript-formatter-indent-style=space", "--javascript-formatter-indent-width=2", "--javascript-formatter-line-ending=lf", "--javascript-formatter-line-width=120", "--trailing-commas=none", "--use-editorconfig=false" },
        },
      },
      formatters_by_ft = {
        javascript = { "biome_js", "oxlint", "biome_js" },
        typescript = { "biome_js", "oxlint", "biome_js" },
        javascriptreact = { "biome_js" },
        typescriptreact = { "biome_js" },
      },
    },
  },
}
