return {
  "Saecki/crates.nvim",
  tag = "stable",
  -- event = "User AstroFile",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        require("crates")
        return require("astrocore").extend_tbl(opts, {
          mappings = {
            n = {
              ["<C-u>"] = "<Cmd>CratesUpdate<CR>",
              ["<A-u>"] = "<Cmd>CratesUpdateAll<CR>",
            },
          },
        })
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        local cmp = require("cmp")
        return require("astrocore").extend_tbl(opts, {
          cmp.setup.buffer({
            sources = {
              { name = "crates" },
              { name = "path" },
              { name = "buffer" },
              { name = "luasnip" },
              { name = "cmdline" },
              { name = "nvim_lsp:lua_ls" },
            },
          }),
        })
      end,
    },
  },
  opts = {
    vim.api.nvim_create_user_command("CratesUpdate", function()
      require("crates").update_crate()
    end, { desc = "Update Single Crate" }),
    vim.api.nvim_create_user_command("CratesUpgrade", function()
      require("crates").upgrade_crate()
    end, { desc = "Upgrade Single Crate" }),
    vim.api.nvim_create_user_command("CratesUpdateAll", function()
      require("crates").update_all_crates()
    end, { desc = "Update All Crates" }),
    vim.api.nvim_create_user_command("CratesUpgradeAll", function()
      require("crates").upgrade_all_crates()
    end, { desc = "Upgrade All Crates" }),
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}
