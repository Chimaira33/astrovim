---@diagnostic disable: missing-fields
-- if true then
--   return {}
-- end
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@class AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "gopls" })
      -- opts.servers = require("astrocore").list_insert_unique(opts.servers, { "golangci_lint_ls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        -- golangci_lint_ls = { init_options = { command = { "golangci-lint", "run", "--output.json.path", "stdout", "--show-stats=false", "--issues-exit-code=1" } } },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1003 = false,
                fieldalignment = false,
                fillreturns = true,
                nilness = true,
                nonewvars = true,
                shadow = false,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                generate = true,
                regenerate_cgo = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              buildFlags = { "-tags", "integration" },
              completeUnimported = true,
              diagnosticsDelay = "500ms",
              matcher = "Fuzzy",
              semanticTokens = true,
              staticcheck = true,
              symbolMatcher = "fuzzy",
              usePlaceholders = true,
            },
          },
        },
      })
    end,
    specs = {
      {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua" },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        opts = {
          disable_defaults = true,
          diagnostic = false,
          go = "go",
          goimports = "goimports",
          fillstruct = "fillstruct",
          gofmt = "gofumpt",
          lsp_gofumpt = true,
          dap_debug = false,
          dap_debug_gui = false,
          dap_debug_keymap = false,
          luasnip = false,
          tag_transform = false,
          verbose = false,
          log_path = "/data/data/com.termux/files/usr/tmp/gonvim.log",
          lsp_cfg = false,
          lsp_keymaps = false,
          lsp_codelens = false,
          preludes = {
            default = function()
              return {}
            end,
            GoRun = function()
              return {}
            end,
          },
          lsp_inlay_hints = {
            enable = false,
          },
          gopls_remote_auto = true,
          dap_vt = false,
        },
      },
      -- {
      --   "olexsmir/gopher.nvim",
      --   ft = "go",
      --   dependencies = {
      --     "nvim-lua/plenary.nvim",
      --     "nvim-treesitter/nvim-treesitter",
      --     -- { "williamboman/mason.nvim", optional = true },
      --   },
      --   opts = {},
      -- },
    },
  },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(
  --       opts.ensure_installed,
  --       { "golangci-lint-langserver", "delve", "goimports", "gomodifytags", "gotests", "iferr", "impl" }
  --     )
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },
  { "mfussenegger/nvim-lint", optional = true, opts = { linters_by_ft = { go = { "golangcilint" } } } },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        -- go = { "gb-goimports-reviser", "gofumpt", lsp_format = "never" },
        go = { "goimports", "gofumpt", "golines" },
        -- go = { "gb-goimports-reviser", "gb-golangci-lint", lsp_format = "never" },
      },
      -- formatters = {
      --   -- ["golangci-lint"] = { append_args = { "-E", "goimports", "-E", "gofumpt" } },
      --   ["gb-goimports-reviser"] = {
      --     command = "goimports-reviser",
      --     args = {
      --       "-rm-unused",
      --       "-set-alias",
      --       "-use-cache",
      --       "-format",
      --       "$FILENAME",
      --     },
      --     stdin = false,
      --   },
      --   ["gb-golangci-lint"] = { command = "golangci-lint", append_args = { "-E", "gofumpt", "-E", "golines" } },
      -- },
    },
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
}
