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
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = { fish = { "fish_indent" } } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = { fish = { "fish" } } },
  },
}
