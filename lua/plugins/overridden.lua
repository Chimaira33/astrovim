---@diagnostic disable: undefined-field, undefined-doc-name, unused-local
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local astro = require("astrocore")
      local maps = astro.empty_map_table()
      maps.i["<C-s>"] = {}
      maps.x["<C-s>"] = {}
      maps.n["|"] = {}
      maps.n["\\"] = {}
      maps.n["<C-J>"] = {}
      maps.n["<C-Up>"] = {}
      maps.n["<C-Down>"] = {}
      maps.n["<C-Left>"] = {}
      maps.n["<C-Right>"] = {}
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        timeout = 2000,
        fps = 90,
        render = "wrapped-compact",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for keymaps that start with a native binding
          i = { "C", "D", "M", "S", "X", "c", "d", "j", "k", "m", "s", "x" },
          v = { " ", "C", "D", "M", "S", "X", "c", "d", "g", "j", "k", "m", "s", "x" },
          n = { "C", "D", "M", "S", "X", "b", "c", "d", "l", "m", "s", "x", "z" },
        },
        plugins = {
          marks = false,
          registers = false,
          spelling = {
            enabled = false,
            suggestions = 20,
          },
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
            hide_by_name = { ".DS_Store", "thumbs.db", ".git", "__pycache__" },
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
            ["<C-f>"] = "<Cmd>Neotree focus<CR>",
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
          check_outdated_packages_on_open = true,
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
        ensure_installed = { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "diff", "fish", "gitignore", "go", "gomod", "html", "ini", "javascript", "jsdoc", "json", "jsonc", "kconfig", "lua", "make", "markdown", "markdown_inline", "perl", "python", "regex", "ruby", "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml" }
,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      opleader = {
        block = "zg",
      },
    },
    dependencies = {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["mm"] = {
              function() require("Comment.api").toggle.linewise.count(vim.v.count1) end,
            },
          },
          v = {
            ["mm"] = "<Esc><Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
          },
        },
      },
    },
  },
}
