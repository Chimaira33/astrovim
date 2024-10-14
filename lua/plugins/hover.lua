---@diagnostic disable: missing-fields
local bufnr = vim.api.nvim_get_current_buf()
return {
  "lewis6991/hover.nvim",
  lazy = true,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        options = { opt = { mousemoveevent = false } },
        mappings = {
          n = {
            --stylua: ignore
            ["K"] = function() require("hover").hover({ bufnr = bufnr }) end,
          },
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      opts = { mappings = { n = { ["K"] = false } } },
    },
  },
  opts = {
    --stylua: ignore
    init = function() require("hover.providers.lsp") end,
    title = false,
  },
}
