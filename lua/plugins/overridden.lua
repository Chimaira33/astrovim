---@diagnostic disable: undefined-field, undefined-doc-name, unused-local
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        mappings = {
          n = {
            ["|"] = false,
            -- ["\\"] = false,
            ["<C-J>"] = false,
            ["<C-Up>"] = false,
            ["<C-Down>"] = false,
            ["<C-Left>"] = false,
            ["<C-Right>"] = false,
          },
          i = {
            ["<C-s>"] = false,
          },
          x = {
            ["<C-s>"] = false,
          },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        timeout = 2000,
        level = 3,
        fps = 90,
        render = "wrapped-compact",
      })
    end,
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<C-n>"] = function()
              require("notify").dismiss({ pending = true, silent = true })
            end,
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        triggers = nil,
        triggers_blacklist = {
          --stylua: ignore
          i = { " ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", },
          --stylua: ignore
          v = { " ", "C", "D", "M", "S", "X", "c", "d", "g", "j", "k", "m", "s", "x", "z" },
          --stylua: ignore
          x = { " ", "C", "D", "M", "S", "X", "c", "d", "g", "j", "k", "m", "s", "x", "z" },
          --stylua: ignore
          n = { "C", "D", "M", "S", "X", "b", "c", "d", "g", "l", "m", "s", "x", "z" },
        },
        plugins = {
          marks = false,
          registers = false,
          spelling = {
            enabled = false,
            suggestions = 20,
          },
          operators = nil,
          presets = {
            operators = false,
            motions = false,
            text_objects = false,
            windows = false,
            nav = false,
            z = false,
            g = false,
          },
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        window = {
          position = "left",
          width = 25,
          height = 10,
          mappings = {
            ["h"] = "navigate_up",
            ["l"] = "open",
          },
        },
        filesystem = {
          group_empty_dirs = true,
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            --stylua: ignore
            hide_by_name = { ".DS_Store", "thumbs.db", ".git", "__pycache__", ".suroot" },
            never_show = {
              ".DS_Store",
            },
          },
          follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
          },
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
        },
      })
    end,
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<C-e>"] = "<Cmd>Neotree toggle<CR>",
            ["<A-f>"] = "<Cmd>Neotree focus<CR>",
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        ui = {
          check_outdated_packages_on_open = false,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- optional = true,
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        --stylua: ignore
        ensure_installed = { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "diff", "fish", "gitignore", "go", "gomod", "html", "ini", "javascript", "jsdoc", "json", "jsonc", "kconfig", "lua", "make", "markdown", "markdown_inline", "perl", "python", "regex", "ruby", "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml" },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      opleader = { block = "zg" },
    },
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["mm"] = function()
              require("Comment.api").toggle.linewise.count(vim.v.count1)
            end,
          },
          v = {
            ["mm"] = "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
          },
        },
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        disable_in_macro = true,
        disable_in_replace_mode = true,
        disable_in_visualblock = true,
        enable_check_bracket_line = true,
        ignored_next_char = string.gsub([[ [%w%%%'%[%(%{%"%.%$%(%{%/] ]], "%s+", ""),
        fast_wrap = { manual_position = true, use_virt_lines = false },
      })
    end,
  },
}
