local slow_format_filetypes = {}
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ timeout_ms = 4000, lsp_format = "fallback", range = range })
  local mode = vim.api.nvim_get_mode().mode
  if vim.startswith(string.lower(mode), "v") then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  end
  vim.cmd("silent! write! | redraw")
end, { desc = "Format", range = true })
-- vim.api.nvim_create_user_command("Format", function() require("conform").format({ timeout_ms = 3500, lsp_format = "fallback" }) vim.cmd("silent! write! | redraw") end, { desc = "Format" })
--stylua: ignore
vim.api.nvim_create_user_command("ToggleFormat", function() if vim.b.autoformat == nil then if vim.g.autoformat == nil then vim.g.autoformat = true end vim.b.autoformat = vim.g.autoformat end vim.b.autoformat = not vim.b.autoformat require("notify")(string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off"), 3) end, { desc = "Toggle Autoformatting" })

vim.api.nvim_create_user_command("SaveWithoutFormat", function()
  vim.g.autoformat = false
  vim.b.autoformat = false
  vim.cmd("silent! update! | redraw")
  vim.g.autoformat = true
  vim.b.autoformat = true
end, { desc = "Save Without Formatting" })
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      format_after_save = function(bufnr)
        --stylua: ignore
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then return else return { lsp_format = "fallback", async = true } end
      end,
      format_on_save = function(bufnr)
        local ignore_filetypes = { "c", "cpp", "cmake", "perl", "rust", "sh", "toml" }
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
          if autoformat then return { timeout_ms = 3500, lsp_format = "fallback" }, on_format() end
        end
      end,
      default_format_opts = { lsp_format = "fallback" },
      formatters = {},
      formatters_by_ft = {},
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
              --stylua: ignore
              ["<C-f>"] = function() vim.cmd.Format() end,
              --stylua: ignore
              ["zf"] = function() vim.cmd.Format() end,
              --stylua: ignore
              ["<C-A-s>"] = function() vim.cmd.SaveWithoutFormat() end,
              ["<Leader>uf"] = {
                function()
                  vim.cmd.ToggleFormat()
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
                  require("notify")(string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off"), 3)
                end,
                desc = "Toggle autoformatting (global)",
              },
            },
            x = {
              --stylua: ignore
              ["<C-f>"] = function() vim.cmd.Format() end,
              --stylua: ignore
              ["zf"] = function() vim.cmd.Format() end,
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
