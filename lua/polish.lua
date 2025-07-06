-- if true then return end

vim.cmd("let g:perl_host_prog = '/data/data/com.termux/files/usr/bin/perl'")
vim.cmd("let g:node_host_prog = '/data/data/com.termux/files/usr/bin/pnpm'")
vim.cmd("let g:python3_host_prog = '/data/data/com.termux/files/usr/bin/python'")
-- local gft = vim.filetype._getline
-- local bufnr = vim.fn.bufnr()
-- local ft, filetype = gft(bufnr, -1):match("vim:.*ft=sh"), gft(bufnr, -1):match("vim:.*filetype=sh")
-- if
--   string.format("%s", vim.env.USER) == "root"
--   and (string.format("%s", ft) ~= nil or string.format("%s", filetype) ~= nil)
-- then
--   vim.cmd("setlocal modeline")
-- end

-- local vroot = vim.env.ROOT_VIM

-- if string.format("%s", vroot) == "1" then
--   vim.o.shell = "/system_ext/bin/bash -l"
-- else
--   vim.o.shell = "fish -il -f remove-percent-self,test-require-arg"
--   vim.o.shell = "fish -N"
-- end

-- local snip_name = vim.fn.expand("%:p")
-- if string.match(snip_name, "(.*)/snippets/(.*)[.]json$") ~= nil then
--   vim.cmd("setlocal nomodeline")
-- end

vim.scriptencoding = "utf-8"
