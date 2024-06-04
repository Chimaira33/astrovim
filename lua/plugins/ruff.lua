---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    table.insert(opts.servers, "ruff")
    opts.config = {
      ruff = {
        on_attach = function(client)
          client.server_capabilities.hoverProvider = true
        end,
      },
    }
  end,
}
