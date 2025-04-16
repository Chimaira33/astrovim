return {
  "willothy/flatten.nvim",
  lazy = false,
  priority = 99999,
  opts = function(_, opts)
    local flatten = require("flatten")
    ---@type Terminal?
    local saved_terminal
    opts.block_for = {
      gitcommit = false,
      gitrebase = false,
    }
    opts.window = { open = "alternate", diff = "split" }
    opts.hooks = {
      -- --stylua: ignore
      -- should_block = function(argv) return vim.tbl_contains({ argv, { "-b", "-d" } }, function(v) return vim.deep_equal(v, { "-b", "-d" }) end, { predicate = true }) end,
      should_block = flatten.hooks.should_block,
      pre_open = function()
        local term = require("toggleterm.terminal")
        local termid = term.get_focused_id()
        saved_terminal = term.get(termid)
      end,

      post_open = function(is_blocking)
        --stylua: ignore
        if is_blocking and saved_terminal then saved_terminal:close() else vim.api.nvim_set_current_win(vim.winnr) end
      end,
      block_end = function()
        vim.schedule(function()
          --stylua: ignore
          if saved_terminal then saved_terminal:open() saved_terminal = nil end
        end)
      end,
    }
  end,
}
