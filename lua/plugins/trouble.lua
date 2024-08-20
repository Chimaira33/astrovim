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
              ["zd"] = "<Cmd>Trouble diagnostics toggle pinned=true win.relative=win win.position=bottom filter.buf=0 focus=0<CR>",
              ["zD"] = "<Cmd>Trouble diagnostics toggle win.relative=win win.position=bottom focus=0<CR>",
              -- ["zD"] = "<Cmd>Trouble diagnostics toggle<CR>",
            },
          },
        },
      },
    },
    specs = {
      {
        "folke/lazydev.nvim",
        optional = true,
        opts = function(_, opts)
          table.insert(opts.library, { path = "trouble.nvim", words = { "trouble" } })
        end,
      },
      { "lewis6991/gitsigns.nvim", opts = { trouble = true } },
      {
        "folke/edgy.nvim",
        -- optional = true,
        opts = function(_, opts)
          --stylua: ignore
          if not opts.bottom then opts.bottom = {} end
          -- table.insert(opts.bottom, "Trouble")
          opts.exit_when_last = true
          opts.bottom = {
            "Trouble",
            {
              ft = "help",
              size = { height = 20 },
              --stylua: ignore
              filter = function(buf) return vim.bo[buf].buftype == "help" end,
            },
          }
          opts.left = {
            {
              title = "Files",
              ft = "neo-tree",
              --stylua: ignore
              filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
              pinned = true,
              open = "Neotree position=left filesystem",
              size = { height = 0.5 },
            },
            -- { title = "Git Status", ft = "neo-tree", filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end, pinned = true, open = "Neotree position=right git_status" },
            {
              title = "Buffers",
              ft = "neo-tree",
              --stylua: ignore
              filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
              pinned = true,
              open = "Neotree position=top buffers",
            },
            "neo-tree",
          }
          opts.right = {
            {
              ft = "aerial",
              title = "Symbol Outline",
              pinned = true,
              --stylua: ignore
              open = function() require("aerial").open() end,
            },
          }
          opts.keys = {}
        end,
        specs = {
          "nvim-neo-tree/neo-tree.nvim",
          optional = true,
          opts = { source_selector = { winbar = false, statusline = false } },
        },
      },
    },
  },
}
