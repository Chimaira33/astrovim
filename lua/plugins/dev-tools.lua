---@type LazySpec
return {
  "yarospace/dev-tools.nvim",
  -- enabled = false,
  lazy = true,
  event = "User AstroFile",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "folke/snacks.nvim", optional = true, opts = { picker = { enabled = true }, terminal = { enabled = true } } },
    { "ThePrimeagen/refactoring.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = {
    ---@type Action[]|fun():Action[]
    actions = {},
    filetypes = { include = {}, exclude = {} },
    builtin_actions = { include = {}, exclude = true },
    action_opts = {},

    ui = { override = true, group_actions = false },
    debug = false,
    cache = true,
  },
  specs = {
    {
      "folke/lazydev.nvim",
      optional = true,
      opts = function(_, opts)
        --stylua: ignore
        if not opts.library then opts.library = {} end
        table.insert(opts.library, { path = "dev-tools.nvim", words = { "DevTools", "dev-tools" } })
      end,
    },
  },
}
