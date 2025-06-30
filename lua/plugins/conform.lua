---@diagnostic disable: unused-local, unused-function
local astro = require("astrocore")
-- local slow_format_filetypes = {}
local ignore_filetypes = { "c", "cpp", "cmake", "perl", "rust", "sh", "toml" }

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      -- format_after_save = nil,
      -- format_on_save = nil,
      format_after_save = function(bufnr)
        if
          vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
          or vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat)
          or (vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat)
          -- or not slow_format_filetypes[vim.bo[bufnr].filetype]
        then
          return
        else
          return { async = true, lsp_format = "fallback" }
        end
      end,
      -- format_after_save = function(bufnr)
      --   --stylua: ignore
      --   if not slow_format_filetypes[vim.bo[bufnr].filetype] then return else return { lsp_format = "fallback", async = true } end
      -- end,
      -- format_on_save = function(bufnr)
      --   if
      --     vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype)
      --     or vim.F.if_nil(vim.b[bufnr].autoformat, vim.g.autoformat, false)
      --     or (vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat)
      --     or slow_format_filetypes[vim.bo[bufnr].filetype]
      --   then
      --     return
      --   else
      --     local function on_format(err)
      --       if err and err:match("timeout$") then
      --         slow_format_filetypes[vim.bo[bufnr].filetype] = true
      --       end
      --     end
      --     return { timeout_ms = 4500, lsp_format = "fallback" }, on_format()
      --   end
      -- end,
      default_format_opts = { lsp_format = "fallback" },
      formatters = {},
      formatters_by_ft = {},
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          options = {
            opt = { formatexpr = "v:lua.require('conform').formatexpr()" },
          },
          commands = {
            Format = {
              function()
                -- local buf_num = vim.api.nvim_get_current_buf()
                -- if slow_format_filetypes[vim.bo[buf_num].filetype] then
                --   require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
                --     if not err then
                --       vim.cmd("silent! write! | redraw")
                --     end
                --   end)
                -- else
                --   local function on_format(err)
                --     if err and err:match("timeout$") then
                --       slow_format_filetypes[vim.bo[buf_num].filetype] = true
                --     end
                --   end
                --   require("conform").format({ timeout_ms = 4500, lsp_format = "fallback" }, on_format())
                --   vim.cmd("silent! write! | redraw")
                -- end
                require("conform").format({ async = true, lsp_format = "fallback" }, function()
                  vim.cmd.Write()
                end)
              end,
              desc = "Format buffer",
              range = false,
            },
            VisualFormat = {
              function(args)
                local range = nil
                if args.count ~= -1 then
                  local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                  range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                  }
                end
                require("conform").format({ async = true, range = range }, function(err)
                  if not err then
                    local mode = vim.api.nvim_get_mode().mode
                    if vim.startswith(string.lower(mode), "v") then
                      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                    end
                  end
                end)
              end,
              desc = "Visual Format buffer",
              range = true,
            },
            ToggleFormat = {
              function()
                -- if vim.b.autoformat == nil then if vim.g.autoformat == nil then vim.g.autoformat = true end vim.b.autoformat = vim.g.autoformat end
                -- vim.b.autoformat = not vim.b.autoformat
                local auto = not vim.F.if_nil(
                  vim.b[vim.fn.bufnr()].autoformat,
                  vim.g.autoformat,
                  vim.g.disable_autoformat,
                  vim.b[vim.fn.bufnr()].disable_autoformat,
                  true
                )
                vim.g.autoformat, vim.b.autoformat, vim.g.disable_autoformat, vim.b[vim.fn.bufnr()].disable_autoformat =
                  auto, auto, not auto, not auto
                --stylua: ignore
                astro.notify(string.format("Global and Buffer autoformatting %s", (vim.g.autoformat and vim.b[vim.fn.bufnr()].autoformat and not (vim.g.disable_autoformat and vim.b[vim.fn.bufnr()].disable_autoformat)) and "on" or "off"), 3)
              end,
              desc = "Toggle AutoFormat",
            },
            SaveWithoutFormat = {
              function()
                vim.g.autoformat, vim.b.autoformat, vim.g.disable_autoformat, vim.b[vim.fn.bufnr()].disable_autoformat =
                  false, false, true, true
                vim.cmd.Update()
                vim.g.autoformat, vim.b.autoformat, vim.g.disable_autoformat, vim.b[vim.fn.bufnr()].disable_autoformat =
                  nil, nil, nil, nil
              end,
              desc = "Save Without Formatting",
            },
          },
          mappings = {
            n = {
              ["<C-f>"] = function()
                vim.cmd.Format()
              end,
              ["zf"] = function()
                vim.cmd.Format()
              end,
              --stylua: ignore
              ["<C-A-s>"] = function() vim.cmd.SaveWithoutFormat() end,
              --stylua: ignore
              ["<Leader>uf"] = function() vim.cmd.ToggleFormat() end,
              ["<Leader>uF"] = false,
              -- ["<Leader>uF"] = {
              --   function()
              --     --stylua: ignore
              --     vim.g.autoformat, vim.b.autoformat = not vim.F.if_nil(vim.g.autoformat, true), nil
              --     --stylua: ignore
              --     astro.notify(string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off"), 3)
              --   end,
              --   desc = "Toggle autoformatting (global)",
              -- },
            },
            x = {
              --stylua: ignore
              ["<C-f>"] = function() vim.cmd.VisualFormat() end,
              --stylua: ignore
              ["zf"] = function() vim.cmd.VisualFormat() end,
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
