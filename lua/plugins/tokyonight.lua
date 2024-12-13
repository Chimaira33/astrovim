---@diagnostic disable: missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "tokyonight",
      highlights = {},
    },
    specs = {
      {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        ---@class tokyonight.Config
        opts = {
          style = "night",
          -- transparent = false,
          terminal_colors = true,
          ---@type table<string, boolean|{enabled:boolean}>
          plugins = {
            all = package.loaded.lazy == nil,
            -- all = false,
            auto = true,
            --[[ ["alpha-nvim"] = true,
            ["bufferline.nvim"] = true,
            ["gitsigns.nvim"] = true,
            ["hop.nvim"] = true,
            ["indent-blankline.nvim"] = true,
            ["lazy.nvim"] = true,
            ["neo-tree.nvim"] = true,
            ["neogit"] = true,
            ["nvim-cmp"] = true,
            ["nvim-notify"] = true,
            ["nvim-treesitter-context"] = true,
            ["telescope.nvim"] = true,
            ["trouble.nvim"] = true,
            ["vim-illuminate"] = true, ]]
            -- add any plugins here that you want to enable
            -- for all possible plugins, see:
            --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
            telescope = true,
          },
          styles = {
            comments = { italic = false },
            keywords = { italic = false },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
          },
          sidebars = {
            "NeoTree",
            "NeogitStatus",
            "help",
            "terminal",
            "qf",
          },
          dim_inactive = false,
          lualine_bold = false,
          ---@param colors ColorScheme
          on_colors = function(colors)
            colors.bg = "#000000"
            colors.bg_dark = colors.bg
            colors.bg_float = colors.bg
            colors.bg_popup = colors.bg
            colors.bg_sidebar = colors.bg
            colors.bg_statusline = colors.bg
            colors.terminal_black = "#555e87"
            colors.git = {
              add = colors.green,
              change = colors.blue,
              delete = colors.red,
            }
          end,
          ---@param highlights tokyonight.Highlights
          ---@param colors ColorScheme
          on_highlights = function(highlights, colors)
            local dark_bg = "#000000"
            highlights.Comment = { fg = colors.comment }
            highlights.IndentBlanklineContextChar = { fg = colors.dark5 }
            highlights.TSConstructor = { fg = colors.blue1 }
            highlights.TSTagDelimiter = { fg = colors.dark5 }
            highlights.Folded = { fg = dark_bg, bg = dark_bg }
            local prompt = dark_bg
            -- local prompt = "#2d3149"
            highlights.TelescopeNormal = {
              bg = dark_bg,
              fg = colors.fg,
            }
            highlights.TelescopeBorder = {
              bg = dark_bg,
              fg = colors.bg_dark,
            }
            highlights.TelescopePromptNormal = {
              bg = prompt,
            }
            highlights.TelescopePromptBorder = {
              bg = prompt,
              fg = prompt,
            }
            highlights.TelescopePromptTitle = {
              bg = prompt,
              fg = prompt,
            }
            highlights.TelescopePreviewTitle = {
              bg = dark_bg,
              fg = colors.bg_dark,
            }
            highlights.TelescopeResultsTitle = {
              bg = dark_bg,
              fg = colors.bg_dark,
            }
          end,
        },
      },
    },
  },
}
