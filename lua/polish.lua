-- if true then return end

vim.cmd("let g:perl_host_prog = '/data/data/com.termux/files/usr/bin/perl'")
vim.cmd("let g:node_host_prog = '/data/data/com.termux/files/usr/bin/pnpm'")
vim.cmd("let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python'")
vim.filetype.add({
  -- extension = {
  --   functions = "sh",
  -- },
  filename = {
    [".aliases"] = "sh",
    [".bash_env"] = "sh",
    [".bindings"] = "sh",
    [".coreutils"] = "sh",
    [".functions"] = "sh",
    ["mkshrc"] = "sh",
    ["mpv.conf"] = "conf",
  },
  -- pattern = {
  --   [".aliases"] = "sh",
  --   [".bash_env"] = "sh",
  --   [".functions"] = "sh",
  -- },
})
