local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#181210", -- Default Background
    base01 = "#251e1c", -- Lighter Background (status bars)
    base02 = "#2f2926", -- Selection Background
    base03 = "#a08d85", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#d8c2ba", -- Dark Foreground (status bars)
    base05 = "#ede0db", -- Default Foreground
    base06 = "#ede0db", -- Light Foreground
    base07 = "#ede0db", -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab", -- Variables, XML Tags, Errors
    base09 = "#d1c88f", -- Integers, Constants
    base0A = "#e6bead", -- Classes, Search Background
    base0B = "#ffb695", -- Strings, Diff Inserted
    base0C = "#d1c88f", -- Regex, Escape Chars
    base0D = "#ffb695", -- Functions, Methods
    base0E = "#e6bead", -- Keywords, Storage
    base0F = "#93000a", -- Deprecated, Embedded Tags
  })
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    package.loaded["matugen"] = nil
    require("matugen").setup()
  end)
)

return M
