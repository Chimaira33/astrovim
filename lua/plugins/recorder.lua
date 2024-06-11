return {
  "chrisgrieser/nvim-recorder",
  event = "User AstroFile",
  opts = {
    mapping = {
      startStopRecording = "Q",
      playMacro = "T",
      switchSlot = "<C-A-S-|>",
      editMacro = "cq",
      deleteAllMacros = "dq",
      yankMacro = "yq",
    },
    clear = true,
  },
  dependencies = {
    { "rcarriga/nvim-notify", optional = true },
    {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
      optional = true,
      opts = function(_, opts)
        table.insert(opts.sections.lualine_c, "require('recorder').recordingStatus()")
      end,
    },
  },
}
