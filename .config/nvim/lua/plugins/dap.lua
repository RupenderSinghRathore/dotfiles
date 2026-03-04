return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
    -- dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-go").setup()
      require("dapui").setup()

      table.insert(dap.configurations.go, {
        type = "go",
        name = "Debug Package (Prompts for Args)",
        request = "launch",
        mode = "debug",
        program = "${workspaceFolder}/cmd/app", -- Debugs the whole package at root
        args = function()
          -- This will prompt you for args every time you launch
          local input = vim.fn.input("Args: ")
          return vim.split(input, " ")
        end,
      })
      table.insert(dap.configurations.go, {
        type = "go",
        name = "Exec Binary (Prompts for Args)",
        request = "launch",
        mode = "exec",
        program = function()
          -- Prompts you for the path to the compiled binary
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
          -- This will prompt you for args every time you launch
          local input = vim.fn.input("Args: ")
          return vim.split(input, " ")
        end,
        dlvLoadConfig = {
          followPointers = true,
          maxVariableRecurse = 3, -- How deep to go into nested structs (default is usually 1)
          maxStringLen = 1024, -- Maximum string length to display (default is usually 64)
          maxArrayValues = 1024, -- Maximum number of array/slice elements to show
          maxStructFields = -1, -- -1 means fetch all fields of a struct
        },
      })

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
          args = {}, -- provide arguments if needed
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
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
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

      -- Keymaps for general debugging

      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      -- vim.keymap.set("n", "<leader>dn", dap.next, { desc = "Next" })

      vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "Disconnect" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
      -- Add these extra keymaps:

      -- Stepping Controls
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dh", dap.run_to_cursor, { desc = "Run untill Cursor" }) -- Run until the line your cursor is on

      vim.keymap.set("n", "<leader>dU", function()
        require("dapui").toggle()
      end, { desc = "Toggle Debug UI" })

      vim.keymap.set("n", "<Leader>dr", function()
        require("dap").repl.open()
      end, { desc = "open repl" })

      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end, { desc = "run last test" })

      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "hover dap ui widget" })

      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end, { desc = "preview dap ui widgets" })

      vim.keymap.set("n", "<Leader>df", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end, { desc = "centered_float" })

      vim.keymap.set("n", "<Leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end, { desc = "centered variables pane" })
    end,
  },
}
