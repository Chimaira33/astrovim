---@diagnostic disable: param-type-mismatch
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      {

        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then
                  config.settings.json.schemas = {}
                end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = { json = { validate = { enable = true } } },
            },
          },
          handlers = {
            jsonls = function(_, opts)
              opts.filetypes = { "json", "jsonc" }
              require("lspconfig").jsonls.setup(opts)
            end,
          },
        },
      },
    },
  },
}
