---@type LazySpec
return {
  {
    "Saecki/crates.nvim",
    -- tag = "stable",
    cond = vim.fs.basename(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())) == "Cargo.toml",
    -- event = { "BufReadPre Cargo.toml" },
    lazy = false,
    ---@class crates.UserConfig
    opts = {
      enable_update_available_warning = false,
      date_format = "%m-%d-%Y",
      -- expand_crate_moves_cursor = false,
      -- insert_closing_quote = false,
      completion = {
        crates = {
          enabled = true,
          max_results = 8,
          min_chars = 3,
        },
      },
      lsp = {
        enabled = true,
        name = "crates.nvim",
        --stylua: ignore
        on_attach = function(...) require("astrolsp").on_attach(...) end,
        actions = true,
        completion = true,
        hover = true,
      },
      null_ls = {
        enabled = false,
        name = "crates.nvim",
      },
      popup = {
        autofocus = true,
        hide_on_select = true,
        copy_register = '"',
        style = "minimal",
        border = "none",
        show_version_date = true,
        show_dependency_version = true,
        max_height = vim.api.nvim_win_get_height(0),
        min_width = vim.api.nvim_win_get_width(0) - 10,
        keys = {
          hide = { "q", "<esc>" },
          open_url = { "<cr>" },
          select = { "<cr>" },
          select_alt = { nil },
          toggle_feature = { "<cr>" },
          copy_value = { "yy" },
          goto_item = { "K" },
          jump_forward = { nil },
          jump_back = { nil },
        },
      },
      text = {
        searching = "   Searching",
        loading = "   Loading",
        version = " %s",
        prerelease = "   %s",
        yanked = "   %s",
        nomatch = "   No match",
        upgrade = "   %s",
        error = "   Error fetching crate",
      },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        optional = true,
        opts = function(_, opts)
          --stylua: ignore
          if not opts.library then opts.library = {} end
          table.insert(opts.library, { path = "crates.nvim", words = { "crates", "Crates" } })
        end,
      },
      {
        "AstroNvim/astrocore",
        opts = {
          commands = {
            CratesUpgrade = {
              function()
                require("crates").upgrade_crate()
              end,
              desc = "Upgrade Single Crate",
            },
            CratesUpgradeAll = {
              function()
                require("crates").upgrade_all_crates()
              end,
              desc = "Upgrade All Crate",
            },
            CratesUpdate = {
              function()
                require("crates").update_crate()
              end,
              desc = "Update Single Crate",
            },
            CratesUpdateAll = {
              function()
                require("crates").update_all_crates()
              end,
              desc = "Update All Crate",
            },
          },
          mappings = {
            n = {
              --stylua: ignore
              ["<C-u>"] = function() vim.cmd.CratesUpdate() end,
              --stylua: ignore
              ["<A-u>"] = function() vim.cmd.CratesUpdateAll() end,
              --stylua: ignore
              ["<C-A-u>"] = function() vim.cmd.CratesUpgrade() end,
              --stylua: ignore
              ["<Leader>cr"] = function() require("crates").reload() end,
              --stylua: ignore
              ["<Leader>cv"] = function() require("crates").show_versions_popup() end,
              --stylua: ignore
              ["<Leader>cf"] = function() require("crates").show_features_popup() end,
              --stylua: ignore
              ["<Leader>cx"] = function() require("crates").expand_plain_crate_to_inline_table() end,
              -- ["K"] = function() if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then require("crates").show_popup() else vim.lsp.buf.hover() end end,
            },
          },
        },
      },
    },
  },
}
