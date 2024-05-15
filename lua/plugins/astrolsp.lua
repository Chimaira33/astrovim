---@diagnostic disable: unused-local, missing-fields
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = { "json", "yaml", "xml" },
        ignore_filetypes = { "lua", "sh", "toml" },
      },
      disabled = { "lua_ls" },
      timeout_ms = 4000,
    },
    -- enable servers that you already have installed without mason
    servers = {
      "bashls",
      "biome",
      "lemminx",
      "lua_ls",
      "ruff_lsp",
      "taplo",
      "tsserver",
      "vimls",
      "yamlls",
    },
    config = {
      bashls = {
        settings = {
          bashIde = {
            shellcheckArguments = "--exclude=SC1091,SC2016,SC2034,SC2043,SC2117,SC2139,SC2154,SC2188,SC2317 --enable=require-double-brackets,deprecate-which",
            backgroundAnalysisMaxFiles = 0,
            enableSourceErrorDiagnostics = false,
            includeAllWorkspaceSymbols = false,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                "vim",
                "require",
              },
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
            telemetry = { enable = false },
            runtime = { version = "LuaJIT" },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
    },
    handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end
      cmake = false,
      clangd = false,
      rust_analyzer = false,
      -- biome = function(_, opts)
      --   opts.filetypes = { "json", "jsonc" }
      --   require("lspconfig").biome.setup(opts)
      -- end,
      biome = false,
      ruff_lsp = function(_, opts)
        opts.filetypes = { "python" }
        require("lspconfig").ruff_lsp.setup(opts)
      end,
      gopls = function(_, opts)
        require("lspconfig").gopls.setup(opts)
      end,
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
