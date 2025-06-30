---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@param opts AstroUIOpts
    opts = function(_, opts)
      --stylua: ignore
      local error, warning, info, hint, comment, normal, inactive, dark_bg = "#db4b4b", "#e0af68", "#0db9d7", "#1abc9c", "#565f89", "#cad4ff", "#686f8e", "#000000"
      opts.folding = { enabled = false }
      opts.lazygit = false
      opts.highlights = require("astrocore").extend_tbl(opts.highlights or {}, {
        init = {
          Comment = { fg = comment },
          TSConstructor = { fg = "#2ac3de" },
          TSTagDelimiter = { fg = "#737aa2" },
          Folded = { fg = dark_bg, bg = dark_bg },
          DiagnosticUnderlineError = { undercurl = false, underline = false, sp = error, fg = error, bg = dark_bg },
          DiagnosticUnderlineWarn = { undercurl = false, underline = false, sp = warning, fg = warning, bg = dark_bg },
          DiagnosticUnderlineInfo = { undercurl = false, underline = false, sp = info, fg = info, bg = dark_bg },
          DiagnosticUnderlineHint = { undercurl = false, underline = false, sp = hint, fg = hint, bg = dark_bg },
          GB_Underlined = { underline = true, bold = true },
        },
      })
      opts.status = require("astrocore").extend_tbl(opts.status or {}, {
        colors = {
          tabline_bg = dark_bg,
          tabline_fg = dark_bg,
          buffer_fg = inactive,
          buffer_path_fg = inactive,
          buffer_close_fg = dark_bg,
          buffer_bg = dark_bg,
          buffer_active_fg = normal,
          buffer_active_path_fg = normal,
          buffer_active_close_fg = dark_bg,
          buffer_active_bg = dark_bg,
          buffer_visible_fg = dark_bg,
          buffer_visible_path_fg = dark_bg,
          buffer_visible_close_fg = dark_bg,
          buffer_visible_bg = dark_bg,
          buffer_overflow_fg = dark_bg,
          buffer_overflow_bg = dark_bg,
          buffer_picker_fg = error,
          tab_close_fg = dark_bg,
          tab_close_bg = dark_bg,
          tab_fg = "#5c7eb6",
          tab_bg = dark_bg,
          tab_active_fg = "#7aa2f7",
          tab_active_bg = dark_bg,
        },
      })
    end,
  },
}
