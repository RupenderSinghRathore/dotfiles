return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",

    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,

        keymap = {
          accept = "<Tab>",
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C-]>",
        },
      },

      panel = {
        enabled = false,
      },

      filetypes = {
        markdown = true,
        help = false,
      },
    },
    keys = {
      {
        "<leader>ap",
        "<cmd>Copilot toggle<CR>",
        desc = "Toggle Copilot",
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "zbirenbaum/copilot.lua",
    },

    opts = {
      strategies = {
        chat = {
          adapter = "copilot",
        },

        inline = {
          adapter = "copilot",
        },
      },

      opts = {
        log_level = "DEBUG",
      },
    },

    keys = {
      {
        "<leader>ct",
        "<cmd>CodeCompanionChat Toggle<CR>",
        mode = "n",
        desc = "Toggle AI Chat",
      },

      {
        "<leader>ca",
        "<cmd>CodeCompanionActions<CR>",
        mode = { "n", "v" },
        desc = "AI Actions",
      },

      {
        "<leader>ci",
        "<cmd>CodeCompanion<CR>",
        mode = "v",
        desc = "Inline AI Assistant",
      },
    },
  },
}
