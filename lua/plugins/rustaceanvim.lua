---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = {
      handlers = { rust_analyzer = false }, -- disable setup of `rust_analyzer`
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              callInfo = { full = true },
              inlayHints = {
                enable = true,
                typeHints = true,
                parameterHints = true,
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
              lens = {
                enable = true,
                references = true,
                implementations = true,
                enumVariantReferences = true,
                methodReferences = true,
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              completion = {
                postfix = { enable = false },
              },
              cargo = {
                autoreload = true,
                allFeatures = false,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              check = { allTargets = false },
              hoverActions = { enable = true },
              cachePriming = { numThreads = 7 },
              server = { extraEnv = "RA_LOG=rust_analyzer=error" },
              checkOnSave = {
                enable = true,
                allFeatures = false,
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                  "-j9",
                  "--target=aarch64-linux-android",
                },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    -- version = "^4",
    ft = "rust",
    lazy = false,
    opts = function()
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      return {
        server = astrolsp_avail and astrolsp.lsp_opts("rust_analyzer"),
        tools = {
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "NonText",
          },
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
    end,
  },
}
