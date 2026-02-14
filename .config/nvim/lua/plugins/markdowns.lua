return {
  --   {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --     vim.g.mkdp_browser = "/usr/bin/zen --new-window"
  --   end,
  --   ft = { "markdown" },
  -- },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   ft = "markdown",
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {
  --     enabled = false,
  --     render_modes = { "n", "i", "v", "V", "c" }, -- Enable in all common modes
  --     completions = {
  --       lsp = { enabled = true },
  --     },
  --     anti_conceal = {
  --       enabled = false,
  --     },
  --   },
  --   latex = {
  --     enabled = true,
  --     converter = { "latex2text", "utftex" }, -- Try 'latex2text' first (Python-based, often better for fractions/complex expr)
  --     -- Other options: position = 'center', top_pad = 0, etc.
  --   },
  --   keys = {
  --     { "<leader>t", "<cmd>RenderMarkdown toggle<CR>" },
  --   },
  -- },
  -- {
  --   "toppair/peek.nvim",
  --   event = { "VeryLazy" },
  --   build = "deno task build:fast",
  --   config = function()
  --     require("peek").setup()
  --     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  --     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  --   end,
  -- },
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      -- You can choose one of the following pickers
      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "echasnovski/mini.pick",
      "folke/snacks.nvim",
    },
  },
}
