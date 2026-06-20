return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",

    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,

        keymap = {
          accept = "<C-e>",
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
        "<leader>cd",
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
      interactions = {
        shared = {
          keymaps = {
            accept_change = {
              modes = { i = "<C-e>" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              opts = { nowait = true },
              description = "Reject the suggested change",
            },
          },
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
