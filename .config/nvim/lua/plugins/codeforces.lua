return {

  --   {
  --   "yunusey/codeforces-nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "rcarriga/nvim-notify", -- required because you use require("notify")
  --   },
  --
  --   opts = {
  --     use_term_toggle = false,
  --     timeout = 15000,
  --
  --     compiler = {
  --       cpp = { "g++", "@.cpp", "-o", "@" },
  --       py = {},
  --     },
  --
  --     run = {
  --       cpp = { "@" },
  --       py = { "python3", "@.py" },
  --     },
  --
  --     notify = function(title, message, type)
  --       local notify = require("notify")
  --
  --       if message == nil then
  --         notify(title, type, {
  --           render = "minimal",
  --         })
  --       else
  --         notify(message, type, {
  --           title = title,
  --         })
  --       end
  --     end,
  --   },
  --
  --   config = function(_, opts)
  --     require("codeforces-nvim").setup(opts)
  --   end,
  -- },
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      {
        "<leader>cf",
        ":CompetiTest ",
        mode = "n",
        desc = "Codeforces",
      },
    },
    config = function()
      require("competitest").setup()
    end,
  },
}
