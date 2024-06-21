---@diagnostic disable: missing-fields
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      table.insert(opts.servers, "ruff")
      opts.config = {
        ruff = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = true
          end,
        },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        formatters_by_ft = {
          python = {
            "ruff_organize_imports",
            "ruff_format",
            "ruff_fix",
          },
        },
      })
    end,
  },
}
