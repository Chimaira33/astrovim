---@diagnostic disable: param-type-mismatch, missing-fields
return {
  {
    "AstroNvim/astrolsp",
    servers_extend = true,
    handlers_extend = true,
    ---@class AstroLSPOpts
    opts = function(_, opts)
      table.insert(opts.servers, "biome")
      return require("astrocore").extend_tbl(opts, {
        handlers = {
          ---@diagnostic disable-next-line: redefined-local
          biome = function(_, opts)
            opts.single_file_support = true
            require("lspconfig").biome.setup(opts)
          end,
        },
      })
    end,
    -- table.insert(opts.servers, "jsonls")
    --[[ return require("astrocore").extend_tbl(opts, {
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
      }) ]]
    -- end,
    specs = {
      -- { "b0o/SchemaStore.nvim", lazy = true },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            formatters_by_ft = { json = { "biome" } },
          })
        end,
      },
      -- {"folke/neodev.nvim", lazy = true, opts = {setup_jsonls = true}},
    },
  },
}
