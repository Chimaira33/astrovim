if true then return {} end

---@type LazySpec
return {
  "garymjr/nvim-snippets",
  lazy = true,
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = { friendly_snippets = true },
  specs = {
    { "L3MON4D3/LuaSnip", optional = true, enabled = false },
    -- {
    --   "hrsh7th/nvim-cmp",
    --   enabled = false,
    --   optional = true,
    --   dependencies = { "garymjr/nvim-snippets" },
    --   opts = function(_, opts)
    --     --stylua: ignore
    --     if not opts.sources then opts.sources = {} end
    --     table.insert(opts.sources, { name = "snippets", priority = 750 })
    --   end,
    -- },
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = { snippets = { preset = "default" } },
    },
    {
      "danymat/neogen",
      optional = true,
      opts = { snippet_engine = "nvim" },
    },
  },
}
