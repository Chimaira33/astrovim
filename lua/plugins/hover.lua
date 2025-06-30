---@diagnostic disable: missing-fields, unused-local, unused-function
local function bufnr()
  return vim.fn.bufnr(vim.fn.bufname(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())))
end
---@type LazySpec
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
            ["K"] = function() if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then require("crates").show_popup() else require("hover").hover({ bufnr = bufnr() }) end end,
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
