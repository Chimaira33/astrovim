return {
  {
    "Saecki/crates.nvim",
    -- tag = "stable",
    -- event = "User AstroFile",
    opts = function(_, opts)
      local crates = require("crates")
      vim.api.nvim_create_user_command("CratesReload", function()
        crates.reload()
      end, { desc = "Reload Crates" })
      vim.api.nvim_create_user_command("CratesVersions", function()
        crates.show_versions_popup()
      end, { desc = "Show Versions Popup" })
      vim.api.nvim_create_user_command("CratesFeatures", function()
        crates.show_features_popup()
      end, { desc = "Show Features Popup" })
      vim.api.nvim_create_user_command("CratesExpandInline", function()
        crates.expand_plain_crate_to_inline_table()
      end, { desc = "Crates Expand to Inline Table" })
      vim.api.nvim_create_user_command("CratesPopup", function()
        if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
          require("crates").show_popup()
        else
          vim.lsp.buf.hover()
        end
      end, { desc = "Crates Show Popup" })

      vim.api.nvim_create_user_command("CratesUpdate", function()
        crates.update_crate()
      end, { desc = "Update Single Crate" })
      vim.api.nvim_create_user_command("CratesUpgrade", function()
        crates.upgrade_crate()
      end, { desc = "Upgrade Single Crate" })
      vim.api.nvim_create_user_command("CratesUpdateAll", function()
        crates.update_all_crates()
      end, { desc = "Update All Crates" })
      vim.api.nvim_create_user_command("CratesUpgradeAll", function()
        crates.upgrade_all_crates()
      end, { desc = "Upgrade All Crates" })
      opts.completion = {
        cmp = { enabled = true },
        crates = { enabled = true },
      }
      opts.lsp = {
        enabled = true,
        name = "crates.nvim",
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr) end,
        actions = true,
        completion = true,
        hover = true,
      }
      opts.null_ls = {
        enabled = true,
        name = "crates.nvim",
      }
    end,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          return require("astrocore").extend_tbl(opts, {
            mappings = {
              n = {
                ["<C-u>"] = "<Cmd>CratesUpdate<CR>",
                ["<A-u>"] = "<Cmd>CratesUpdateAll<CR>",
                ["<Leader>cr"] = "<Cmd>CratesReload<CR>",
                ["<Leader>cv"] = "<Cmd>CratesVersions<CR>",
                ["<Leader>cf"] = "<Cmd>CratesFeatures<CR>",
                ["<Leader>cx"] = "<Cmd>CratesExpandInline<CR>",
                ["K"] = "<Cmd>CratesPopup<CR>",
              },
            },
          })
        end,
      },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, { name = "crates" })
          -- table.insert(opts.sources, { name = "crates", group_index = 0 })
          -- local cmp = require("cmp")
          -- return require("astrocore").extend_tbl(opts, {
          --   cmp.setup.buffer({
          --     sources = {
          --       { name = "crates" },
          --       { name = "path" },
          --       { name = "buffer" },
          --       { name = "luasnip" },
          --       { name = "cmdline" },
          --       { name = "nvim_lsp:lua_ls" },
          --     },
          --   }),
          -- })
        end,
      },
    },
  },
}
