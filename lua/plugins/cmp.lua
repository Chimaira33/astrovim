return {
  "hrsh7th/cmp-cmdline",
  keys = { ":", "/", "?" },
  dependencies = {
    { "hrsh7th/nvim-cmp" },
    { url = "https://codeberg.org/FelipeLema/cmp-async-path", lazy = true },
  },
  opts = function()
    local cmp = require("cmp")
    return {
      {
        type = { "/", "?" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      },
      {
        type = ":",
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          -- { name = "path" },
          {
            name = "async_path",
            priority = 250,
            option = { show_hidden_files_by_default = true },
          },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    vim.tbl_map(function(val)
      cmp.setup.cmdline(val.type, val)
    end, opts)
  end,
}
