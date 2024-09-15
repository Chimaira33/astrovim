return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
        --stylua: ignore
        if not opts.sources then opts.sources = {} end
        --stylua: ignore
        opts.sources = vim.list_extend(opts.sources, {
          nls.builtins.diagnostics.fish,
        -- nls.builtins.formatting.fish_indent
        })
    end,
  },
  -- specs = {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
      },
    },
  },
}
