return {
  "Saecki/crates.nvim",
  tag = "stable",
  lazy = true,
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-u>"] = "<Cmd>lua require('crates').update_crate()<CR>",
          ["<A-u>"] = "<Cmd>lua require('crates').update_all_crates()<CR>",
        },
      },
      autocmds = {
        CmpSourceCargo = {
          {
            event = "BufRead",
            desc = "Load crates.nvim into Cargo buffers",
            pattern = "Cargo.toml",
            callback = function()
              require("cmp").setup.buffer({
                sources = {
                  { name = "crates" },
                },
              })
              require("crates")
            end,
          },
        },
      },
    },
  },
  opts = {
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}
