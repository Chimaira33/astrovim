---@diagnostic disable: missing-fields, inject-field, param-type-mismatch
---@type LazySpec
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = "rust",
    specs = {
      {
        "AstroNvim/astrolsp",
        opts = function(_, opts)
          table.insert(opts.handlers, { rust_analyzer = false })
          opts.config = require("astrocore").extend_tbl(opts.config or {}, {
            ---@type lspconfig.options.rust_analyzer
            rust_analyzer = {
              ---@type _.lspconfig.settings.rust_analyzer.Rust-analyzer
              settings = {
                ---@type _.lspconfig.settings.rust_analyzer.Rust-analyzer
                ["rust-analyzer"] = {
                  files = {
                    excludeDirs = {
                      ".cache",
                      ".direnv",
                      ".git",
                      ".github",
                      "debug",
                      "target",
                    },
                  },
                  diagnostics = {
                    enable = true,
                    disabled = { "unlinked-file" },
                    styleLints = { enable = true },
                    useRustcErrorCode = true,
                  },
                  cargo = {
                    buildScripts = {
                      enable = true,
                      useRustcWrapper = true,
                      rebuildOnSave = true,
                      -- overrideCommand = { "cargo", "check", "--workspace", "-j8", "--profile=dev", "--target=aarch64-linux-android", "--message-format=json", "--quiet", "--keep-going" },
                    },
                    allTargets = false,
                    autoreload = true,
                    features = {},
                    target = "aarch64-linux-android",
                    noDeps = false,
                    -- sysroot = "/data/data/com.termux/files/usr",
                    -- sysrootSrc = "/data/data/com.termux/files/usr/lib/rustlib/src/rust/library",
                    sysroot = "/data/data/com.termux/files/usr/opt/rust-nightly",
                    sysrootSrc = "/data/data/com.termux/files/usr/opt/rust-nightly/lib/rustlib/src/rust/library",
                    cfgs = { "!debug_assertions", "!miri" },
                  },
                  cachePriming = { enable = true, numThreads = 8 },
                  -- server = { extraEnv = { RA_LOG = "rust_analyzer=error" } },
                  check = {
                    allTargets = false,
                    command = "clippy",
                    extraArgs = {
                      "--no-deps",
                      "-j8",
                      "--target=aarch64-linux-android",
                      "--profile=dev",
                    },
                    features = {},
                    -- overrideCommand = { "cargo", "clippy", "--no-deps", "--workspace", "-j8", "--profile=dev", "--target=aarch64-linux-android", "--message-format=json" },
                    targets = "aarch64-linux-android",
                  },
                  cfg = { setTest = false },
                  trace = { server = "off" },
                  restartServerOnConfigChange = true,
                  showUnlinkedFileNotification = false,
                  debug = { enable = false },
                  -- checkOnSave = true,
                  load_vscode_settings = false,
                  hover = {
                    actions = { enable = true },
                    documentation = { enable = true },
                    links = { enable = true },
                    dropGlue = { enable = true },
                    memoryLayout = { enable = true },
                  },
                  imports = {
                    granularity = { enforce = true },
                    group = { enable = true },
                    merge = { glob = true },
                  },
                  rustc = {
                    source = "/data/data/com.termux/files/usr/opt/rust-nightly/bin/rustc",
                  },
                  procMacro = {
                    enable = true,
                    -- server = "/data/data/com.termux/files/usr/opt/rust-nightly/libexec/rust-analyzer-proc-macro-srv",
                    server = "/data/data/com.termux/files/home/.local/libexec/rust-analyzer-proc-macro-srv",
                  },
                  server = { path = "/data/data/com.termux/files/home/.local/bin/rust-analyzer" },
                  numThreads = 8,
                  assist = {
                    emitMustUse = true,
                    preferSelf = true,
                  },
                  lens = {
                    enable = true,
                    debug = { enable = false },
                    updateTest = { enable = false },
                  },
                },
              },
            },
          })
        end,
      },
    },
    opts = function()
      local astrolsp = require("astrolsp")
      local astrolsp_opts = astrolsp.lsp_opts("rust_analyzer")
      local server = {
        settings = function(project_root)
          local astrolsp_settings = astrolsp_opts.settings

          -- local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require("rustaceanvim.config.server")
          -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
          return ra.load_rust_analyzer_settings(project_root, {
            --   settings_file_pattern = "rust-analyzer.json",
            -- return ra.load_rust_analyzer_settings("/dev/null", {
            settings_file_pattern = "/dev/null",
            default_settings = astrolsp_settings,
          })
        end,
      }
      local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
      return {
        server = final_server,
        tools = {
          enable_clippy = false,
          enable_nextest = false,
          cargo_override = nil,
        },
        dap = { autoload_configurations = false },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim)
    end,
  },
}
