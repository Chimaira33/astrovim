return {
  {
    "akinsho/bufferline.nvim",
    event = "User AstroFile",
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
        navigation = { mode = "uncentered" },
        indicator = { style = "icon" },
        max_name_length = 12,
        max_prefix_length = 9,
        truncate_names = true,
        tab_size = 12,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
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
        -- sort_by = "id",
        sort_by = "insert_after_current",
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
