return {
  "sindrets/diffview.nvim",
  event = "User AstroGitFile",
  cmd = { "DiffviewOpen" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    hooks = {
      diff_buf_read = function(bufnr)
        vim.b[bufnr].view_activated = false
      end,
    },
  },
  dependencies = {
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
        local fold_signs = { ui_utils.get_icon("FoldClosed"), ui_utils.get_icon("FoldOpened") }

        return utils.extend_tbl(opts, {
          disable_builtin_notifications = disable_builtin_notifications,
          telescope_sorter = function()
            if utils.is_available("telescope-fzf-native.nvim") then
              return require("telescope").extensions.fzf.native_fzf_sorter()
            end
          end,
          integrations = { telescope = utils.is_available("telescope.nvim"), diffview = true },
          signs = { section = fold_signs, item = fold_signs },
        })
      end,
    },
  },
}
