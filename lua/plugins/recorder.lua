-- --stylua: ignore
-- if true then return {} end

return {
  "chrisgrieser/nvim-recorder",
  event = "User AstroFile",
  ---@class configObj
  opts = {
    mapping = {
      startStopRecording = "Q",
      playMacro = "T",
      switchSlot = "<C-A-S-|>",
      editMacro = "<C-A-S-/>",
      deleteAllMacros = "<C-A-S-\\>",
      yankMacro = "<Leader>ry",
      addBreakPoint = "##",
    },
    clear = true,
    logLevel = vim.log.levels.DEBUG,
    lessNotifications = true,
  },
  dependencies = { "rcarriga/nvim-notify", optional = true },
  specs = {
    {
      "nvim-lualine/lualine.nvim",
      lazy = true,
      optional = true,
      opts = function(_, opts)
        table.insert(opts.sections.lualine_c, {
          "require('recorder').recordingStatus()",
          color = { fg = "#e0af68" },
        })
      end,
    },
  },
}
