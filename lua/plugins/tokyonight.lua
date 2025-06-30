---@diagnostic disable: missing-fields
-- --stylua: ignore
-- if true then return {} end

---@type LazySpec
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 2000,
    dependencies = {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        colorscheme = "tokyonight",
      },
    },
    ---@class tokyonight.Config
    opts = {
      style = "night",
      terminal_colors = true,
      ---@type table<string, boolean|{enabled:boolean}>
      plugins = {
        all = package.loaded.lazy == nil,
        auto = true,
        telescope = false,
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
        "help",
        "terminal",
        "qf",
      },
      dim_inactive = false,
      lualine_bold = true,
      ---@param colors ColorScheme
      on_colors = function(colors)
        local dark_bg = "#000000"
        colors.bg = dark_bg
        colors.bg_dark = dark_bg
        colors.bg_float = dark_bg
        colors.bg_popup = dark_bg
        colors.bg_search = dark_bg
        colors.bg_sidebar = dark_bg
        colors.bg_statusline = dark_bg
        colors.bg_highlight = "#292e42"
        colors.blue = "#7aa2f7"
        colors.blue0 = "#3d59a1"
        colors.blue1 = "#F7778F"
        colors.blue2 = "#0db9d7"
        colors.blue5 = "#89ddff"
        colors.blue6 = "#b4f9f8"
        colors.blue7 = "#394b70"
        colors.comment = "#565f89"
        colors.cyan = "#7dcfff"
        colors.dark3 = "#545c7e"
        colors.dark5 = "#737aa2"
        colors.fg = "#c0caf5"
        colors.fg_dark = "#a9b1d6"
        colors.fg_gutter = "#3b4261"
        colors.green = "#9ece6a"
        colors.green1 = "#37f499"
        colors.green2 = "#41a6b5"
        colors.magenta = "#9d7cd8"
        colors.magenta2 = "#f7768e"
        colors.orange = "#ff9e64"
        colors.purple = "#a48cf2"
        colors.red = "#f7768e"
        colors.red1 = "#db4b4b"
        colors.teal = "#1abc9c"
        colors.terminal_black = "#414868"
        colors.yellow = "#d29b68"
        colors.git = { add = "#37f499", change = "#6183bb", delete = "#914c54" }
        colors.terminal_black = "#555e87"
        -- colors.git = { add = colors.green, change = colors.blue, delete = colors.red }
      end,
    },
  },
}
