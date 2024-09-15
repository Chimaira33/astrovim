---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  ---@class AstroLSPOpts
  opts = function(_, opts)
    table.insert(opts, { formatting = { disabled = "lua_ls" } })
    --stylua: ignore
    if not opts.servers then opts.servers = {} end
    opts.servers = require("astrocore").list_insert_unique(opts.servers, { "lua_ls" })
    opts.config = require("astrocore").extend_tbl(opts.config or {}, {
      lua_ls = {
        settings = {
          Lua = {
            -- diagnostics = { globals = { "vim", "require" } },
            hint = { enable = true, arrayIndex = "Disable" },
            runtime = { version = "LuaJIT" },
            -- workspace = {
            --   library = vim.api.nvim_get_runtime_file("", true),
            --   checkThirdParty = false,
            -- },
          },
        },
      },
    })
  end,
  specs = {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
