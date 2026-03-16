---@type LazySpec
return {
  -- "RunnyC/translator.nvim",
  -- cmd = { "Translate", "TranslateClipboard" },
  -- keys = {
  --   { "<Leader>tr", mode = "v" },
  --   { "<Leader>tc", mode = "n" },
  -- },
  -- opts = {
  --   translate_to_language = "en",
  --   debug = false,
  -- },
  "uga-rosa/translate.nvim",
  cmd = { "Translate" },
  opts = {
    default = {
      command = "translate_shell",
      output = "replace",
    },
    -- preset = { output = { split = { append = true } } },
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          -- n = { ["<C-u>"] = function() require("neoscroll").ctrl_u({ duration = 150 }) end },
          n = { ["<Leader>k"] = "<Cmd>Translate EN<CR><ESC>" },
          v = { ["<Leader>k"] = "<Cmd>Translate EN<CR><ESC>" },
        },
      },
    },
  },
}
