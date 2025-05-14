return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      messages = {
        enabled = true,
        view = "mini", -- You can also use "notify" for pop-up messages
      },
    })
  end,
}
