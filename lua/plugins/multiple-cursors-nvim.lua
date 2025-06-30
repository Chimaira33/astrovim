---@type LazySpec
return {
  "brenton-leighton/multiple-cursors.nvim",
  cmd = {
    "MultipleCursorsAddDown",
    "MultipleCursorsAddUp",
    "MultipleCursorsAddMatches",
    "MultipleCursorsAddMatchesV",
    "MultipleCursorsAddJumpNextMatch",
    "MultipleCursorsJumpNextMatch",
    "MultipleCursorsLock",
  },
  dependencies = {
    { "AstroNvim/astroui", opts = { icons = { MultipleCursors = "󰗧" } } },
    {
      "AstroNvim/astrocore",
      -- opts = { mappings = { n = { ["<C-Down>"] = function() vim.cmd.MultipleCursorsAddDown() end, ["<C-Up>"] = function() vim.cmd.MultipleCursorsAddUp() end, ["<Leader>ma"] = function() vim.cmd.MultipleCursorsAddMatches() end, ["<Leader>mj"] = function() vim.cmd.MultipleCursorsAddJumpNextMatch() end }, i = { ["<C-Down>"] = function() vim.cmd.MultipleCursorsAddDown() end, ["<C-Up>"] = function() vim.cmd.MultipleCursorsAddUp() end }, x = { ["<Leader>ma"] = function() vim.cmd.MultipleCursorsAddMatches() end, ["<Leader>mj"] = function() vim.cmd.MultipleCursorsAddJumpNextMatch() end } } },
      opts = function(_, opts)
        local maps = require("astrocore").extend_tbl(opts.mappings or {}, _)
        for lhs, map in pairs({
          ["<C-Down>"] = function()
            vim.cmd.MultipleCursorsAddDown()
          end,
          ["<C-Up>"] = function()
            vim.cmd.MultipleCursorsAddUp()
          end,
        }) do
          maps.n[lhs] = map
          maps.i[lhs] = map
        end
        local prefix = "<Leader>m"
        for lhs, map in pairs({
          [prefix .. "a"] = function()
            vim.cmd.MultipleCursorsAddMatches()
          end,
          [prefix .. "j"] = function()
            vim.cmd.MultipleCursorsAddJumpNextMatch()
          end,
        }) do
          maps.n[lhs] = map
          maps.x[lhs] = map
        end
      end,
    },
  },
  opts = {},
}
