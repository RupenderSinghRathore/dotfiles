return {
  -- 1. Core DAP – load only when you press a debug key
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      -- All your existing <leader>d… keys trigger loading instantly
      { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
      { "<leader>dq", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate" },
      { "<leader>dn", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
      { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
      { "<leader>dh", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run until Cursor" },
      { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>", desc = "Open REPL" },
      { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last" },
    },
    config = function()
      local dap = require("dap")

      -- gdb adapter (C/C++/Rust) – unchanged
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          pid = function()
            return require("dap.utils").pick_process({ filter = vim.fn.input("Executable name (filter): ") })
          end,
          cwd = "${workspaceFolder}",
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
    end,
  },

  -- 2. dap-ui – loads only when you open it (or when dap starts)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Dap UI Toggle",
      },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

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
    end,
  },

  -- 3. Go support – loads only on Go files (or when you use dap-go commands)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },

  -- 4. nvim-nio (required by dap-ui) – stays lazy
  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },
}
