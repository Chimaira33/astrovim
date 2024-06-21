---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields
return {
  {
    "AstroNvim/astrolsp",
    opts_extend = { "handlers", "config" },
    ---@class AstroLSPOpts
    opts = {
      -- table.insert(opts.servers, "rust_analyzer")
      handlers = { rust_analyzer = false },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    -- enabled = false,
    version = "^4",
    ft = "rust",
    lazy = false,
    opts = function()
      -- local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      -- local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
      ---@type RustaceanOpts
      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table)
        settings = function()
          -- settings = function(project_root, default_settings)
          -- local astrolsp_settings = astrolsp_opts.settings or {}

          -- local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require("rustaceanvim.config.server")
          return ra.load_rust_analyzer_settings("/dev/null", {
            settings_file_pattern = "/dev/null",
            default_settings = {
              ["rust-analyzer"] = {
                inlayHints = {
                  -- typeHints = { enable = true },
                  -- parameterHints = { enable = true },
                  lifetimeElisionHints = { enable = "always", useParameterNames = true },
                },
                -- lens = { enable = true, references = { enable = true, enumVariant = { enable = true }, method = { enable = true } }, implementations = { enable = true } },
                imports = { granularity = { enforce = true }, prefix = "crate" },
                completion = { postfix = { enable = false } },
                cargo = {
                  buildScripts = {
                    overrideCommand = {
                      "cargo",
                      "clippy",
                      "--no-deps",
                      "-j8",
                      "--workspace",
                      "--target=aarch64-linux-android",
                      "--quiet",
                      "--message-format=json",
                    },
                    useRustcWrapper = true,
                  },
                  autoreload = true,
                  -- features = {},
                  target = "aarch64-linux-android",
                },
                hover = { actions = { enable = false } },
                -- cachePriming = { enable = true, numThreads = 8 },
                -- server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
                check = {
                  allTargets = false,
                  -- overrideCommand = { "cargo", "clippy", "--no-deps", "--workspace", "-j8", "--target=aarch64-linux-android", "--message-format=json" },
                  command = "clippy",
                  extraArgs = {
                    "--no-deps",
                    "--workspace",
                    "-j9",
                    "--target=aarch64-linux-android",
                  },
                  targets = { "aarch64-linux-android" },
                },
                -- procMacro = { enable = true },
                -- numThreads = 8,
              },
            },
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(server)
      return { server = final_server }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
    end,
  },
  {
    "folke/lazydev.nvim",
    optional = true,
    opts_extend = { "library" },
    opts = {
      library = {
        {
          path = "rustaceanvim",
          words = { "rustaceanvim" },
        },
      },
    },
  },
}
