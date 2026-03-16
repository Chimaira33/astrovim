return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        extension = { just = "just" },
        filename = {
          justfile = "just",
          Justfile = "just",
          [".Justfile"] = "just",
          [".justfile"] = "just",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      require("astrocore").list_insert_unique(opts.ensure_installed, { "just" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      -- vim.lsp.enable("just")
      local util = require("lspconfig.util")
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "just-lsp" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ["just-lsp"] = {
          capabilities = { offsetEncoding = "utf-8", checkUpdates = false },
          offset_encoding = "utf-8",
          cmd = { "just-lsp" },
          filetypes = { "just" },
          single_file_support = true,
          root_dir = util.root_pattern({
            ".Justfile",
            ".justfile",
            "Justfile",
            "justfile",
          }),
        },
      })
    end,
  },
}
