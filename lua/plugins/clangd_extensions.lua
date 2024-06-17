---@diagnostic disable: missing-fields
return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
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
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      opts_extend = { "servers", "config" },
      ---@class AstroLSPOpts
      opts = {
        servers = { "clangd" },
        config = {
          clangd = {
            capabilities = {
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
              "--offset-encoding=utf-16",
              "--pch-storage=memory",
              "--ranking-model=heuristics",
              "-j=9",
            },
            settings = { clangd = { checkUpdates = false } },
          },
        },
      },
    },
  },
}
