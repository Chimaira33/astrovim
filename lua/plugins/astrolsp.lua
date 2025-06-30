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
      -- autocmds = {
      --   lsp_document_highlight = {
      --     cond = "textDocument/documentHighlight",
      --     {
      --       event = { "CursorHold", "CursorHoldI" },
      --       desc = "Document Highlighting",
      --       callback = function()
      --         vim.lsp.buf.document_highlight()
      --       end,
      --     },
      --     {
      --       event = { "CursorMoved", "CursorMovedI", "BufLeave" },
      --       desc = "Document Highlighting Clear",
      --       callback = function()
      --         vim.lsp.buf.clear_references()
      --       end,
      --     },
      --   },
      --   lsp_codelens_refresh = {
      --     cond = "textDocument/codeLens",
      --     {
      --       event = { "InsertLeave", "BufEnter" },
      --       desc = "Refresh codelens (buffer)",
      --       callback = function(args)
      --         if require("astrolsp").config.features.codelens then
      --           vim.lsp.codelens.refresh({ bufnr = args.buf })
      --         end
      --       end,
      --     },
      --   },
      -- },
      -- mappings to be set up on attaching of a language server
      --[[ mappings = {
      n = {
        -- gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    }, ]]
    },
  },
  --[[ {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  }, ]]
}
