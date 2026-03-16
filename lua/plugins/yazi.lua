return {
  "mikavilpas/yazi.nvim",
  version = "*",
  cmd = "Yazi",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = { mappings = { n = { ["<Leader>y"] = { "<Cmd>Yazi<CR>", desc = "Open yazi at the current file" } } } },
    },
  },
  opts = {
    log_level = vim.log.levels.OFF,
    open_for_directories = false,
    chosen_file_path = "/data/data/com.termux/files/usr/tmp/chosen_yazi_file",
    cwd_file_path = "/data/data/com.termux/files/usr/tmp/cwd_yazi_file",
    future_features = { use_cwd_file = false },
    open_multiple_tabs = false,
    enable_mouse_support = false,
    change_neovim_cwd_on_close = false,
    keymaps = false,
    floating_window_scaling_factor = 1.0,

    integrations = {
      resolve_relative_path_application = "realpath",
      grep_in_directory = "snacks.picker",
      grep_in_selected_files = "snacks.picker",
    },
  },
}
