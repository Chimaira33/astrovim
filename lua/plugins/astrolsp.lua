---@diagnostic disable: unused-local, missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      capabilities = {
        general = { positionEncodings = { "utf-8", "utf-16" } },
        workspace = {
          foldingRange = { refreshSupport = false },
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
        textDocument = { foldingRange = { dynamicRegistration = false } },
      },
      features = {
        codelens = true,
        inlay_hints = false,
        semantic_tokens = true,
        signature_help = false,
      },
      servers = {
        "vimls",
      },
      -- native_lsp_config = true,
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
      file_operations = {
        operations = {
          willRename = false,
          didRename = false,
          willCreate = false,
          didCreate = false,
          willDelete = false,
          didDelete = false,
        },
      },
    },
  },
}
