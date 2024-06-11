return {
  "nvimtools/none-ls.nvim",
  dependencies = { "gbprod/none-ls-shellcheck.nvim" },
  opts = function()
    local nls = require("null-ls")
    nls.register(require("none-ls-shellcheck.code_actions"))
  end,
}
