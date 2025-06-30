---@diagnostic disable: missing-fields
-- if true then return {} end

---@type LazySpec
return {
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
    opts = function(_, opts)
      local actions = require("diffview.actions")
      opts.enhanced_diff_hl = true
      opts.view = require("astrocore").extend_tbl(opts.view or {}, {
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
      })
      opts.hooks = {
        diff_buf_read = function(bufnr)
          vim.b[bufnr].view_activated = false
          vim.opt_local.wrap = true
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = { 80 }
        end,
      }
      --stylua: ignore
      opts.keymaps = require("astrocore").extend_tbl(opts.keymaps or {}, {
        view = {
          { "n", "bG", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
        },
        file_panel = {
          { "n", "bG", actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
        },
      })
    end,
    specs = {
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = { ["<C-d>"] = "<Cmd>DiffviewOpen<CR>" },
          },
        },
      },
    },
  },
}
