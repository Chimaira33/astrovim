if true then
  return {}
end

return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  dependencies = { "astronvim/astrocore", opts = { diagnostics = { virtual_text = false } } },
  opts = {},
}
