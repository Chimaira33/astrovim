---@diagnostic disable: missing-fields
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "lua_ls" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        lua_ls = {
          ---@type lspconfig.settings.lua_ls
          settings = {
            Lua = {
              capabilities = { offsetEncoding = "utf-8" },
              offset_encoding = "utf-8",
              format = { enable = false },
              diagnostics = { globals = { "astronvim" } },
              runtime = { version = "LuaJIT" },
            },
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters = {
        gjb_stylua = {
          command = "stylua",
          --stylua: ignore start
          args = { "--config-path=/data/data/com.termux/files/home/.config/astrovim/.stylua.toml", "--respect-ignores", "--verify", "--stdin-filepath", "$FILENAME", "-" },
          range_args = function(_, ctx) local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range) return { "--config-path=/data/data/com.termux/files/home/.config/astrovim/.stylua.toml", "--verify", "--stdin-filepath", "$FILENAME", "--range-start", tostring(start_offset), "--range-end", tostring(end_offset), "-" } end,
          --stylua: ignore end
        },
      },
      formatters_by_ft = { lua = { "gjb_stylua" } },
    },
  },
}
