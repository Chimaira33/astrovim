--[[ if true then
  return {}
end ]]
return {
  { "folke/neodev.nvim", enabled = false },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "astrocore", words = { "AstroCore" } },
        { path = "astrolsp", words = { "AstroLSP" } },
        { path = "astroui", words = { "AstroUI" } },
        { path = "astrotheme", words = { "AstroTheme" } },
        { path = "lazy.nvim", words = { "Lazy" } },
        -- { path = "noice.nvim", words = { "Noice" } },
        --[[ "luvit-meta/library",
        "astrocore",
        "astrolsp",
        "astroui",
        "astrotheme",
        "lazy.nvim", ]]
        "~/.local/share/nvim/runtime/types",
        "neoconf.nvim/types",
        "nvim-cmp/lua/cmp/types",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "lazydev" })
    end,
  },
}
