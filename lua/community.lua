-- if true then return {} end

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.lsp.garbage-day-nvim" },
  -- { import = "astrocommunity.bars-and-lines.feline-nvim" },
  -- import/override with your plugins folder
}
