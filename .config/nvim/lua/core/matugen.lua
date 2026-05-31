local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#1a1b1c", -- Default Background
    base01 = "#252627", -- Lighter Background (status bars)
    base02 = "#2f3031", -- Selection Background
    base03 = "#656668", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#a69d96", -- Dark Foreground (status bars)
    base05 = "#cdc5bd", -- Default Foreground
    base06 = "#cdc5bd", -- Light Foreground
    base07 = "#cdc5bd", -- Lightest Foreground
    -- Accent colors
    base08 = "#db6d6d", -- Variables, XML Tags, Errors
    base09 = "#8faeb1", -- Integers, Constants
    base0A = "#d1b394", -- Classes, Search Background
    base0B = "#db6d6d", -- Strings, Diff Inserted
    base0C = "#96e1e9", -- Regex, Escape Chars
    base0D = "#e99696", -- Functions, Methods
    base0E = "#e9c096", -- Keywords, Storage
    base0F = "#831212", -- Deprecated, Embedded Tags
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
