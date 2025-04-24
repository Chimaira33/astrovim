local indent_char = "│"
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    ---@class snacks.picker.Config
    picker = {
      prompt = " ",
      sources = {},
      focus = "input",
      layout = {
        cycle = true,
        preset = "vertical",
        auto_hide = { "input" },
        fullscreen = true,
      },
      ui_select = true,
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        sort_empty = false,
        filename_bonus = false,
        file_pos = false,
        cwd_bonus = false,
        frecency = false,
        history_bonus = false,
      },
      formatters = {
        file = {
          filename_first = true,
          filename_only = false,
        },
        severity = {
          icons = true,
          level = true,
          pos = "left",
        },
      },
      previewers = {
        diff = {
          builtin = true,
          cmd = { "diff-so-fancy" },
        },
      },
      debug = {
        scores = false,
        leaks = false,
        explorer = false,
        files = false,
        grep = false,
        proc = false,
        extmarks = false,
      },
    },
    notifier = {
      timeout = 2000, -- default timeout in ms
      width = { min = 1, max = vim.o.columns - 10 },
      height = { min = 1, max = 7 },
      level = vim.log.levels.INFO,
    },
    ---@class snacks.indent.Config
    indent = {
      indent = {
        char = indent_char,
      },
      scope = {
        enabled = false,
        char = indent_char,
        underline = false,
      },
    },
    zen = {},
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
          n = {
            ["<Leader>f"] = vim.tbl_get(opts, "_map_sections", "f"),
            ["<Leader>fa"] = function()
              require("snacks").picker.files({ dirs = { vim.fn.stdpath("config") } })
            end,
            ["<Leader>fb"] = function()
              require("snacks").picker.buffers()
            end,
            ["<Leader>fd"] = function()
              require("snacks").picker.diagnostics()
            end,
            -- ["<Leader>fe"] = function() require("snacks").picker.files({ hidden = true, ignored = true, cmd = "fd", follow = true }) end,
            ["<Leader>fe"] = function()
              require("snacks").picker.explorer({
                finder = "explorer",
                sort = { fields = { "sort" } },
                supports_live = true,
                tree = true,
                watch = true,
                diagnostics = true,
                diagnostics_open = false,
                git_status = false,
                git_status_open = false,
                git_untracked = false,
                follow_file = true,
                focus = "list",
                auto_close = false,
                jump = { close = true },
                layout = { preset = "sidebar", preview = false },
                formatters = {
                  file = { filename_only = true },
                  severity = { pos = "right" },
                },
                matcher = { sort_empty = false, fuzzy = false },
                config = function(config)
                  return require("snacks.picker.source.explorer").setup(config)
                end,
                win = {
                  list = {
                    keys = {
                      ["h"] = "explorer_up",
                      ["<Left>"] = "explorer_up",
                      ["<CR>"] = "confirm",
                      ["x"] = "explorer_close",
                      ["a"] = "explorer_add",
                      ["d"] = "explorer_del",
                      ["r"] = "explorer_rename",
                      ["c"] = "explorer_copy",
                      ["m"] = "explorer_move",
                      ["P"] = "toggle_preview",
                      ["y"] = { "explorer_yank", mode = { "n", "x" } },
                      ["p"] = "explorer_paste",
                      ["u"] = "explorer_update",
                      ["."] = "tcd",
                      ["<leader>/"] = "picker_grep",
                      ["<C-t>"] = "terminal",
                      ["I"] = "toggle_ignored",
                      ["H"] = "toggle_hidden",
                      ["Z"] = "explorer_close_all",
                      ["<Home>"] = "list_top",
                      ["<End>"] = "list_bottom",
                      ["<2-LeftMouse>"] = false,
                      ["<BS>"] = false,
                      ["<C-D>"] = false,
                      ["<C-J>"] = false,
                      ["<C-K>"] = false,
                      ["<C-N>"] = false,
                      ["<C-P>"] = false,
                      ["<C-S>"] = false,
                      ["<C-U>"] = false,
                      ["<C-V>"] = false,
                      ["<C-W>H"] = false,
                      ["<C-W>J"] = false,
                      ["<C-W>K"] = false,
                      ["<C-W>L"] = false,
                      ["<M-d>"] = false,
                      ["<M-w>"] = false,
                      ["<S-CR>"] = false,
                      ["G"] = false,
                      ["[d"] = false,
                      ["[e"] = false,
                      ["[g"] = false,
                      ["[w"] = false,
                      ["]d"] = false,
                      ["]e"] = false,
                      ["]g"] = false,
                      ["]w"] = false,
                      ["gg"] = false,
                      ["j"] = false,
                      ["k"] = false,
                      ["l"] = false,
                      ["o"] = false,
                      ["zb"] = false,
                      ["zt"] = false,
                      ["zz"] = false,
                    },
                  },
                },
              })
            end,
            ["<Leader>fh"] = function()
              require("snacks").picker.help()
            end,
            ["<Leader>fk"] = function()
              require("snacks").picker.keymaps()
            end,
            ["<Leader>fl"] = function()
              require("snacks").picker.lines()
            end,
            ["<Leader>fm"] = function()
              require("snacks").picker.man()
            end,
            ["<Leader>fn"] = function()
              require("snacks").picker.notifications()
            end,
            ["<Leader>fw"] = function()
              require("snacks").picker.grep({ hidden = true, ignored = true })
            end,
            ["<Leader>f'"] = false,
            ["<Leader>f<CR>"] = false,
            ["<Leader>fC"] = false,
            ["<Leader>fO"] = false,
            ["<Leader>fW"] = false,
            ["<Leader>fc"] = false,
            ["<Leader>fg"] = false,
            ["<Leader>fo"] = false,
            ["<Leader>fr"] = false,
            ["<Leader>fs"] = false,
            ["<Leader>ft"] = false,
            ["<Leader>g"] = false,
            ["<Leader>gC"] = false,
            ["<Leader>gb"] = false,
            ["<Leader>gc"] = false,
            ["<Leader>gt"] = false,
            ["<Leader>ls"] = false,
          },
        })
      end,
    },
    {
      "folke/todo-comments.nvim",
      optional = true,
      specs = {
        {
          "AstroNvim/astrocore",
          opts = { mappings = { n = { ["<Leader>fT"] = false } } },
        },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      opts = {
        commands = {
          find_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            require("snacks").picker.files({ cwd = path })
          end,
        },
        window = { mappings = { F = "find_in_dir" } },
      },
    },
    { "stevearc/dressing.nvim", optional = true, opts = { select = { enabled = false } } },
    { "nvim-telescope/telescope.nvim", enabled = false },
  },
}
