---@diagnostic disable: unused-local
local types = table.concat({ vim.fn.stdpath("config") .. "/types" })

---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts_extend = { "library" },
  opts = {
    library = {
      { path = types },
      { path = "neoconf.nvim" },
      { path = "tokyonight.nvim" },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "lazy.nvim", words = { "Lazy" } },
      { path = "astrocore", words = { "AstroCore" } },
      { path = "astrolsp", words = { "AstroLSP" } },
      { path = "astroui", words = { "AstroUI" } },
      { path = "astrotheme", words = { "AstroTheme" } },
    },
  },
}
