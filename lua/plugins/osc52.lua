-- local function copy(lines, _)
--   require("osc52").copy(table.concat(lines, "\n"))
-- end
local function copy()
  require("osc52").copy_register("0")
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end
return {
  "ojroques/nvim-osc52",
  opts = {
    silent = true,
    trim = true,
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        g = {
          clipboard = {
            name = "osc52",
            copy = { ["+"] = copy, ["*"] = copy },
            paste = { ["+"] = paste, ["*"] = paste },
          },
        },
      },
    },
  },
}
