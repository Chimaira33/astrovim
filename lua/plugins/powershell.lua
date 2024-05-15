---@diagnostic disable: missing-fields
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "powershell_es" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "powershell-editor-services" })
    end,
  },
  { "PProvost/vim-ps1", ft = "ps1" },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        formatting = {
          format_on_save = {
            allow_filetypes = { "ps1" },
          },
        },
        config = {
          powershell_es = {
            settings = {
              powershell = {
                analyzeOpenDocumentsOnly = true,
                buttons = { showRunButtons = false },
                codeFolding = { enable = false },
                codeFormatting = {
                  addWhitespaceAroundPipe = true,
                  alignPropertyValuePairs = true,
                  autoCorrectAliases = true,
                  avoidSemicolonsAsLineTerminators = true,
                  ignoreOneLineBlock = true,
                  newLineAfterCloseBrace = true,
                  newLineAfterOpenBrace = true,
                  openBraceOnSameLine = true,
                  pipelineIndentationStyle = "IncreaseIndentationForFirstPipeline",
                  preset = "Custom",
                  trimWhitespaceAroundPipe = true,
                  useConstantStrings = true,
                  useCorrectCasing = true,
                  whitespaceAfterSeparator = true,
                  whitespaceAroundOperator = true,
                  whitespaceAroundPipe = true,
                  whitespaceBeforeOpenBrace = true,
                  whitespaceBeforeOpenParen = true,
                  whitespaceBetweenParameters = true,
                  whitespaceInsideBrace = true,
                },
                developer = { editorServicesLogLevel = "Error" },
                integratedConsole = { suppressStartupBanner = true },
                pester = { codeLens = false },
              },
            },
          },
        },
      })
    end,
  },
}
