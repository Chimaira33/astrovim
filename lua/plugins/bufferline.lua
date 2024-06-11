-- if true then return {} end
return {
  { import = "astrocommunity.recipes.disable-tabline" },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      highlights = { background = { italic = true }, buffer_selected = { bold = true } },
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
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            --stylua: ignore
            ["zn"] = function() require("bufferline.commands").cycle(vim.v.count1) end,
            --stylua: ignore
            ["zb"] = function() require("bufferline.commands").cycle(-vim.v.count1) end,
            --stylua: ignore
            ["<C-A-n>"] = function() require("bufferline.commands").move(vim.v.count1) end,
            --stylua: ignore
            ["<C-A-b>"] = function() require("bufferline.commands").move(-vim.v.count1) end,
          },
        },
      },
    },
  },
}
