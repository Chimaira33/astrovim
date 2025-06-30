---@diagnostic disable: missing-fields
---@type LazySpec
return {
  "RRethy/nvim-treesitter-endwise",
  event = "User AstroFile",
  require("nvim-treesitter.configs").setup({
    endwise = {
      enable = true,
    },
  }),
}
