---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "tokyonight",
    highlights = {},
  },
  dependencies = {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      hide_inactive_statusline = true,
      -- transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = {
        "terminal",
        "NeogitStatus",
        "help",
      },
      dim_inactive = false,
      lualine_bold = false,
      use_background = true,
      on_colors = function(c)
        c.bg = "#000000"
        c.bg_dark = c.bg
        c.bg_float = c.bg
        c.bg_popup = c.bg
        c.bg_sidebar = c.bg
        c.bg_statusline = c.bg
        c.terminal_black = "#555e87"
      end,
      on_highlights = function(hl, c)
        hl.Comment = { fg = c.comment }
        hl.IndentBlanklineContextChar = { fg = c.dark5 }
        hl.TSConstructor = { fg = c.blue1 }
        hl.TSTagDelimiter = { fg = c.dark5 }
        hl.Folded = { fg = "#000000", bg = "#000000" }
      end,
    },
  },
}
