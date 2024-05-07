return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      -- status.component.git_branch(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.file_info(),
      -- status.component.fill(),
      status.component.lsp({ lsp_progress = false }),
      status.component.nav(),
      status.component.mode({ surround = { separator = "right" } }),
    }
    -- opts.winbar = nil
  end,
}
