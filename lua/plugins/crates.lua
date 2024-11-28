--stylua: ignore
vim.api.nvim_create_user_command("CratesUpgrade", function() require("crates").upgrade_crate() end, { desc = "Upgrade Single Crate" })
--stylua: ignore
vim.api.nvim_create_user_command("CratesUpgradeAll", function() require("crates").upgrade_all_crates() end, { desc = "Upgrade All Crates" })

return {
  {
    "Saecki/crates.nvim",
    -- tag = "stable",
    event = { "BufRead Cargo.toml" },
    opts = {
      date_format = "%m-%d-%Y",
      completion = {
        cmp = { enabled = true },
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
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              --stylua: ignore
              ["<C-u>"] = function() require("crates").update_crate() end,
              --stylua: ignore
              ["<A-u>"] = function() require("crates").update_all_crates() end,
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
      -- {"hrsh7th/nvim-cmp", opts = function(_, opts) opts.sources = require("astrocore").extend_tbl(opts.sources or {}, {name = "crates"}) end},
    },
  },
}
