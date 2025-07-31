return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Load immediately
    priority = 100, -- Load before other plugins
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false, -- Default is not transparent
        terminal_colors = true,
        on_colors = function(colors)
          colors.bg = "#16161E" -- Your desired darker hex color
          -- Specifically for 'night' style's dark background if it's different
          colors.bg_dark = "#16161E" -- Your desired darker hex color
        end,
      })

      vim.cmd.colorscheme("tokyonight")

      -- Function to toggle transparency
      local function toggle_transparency()
        local current_transparency = require("tokyonight.config").options.transparent
        require("tokyonight").setup({
          transparent = not current_transparency,
          style = "night",
        })
        vim.cmd.colorscheme("tokyonight") -- Reload colorscheme
      end

      -- Set keybinding to <leader>tt (change if you prefer another keybinding)
      vim.keymap.set("n", "<leader>tt", toggle_transparency, { noremap = true, silent = true })
    end,
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 100 },
  --
  --

  -- ### Rose - pine theme
  -- {
  --     "rose-pine/neovim",
  --     name = "rose-pine",
  --     priority = 100,
  --     config = function()
  --         -- require("rose-pine").setup({
  --         -- disable_background = false, -- Remove background
  --         --   disable_float_background = true, -- Transparent floats
  --         -- })
  --         vim.cmd("colorscheme rose-pine-moon")
  --         -- vim.cmd("colorscheme rose-pine")
  --     end,
  -- },
}
