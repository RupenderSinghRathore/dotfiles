return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-go").setup()
      require("dapui").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Keymaps for general debugging

      vim.keymap.set("n", "<leader>df", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })

      vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "Disconnect" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
      -- Add these extra keymaps:

      -- Stepping Controls
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dh", dap.run_to_cursor, { desc = "Run untill Cursor" }) -- Run until the line your cursor is on
    end,
  },
}
