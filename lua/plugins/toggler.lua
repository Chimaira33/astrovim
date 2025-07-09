local list = {
  [" \\"] = "",
  ["!"] = "not",
  ["!="] = "==",
  ["&&"] = "||",
  [">/dev/null 2>&1"] = "&>/dev/null",
  ["1"] = "0",
  ["and"] = "or",
  ["ENABLE"] = "DISABLE",
  ["ENABLED"] = "DISABLED",
  ["Enabled"] = "Disabled",
  ["enable"] = "disable",
  ["enabled"] = "disabled",
  ["include"] = "exclude",
  ["left"] = "right",
  ["ON"] = "OFF",
  ["On"] = "Off",
  ["on"] = "off",
  ["True"] = "False",
  ["true"] = "false",
  ["Y"] = "N",
  ["Yes"] = "No",
  ["y"] = "n",
  ["yes"] = "no",
  ["UP"] = "DOWN",
  ["up"] = "down",
  ["declare"] = "local",
  ["while"] = "until",
  ["set +"] = "set -",
  ["& -n"] = "& -z",
  ["[ -n"] = "[ -z",
  ["| -n"] = "| -z",
}

---@type LazySpec
return {
  "nguyenvukhang/nvim-toggler",
  event = { "User AstroFile", "InsertEnter" },
  specs = {
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
  opts = {
    remove_default_inverses = true,
    remove_default_keybinds = true,
    inverses = list,
    autoselect_longest_match = true,
  },
}
