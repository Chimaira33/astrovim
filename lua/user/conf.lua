return {
  vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "mpv.conf" },
    command = "set filetype=conf",
  }),
}
