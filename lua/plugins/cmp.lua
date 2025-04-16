---@diagnostic disable: redundant-parameter
if true then
  return {}
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local comp_down = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    else
      cmp.select_next_item()
    end
  elseif luasnip.locally_jumpable(1) then
    luasnip.jump(1)
  elseif has_words_before() then
    cmp.complete()
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    end
  else
    fallback()
  end
end

local comp_up = function(fallback)
  if cmp.visible() then
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    else
      cmp.select_prev_item()
    end
  elseif luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
  elseif has_words_before() then
    cmp.complete()
    if #cmp.get_entries() == 1 then
      cmp.confirm({ select = true })
    end
  else
    fallback()
  end
end
local cmd_down = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end
local cmd_up = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

return {
  {
    "iguanacucumber/magazine.nvim",
    -- name = "nvim-cmp",
    lazy = true,
    config = function()
      vim.opt.rtp:remove(require("astrocore").get_plugin("nvim-cmp").dir)
    end,
    specs = {
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          { "iguanacucumber/magazine.nvim" },
          {
            "iguanacucumber/mag-nvim-lsp",
            -- name = "cmp-nvim-lsp",
            opts = {},
          },
          {
            "iguanacucumber/mag-nvim-lua",
            -- name = "cmp-nvim-lua",
          },
          {
            "iguanacucumber/mag-buffer",
            -- name = "cmp-buffer",
          },
          {
            "iguanacucumber/mag-cmdline",
            -- name = "cmp-cmdline",
          },
        },
        opts = {
          mapping = {
            ["<Down>"] = cmp.mapping({
              c = cmd_down,
              i = comp_down,
              s = comp_down,
            }),
            ["<Tab>"] = cmp.mapping({
              c = cmd_down,
              i = comp_down,
              s = comp_down,
            }),
            ["<Up>"] = cmp.mapping({
              c = cmd_up,
              i = comp_up,
              s = comp_up,
            }),
            ["<S-Tab>"] = cmp.mapping({
              c = cmd_up,
              i = comp_up,
              s = comp_up,
            }),
            ["<CR>"] = cmp.mapping({
              i = function(fallback)
                if luasnip.expandable() then
                  luasnip.expand()
                elseif cmp.visible() and cmp.get_active_entry() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                  fallback()
                end
              end,
              s = cmp.mapping.confirm({ select = true }),
              c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            }),
          },
        },
      },
    },
  },
  {
    "iguanacucumber/mag-nvim-lsp",
    -- name = "cmp-nvim-lsp",
    opts = {},
  },
  {
    "iguanacucumber/mag-nvim-lua",
    -- name = "cmp-nvim-lua",
  },
  {
    "iguanacucumber/mag-buffer",
    -- name = "cmp-buffer",
  },
  {
    "iguanacucumber/mag-cmdline",
    -- name = "cmp-cmdline",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { url = "https://codeberg.org/FelipeLema/cmp-async-path", lazy = true },
    },
    opts = function()
      return {
        {
          type = { "/", "?" },
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        },
        {
          type = ":",
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            -- { name = "path" },
            {
              name = "async_path",
              priority = 250,
              option = { show_hidden_files_by_default = true },
            },
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      vim.tbl_map(function(val)
        cmp.setup.cmdline(val.type, val)
      end, opts)
    end,
  },
}
