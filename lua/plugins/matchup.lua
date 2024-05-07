return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "andymass/vim-matchup",
      dependencies = {
        {
          "AstroNvim/astrocore",
          opts = {
            options = {
              g = {
                -- matchup_matchparen_offscreen = {},
                matchup_matchparen_offscreen = { method = "popup", fullwidth = 1, highlight = "Normal", syntax_hl = 1 },
              },
            },
            mappings = {
              n = {
                ["gv"] = "V<Cmd>call matchup#motion#find_matching_pair(0, 0)<CR>",
                ["gd"] = 'V<Cmd>call matchup#motion#find_matching_pair(0, 1)<CR>"_D',
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
      },
    },
  },
  opts = { matchup = { enable = true } },
}
