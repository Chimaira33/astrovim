---@diagnostic disable: missing-fields
return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
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
        })
      end,
    },
    {
      "AstroNvim/astrolsp",
      ---@class AstroLSPOpts
      opts = function(_, opts)
        table.insert(opts.servers, "clangd")
        table.insert(opts.config, {
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
        })
      end,
    },
  },
}
