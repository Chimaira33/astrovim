return {
  {
    "jdhao/whitespace.nvim",
    event = "User AstroFile",
    specs = {
      {
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
    },
  },
}
