---@diagnostic disable: missing-fields
local char = "│"
local height = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win())
local width = vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())
---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@class snacks.plugins.Config
  opts = {
    picker = {
      prompt = " ",
      sources = {
        ---@type snacks.explorer.Config
        explorer = {
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
          layout = { preset = "vscode", preview = false, fullscreen = true },
          formatters = {
            file = { filename_only = true },
            severity = { pos = "right" },
          },
          matcher = { sort_empty = false, fuzzy = false },
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
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
                ["<PageUp>"] = "list_scroll_up",
                ["<PageDown>"] = "list_scroll_down",
                ["<Home>"] = "list_top",
                ["<End>"] = "list_bottom",
                ["<leader>/"] = false,
                ["<C-t>"] = false,
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
        },
      },
      focus = "input",
      ---@class snacks.layout.Config
      layout = {
        cycle = true,
        preset = "dropdown",
        auto_hide = { "input" },
        fullscreen = true,
        width = width,
        height = height,
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
      width = { min = 1, max = width - 10 },
      height = { min = 1, max = height },
      level = vim.log.levels.INFO,
      margin = { top = 1, right = 0, bottom = 1, left = 1 },
      ---@type snacks.notifier.style
      style = function(buf, notif, ctx)
        ctx.opts.border = "single"
        local whl = ctx.opts.wo.winhighlight
        ctx.opts.wo.winhighlight = whl:gsub(ctx.hl.msg, "SnacksNotifierMinimal")
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(notif.msg, "\n"))
        --stylua: ignore
        vim.api.nvim_buf_set_extmark(buf, ctx.ns, 0, 0, { virt_text = { { notif.icon, ctx.hl.icon } }, virt_text_pos = "eol_right_align" })
      end,
      -- style = "minimal",
      date_format = "%I:%M %p",
      ---@type string|boolean
      more_format = false,
      refresh = 50,
    },
    ---@class snacks.indent.Config
    indent = {
      indent = { char = char },
      scope = {
        enabled = true,
        char = char,
        underline = false,
      },
      animate = { enabled = false },
    },
    ---@class snacks.scope.Config
    scope = {
      treesitter = {
        enabled = true,
        injections = true,
        blocks = {
          enabled = true,
          "function_declaration",
          "function_definition",
          "method_declaration",
          "method_definition",
          "class_declaration",
          "class_definition",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
        },
        field_blocks = { "local_declaration" },
      },
    },
    zen = {},
  },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local Snacks = require("snacks")
        opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
          n = {
            ["<Leader>f"] = vim.tbl_get(opts, "_map_sections", "f"),
            ["<Leader>fa"] = function()
              Snacks.picker.files({ dirs = { vim.fn.stdpath("config") } })
            end,
            ["<Leader>fb"] = function()
              Snacks.picker.buffers()
            end,
            ["<Leader>fd"] = function()
              Snacks.picker.diagnostics_buffer()
            end,
            ["<Leader>fD"] = function()
              Snacks.picker.diagnostics()
            end,
            -- ["<Leader>fe"] = function() Snacks.picker.files({ hidden = true, ignored = true, cmd = "fd", follow = true }) end,
            ["<Leader>fe"] = function()
              Snacks.picker.explorer()
            end,
            ["<Leader>fh"] = function()
              Snacks.picker.help()
            end,
            ["<Leader>fk"] = function()
              Snacks.picker.keymaps()
            end,
            ["<Leader>fl"] = function()
              Snacks.picker.lines()
            end,
            ["<Leader>fm"] = function()
              Snacks.picker.man()
            end,
            ["<Leader>fn"] = function()
              Snacks.picker.notifications()
            end,
            ["<Leader>fw"] = function()
              Snacks.picker.grep({ hidden = true, ignored = true })
            end,
            ["<C-n>"] = function()
              Snacks.notifier.hide()
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
