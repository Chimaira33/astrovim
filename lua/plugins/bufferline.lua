---@diagnostic disable: missing-fields
-- if true then return {} end
---@type LazySpec
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    ---@type bufferline.Config
    opts = {
      highlights = {
        separator = { fg = "#000000", bg = "#000000" },
        fill = { fg = "#000000", bg = "#000000" },
        tab = {
          italic = false,
          bold = false,
          fg = "#5c7eb6",
          bg = "#000000",
        },
        tab_selected = {
          italic = false,
          bold = true,
          fg = "#7aa2f7",
          bg = "#000000",
        },
        background = {
          italic = true,
          bold = false,
          fg = "#686f8e",
          bg = "#000000",
        },
        buffer_selected = {
          italic = false,
          bold = true,
          fg = "#cad4ff",
          bg = "#000000",
        },
        buffer_visible = {
          fg = "#000000",
          bg = "#000000",
        },
        tab_separator = {
          italic = false,
          bold = false,
          fg = "#000000",
          bg = "#000000",
          underline = false,
        },
        tab_separator_selected = {
          italic = false,
          bold = false,
          fg = "#000000",
          bg = "#000000",
          underline = false,
        },
      },
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
        indicator = {
          style = "icon",
          icon = "",
        },
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
        hover = {
          enabled = false,
          delay = 200,
          reveal = { "close" },
        },
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
                ["cc"] = function() buff.unpin_and_close(vim.fn.bufnr(vim.fn.bufname(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())))) end,
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
        --stylua: ignore
        if not opts.library then opts.library = {} end
          table.insert(opts.library, { path = "bufferline.nvim", words = { "bufferline" } })
        end,
      },
    },
  },
}
