---@diagnostic disable: missing-fields
return {
  {
    "AstroNvim/astrolsp",
    ---@class AstroLSPOpts
    opts = function(_, opts)
      table.insert(opts.servers, "bashls")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        formatters = { shfmt = { prepend_args = { "-i", "2", "-s", "-ci" } } },
        formatters_by_ft = { sh = { "shfmt" } },
      })
    end,
  },
}
