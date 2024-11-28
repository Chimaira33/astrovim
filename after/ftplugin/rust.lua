local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "bh", function()
  vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr })

for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if
      (err ~= nil and err.code == -32802) or (err ~= nil and string.match(err.message, "overly long loop turn took"))
    then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
