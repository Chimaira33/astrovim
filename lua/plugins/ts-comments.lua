--stylua: ignore
if true then return {} end

do
  local operator_rhs = function()
    return require("vim._comment").operator()
  end
  vim.keymap.set("x", "mm", operator_rhs, { expr = true, desc = "Toggle comment" })

  local line_rhs = function()
    return require("vim._comment").operator() .. "_"
  end
  vim.keymap.set("n", "mm", line_rhs, { expr = true, desc = "Toggle comment line" })

  local textobject_rhs = function()
    require("vim._comment").textobject()
  end
  vim.keymap.set({ "o" }, "mm", textobject_rhs, { desc = "Comment textobject" })
end
return {
  "folke/ts-comments.nvim",
  opts = {},
  specs = {
    {
      "numToStr/Comment.nvim",
      opts = function(_, opts)
        opts.mappings = {
          basic = true,
          extra = false,
        }
        opts.opleader = { block = "zg" }
      end,
      keys = {},
      -- specs = { { "AstroNvim/astrocore", opts = { mappings = { n = { ["mm"] = function() require("Comment.api").toggle.linewise.count(vim.v.count1) end }, v = { ["mm"] = "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>" } } } } },
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", optional = true, enabled = false },
  },
}
