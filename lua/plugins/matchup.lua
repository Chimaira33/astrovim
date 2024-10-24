return {
  {
    "andymass/vim-matchup",
    lazy = true,
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            g = {
              -- matchup_matchparen_offscreen = {},
              matchup_matchparen_offscreen = {
                method = "popup",
                fullwidth = 1,
                highlight = "Normal",
                syntax_hl = 1,
              },
              matchup_matchparen_deferred = 1,
              matchup_matchparen_pumvisible = 0,
              matchup_matchparen_nomode = "i",
            },
          },
          mappings = {
            n = {
              ["gj"] = "V<Cmd>call matchup#motion#find_matching_pair(0, 1)<CR>:'<,'>join<CR>",
              ["gv"] = "V<Cmd>call matchup#motion#find_matching_pair(0, 1)<CR>",
              ["gV"] = "V<Cmd>call matchup#motion#find_matching_pair(0, 0)<CR>",
              ["gd"] = 'V<Cmd>call matchup#motion#find_matching_pair(0, 1)<CR>"_D',
              ["gD"] = 'V<Cmd>call matchup#motion#find_matching_pair(0, 0)<CR>"_D',
            },
          },
        },
      },
      {
        "AstroNvim/astrolsp",
        ---@param opts AstroLSPOpts
        opts = function(_, opts)
          opts.mappings.n.gd[1] = nil
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "andymass/vim-matchup" },
        opts = { matchup = { enable = true } },
      },
    },
  },
}
