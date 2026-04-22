local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "{{colors.surface.default.hex}}",
    base01 = "{{colors.surface_container.default.hex}}",
    base02 = "{{colors.surface_container_high.default.hex}}",
    base03 = "{{colors.outline.default.hex}}",

    -- Foreground tones
    base04 = "{{colors.on_surface_variant.default.hex}}",
    base05 = "{{colors.on_surface.default.hex}}",
    base06 = "{{colors.on_surface.default.hex}}",
    base07 = "{{colors.on_background.default.hex}}",

    -- Accent colors
    base08 = "{{colors.error.default.hex}}",
    base09 = "{{colors.tertiary.default.hex}}",
    base0A = "{{colors.secondary.default.hex}}",
    base0B = "{{colors.primary.default.hex}}",
    base0C = "{{colors.tertiary_fixed_dim.default.hex}}",
    base0D = "{{colors.primary_fixed_dim.default.hex}}",
    base0E = "{{colors.secondary_fixed_dim.default.hex}}",
    base0F = "{{colors.error_container.default.hex}}",
  })
  local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "LineNr",
    "SignColumn",
    "EndOfBuffer",
    "MsgArea",
    "Pmenu",
    "StatusLine",
    "StatusLineNC",
    "lualine_c_normal",
    "lualine_c_insert",
    "lualine_c_visual",
    "lualine_c_replace",
    "lualine_c_command",
    "lualine_c_inactive",
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

-- Register a signal handler for live reloads (when Noctalia changes colors)
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
