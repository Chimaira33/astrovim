return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "bashls" })
    end,
    specs = {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters = {
          shfmt = { prepend_args = { "-i", "2", "-s", "-ci" } },
        },
        formatters_by_ft = {
          sh = { "shfmt" },
        },
      },
      --[[ opts = function(_, opts)
        opts.formatters = require("astrocore").extend_tbl(opts.formatters or {}, {
          shfmt = { prepend_args = { "-i", "2", "-s", "-ci" } },
        })
        opts.formatters_by_ft = require("astrocore").extend_tbl(opts.formatters_by_ft or {}, {
          sh = { "shfmt" },
        })
      end, ]]
    },
  },
}
