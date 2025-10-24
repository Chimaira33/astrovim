---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      -- opts.native_lsp_config = true
      vim.lsp.enable("tombi")
      opts.handlers = require("astrocore").extend_tbl(opts.handlers or {}, {
        tombi = function(server)
          local util = require("lspconfig.util")
          require("lspconfig")[server].setup({
            cmd = { "tombi", "lsp" },
            filetypes = { "toml" },
            root_markers = { "tombi.toml", "pyproject.toml", ".git" },
            root_dir = util.root_pattern("*.toml"),
            single_file_support = true,
          })
        end,
      })
      -- --stylua: ignore
      --if not opts.servers then opts.servers = {} end
      --opts.servers = require("astrocore").list_insert_unique(opts.servers, { "taplo" })
      -- opts.handlers = require("astrocore").extend_tbl(opts.handlers or {}, {
      --   taplo = function(server)
      --     local util = require("lspconfig.util")
      --     require("lspconfig")[server].setup({
      --       cmd = { "taplo", "lsp", "stdio" },
      --       filetypes = { "toml" },
      --       root_dir = util.root_pattern("*.toml"),
      --       single_file_support = true,
      --     })
      --   end,
      -- })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@type conform.setupOpts
    opts = {
      -- formatters = { taplo_gb = { command = "taplo", args = { "format", "--config", "/data/data/com.termux/files/home/.local/etc/taplo_config.toml", "-" } } },
      -- formatters_by_ft = { toml = { "taplo_gb" } },
      -- formatters = {
      --   ---@diagnostic disable-next-line: missing-fields
      --   tombi_gb = {
      --     command = "tombi",
      --     args = { "format", "--", "--stdin-file-path", "$FILENAME" },
      --     stdin = true,
      --   },
      -- },
      formatters_by_ft = { toml = { "tombi" } },
    },
  },
}
