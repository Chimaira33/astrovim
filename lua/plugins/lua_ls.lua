---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  opts_extend = { "config" },
  ---@param opts AstroLSPOpts
  opts = function(_, opts)
    if not opts.formatting then
      opts.formatting = {}
    end
    table.insert(opts.formatting, { disabled = "lua_ls" })
    table.insert(opts.servers, "lua_ls")
    opts.config = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "require" } },
            hint = { enable = true, arrayIndex = "Disable" },
            runtime = { version = "LuaJIT" },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
    }
  end,
}
