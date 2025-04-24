local spath = table.concat({ vim.fn.stdpath("config") .. "/snippets" })
return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  config = function(plugin, opts)
    require("astronvim.plugins.configs.luasnip")(plugin, opts)
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = spath,
    })
  end,
  specs = {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = spath,
    },
  },
}
