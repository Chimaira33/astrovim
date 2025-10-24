---@diagnostic disable: unused-local, missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      features = {
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
      },
      servers = {
        "vimls",
      },
      -- config = {},
      -- handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end
      -- cmake = false,
      -- golangci_lint_ls = false,
      -- },
      autocmds = {
        no_paste = {
          {
            event = { "InsertLeave" },
            desc = "No Paste",
            callback = function()
              vim.cmd("set nopaste")
            end,
          },
        },
      },
    },
  },
}
