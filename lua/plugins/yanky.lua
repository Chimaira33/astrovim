return {
  "gbprod/yanky.nvim",
  dependencies = {
    { "kkharji/sqlite.lua", enabled = true },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            -- ["<Leader>fy"] = { "<Cmd>YankyRingHistory<CR>", desc = "Find yanks" },
            ["y"] = { "<Plug>(YankyYank)", desc = "Yank text" },
            ["p"] = { "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor" },
            ["P"] = { "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor" },
            ["]p"] = { "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            ["[p"] = { "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
          },
          x = {
            ["y"] = { "<Plug>(YankyYank)", desc = "Yank text" },
            ["p"] = { "<Plug>(YankyPutAfter)", desc = "Put yanked text after cursor" },
            ["P"] = { "<Plug>(YankyPutBefore)", desc = "Put yanked text before cursor" },
            ["]p"] = { "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
            ["[p"] = { "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
          },
        },
      },
    },
  },
  specs = {
    {
      "folke/snacks.nvim",
      optional = true,
      specs = {
        {
          "AstroNvim/astrocore",
          opts = {
            mappings = {
              n = {
                ["<Leader>fy"] = {
                  function()
                    ---@diagnostic disable-next-line: undefined-field
                    require("snacks").picker.yanky()
                  end,
                  desc = "Find yanks",
                },
              },
            },
          },
        },
      },
    },
  },
  opts = {
    highlight = { timer = 200 },
    ring = {
      history_length = 50,
      storage = "sqlite",
      storage_path = vim.fn.stdpath("state") .. "/databases/yanky.db",
      sync_with_numbered_registers = false,
      cancel_event = "update",
      ignore_registers = { "_" },
      update_register_on_cycle = false,
      permanent_wrapper = nil,
    },
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = "*",
    },
  },
}
