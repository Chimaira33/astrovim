---@diagnostic disable: param-type-mismatch
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          table.insert(opts.servers, "jsonls")
          opts.config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then
                  config.settings.json.schemas = {}
                end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = { json = { validate = { enable = true } } },
            },
          }
        end,
      },
      {
        "folke/neodev.nvim",
        lazy = true,
        opts = {
          setup_jsonls = true,
        },
      },
    },
  },
}
