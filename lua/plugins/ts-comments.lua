--stylua: ignore
local comment = function() return require("vim._comment").operator() .. "_" end
--stylua: ignore
local vcomment = function() return require("vim._comment").operator() end
return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = { ["mm"] = comment() },
          x = { ["mm"] = vcomment() },
        },
      },
    },
    {
      "numToStr/Comment.nvim",
      opts = { opleader = { block = "zg" } },
      -- specs = { { "AstroNvim/astrocore", opts = { mappings = { n = { ["mm"] = function() require("Comment.api").toggle.linewise.count(vim.v.count1) end }, v = { ["mm"] = "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" } } } } },
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", optional = true, enabled = false },
  },
}
