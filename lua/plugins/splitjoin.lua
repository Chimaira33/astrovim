return {
  {
    "Wansmer/treesj",
    event = "BufEnter",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = function(_, opts)
      opts.use_default_keymaps = false
      opts.max_join_length = 840
    end,
    specs = {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          ---@type AstroCoreOpts
          mappings = {
            n = {
              ["zj"] = "<Cmd>TSJToggle<CR>",
            },
          },
        })
      end,
    },
  },
}
