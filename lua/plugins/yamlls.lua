return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      "AstroNvim/astrolsp",
      optional = true,
      ---@param opts AstroLSPOpts
      opts = function(_, opts)
        ---@diagnostic disable: missing-fields
        table.insert(opts.servers, "yamlls")
        opts.config = {
          yamlls = {
            on_new_config = function(config)
              config.settings.yaml.schemas =
                vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
            end,
            settings = { yaml = { schemaStore = { enable = false, url = "" } } },
          },
        }
      end,
    },
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
}
