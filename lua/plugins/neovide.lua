--stylua: ignore
if not vim.g.neovide then return {} end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        guifont = "JetBrainsMono Nerd Font Mono:h16",
        linespace = 1,
      },
      g = {
        neovide_increment_scale_factor = vim.g.neovide_increment_scale_factor or 0.1,
        neovide_min_scale_factor = vim.g.neovide_min_scale_factor or 0.7,
        neovide_max_scale_factor = vim.g.neovide_max_scale_factor or 2.0,
        neovide_initial_scale_factor = vim.g.neovide_scale_factor or 1,
        neovide_scale_factor = vim.g.neovide_scale_factor or 1,
        neovide_padding_top = 0,
        neovide_padding_bottom = 0,
        neovide_padding_right = 0,
        neovide_padding_left = 0,
        neovide_scroll_animation_length = 0.2,
        neovide_cursor_animation_length = 0.072,
        neovide_cursor_trail_size = 0.48,
        neovide_cursor_antialiasing = true,
      },
    },
    mappings = {
      c = {
        ["<C-S-V>"] = "<C-R>+",
      },
      i = {
        ["<C-S-V>"] = "<C-R>+",
      },
      n = {
        ["y"] = '"+y',
        ["p"] = '"+p',
      },
      v = {
        ["y"] = '"+y',
        ["p"] = '"+p',
      },
    },
  },
}
