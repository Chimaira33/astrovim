return {
  "gbprod/cutlass.nvim",
  event = { "User AstroFile" },
  lazy = true,
  opts = {
    cut_key = "x",
    override_del = true,
    registers = {
      select = "_",
      delete = "_",
      change = "_",
    },
  },
}
