---@diagnostic disable: missing-fields
return {
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          opts.autocmds = require("astrocore").extend_tbl(opts.autocmds or {}, {
            clangd_extensions = {
              {
                event = "LspAttach",
                desc = "Load clangd_extensions with clangd",
                callback = function(args)
                  if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
                    require("clangd_extensions")
                    vim.api.nvim_del_augroup_by_name("clangd_extensions")
                  end
                end,
              },
            },
          })
        end,
      },
      {
        "AstroNvim/astrolsp",
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
          --stylua: ignore
          if not opts.servers then opts.servers = {} end
          opts.servers = require("astrocore").list_insert_unique(opts.servers, { "clangd" })
          opts.config = require("astrocore").extend_tbl(opts.config or {}, {
            clangd = {
              capabilities = {
                offsetEncoding = "utf-8",
                checkUpdates = false,
              },
              settings = {
                clangd = {
                  arguments = {
                    "--all-scopes-completion",
                    "--background-index",
                    "--background-index-priority=low",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--enable-config",
                    "--fallback-style=google",
                    "--function-arg-placeholders",
                    "--header-insertion-decorators",
                    "--header-insertion=iwyu",
                    "--import-insertions",
                    "--log=error",
                    "--pch-storage=memory",
                    "--ranking-model=heuristics",
                    "-j=9",
                  },
                  checkUpdates = false,
                },
              },
            },
          })
        end,
      },
      {
        "Civitasv/cmake-tools.nvim",
        ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        opts = {},
      },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
          formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
          },
        },
      },
    },
  },
}
