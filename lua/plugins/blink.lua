---@diagnostic disable: undefined-field, assign-type-mismatch
-- if true then
--   return {}
-- end

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "^1",
  ---@class blink.cmp.Config
  opts = {
    fuzzy = {
      prebuilt_binaries = { force_version = "v1.1.1", force_system_triple = "aarch64-linux-android" },
    },
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      ["<C-j>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      -- ["<Esc>"] = { "cancel", "fallback" },
      ["<Tab>"] = {
        "snippet_forward",
        function(cmp)
          if has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-b>"] = {},
      ["<C-f>"] = {},
      ["<C-n>"] = {},
      ["<C-p>"] = {},
      ["<C-y>"] = {},
    },
    cmdline = {
      completion = {
        menu = { auto_show = false },
        list = { selection = { auto_insert = true } },
      },
      keymap = {
        preset = "cmdline",
        -- ["<Down>"] = { "show_and_insert", "select_next", "fallback_to_mappings", "fallback" },
        -- ["<Up>"] = { "show_and_insert", "select_prev", "fallback_to_mappings", "fallback" },
        -- ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Up>"] = {
          "show_and_insert",
          "select_prev",
        },
        ["<Down>"] = {
          function(cmp)
            if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
              return cmp.accept()
            end
          end,
          "show_and_insert",
          "select_next",
        },
        -- ["<CR>"] = { "accept" },
        ["<C-Space>"] = { "select_accept_and_enter" },
        ["<C-b>"] = {},
        ["<C-f>"] = {},
        ["<C-n>"] = {},
        ["<C-p>"] = {},
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      list = {
        selection = {
        --stylua: ignore
        preselect = function(ctx) return ctx.mode ~= "cmdline" end,
        --stylua: ignore
        auto_insert = function(ctx) return ctx.mode ~= "cmdline" end,
        },
      },
      menu = {
        auto_show = true, -- function(ctx) return ctx.mode ~= "cmdline" end,
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = { treesitter = { "lsp" } },
      },
      keyword = { range = "prefix" },
      -- keyword = { range = "full" },
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 750,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          direction_priority = {
            menu_north = { "e", "s", "n", "w" },
          },
        },
        treesitter_highlighting = true,
        update_delay_ms = 50,
      },
      ghost_text = { enabled = false, show_with_selection = true },
      trigger = {
        show_on_keyword = true,
        show_in_snippet = true,
      },
    },
    signature = {
      enabled = false,
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
  },
}
