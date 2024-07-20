local slow_format_filetypes = {}
--stylua: ignore
vim.api.nvim_create_user_command("Format", function() require("conform").format({ timeout_ms = 3500, lsp_format = "fallback" }) vim.cmd("silent! update! | redraw") end, { desc = "Format" })
--stylua: ignore
vim.api.nvim_create_user_command("ToggleFormat", function() if vim.b.autoformat == nil then if vim.g.autoformat == nil then vim.g.autoformat = true end vim.b.autoformat = vim.g.autoformat end vim.b.autoformat = not vim.b.autoformat require("astrocore").notify(string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off")) end, { desc = "Toggle Autoformatting" })
return {
  {
    "stevearc/conform.nvim",
    event = "User AstroFile",
    cmd = "ConformInfo",
    opts = {
      format_after_save = function(bufnr)
        --stylua: ignore
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then return else return { lsp_format = "fallback", async = true } end
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
          if autoformat then return { timeout_ms = 3500, lsp_format = "fallback" }, on_format end
        end
      end,
      formatters = {
        gersemi = { prepend_args = { "--indent", "2", "--line-length", "80" } },
      },
      formatters_by_ft = {
        c = { "clang-format" },
        cmake = { "gersemi" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        toml = { "taplo" },
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            opt = { formatexpr = "v:lua.require'conform'.formatexpr()" },
          },
          mappings = {
            n = {
              ["<C-f>"] = function()
                vim.cmd("Format")
              end,
              ["<Leader>uf"] = {
                function()
                  vim.cmd("ToggleFormat")
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
    },
  },
}
