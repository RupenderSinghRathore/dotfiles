return {
  {
    -- Hints keybinds
    "folke/which-key.nvim",
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- High-performance color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- {
  --   "mg979/vim-visual-multi",
  --   branch = "master",
  --   init = function()
  --     vim.g.VM_maps = {
  --       ["Find Under"] = "<C-d>", -- Select next occurrence
  --       ["Find Subword Under"] = "<C-d>",
  --     }
  --   end,
  -- },
}
