---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "neocmake" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        neocmake = {
          init_options = { format = { enable = false }, lint = { enable = false }, scan_cmake_in_package = true },
          capabilities = {
            textDocument = { completion = { completionItem = { snippetSupport = true } } },
            workspace = { didChangeWatchedFiles = { dynamicRegistration = true, relativePatternSupport = true } },
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        cmakelint = {
          args = { "--quiet", "--linelength=120", "--spaces=2" },
        },
      },
      linters_by_ft = { cmake = { "cmakelint" } },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- formatters = { gersemi = { prepend_args = { "--indent", "2", "--line-length", "80" } } },
      formatters_by_ft = { cmake = { "gersemi" } },
    },
  },
}
