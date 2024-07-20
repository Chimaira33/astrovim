return {
  {
    "folke/trouble.nvim",
    event = "User AstroFile",
    cmd = "Trouble",
    opts = function()
      local get_icon = require("astroui").get_icon
      local lspkind_avail, lspkind = pcall(require, "lspkind")
      return {
        auto_open = false,
        auto_close = true,
        padding = false,
        height = 10,
        use_diagnostic_signs = true,
        keys = { ["q"] = "close" },
        icons = {
          indent = {
            fold_open = get_icon("FoldOpened"),
            fold_closed = get_icon("FoldClosed"),
          },
          folder_closed = get_icon("FolderClosed"),
          folder_open = get_icon("FolderOpen"),
          kinds = lspkind_avail and lspkind.symbol_map,
        },
        ---@type table<string, trouble.Mode>
        modes = {
          cascade = {
            mode = "diagnostics", -- inherit from diagnostics mode
            filter = function(items)
              local severity = vim.diagnostic.severity.HINT
              for _, item in ipairs(items) do
                severity = math.min(severity, item.severity)
              end
              return vim.tbl_filter(function(item)
                return item.severity == severity
              end, items)
            end,
          },
          preview_float = {
            mode = "diagnostics",
            preview = {
              type = "float",
              relative = "editor",
              border = "rounded",
              title = "Preview",
              title_pos = "center",
              position = { 0, -2 },
              size = { width = 0.8, height = 0.5 },
              zindex = 200,
            },
          },
        },
      }
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Trouble = "󱍼" } } },
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["zd"] = "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
              ["zD"] = "<Cmd>Trouble diagnostics toggle<CR>",
            },
          },
        },
      },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        optional = true,
        opts_extend = { "library" },
        opts = {
          library = {
            { path = "trouble.nvim", words = { "trouble" } },
          },
        },
      },
      { "lewis6991/gitsigns.nvim", opts = { trouble = true } },
      {
        "folke/edgy.nvim",
        -- optional = true,
        opts = function(_, opts)
          if not opts.bottom then
            opts.bottom = {}
          end
          table.insert(opts.bottom, "Trouble")
        end,
      },
    },
  },
}
