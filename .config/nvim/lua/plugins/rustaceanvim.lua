return {
  "mrcjkb/rustaceanvim",
  ft = "rust",
  version = "^8", -- Recommended
  lazy = true, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        -- cmd = (function()
        --   local mason_ra = vim.fn.expand("~/.local/share/nvim/mason/bin/rust-analyzer")
        --   if vim.fn.executable(mason_ra) == 1 then
        --     return { mason_ra }
        --   end
        --   error("Mason rust-analyzer not found at: " .. mason_ra)
        -- end)(),
        cmd = { "rust-analyzer" },

        settings = {
          ["rust-analyzer"] = {
            -- numThreads = 4,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["tokio"] = { "main", "test" },
              },
            },
            check = {
              command = "clippy",
              extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
            },
            cargo = {
              buildScripts = { enable = false },
            },
            diagnostics = {
              enable = true,
              experimental = { enable = false },
            },
            inlayHints = {
              enable = true,
              chainingHints = { enable = false },
              typeHints = { enable = true },
            },
            completion = {
              postfix = { enable = false },
            },
          },
        },
        on_attach = function(client, buf)
          local nmap = function(bind, cmd, desc)
            vim.keymap.set("n", bind, cmd, { desc = desc, silent = true, buffer = buf })
          end

          nmap("<leader>da", function()
            vim.ui.input({ prompt = "Args: " }, function(input)
              if input == nil then
                return
              end
              local args = vim.split(input, " ")
              vim.cmd.RustLsp(vim.list_extend({ "debuggables" }, args))
            end)
          end, "Debug with args")

          -- },
        end,
      },
    }
  end,
  config = function()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "<leader>a", function()
      vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
      -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end, { silent = true, buffer = bufnr })
    -- vim.keymap.set(
    --   "n",
    --   "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    --   function()
    --     vim.cmd.RustLsp({ "hover", "actions" })
    --   end,
    --   { silent = true, buffer = bufnr }
    -- )
  end,
}
