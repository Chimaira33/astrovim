---@diagnostic disable: undefined-field, assign-type-mismatch
-- if true then
--   return {}
-- end

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

---@type function?, function?
local icon_provider, hl_provider

local function get_kind_icon(CTX)
  -- Evaluate icon provider
  if not icon_provider then
    local lspkind_avail, lspkind = pcall(require, "lspkind")
    if lspkind_avail then
      icon_provider = function(ctx)
        if ctx.item.source_name == "LSP" then
          local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
          if icon then
            ctx.kind_icon = icon
          end
        end
      end
    end
  end
  if not icon_provider then
    icon_provider = function() end
  end
  -- Evaluate highlight provider
  if not hl_provider then
    local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
    if highlight_colors_avail then
      local kinds
      hl_provider = function(ctx)
        if not kinds then
          kinds = require("blink.cmp.types").CompletionItemKind
        end
        if ctx.item.kind == kinds.Color then
          local doc = vim.tbl_get(ctx, "item", "documentation")
          if doc then
            local color_item = highlight_colors_avail and highlight_colors.format(doc, { kind = kinds[kinds.Color] })
            if color_item and color_item.abbr_hl_group then
              if color_item.abbr then
                ctx.kind_icon = color_item.abbr
              end
              ctx.kind_hl = color_item.abbr_hl_group
            end
          end
        end
      end
    end
    if not hl_provider then
      hl_provider = function() end
    end
  end
  -- Call resolved providers
  icon_provider(CTX)
  hl_provider(CTX)
  -- Return text and highlight information
  return { text = CTX.kind_icon .. CTX.icon_gap, highlight = CTX.kind_hl }
end

return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  -- commit = "f0f34c3",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
    },
    {
      "saghen/blink.compat",
      version = "*",
      lazy = true,
      dependencies = { "lukas-reineke/cmp-under-comparator", lazy = true },
      opts = {},
    },
  },
  opts_extend = { "sources.default", "sources.providers", "cmdline.sources", "term.sources" },
  ---@class blink.cmp.Config
  opts = {
    fuzzy = {
      -- prebuilt_binaries = { force_version = "v0.12.4", force_system_triple = "aarch64-linux-android" },
      prebuilt_binaries = { force_version = "v0.14.2", force_system_triple = "aarch64-linux-android" },
      -- sorts = { "exact", "label", "score", "sort_text", "kind" },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "nvim_lua",
        "cmp-under-comparator",
      },
      providers = {
        lsp = { async = true },
        snippets = { async = true },
        path = { async = true },
        buffer = { async = true },
        nvim_lua = {
          name = "nvim_lua",
          module = "blink.compat.source",
          score_offset = -3,
        },
        ["cmp-under-comparator"] = {
          name = "cmp-under-comparator",
          module = "blink.compat.source",
          score_offset = -3,
        },
      },
    },
    keymap = {
      preset = "default",
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
      ["<S-Tab>"] = {
        "snippet_backward",
        "fallback",
      },
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
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              --stylua: ignore
              text = function(ctx) return get_kind_icon(ctx).text end,
              --stylua: ignore
              highlight = function(ctx) return get_kind_icon(ctx).highlight end,
            },
          },
        },
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
  specs = {
    {
      "AstroNvim/astrolsp",
      optional = true,
      opts = function(_, opts)
        opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)

        -- disable AstroLSP signature help if `blink.cmp` is providing it
        local blink_opts = require("astrocore").plugin_opts("blink.cmp")
        if vim.tbl_get(blink_opts, "signature", "enabled") == true then
          --stylua: ignore
          if not opts.features then opts.features = {} end
          opts.features.signature_help = false
        end
      end,
    },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "hrsh7th/cmp-buffer", enabled = false },
    { "hrsh7th/cmp-path", enabled = false },
    { "hrsh7th/cmp-nvim-lsp", enabled = false },
    { "saadparwaiz1/cmp_luasnip", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
  },
}
