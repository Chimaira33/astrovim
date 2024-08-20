---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  ---@class AstroLSPOpts
  opts = function(_, opts)
    table.insert(opts, { formatting = { disabled = "lua_ls" } })
    table.insert(opts.servers, "lua_ls")
    return require("astrocore").extend_tbl(opts, {
      config = {
        lua_ls = {
          settings = {
            Lua = {
              -- diagnostics = { globals = { "vim", "require" } },
              hint = { enable = true, arrayIndex = "Disable" },
              -- runtime = { version = "LuaJIT" },
              -- workspace = {
              --   library = vim.api.nvim_get_runtime_file("", true),
              --   checkThirdParty = false,
              -- },
            },
          },
        },
      },
    })
  end,
  specs = {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        formatters_by_ft = { lua = { "stylua" } },
      })
    end,
  },
}
