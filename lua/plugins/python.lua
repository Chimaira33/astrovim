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
      formatters = {
        _ruff_organize = {
          command = "ruff",
          stdin = true,
          --stylua: ignore
          args = { "check", "--fix", "--exit-zero", "--no-cache", "--no-force-exclude", "--no-respect-gitignore", "--select=I001", "--isolated", "--stdin-filename", "$FILENAME", "-" },
        },
        _ruff_format = {
          command = "ruff",
          stdin = true,
          --stylua: ignore
          args = { "format", "--no-force-exclude", "--no-respect-gitignore", "--isolated", "--stdin-filename", "$FILENAME", "-" },
        },
        _ruff_fix = {
          command = "ruff",
          stdin = true,
          --stylua: ignore
          args = { "check", "--fix", "--exit-zero", "--no-cache", "--no-force-exclude", "--no-respect-gitignore", "--isolated", "--stdin-filename", "$FILENAME", "-" },
        },
      },
      formatters_by_ft = {
        python = {
          "_ruff_organize",
          "_ruff_format",
          "_ruff_fix",
        },
      },
    },
  },
}
