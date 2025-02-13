---@diagnostic disable: missing-fields

return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "vtsls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        vtsls = {
          settings = {
            typescript = {
              format = { enable = false },
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
              format = { enable = false },
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
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        biome_js = {
          command = "biome",
          stdin = true,
          --stylua: ignore
          args = { "format", "--stdin-file-path", "$FILENAME", "--javascript-formatter-enabled=true", "--javascript-formatter-indent-style=space", "--javascript-formatter-indent-width=2", "--javascript-formatter-line-ending=lf", "--javascript-formatter-line-width=120" },
        },
      },
      formatters_by_ft = {
        javascript = { "biome_js" },
        javascriptreact = { "biome_js" },
        typescript = { "biome_js" },
        typescriptreact = { "biome_js" },
      },
    },
  },
}
