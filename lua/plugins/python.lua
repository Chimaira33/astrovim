---@diagnostic disable: missing-fields
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "ruff" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ruff = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = {
          "ruff_organize_imports",
          "ruff_format",
          "ruff_fix",
        },
      },
    },
  },
}
