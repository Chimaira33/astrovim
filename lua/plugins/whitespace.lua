return {
  "jdhao/whitespace.nvim",
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-i>"] = "<Cmd>StripTrailingWhitespace<CR>",
        },
      },
    },
  },
}
