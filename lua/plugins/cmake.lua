---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --stylua: ignore
      if not opts.servers then opts.servers = {} end
      opts.servers = require("astrocore").list_insert_unique(opts.servers, { "neocmake" })
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        neocmake = {
          offset_encoding = "utf-8",
          cmd = { "neocmakelsp", "stdio" },
          filetypes = { "cmake" },
          root_markers = { ".git", "build", "cmake" },
          single_file_support = true,
          init_options = {
            format = { enable = false },
            lint = { enable = false },
            scan_cmake_in_package = true,
            semantic_token = false,
          },
          capabilities = {
            textDocument = { completion = { completionItem = { snippetSupport = true } } },
            -- workspace = { didChangeWatchedFiles = { dynamicRegistration = false, relativePatternSupport = false } },
          },
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = { cmakelint = { args = { "--quiet", "--linelength=120", "--spaces=2" } } },
      linters_by_ft = { cmake = { "cmakelint" } },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters = { gersemi = { prepend_args = { "--indent", "2", "--line-length", "120" } } },
      formatters_by_ft = { cmake = { "gersemi" } },
    },
  },
  -- {
  --   "Civitasv/cmake-tools.nvim",
  --   ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "cmake" },
  --   opts = {
  --     cmake_build_directory = "out/${variant:buildType}",
  --     cmake_use_preset = false,
  --   },
  -- },
}
