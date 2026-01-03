return {
  {
    "github/copilot.vim",
    ft = { "html" },
    -- cmd = { "co" },
    -- event = "InsertEnter",
    config = function()
      -- vim.g.copilot_enabled = 0
      -- vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-;>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.keymap.set("n", "<leader>cp", function()
        -- vim.fn["copilot#Enabled"]() returns 1 if Copilot is active, 0 otherwise
        if vim.fn["copilot#Enabled"]() == 1 then
          vim.cmd("Copilot disable")
          print("Copilot Disabled")
        else
          vim.cmd("Copilot enable")
          print("Copilot Enabled")
        end
      end, { desc = "Toggle Copilot" })
    end,
  },
}
