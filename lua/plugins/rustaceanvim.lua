---@diagnostic disable: undefined-doc-param, undefined-doc-name, missing-fields

local override_cmd = vim
  .iter({
    "cargo",
    "clippy",
    "-q",
    "--message-format=json",
    "--no-deps",
    "-j8",
    "--workspace",
    "--target=aarch64-linux-android",
    "--profile=dev",
  })
  :flatten()
  :totable()

local env = vim
  .iter({
    "CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=aarch64-linux-android-clang",
    "CARGO_MAKEFLAGS='-O3 -pipe -mcpu=cortex-a55 -fomit-frame-pointer -fno-stack-protector -fno-stack-clash-protection -ffunction-sections -fdata-sections'",
    "CFLAGS_aarch64_linux_android='-O3 -pipe -mcpu=cortex-a55 -fomit-frame-pointer -fno-stack-protector -fno-stack-clash-protection -ffunction-sections -fdata-sections'",
    "CC_aarch64_linux_android=aarch64-linux-android-clang",
    "RUSTFLAGS='-C linker=aarch64-linux-android-clang -C codegen-units=1 -C debug-assertions=false -C overflow-checks=false -C opt-level=3 -C strip=symbols -C target-cpu=cortex-a55 -C debuginfo=0 -C panic=abort -C link-arg=-fuse-ld=lld -C relocation-model=pie -C link-arg=/data/data/com.termux/files/usr/lib/clang/20/lib/linux/libclang_rt.builtins-aarch64-android.a'",
  })
  :flatten()
  :totable()

local pack = {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = {
      handlers = { rust_analyzer = false },
      --[[ config = {
        ---@type lspconfig.options.rust_analyzer
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = {
                  ".cache",
                  ".direnv",
                  ".git",
                  ".github",
                  "target",
                },
                watcher = "client",
              },
              diagnostics = {
                disabled = { "unlinked-file" },
                useRustcErrorCode = true,
              },
              cargo = {
                allTargets = false,
                autoreload = true,
                features = {},
                -- target = "aarch64-linux-android",
                buildScripts = {
                  invocationStrategy = "per_workspace",
                  overrideCommand = override_cmd,
                  useRustcWrapper = true,
                },
                extraEnv = { env },
                sysroot = "/data/data/com.termux/files/usr",
                sysrootSrc = "/data/data/com.termux/files/usr/lib/rustlib/src/rust/library",
              },
              cachePriming = { enable = true, numThreads = 7 },
              server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
              check = {
                extraEnv = { env },
                allTargets = false,
                -- command = "clippy",
                -- extraArgs = { "--message-format=json-diagnostic-rendered-ansi", "--no-deps", "-j8", "--target", "aarch64-linux-android" },
                features = {},
                invocationStrategy = "per_workspace",
                overrideCommand = override_cmd,
                -- targets = { "aarch64-linux-android" },
              },
              cfg = { setTest = false },
              trace = { server = "off" },
              restartServerOnConfigChange = true,
              showUnlinkedFileNotification = false,
              numThreads = 8,
              debug = { enable = false },
              checkOnSave = true,
            },
          },
          load_vscode_settings = false,
        },
      }, ]]
    },
  },
}

table.insert(pack, {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = "rust",
  opts = function()
    -- local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
    -- local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
    local server = {
      ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table)
      settings = function()
        -- local astrolsp_settings = astrolsp_opts.settings

        local ra = require("rustaceanvim.config.server")
        return ra.load_rust_analyzer_settings("/dev/null", {
          settings_file_pattern = "/dev/null",
          default_settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = {
                  ".cache",
                  ".direnv",
                  ".git",
                  ".github",
                  "target",
                },
                watcher = "client",
              },
              diagnostics = {
                disabled = { "unlinked-file" },
                useRustcErrorCode = true,
              },
              cargo = {
                allTargets = false,
                autoreload = true,
                features = {},
                -- target = "aarch64-linux-android",
                buildScripts = {
                  invocationStrategy = "per_workspace",
                  overrideCommand = override_cmd,
                  useRustcWrapper = true,
                },
                extraEnv = env,
                sysroot = "/data/data/com.termux/files/usr",
                sysrootSrc = "/data/data/com.termux/files/usr/lib/rustlib/src/rust/library",
                targets = { "aarch64-linux-android" },
              },
              cachePriming = { enable = true, numThreads = 7 },
              server = { extraEnv = { "RA_LOG=rust_analyzer=error" } },
              check = {
                extraEnv = env,
                allTargets = false,
                -- command = "clippy",
                -- extraArgs = { "--message-format=json-diagnostic-rendered-ansi", "--no-deps", "-j8", "--target", "aarch64-linux-android" },
                features = {},
                invocationStrategy = "per_workspace",
                overrideCommand = override_cmd,
                targets = { "aarch64-linux-android" },
              },
              cfg = { setTest = false },
              trace = { server = "off" },
              restartServerOnConfigChange = true,
              showUnlinkedFileNotification = false,
              debug = { enable = false },
              checkOnSave = true,
            },
          },
        })
      end,
    }
    -- local final_server = require("astrocore").extend_tbl(astrolsp_opts, server)
    return {
      server = server,
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
})

return pack
