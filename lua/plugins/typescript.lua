---@diagnostic disable: missing-fields

local format_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      table.insert(opts.servers, "vtsls")
      opts.config = {
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
      }
    end,
    specs = {
      { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
          if not opts.formatters_by_ft then
            opts.formatters_by_ft = {}
          end
          for _, filetype in ipairs(format_filetypes) do
            opts.formatters_by_ft[filetype] = { "biome" }
          end
        end,
      },
      --[[ {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  }, ]]
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
}
