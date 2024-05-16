---@diagnostic disable: missing-fields
return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    table.insert(opts.servers, "bashls")
    opts.config = {
      bashls = {
        settings = {
          bashIde = {
            backgroundAnalysisMaxFiles = 0,
            enableSourceErrorDiagnostics = false,
            includeAllWorkspaceSymbols = false,
            inclueAllWorkspaceSymbols = false,
            logLevel = "error",
            shellcheckArguments = "--exclude=SC1091,SC2016,SC2034,SC2043,SC2117,SC2139,SC2154,SC2188,SC2317 --enable=require-double-brackets,deprecate-which,avoid-nullary-conditions",
          },
        },
      },
    }
  end,
}
