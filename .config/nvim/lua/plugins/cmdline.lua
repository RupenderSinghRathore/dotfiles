return {
  -- {
  --   "VonHeikemen/fine-cmdline.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("fine-cmdline").setup({
  --       cmdline = {
  --         enable_keymaps = true,
  --         smart_history = true,
  --         prompt = " ",
  --       },
  --       popup = {
  --         position = {
  --           row = "50%",
  --           col = "50%",
  --         },
  --         size = {
  --           width = "60%",
  --         },
  --         border = {
  --           style = "rounded",
  --         },
  --       },
  --     })
  --
  --     vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>")
  --   end,
  -- },
  {
    "rachartier/tiny-cmdline.nvim",
    config = function()
      vim.o.cmdheight = 0
      vim.o.laststatus = 3
      require("tiny-cmdline").setup()
    end,
  },
}
