---@type LazySpec
return {
  "rebelot/heirline.nvim",
  -- enabled = false,
  opts = function(_, opts)
    local status = require("astroui.status")
    opts.statusline = {
      hl = { fg = "fg", bg = "#000000" },
      status.component.mode(),
      -- status.component.git_branch(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.file_info(),
      -- status.component.fill(),
      -- status.component.lsp({ lsp_progress = false }),
      status.component.nav(),
      status.component.mode({ surround = { separator = "right" } }),
    }
    -- opts.tabline = {
    --   {
    --     condition = function(self)
    --       self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
    --       self.winwidth = vim.api.nvim_win_get_width(self.winid)
    --       return self.winwidth ~= vim.o.columns -- only apply to sidebars
    --         and not require("astrocore.buffer").is_valid(vim.api.nvim_win_get_buf(self.winid)) -- if buffer is not in tabline
    --     end,
    --     provider = function(self)
    --       return (" "):rep(self.winwidth + 1)
    --     end,
    --     hl = { bg = "#000000" },
    --   },
    --   status.heirline.make_buflist(status.component.tabline_file_info({
    --     close_button = false,
    --     filename = {
    --       fallback = "Untitled",
    --       fname = function()
    --         local name =
    --           require("user.truncate").truncate_name(vim.fs.basename(vim.api.nvim_buf_get_name(vim.fn.bufnr())), 12)
    --         name = name:gsub("%%", "%%%1")
    --         return name
    --       end,
    --       modify = ":t",
    --     },
    --   })),
    --   status.component.fill({ hl = { bg = "#000000" } }),
    --   {
    --     condition = function()
    --       return #vim.api.nvim_list_tabpages() >= 2
    --     end, -- only show tabs if there are more than one
    --     status.heirline.make_tablist({
    --       provider = status.provider.tabnr(),
    --       hl = function(self)
    --         return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
    --       end,
    --     }),
    --   },
    -- }
    opts.winbar = nil
  end,
}
