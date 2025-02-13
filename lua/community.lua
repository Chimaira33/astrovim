-- if true then return {} end

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.completion.cmp-nvim-lua" },
  { import = "astrocommunity.motion.tabout-nvim" },
  { import = "astrocommunity.completion.cmp-under-comparator" },
  { import = "astrocommunity.neovim-lua-development.helpview-nvim" },
  { import = "astrocommunity.completion.magazine-nvim" },
  -- { import = "astrocommunity.completion.blink-cmp" },
  -- { import = "astrocommunity.snippet.nvim-snippets" },
}
