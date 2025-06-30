---@type LazySpec
return {
  "uga-rosa/ccc.nvim",
  event = { "User AstroFile", "InsertEnter" },
  cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  opts = {
    highlighter = {
      auto_enable = false,
      lsp = true,
    },
  },
  specs = {
    { "brenoprata10/nvim-highlight-colors", enabled = false },
    { "NvChad/nvim-colorizer.lua", enabled = false },
  },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>cc"] = "<Cmd>CccHighlighterToggle<CR>",
            ["<Leader>cp"] = "<Cmd>CccPick<CR>",
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("ccc").setup(opts)
    if opts.highlighter and opts.highlighter.auto_enable then
      vim.cmd.CccHighlighterEnable()
    end
  end,
}
