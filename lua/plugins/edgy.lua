return {
  "folke/edgy.nvim",
  -- optional = true,
  opts = {
    -- table.insert(bottom, "Trouble")
    exit_when_last = true,
    bottom = {
      {
        ft = "help",
        size = { height = 20 },
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "qf", title = "QuickFix" },
    },
    left = {
      {
        title = "Files",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        pinned = true,
        open = "Neotree position=left filesystem",
        size = { height = 0.5 },
      },
      -- { title = "Git Status", ft = "neo-tree", filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end, pinned = true, open = "Neotree position=right git_status" },
      {
        title = "Buffers",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        pinned = true,
        open = "Neotree position=top buffers",
      },
      "neo-tree",
    },
    right = {
      {
        ft = "aerial",
        title = "Symbol Outline",
        pinned = true,
        open = function()
          require("aerial").open()
        end,
      },
    },
    keys = {
      -- increase width
      ["<A-Right>"] = function(win)
        win:resize("width", 2)
      end,
      -- decrease width
      ["<A-Left>"] = function(win)
        win:resize("width", -2)
      end,
      -- increase height
      ["<C-A-Up>"] = function(win)
        win:resize("height", 2)
      end,
      -- decrease height
      ["<C-A-Down>"] = function(win)
        win:resize("height", -2)
      end,
    },
  },
  specs = {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = { source_selector = { winbar = false, statusline = false } },
  },
}
