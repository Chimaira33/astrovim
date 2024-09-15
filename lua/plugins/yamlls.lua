---@diagnostic disable: missing-fields
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrolsp",
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
          --stylua: ignore
          if not opts.servers then opts.servers = {} end
          opts.servers = require("astrocore").list_insert_unique(opts.servers, { "yamlls" })
          opts.config = require("astrocore").extend_tbl(opts.config or {}, {
            yamlls = {
              on_new_config = function(config)
                config.settings.yaml.schemas = vim.tbl_deep_extend(
                  "force",
                  config.settings.yaml.schemas or {},
                  require("schemastore").yaml.schemas()
                )
              end,
              settings = { yaml = { schemaStore = { enable = false, url = "" } } },
            },
          })
        end,
      },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
          formatters_by_ft = {
            yaml = { "yamlfmt" },
          },
        },
      },
    },
  },
}
