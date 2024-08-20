return {
  {
    "kaplanz/retrail.nvim",
    event = "User AstroFile",
    opts = {
      hlgroup = "TabLineSel",
      pattern = "\\v((.*%#)@!|%#)\\s+$",
      filetype = {
        strict = false,
        include = {},
        exclude = {
          "",
          "aerial",
          "alpha",
          "checkhealth",
          "cmp_menu",
          "diff",
          "lazy",
          "lspinfo",
          "man",
          "mason",
          "TelescopePrompt",
          "toggleterm",
          "Trouble",
          "WhichKey",
        },
      },
      buftype = {
        strict = false,
        include = {},
        exclude = {
          "dashboard",
          "help",
          "nofile",
          "prompt",
          "quickfix",
          "terminal",
        },
      },
      trim = {
        auto = true,
        whitespace = true,
        blanklines = true,
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<C-i>"] = "<Cmd>RetrailTrimWhitespace<CR>",
            },
          },
        },
      },
    },
  },
}
