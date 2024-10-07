---@diagnostic disable: unused-local
local types = table.concat({ vim.fn.stdpath("config") .. "/types" })

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        "lazy.nvim",
        types,
        "neoconf.nvim",
        "nvim-cmp",
        "tokyonight.nvim",
      },
    },
    -- opts = function(_, opts)
    --   table.insert(opts, {
    --     library = {
    --       "lazy.nvim",
    --       "~/.local/share/nvim/runtime/types",
    --       "neoconf.nvim/types",
    --       "nvim-cmp/lua/cmp/types",
    --     },
    --   })
    --   --[[ opts.library = {
    --       -- { path = "noice.nvim", words = { "Noice" } },
    --       "~/.local/share/nvim/runtime/types",
    --       "neoconf.nvim/types",
    --       "nvim-cmp/lua/cmp/types",
    --     } ]]
    -- end,
  },
}
