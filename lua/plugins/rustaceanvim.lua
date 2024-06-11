---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      -- table.insert(opts.servers, "rust_analyzer")
      return require("astrocore").extend_tbl(opts, {
        handlers = { rust_analyzer = false },
        config = {
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                inlayHints = {
                  typeHints = { enable = true },
                  parameterHints = { enable = true },
                  lifetimeElisionHints = { enable = "always", useParameterNames = true },
                },
                lens = {
                  enable = true,
                  references = { enable = true, enumVariant = { enable = true }, method = { enable = true } },
                  implementations = { enable = true },
                },
                imports = { granularity = { enforce = true }, prefix = "crate" },
                completion = { postfix = { enable = false } },
                cargo = { autoreload = true, features = {}, target = "aarch64-linux-android" },
                hover = { actions = { enable = true } },
                cachePriming = { numThreads = 4 },
                server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
                check = {
                  allTargets = false,
                  command = "clippy",
                  extraArgs = { "--no-deps", "-j9", "--target=aarch64-linux-android" },
                },
                procMacro = { enable = true },
                numThreads = 8,
              },
            },
          },
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    -- enabled = false,
    version = "^4",
    ft = "rust",
    lazy = false,
    opts = function()
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table)
        settings = function(project_root, default_settings)
          local astrolsp_settings = astrolsp_opts.settings or {}

          local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require("rustaceanvim.config.server")
          return ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = "rust-analyzer.json",
            default_settings = merge_table,
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
      return { server = final_server }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
    end,
  },
}
