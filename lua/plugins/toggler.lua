return {
  "nguyenvukhang/nvim-toggler",
  event = { "User AstroFile", "InsertEnter" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            --stylua: ignore
            ["<Leader>i"] = function() require("nvim-toggler").toggle() end,
          },
          v = {
            --stylua: ignore
            ["<Leader>i"] = function() require("nvim-toggler").toggle() end,
          },
        },
      },
    },
  },
  opts = function(_, opts)
    opts.remove_default_keybinds = true
    opts.inverses = require("astrocore").extend_tbl(opts.inverses or {}, {
      ["&&"] = "||",
      ["1"] = "0",
      ["ON"] = "OFF",
      ["On"] = "Off",
      ["Yes"] = "No",
      ["and"] = "or",
      ["include"] = "exclude",
      ["enabled"] = "disabled",
      ["Enabled"] = "Disabled",
      ["ENABLED"] = "DISABLED",
    })
  end,
}
