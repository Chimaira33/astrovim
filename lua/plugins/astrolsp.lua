---@diagnostic disable: unused-local, missing-fields
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = false,
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = false,
        allow_filetypes = {
          "fish",
          "lua",
          "json",
          "yml",
          "yaml",
          "xml",
        },
        -- ignore_filetypes = {},
      },
      -- disabled = { "lua_ls" },
      timeout_ms = 4000,
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "biome",
      "gopls",
      "lemminx",
      "neocmake",
      "taplo",
      "vimls",
      "vtsls",
      "yamlls",
    },
    -- config = {},
    handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end
      cmake = false,
      -- biome = function(_, opts)
      --   opts.filetypes = { "json", "jsonc" }
      --   require("lspconfig").biome.setup(opts)
      -- end,
      biome = false,
      -- jsonls = function(_, opts)
      --   opts.filetypes = { "json", "jsonc" }
      --   require("lspconfig").jsonls.setup(opts)
      -- end,
      -- jsonls = false,
    },
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function()
            vim.lsp.buf.document_highlight()
          end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        },
      },
    },
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
}
