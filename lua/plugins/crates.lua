return {
  {
    "Saecki/crates.nvim",
    -- tag = "stable",
    event = { "BufRead Cargo.toml" },
    opts = {
      date_format = "%m-%d-%Y",
      completion = {
        -- cmp = { enabled = true },
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
        enabled = true,
        name = "crates.nvim",
      },
      popup = {
        autofocus = true,
        hide_on_select = true,
        copy_register = '"',
        style = "minimal",
        border = "none",
        show_version_date = false,
        show_dependency_version = true,
        max_height = vim.api.nvim_win_get_height(0),
        min_width = vim.api.nvim_win_get_width(0) - 10,
      },
    },
    specs = {
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
