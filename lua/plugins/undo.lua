---@type LazySpec
return {
  {
    "kevinhwang91/nvim-fundo",
    requires = "kevinhwang91/promise-async",
    run = function()
      require("fundo").install()
    end,
    specs = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = { options = { opt = { undofile = true } } },
    },
  },
  -- {
  --   "mbbill/undotree",
  --   keys = {
  --     {
  --       "<Leader>tu",
  --       function()
  --         vim.cmd.UndotreeToggle()
  --       end,
  --       desc = "toggle undo tree",
  --     },
  --   },
  --   specs = {
  --     "AstroNvim/astrocore",
  --     ---@type AstroCoreOpts
  --     opts = {
  --       options = {
  --         g = {
  --           undotree_ShortIndicators = true,
  --           undotree_SetFocusWhenToggle = true,
  --         },
  --       },
  --     },
  --   },
  -- },
}
