-- if true then return {} end

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  { import = "astrocommunity.completion.cmp-nvim-lua" },
}
