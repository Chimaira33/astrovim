---@type LazySpec
return {
  "RRethy/vim-illuminate",
  -- enabled = false,
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
    {
      "AstroNvim/astroui",
      ---@param opts AstroUIOpts
      opts = function(_, opts)
        local settings = { underline = true, bold = true }
        opts.highlights = require("astrocore").extend_tbl(opts.highlights or {}, {
          init = {
            IlluminatedWordRead = settings,
            IlluminatedWordText = settings,
            IlluminatedWordWrite = settings,
            illuminatedCurWord = settings,
            illuminatedWord = settings,
          },
        })
      end,
    },
  },
  opts = {},
}
