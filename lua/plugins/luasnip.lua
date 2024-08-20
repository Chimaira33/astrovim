local spath = table.concat({ vim.fn.stdpath("config") .. "/snippets" })
return {
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    require("astronvim.plugins.configs.luasnip")(_, opts)
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
