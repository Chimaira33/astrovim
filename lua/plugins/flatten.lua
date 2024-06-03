return {
  "willothy/flatten.nvim",
  lazy = false,
  priority = 99999,
  opts = function(_, opts)
    ---@type Terminal?
    local saved_terminal
    opts.block_for = {
      gitcommit = false,
      gitrebase = false,
    }
    opts.window = {
      open = "alternate",
      diff = "vsplit",
    }
    opts.callbacks = {
      should_block = function(argv)
        --stylua: ignore
        return vim.tbl_contains({ argv, { "-b", "-d" } }, function(v) return vim.deep_equal(v, { "-b", "-d" }) end, { predicate = true })
      end,
      pre_open = function()
        local term = require("toggleterm.terminal")
        local termid = term.get_focused_id()
        saved_terminal = term.get(termid)
      end,

      post_open = function(winnr, is_blocking)
        --stylua: ignore
        if is_blocking and saved_terminal then saved_terminal:close() else vim.api.nvim_set_current_win(winnr) end
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
