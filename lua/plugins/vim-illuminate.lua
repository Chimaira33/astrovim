return {
  "RRethy/vim-illuminate",
  commit = "fbc16de",
  event = "User AstroFile",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(plugin, opts)
        require("astronvim.plugins.configs.vim-illuminate")(plugin, opts)
        local maps = opts.mappings
        maps.n["r>"] = function()
          require("illuminate").goto_next_reference(true)
        end
        maps.n["r<"] = function()
          require("illuminate").goto_prev_reference(true)
        end
        maps.n["<Leader>ur"] = function()
          require("illuminate").toggle_buf()
        end

        maps.n["<Leader>uR"] = function()
          require("illuminate").toggle()
        end
      end,
    },
  },
  opts = {},
}
