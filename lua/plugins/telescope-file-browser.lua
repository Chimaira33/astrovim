return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-lua/plenary.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>fe"] = { "<Cmd>Telescope file_browser<CR>", desc = "Open File browser" },
          },
        },
      },
    },
  },
  opts = function()
    require("telescope").setup({
      extensions = {
        file_browser = {
          hidden = { file_browser = true, folder_browser = true },
          respect_gitignore = false,
          no_ignore = true,
          follow_symlinks = true,
          git_status = false,
        },
      },
    })
    require("telescope").load_extension("file_browser")
  end,
}
