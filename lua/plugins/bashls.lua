return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      table.insert(opts.servers, "bashls")
    end,
    specs = {
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
    },
  },
}
