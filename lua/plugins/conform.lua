local slow_format_filetypes = {}
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = { formatting = { disabled = true } },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = { methods = { formatting = false } },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    cmd = "ConformInfo",
    opts = {
      format_after_save = function(bufnr)
        --stylua: ignore
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then return else return { lsp_fallback = true, async = true } end
      end,
      format_on_save = function(bufnr)
        local ignore_filetypes = { "c", "cpp", "rust", "sh", "toml" }
        --stylua: ignore
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) or vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        elseif slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        else
          local function on_format(err)
            --stylua: ignore
            if err and err:match("timeout$") then slow_format_filetypes[vim.bo[bufnr].filetype] = true end
          end
          --stylua: ignore
          if vim.g.autoformat == nil then vim.g.autoformat = true end
          local autoformat = vim.b[bufnr].autoformat
          --stylua: ignore
          if autoformat == nil then autoformat = vim.g.autoformat end
          --stylua: ignore
          if autoformat then return { timeout_ms = 3500, lsp_fallback = true }, on_format end
        end
      end,
      formatters = {
        gersemi = { prepend_args = { "--indent", "2", "--line-length", "80" } },
      },
      formatters_by_ft = {
        c = { "clang-format" },
        cmake = { "gersemi" },
        cpp = { "clang-format" },
        -- go = { "gofmt" },
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        toml = { "taplo" },
      },
    },
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        options = {
          opt = { formatexpr = "v:lua.require'conform'.formatexpr()" },
        },
        commands = {
          Format = {
            function()
              require("conform").format({ timeout_ms = 3500, lsp_fallback = true })
              vim.cmd("silent! update! | redraw")
            end,
            desc = "Format buffer",
          },
        },
        mappings = {
          n = {
            --stylua: ignore
            ["<C-f>"] = function() vim.cmd.Format() end,
            ["<Leader>uf"] = {
              function()
                --stylua: ignore
                if vim.b.autoformat == nil then if vim.g.autoformat == nil then vim.g.autoformat = true end vim.b.autoformat = vim.g.autoformat end
                vim.b.autoformat = not vim.b.autoformat
                --stylua: ignore
                require("astrocore").notify(string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off"))
              end,
              desc = "Toggle autoformatting (buffer)",
            },
            ["<Leader>uF"] = {
              function()
                --stylua: ignore
                if vim.g.autoformat == nil then vim.g.autoformat = true end
                vim.g.autoformat = not vim.g.autoformat
                vim.b.autoformat = nil
                --stylua: ignore
                require("astrocore").notify(string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off"))
              end,
              desc = "Toggle autoformatting (global)",
            },
          },
        },
      },
    },
  },
}
