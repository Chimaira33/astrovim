---@diagnostic disable: unused-local
local M = {}

---@param clipboard string
---@param contents string
local function osc52(clipboard, contents)
  return string.format("\027]52;%s;%s\027\\", clipboard, contents)
end

function M.copy(reg)
  local clipboard = reg == "0" and "0" or '"'
  return function(lines)
    local s = table.concat(lines, "\n")
    vim.api.nvim_chan_send(2, osc52(clipboard, vim.base64.encode(s)))
  end
end

function M.paste(reg)
  local clipboard = reg == "0" and "0" or '"'
  return function()
    return vim.split(vim.fn.getreg(clipboard), "\n")
  end
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = { ["+"] = M.copy("+"), ["*"] = M.copy("*") },
  paste = { ["+"] = M.paste("+"), ["*"] = M.paste("*") },
}

return M
