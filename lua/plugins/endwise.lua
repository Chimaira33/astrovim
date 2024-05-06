---@diagnostic disable: missing-fields
return {
  "RRethy/nvim-treesitter-endwise",
  event = "User AstroFile",
  require("nvim-treesitter.configs").setup({
    endwise = {
      enable = true,
    },
  }),
}
