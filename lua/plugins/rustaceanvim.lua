---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields

-- if vim.fs.find("Cargo.toml", { path = vim.env.PWD, upward = true, type = "file" })[1] then
return {
  {
    "mrcjkb/rustaceanvim",
    -- enabled = false,
    version = "^5",
    ft = "rust",
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
                diagnostics = {
                  disabled = { "unlinked-file" },
                },
                cargo = {
                  autoreload = true,
                  features = {},
                  target = "aarch64-linux-android",
                },
                cachePriming = { enable = true, numThreads = 4 },
                server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
                check = {
                  allTargets = false,
                  command = "clippy",
                  extraArgs = {
                    "--no-deps",
                    "-j8",
                    "--target=aarch64-linux-android",
                  },
                  targets = { "aarch64-linux-android" },
                },
                -- procMacro = { enable = true },
              },
            },
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(server)
      return { server = final_server, tools = { enable_clippy = false } }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
    end,
    specs = {
      {
        "AstroNvim/astrolsp",
        opts = { handlers = { rust_analyzer = false } },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = { rust = { "rustfmt" } } },
  },
}
-- else
--   return {}
-- end
