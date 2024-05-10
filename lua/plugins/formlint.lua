---@diagnostic disable: need-check-nil, undefined-field, duplicate-set-field
return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "gbprod/none-ls-shellcheck.nvim",
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      nls.register(require("none-ls-shellcheck.code_actions"))
      if not opts.sources then
        opts.sources = {}
      end
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
      })
    end,
  },
  {

    "stevearc/conform.nvim",
    opts = {
      format_on_save = function(bufnr)
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { "c", "cmake", "cpp", "rust", "sh", "toml" }
        if
          vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
          or vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
        then
          return
        end
        return { timeout_ms = 2500, lsp_fallback = true }
      end,
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      }),
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      }),
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-s", "-ci" },
        },
      },
      formatters_by_ft = {
        fish = { "fish_indent" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- go = { "goimports-reviser" },
        -- json = { "biome" },
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
      },
    },
  },
  { "jay-babu/mason-null-ls.nvim", optional = false, opts = { methods = { diagnostics = false } } },
  {
    "mfussenegger/nvim-lint",
    event = "User AstroFile",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      linters_by_ft = {
        -- c = { "clang-tidy" },
        -- cpp = { "clang-tidy" },
        dash = { "dash" },
        fish = { "fish" },
        -- go = { "golangcilint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft or {}
      for name, linter in pairs(opts.linters or {}) do
        local base = lint.linters[name]
        lint.linters[name] = (type(linter) == "table" and type(base) == "table")
            and vim.tbl_deep_extend("force", base, linter)
          or linter
      end

      local valid_linters = function(ctx, linters)
        if not linters then
          return {}
        end
        return vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          return linter
            and vim.fn.executable(linter.cmd) == 1
            and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, linters)
      end

      local orig_resolve_linter_by_ft = lint._resolve_linter_by_ft
      lint._resolve_linter_by_ft = function(...)
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

        local linters = valid_linters(ctx, orig_resolve_linter_by_ft(...))
        if not linters[1] then
          linters = valid_linters(ctx, lint.linters_by_ft["_"])
        end -- fallback
        require("astrocore").list_insert_unique(linters, valid_linters(ctx, lint.linters_by_ft["*"])) -- global

        return linters
      end

      lint.try_lint() -- start linter immediately
      local timer = vim.loop.new_timer()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
        group = vim.api.nvim_create_augroup("auto_lint", { clear = true }),
        desc = "Automatically try linting",
        callback = function()
          timer:start(100, 0, function()
            timer:stop()
            vim.schedule(lint.try_lint)
          end)
        end,
      })
    end,
  },
}
