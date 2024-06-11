---@diagnostic disable: undefined-field
-- if true then
--   return {}
-- end
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local colors = {
        bg = "#000000",
        blue = "#7aa2f7",
        cyan = "#7dcfff",
        darkblue = "#081633",
        fg = "#c0caf5",
        green = "#9ece6a",
        magenta = "#bb9af7",
        orange = "#ff9e64",
        red = "#f7768e",
        violet = "#9d7cd8",
        yellow = "#e0af68",
      }

      opts.extensions = { "lazy", "man", "mason", "neo-tree", "toggleterm", "trouble" }
      opts.options = {
        component_separators = "",
        section_separators = "",
      }
      opts.theme = {
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
      }
      opts.sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      }
      opts.inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      }

      local function ins_left(component)
        table.insert(opts.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(opts.sections.lualine_x, component)
      end
      local function color()
        local mod = vim.fn.mode()
        if string.find(mod, "n") then
          return { fg = colors.blue, bg = colors.blue }
        elseif string.find(mod, "i") then
          return { fg = colors.green, bg = colors.green }
        elseif string.find(mod, "v") or string.find(mod, "V-") or string.find(mod, "C") then
          return { fg = colors.magenta, bg = colors.magenta }
        end
      end
      ins_left({
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
        padding = { left = 0, right = 0 },
        color = color,
      })
      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
        update_in_insert = true,
      })
      ins_right({
        "searchcount",
        maxcount = 999,
        timeout = 500,
        color = { fg = colors.fg },
      })
      ins_right({
        "selectioncount",
        maxcount = 999,
        timeout = 500,
        color = { fg = colors.orange },
        padding = { left = 0, right = 1 },
      })
      ins_right({ "filetype", icon_only = true, padding = { left = 0, right = 0 } })
      ins_right({
        "progress",
        -- fmt = function()
        --   return "%P/%L"
        -- end,
        color = { fg = colors.fg },
        padding = { left = 0, right = 0 },
      })
      ins_right({
        "location",
        color = { fg = colors.fg },
        padding = { left = 1, right = 1 },
      })
      ins_right({
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
        padding = { left = 0, right = 0 },
        color = color,
      })
    end,
  },
  {
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts)
      opts.statusline = nil
    end,
  },
}
