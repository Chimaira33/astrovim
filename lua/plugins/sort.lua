return {
  "sQVe/sort.nvim",
  opts = {},
  specs = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        x = {
          ["<C-s>"] = { ":Sort<CR>", silent = true },
          ["<C-u>"] = { ":Sort u<CR>", silent = true },
        },
      },
    },
  },
}
