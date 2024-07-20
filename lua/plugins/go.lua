---@diagnostic disable: missing-fields
-- if true then
--   return {}
-- end
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@class AstroLSPOpts
    opts = function(_, opts)
      table.insert(opts.servers, "gopls")
      table.insert(opts.config, {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1003 = true,
                fieldalignment = false,
                fillreturns = true,
                nilness = true,
                nonewvars = true,
                shadow = true,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = true,
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
        "nvim-treesitter/nvim-treesitter",
        optional = true,
        opts = function(_, opts)
          if opts.ensure_installed ~= "all" then
            opts.ensure_installed =
              require("astrocore").list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
          end
        end,
      },
      --[[ {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      --stylua: ignore
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "gomodifytags", "gofumpt", "iferr", "impl", "goimports" })
    end,
  }, ]]
      {
        "ray-x/go.nvim",
        dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
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
          luasnip = true,
          tag_transform = false,
          verbose = false,
          log_path = "/data/data/com.termux/files/usr/tmp/gonvim.log",
          lsp_cfg = false,
          lsp_keymaps = false,
          lsp_codelens = false,
      --stylua: ignore
      preludes = { default = function() return {} end, GoRun = function() return {} end },
          lsp_inlay_hints = {
            enable = false,
          },
          gopls_remote_auto = true,
          dap_vt = false,
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
      },
      -- { "olexsmir/gopher.nvim", ft = "go", dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", { "williamboman/mason.nvim", optional = true } }, opts = {} },
      {
        "stevearc/conform.nvim",
        optional = true,
        opts = { formatters_by_ft = { go = { "goimports", "gofumpt", "golines" } } },
      },
    },
  },
}
