return {
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = false,
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          vim.b[bufnr].view_activated = false
          vim.opt_local.wrap = true
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<C-d>"] = "<Cmd>DiffviewOpen<CR>",
            },
          },
        },
      },
      {
        "NeogitOrg/neogit",
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          { "AstroNvim/astroui", opts = { icons = { Neogit = "󰰔" } } },
          {
            "AstroNvim/astrocore",
            ---@type AstroCoreOpts
            opts = {
              mappings = {
                n = {
                  ["gt"] = "<Cmd>Neogit<CR>",
                  ["gc"] = "<Cmd>Neogit commit<CR>",
                },
              },
            },
          },
        },
        event = "User AstroGitFile",
        opts = function(_, opts)
          local utils = require("astrocore")
          local disable_builtin_notifications = utils.is_available("nvim-notify") or utils.is_available("noice.nvim")
          local ui_utils = require("astroui")

          return utils.extend_tbl(opts, {
            disable_builtin_notifications = disable_builtin_notifications,
            disable_signs = true,
            telescope_sorter = function()
              if utils.is_available("telescope-fzf-native.nvim") then
                return require("telescope").extensions.fzf.native_fzf_sorter()
              end
            end,
            integrations = { telescope = utils.is_available("telescope.nvim"), diffview = true },
          })
        end,
      },
    },
  },
}
