return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- make sure it loads before other plugins
    opts = {
      style = "moon", -- "storm", "moon", "night", "day"
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        floats = "transparent",
        sidebars = "transparent",
      },
      -- sidebars = { "qf", "help", "terminal", "packer" },
      -- hide_inactive_statusline = true,
      dim_inactive = false,
      lualine_bold = false,

      -- cache = true,
      --- You can override specific highlight groups
      on_colors = function(colors)
        colors.bg_highlight = "#5b2571"
        -- colors.bg_highlight = "#40587C"

        colors.bg_statusline = colors.none -- or "NONE"
      end,

      on_highlights = function(hl, c)
        hl.CursorLine = { bg = c.bg_highlight, blend = 50 } -- 20% transparent
        hl.Visual = { bg = c.bg_highlight, bold = false }
        hl.Folded = { bg = "NONE" }

        hl.UfoPreviewNormal = { bg = "NONE" }
        hl.UfoPreviewBorder = { bg = "NONE" }
        hl.UfoCursorFoldedLine = { bg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- {
  --   "RRethy/base16-nvim",
  --   config = function()
  --     require("core.matugen").setup()
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = "latte",
  --         dark = "mocha",
  --       },
  --       transparent_background = true, -- disables setting the background color.
  --       float = {
  --         transparent = true, -- enable transparent floating windows
  --         solid = false, -- use solid styling for floating windows, see |winborder|
  --       },
  --       show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  --       term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  --       dim_inactive = {
  --         enabled = false, -- dims the background color of inactive window
  --         shade = "dark",
  --         percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --       },
  --       no_italic = false, -- Force no italic
  --       no_bold = false, -- Force no bold
  --       no_underline = false, -- Force no underline
  --       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
  --         comments = { "italic" }, -- Change the style of comments
  --         conditionals = { "italic" },
  --         loops = {},
  --         functions = {},
  --         keywords = {},
  --         strings = {},
  --         variables = {},
  --         numbers = {},
  --         booleans = {},
  --         properties = {},
  --         types = {},
  --         operators = {},
  --         -- miscs = {}, -- Uncomment to turn off hard-coded styles
  --       },
  --       lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
  --         virtual_text = {
  --           errors = { "italic" },
  --           hints = { "italic" },
  --           warnings = { "italic" },
  --           information = { "italic" },
  --           ok = { "italic" },
  --         },
  --         underlines = {
  --           errors = { "underline" },
  --           hints = { "underline" },
  --           warnings = { "underline" },
  --           information = { "underline" },
  --           ok = { "underline" },
  --         },
  --         inlay_hints = {
  --           background = true,
  --         },
  --       },
  --       color_overrides = {},
  --       custom_highlights = {},
  --       default_integrations = true,
  --       auto_integrations = false,
  --       integrations = {
  --         cmp = true,
  --         gitsigns = true,
  --         nvimtree = true,
  --         notify = false,
  --         mini = {
  --           enabled = true,
  --           indentscope_color = "",
  --         },
  --         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  --       },
  --     })
  --
  --     -- setup must be called before loading
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  --
  --
  -- lua/plugins/rose-pine.lua
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     vim.cmd("colorscheme rose-pine")
  --
  --     require("rose-pine").setup({
  --       -- styles = {
  --       --   bold = true,
  --       --   italic = true,
  --       --   transparency = true,
  --       -- },
  --     })
  --   end,
  -- },
  -- {
  --   "xiyaowong/transparent.nvim",
  --   lazy = false,
  --   dependencies = { "nvim-lualine/lualine.nvim" },
  --   config = function()
  --     -- Initialize the plugin first
  --     require("transparent").setup({
  --       -- You can easily add other stubborn plugins here later if needed
  --       extra_groups = { "NormalFloat", "FloatBorder" },
  --     })
  --     vim.g.transparent_enabled = true
  --     -- Then tell it to strip Lualine
  --     -- require("transparent").clear_prefix("lualine")
  --   end,
  -- },
}
