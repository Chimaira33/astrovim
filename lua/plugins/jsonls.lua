---@diagnostic disable: param-type-mismatch, missing-fields
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrolsp",
        opts_extend = { "servers", "config" },
        ---@class AstroLSPOpts
        opts = {
          servers = { "jsonls" },
          config = {
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
          },
        },
      },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = { formatters_by_ft = { json = { "biome" } } },
      },
      -- {"folke/neodev.nvim", lazy = true, opts = {setup_jsonls = true}},
    },
  },
}
