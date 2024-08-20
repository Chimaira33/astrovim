-- if true then return {} end
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      highlights = { background = { italic = true }, buffer_selected = { bold = true } },
      ---@class bufferline.Options
      options = {
        -- keymap = { normal_mode = {} },
        mode = "buffers",
        numbers = "none",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        -- always_show_bufferline = false,
        navigation = { mode = "uncentered" },
        indicator = { style = "icon" },
        max_name_length = 12,
        max_prefix_length = 9,
        truncate_names = true,
        tab_size = 12,
        diagnostics = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        sort_by = "id",
        -- hover = {
        --   enabled = false,
        --   delay = 200,
        --   reveal = { "close" },
        -- },
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local buff = require("bufferline.commands")
          return require("astrocore").extend_tbl(opts, {
            mappings = {
              n = {
                --stylua: ignore
                ["zn"] = function() buff.cycle(vim.v.count1) end,
                --stylua: ignore
                ["zb"] = function() buff.cycle(-vim.v.count1) end,
                --stylua: ignore
                ["ca"] = function() buff.close_others() end,
                --stylua: ignore
                ["cp"] = function() buff.close_with_pick() end,
                --stylua: ignore
                ["cb"] = function() buff.pick() end,
                --stylua: ignore
                ["cl"] = function() buff.close_in_direction("left") end,
                --stylua: ignore
                ["cr"] = function() buff.close_in_direction("right") end,
              },
            },
          })
        end,
      },
      { import = "astrocommunity.recipes.disable-tabline" },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        optional = true,
        opts = function(_, opts)
          table.insert(opts.library, { path = "bufferline.nvim", words = { "bufferline" } })
        end,
      },
    },
  },
}
