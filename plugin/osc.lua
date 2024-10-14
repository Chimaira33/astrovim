---@diagnostic disable: unused-local
local M = {}

---@param clipboard string
---@param contents string
local function osc52(clipboard, contents)
  return string.format("\x1b]52;%s;%s\x1b\\", clipboard, contents)
end

function M.copy()
  -- local clipboard = reg == "0" and "0" or '"'
  -- local clipboard = reg == '"' and '"' or "0"
  -- local clipboard = reg == '"' and "+" or "0"
  -- Clipboard = reg == "+" and "*" or '"'
  -- Clipboard = ""
  ---@param lines table
  return function(lines)
    local clip = table.concat(lines, "\n")
    -- local trim = clip:gsub("^%s*(.-)%s*$", "%1")
    local trim = vim.trim(clip)
    vim.api.nvim_chan_send(2, osc52("", vim.base64.encode(trim)))
    local file = io.open("/data/data/com.termux/files/home/.clipboard/clip", "w")
    if file then
      file:write(assert(vim.base64.encode(clip)))
      file:close()
    else
      return
    end
  end
end

function M.paste()
  return function()
    local file = io.open("/data/data/com.termux/files/home/.clipboard/clip", "r")
    if file then
      Content = file:read("*a")
      file:close()
      return vim.split(assert(string.format("%s", vim.base64.decode(Content))), "\n")
    else
      return vim.split(assert(vim.fn.getreg("")), "\n"), vim.fn.getregtype("")
    end
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
