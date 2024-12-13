---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields

local pack = {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      handlers = { rust_analyzer = false },
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                disabled = { "unlinked-file" },
                useRustcErrorCode = true,
              },
              cargo = {
                allTargets = false,
                autoreload = true,
                features = {},
                target = "aarch64-linux-android",
              },
              cachePriming = { enable = true, numThreads = 7 },
              server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
              check = {
                allTargets = false,
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                  "-j8",
                },
                targets = { "aarch64-linux-android" },
              },
              -- procMacro = { enable = true },
            },
          },
        },
      },
    },
  },
}

table.insert(pack, {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = "rust",
  opts = function()
    local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
    local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
    local server = {
      ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table)
      settings = function()
        local astrolsp_settings = astrolsp_opts.settings

        local ra = require("rustaceanvim.config.server")
        return ra.load_rust_analyzer_settings("/dev/null", {
          settings_file_pattern = "/dev/null",
          default_settings = astrolsp_settings,
        })
      end,
    }
    local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
    return { server = final_server, tools = { enable_clippy = false } }
  end,
  config = function(_, opts)
    vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
  end,
})

return pack
