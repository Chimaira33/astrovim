require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  -- install = { colorscheme = { "astrodark", "habamax" } },
  ui = { backdrop = 100 },
  checker = {
    enabled = false,
  },
  rocks = { enabled = false },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins, add more to your liking
      --stylua: ignore
      disabled_plugins = { "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "matchit", "matchparen", "netrw", "netrwFileHandlers", "netrwPlugin", "netrwSettings", "rrhelper", "spellfile_plugin", "tar", "tarPlugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "node_provider", "python3_provider", "perl_provider", "ruby_provider" },
    },
  },
} --[[@as LazyConfig]])
