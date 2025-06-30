---@diagnostic disable: missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "lua_ls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        lua_ls = {
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              format = { enable = false },
              diagnostics = { globals = { "astronvim" } },
              runtime = { version = "LuaJIT" },
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = { lua = { "stylua" } } },
  },
}
