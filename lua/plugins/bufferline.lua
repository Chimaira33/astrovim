return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      highlights = {
        background = { italic = true },
        buffer_selected = { bold = true },
      },
      options = {
        keymap = { normal_mode = {} },
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
        indicator = { style = "icon" },
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        hover = {
          enabled = false,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "id",
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts)
      opts.tabline = nil
    end,
  },
}
