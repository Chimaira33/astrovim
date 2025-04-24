-- if true then
--   return {}
-- end
return {
  "ggandor/leap.nvim",
  dependencies = {
    { "tpope/vim-repeat" },
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = { ["<C-p>"] = "<Plug>(leap)" },
          x = { ["<C-p>"] = "<Plug>(leap)" },
          o = { ["<C-p>"] = "<Plug>(leap)" },
        },
      },
    },
  },
  opts = {
    preview_filter = function(ch0, ch1, ch2)
      return not (ch1:match("%s") or ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
    end,
    equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
    user = {
      set_repeat_keys = { "<enter>", "<backspace>" },
    },
    safe_labels = {},
  },
}
-- return {
--   {
--     "smoka7/hop.nvim",
--     version = "*",
--     event = "User AstroFile",
--     opts = {},
--     specs = {
--       "AstroNvim/astrocore",
--       ---@type AstroCoreOpts
--       opts = {
--         mappings = {
--           n = {
--             ["<C-h>"] = "<Cmd>HopWord<CR>",
--             ["<C-l>"] = "<Cmd>HopLineStart<CR>",
--             ["<C-p>"] = "<Cmd>HopPattern<CR>",
--           },
--         },
--       },
--     },
--   },
-- }
