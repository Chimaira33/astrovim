return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      --stylua: ignore
      if not opts.sources then opts.sources = {} end
      --stylua: ignore
      opts.sources = vim.list_extend( opts.sources, { nls.builtins.formatting.fish_indent, nls.builtins.diagnostics.fish } )
    end,
    specs = {
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            formatters_by_ft = {
              fish = { "fish_indent" },
            },
          })
        end,
      },
      {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            linters_by_ft = { fish = { "fish" } },
          })
        end,
      },
    },
  },
}
