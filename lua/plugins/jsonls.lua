---@diagnostic disable: param-type-mismatch, missing-fields
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          --stylua: ignore
          if not opts.servers then opts.servers = {} end
          opts.servers = require("astrocore").list_insert_unique(opts.servers, { "jsonls" })
          opts.config = require("astrocore").extend_tbl(opts.config or {}, {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then
                  config.settings.json.schemas = {}
                end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = {
                json = {
                  format = { enable = false },
                  validate = { enable = true },
                  schemaDownload = { enable = true },
                },
              },
            },
          })
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = { json = { "biome" } } },
  },
}
