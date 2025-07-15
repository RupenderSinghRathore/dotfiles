-- ~/.config/nvim/lua/plugins/debugger.lua

return {
  -- Mason for managing LSP servers, DAP servers, linters, formatters
  {
    "williamboman/mason.nvim",
    opts = {
      -- Add list of DAPs, LSPs, etc. you want Mason to ensure are installed
      ensure_installed = {
        -- Example DAPs (add the ones you need!)
        "debugpy", -- Python
        "codelldb", -- C, C++, Rust (needs build tools: sudo dnf groupinstall "Development Tools")
        "js-debug-adapter", -- Javascript/Typescript (Chrome, Edge, Node)
        "delve", -- Go
        -- "bash-debug-adapter", -- Bash (optional)
        -- Add more DAPs based on the languages you use (see :Mason)
      },
    },
  },

  -- Bridge between Mason and nvim-dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy", -- Load after Mason and DAP
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    -- We will automatically configure adapters based on what's installed in Mason
    config = function()
      require("mason-nvim-dap").setup({
        handlers = {}, -- Automatically handles setup for installed DAPs
        ensure_installed = {}, -- Can also list DAPs here, but mason.nvim `ensure_installed` is preferred
        automatic_installation = true, -- Optional: automatically install adapters used in `launch.json`
      })
    end,
  },

  -- The core Debug Adapter Protocol client
  {
    "mfussenegger/nvim-dap",
    -- Ensure NIO is loaded before DAP UI attempts to use it
    -- Also depends on Telescope for optional picker UI
    dependencies = {
      "rcarriga/nvim-dap-ui", -- Load UI dependency first
      "nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
      { "nvim-telescope/telescope.nvim", optional = true }, -- Optional dependency for picker
      -- Add other DAP extensions like java debug etc. if needed
    },
    -- Define keybindings that are active when this plugin loads
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP: Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))
        end,
        desc = "DAP: Conditional Breakpoint",
      },
      {
        "<leader>dl",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log Message: "))
        end,
        desc = "DAP: Log Point",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "DAP: Continue",
      },
      {
        "<leader>dj",
        function()
          require("dap").step_over()
        end,
        desc = "DAP: Step Over",
      },
      {
        "<leader>dk",
        function()
          require("dap").step_into()
        end,
        desc = "DAP: Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "DAP: Step Out",
      },
      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
        desc = "DAP: Terminate",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "DAP: Open REPL",
      },
      {
        "<leader>dR",
        function()
          require("dap").run_last()
        end,
        desc = "DAP: Run Last",
      },
      -- If Telescope is installed:
      -- { "<leader>ds", function() require("telescope").extensions.dap.configurations({}) end, desc = "DAP: Select Configuration" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui") -- Require dapui here to setup listeners

      -- Define DAP signs (visual markers in the gutter)
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "Error", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "Error", linehl = "", numhl = "" }) -- Optional: Condition icon
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "Debug", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Debug", linehl = "Debug", numhl = "" })

      -- Setup DAP listeners to automatically open/close the UI
      -- This is placed in the main dap config now to avoid LuaLS warnings
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      -- Note: Adapter definitions (`dap.adapters.*`) and configurations (`dap.configurations.*`)
      -- are now primarily handled by `mason-nvim-dap` based on installed adapters
      -- and `.vscode/launch.json` files. You generally don't need to manually define them here
      -- unless you have very specific custom requirements.
    end,
  },

  -- Fancy UI for DAP
  {
    "rcarriga/nvim-dap-ui",
    -- Dependencies are listed under nvim-dap now, lazy.nvim handles the order
    -- dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "DAP: Toggle UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "DAP: Evaluate",
        mode = { "n", "v" },
      }, -- Evaluate visual selection too
    },
    opts = {
      -- Layout: Configure the structure and elements of the DAP UI
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.30 }, -- Variables, Registers
            { id = "breakpoints", size = 0.20 }, -- Breakpoints, Log points
            { id = "stacks", size = 0.25 }, -- Call stack
            { id = "watches", size = 0.25 }, -- Expressions to watch
          },
          size = 40, -- Width of the sidebar
          position = "left", -- "left", "right", "top", "bottom"
        },
        {
          elements = {
            { id = "repl", size = 0.5 }, -- Debug REPL
            { id = "console", size = 0.5 }, -- Program output
          },
          size = 0.25, -- Height of the bottom panel (25% of editor height)
          position = "bottom",
        },
      },
      -- Floating Window behavior for things like Evaluate hover
      floating = {
        max_height = nil, -- Use default calculated height based on content
        max_width = nil, -- Use default calculated width based on content
        border = "rounded", -- Style of border for floating windows
        mappings = {
          close = { "q", "<Esc>" }, -- Keys to close the floating window
        },
      },
      -- Controls: Integrated control buttons in the REPL or Console
      controls = {
        enabled = true, -- Show controls
        element = "repl", -- Which element to attach controls to (repl or console)
        icons = { -- Customize icons (requires a Nerd Font)
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "", -- Not always supported by adapters
          run_last = "↻",
          terminate = "⏹",
          disconnect = "⏏", -- Added for disconnect action if available
        },
      },
      -- Rendering options
      render = {
        max_value_lines = 100, -- Don't truncate long variable values too early
        indent = 1,
      },
      -- You can explore other options in :help dapui-options
    },
    config = function(_, opts)
      -- Setup nvim-dap-ui with the options defined above
      require("dapui").setup(opts)
      -- Listeners moved to nvim-dap config
    end,
  },
}
