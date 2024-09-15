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
local gft = vim.filetype._getline
local bufnr = vim.api.nvim_get_current_buf()
local ft = gft(bufnr, -1):match("vim:.*ft=sh")
local filetype = gft(bufnr, -1):match("vim:.*filetype=sh")
if
  string.format("%s", vim.env.USER) == "root"
  and (string.format("%s", ft) ~= nil or string.format("%s", filetype) ~= nil)
then
  vim.cmd("setlocal modeline")
end

local vroot = vim.env.ROOT_VIM

if string.format("%s", vroot) == "1" then
  vim.o.shell = "/system_ext/bin/bash -l"
else
  vim.o.shell = "fish -il"
end
