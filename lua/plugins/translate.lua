--stylua: ignore
if true then return {} end
return {
  "potamides/pantran.nvim",
  opts = {
    default_engine = "google",
    -- Configuration for individual engines goes here.
    controls = {
      mappings = {
        edit = {
          n = {},
          i = {},
        },
        -- Keybindings here are used in the selection window.
        select = { n = {} },
      },
    },
  },
  specs = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        ---@type AstroCoreOpts
        mappings = {
          n = {
            ["<leader>tr"] = function()
              return require("pantran").motion_translate() .. "_"
            end,
          },
          x = {
            ["<leader>tr"] = require("pantran").motion_translate(),
          },
        },
      })
    end,
  },
}
