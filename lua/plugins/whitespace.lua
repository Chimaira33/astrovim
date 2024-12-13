return {
  --[[ {
    "kaplanz/retrail.nvim",
    event = "User AstroFile",
    opts = {
      hlgroup = "TabLineSel",
      pattern = "\\v((.*%#)@!|%#)\\s+$",
      filetype = {
        strict = false,
        include = {},
        --stylua: ignore
        exclude = { "", "aerial", "alpha", "checkhealth", "cmp_menu", "diff", "lazy", "lspinfo", "man", "mason", "TelescopePrompt", "toggleterm", "Trouble", "WhichKey" },
      },
      buftype = {
        strict = false,
        include = {},
        exclude = { "dashboard", "help", "markdown", "nofile", "prompt", "quickfix", "terminal" },
      },
      trim = { auto = true, whitespace = true, blanklines = true },
    },
    specs = { {"AstroNvim/astrocore", opts = { mappings = { n = { ["<C-i>"] = "<Cmd>RetrailTrimWhitespace<CR>" } } } } },
  }, ]]
  {
    "cappyzawa/trim.nvim",
    event = "User AstroFile",
    opts = {
      --stylua: ignore
      ft_blocklist = { "", "TelescopePrompt", "Trouble", "WhichKey", "aerial", "alpha", "checkhealth", "cmp_menu", "dashboard", "diff", "grug-far", "help", "lazy", "lspinfo", "man", "markdown", "mason", "nofile", "prompt", "quickfix", "terminal", "text", "toggleterm" },
      patterns = { [[%s/\(\n\n\)\n\+/\1/]] },
      trim_on_write = false,
      trim_trailing = true,
      trim_last_line = true,
      trim_first_line = true,
      highlight = true,
      highlight_bg = "#7aa2f7",
      highlight_ctermbg = "blue",
      notifications = false,
    },
    specs = { { "AstroNvim/astrocore", opts = { mappings = { n = { ["<C-i>"] = "<Cmd>Trim<CR>" } } } } },
  },
}
