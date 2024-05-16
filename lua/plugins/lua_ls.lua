---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    table.insert(opts.formatting, { disabled = "lua_ls" })
    table.insert(opts.servers, "lua_ls")
    opts.config = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "require" } },
            hint = { enable = true, arrayIndex = "Disable" },
            telemetry = { enable = false },
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
