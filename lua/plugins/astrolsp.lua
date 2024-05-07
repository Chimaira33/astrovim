---@diagnostic disable: unused-local
-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = false, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "fish",
          "lua",
          "json",
          "yml",
          "yaml",
          "xml",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          --[[ "c",
          "cpp", ]]
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        "lua_ls",
      },
      timeout_ms = 4000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      "bashls",
      "biome",
      "clangd",
      "gopls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "neocmake",
      "ruff_lsp",
      "taplo",
      "vimls",
      "vtsls",
      "yamlls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                "vim",
                "require",
              },
            },
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
            telemetry = {
              enable = false,
            },
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              -- maxPreload = 100,
              -- preloadFileSize = 500,
              checkThirdParty = false,
            },
          },
        },
      },
      clangd = {
        capabilities = {
          "--all-scopes-completion",
          "--background-index",
          "--background-index-priority=low",
          "--clang-tidy",
          "--completion-style=detailed",
          "--enable-config",
          "--fallback-style=google",
          "--function-arg-placeholders",
          "--header-insertion-decorators",
          "--header-insertion=iwyu",
          "--import-insertions",
          "--log=error",
          "--offset-encoding=utf-16",
          "--pch-storage=memory",
          "--ranking-model=heuristics",
          "-j=9",
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      cmake = false,
      -- rust_analyzer = false,
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
      ruff_lsp = function(_, opts)
        opts.filetypes = { "python" }
        require("lspconfig").ruff_lsp.setup(opts)
      end,
      gopls = function(_, opts) require("lspconfig").gopls.setup(opts) end,
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = {
          function() vim.diagnostic.open_float() end,
          desc = "Hover diagnostics",
        },
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
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    -- on_attach = function(client, bufnr)
    -- this would disable semanticTokensProvider for all clients
    -- client.server_capabilities.semanticTokensProvider = nil
    -- end,
  },
}
