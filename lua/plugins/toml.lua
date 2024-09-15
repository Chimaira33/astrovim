return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "taplo" })
      opts.handlers = require("astrocore").extend_tbl(opts.handlers or {}, {
        ---@diagnostic disable-next-line: redefined-local
        taplo = function(server, opts)
          local util = require("lspconfig.util")
          opts.cmd = { "taplo", "lsp", "stdio" }
          opts.filetypes = { "toml" }
          opts.root_dir = util.root_pattern("*.toml")
          opts.single_file_support = true
          require("lspconfig")[server].setup(opts)
        end,
      })
    end,
    specs = {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          toml = { "taplo" },
        },
      },
    },
  },
}
