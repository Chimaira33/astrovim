---@diagnostic disable: missing-fields, undefined-doc-name, inject-field

local default_opts = { instanceName = "main" }
local function grug_far_open(opts, with_visual)
  local grug_far = require("grug-far")
  opts = require("astrocore").extend_tbl(default_opts, opts)
  if not grug_far.has_instance(opts.instanceName) then
    grug_far.open(opts)
  else
    if with_visual then
      if not opts.prefills then
        opts.prefills = {}
      end
      opts.prefills.search = grug_far.get_current_visual_selection()
    end
    grug_far.open_instance(opts.instanceName)
    if opts.prefills then
      grug_far.update_instance_prefills(opts.instanceName, opts.prefills, false)
    end
  end
end

---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  specs = {
    { "AstroNvim/astroui", opts = { icons = { GrugFar = "󰛔" } } },
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>ss"] = function()
              local filter = require("astrocore.buffer").is_valid() and vim.fn.expand("%") or nil
              grug_far_open({ transient = true, prefills = { paths = filter } })
              -- vim.cmd("vertical resize +15")
            end,
            ["<Leader>S"] = function()
              grug_far_open({ transient = true })
            end,
            ["<Leader>sw"] = function()
              local current_word = vim.fn.expand("<cword>")
              if current_word ~= "" then
                grug_far_open({
                  startCursorRow = 4,
                  prefills = { search = vim.fn.expand("<cword>") },
                })
                -- vim.cmd("vertical resize +15")
              else
                vim.notify("No word under cursor", vim.log.levels.WARN, { title = "Grug-far" })
              end
            end,
          },
          x = {
            ["<Leader>sx"] = function()
              grug_far_open(nil, true)
            end,
          },
        },
      },
    },
  },
  ---@param opts GrugFarOptionsOverride
  opts = function(_, opts)
    opts.transient = true
    if not opts.icons then
      opts.icons = {}
    end
    if vim.g.icons_enabled == false then
      opts.icons.enabled = false
      opts.resultsSeparatorLineChar = "-"
      opts.spinnerStates = { "|", "\\", "-", "/" }
    end
    opts.engines = {
      ripgrep = {
        path = "rg",
        extraArgs = "--multiline",
        showReplaceDiff = true,

        placeholders = {
          enabled = false,

          search = "",
          replacement = "",
          replacement_lua = "",
          filesFilter = "",
          flags = "",
          paths = "",
        },
      },
    }
    opts.windowCreationCommand = "tab split"
    -- opts.windowCreationCommand = "enew"
    opts.folding = { enabled = false }
  end,
}
