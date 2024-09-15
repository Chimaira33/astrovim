return {
  {
    "kylechui/nvim-surround",
    -- version = "*",
    branch = "main",
    event = "VeryLazy",
    opts = function(_, opts)
      --stylua: ignore
      return require("astrocore").extend_tbl(opts, { keymaps = { normal_cur = "Y", visual = "S", visual_line = "gS", delete = "ds", change = "cs" }, aliases = { ["b"] = "}", ["a"] = "'", ["B"] = "]", ["p"] = ")", ["q"] = '"' } })
    end,
    specs = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        return require("astrocore").extend_tbl(opts, {
          mappings = {
            x = {
              ["z["] = "<Plug>(nvim-surround-visual)B",
              ["za"] = "<Plug>(nvim-surround-visual)a",
              ["zb"] = "<Plug>(nvim-surround-visual)b",
              ["zp"] = "<Plug>(nvim-surround-visual)p",
              ["zq"] = "<Plug>(nvim-surround-visual)q",
            },
          },
        })
      end,
    },
  },
}
