---@diagnostic disable: unused-local
local M = {}

---@param clipboard string
---@param contents string
local function osc52(clipboard, contents)
  return string.format("\027]52;%s;%s\027\\", clipboard, contents)
end

function M.copy()
  -- local clipboard = reg == "0" and "0" or '"'
  -- local clipboard = reg == '"' and '"' or "0"
  -- local clipboard = reg == '"' and "+" or "0"
  -- Clipboard = reg == "+" and "*" or '"'
  -- Clipboard = ""
  ---@param lines table
  return function(lines)
    local s = table.concat(lines, "\n")
    vim.api.nvim_chan_send(2, osc52("", vim.base64.encode(s)))
  end
end

function M.paste()
  return function()
    return { vim.split(assert(vim.fn.getreg("")), "\n"), vim.fn.getregtype("") }
  end
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = M.copy(),
    ["*"] = M.copy(),
  },
  paste = {
    ["+"] = M.paste(),
    ["*"] = M.paste(),
  },
}

return M
