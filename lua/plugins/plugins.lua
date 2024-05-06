---@diagnostic disable: undefined-field, missing-fields
return {
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4",
  --   ft = { "rust" },
  --   config = function()
  --     require("user.rustaceanvim").config()
  --   end,
  -- },
  {
    "folke/neodev.nvim",
    lazy = true,
    opts = {
      setup_jsonls = false,
    },
  },
}
