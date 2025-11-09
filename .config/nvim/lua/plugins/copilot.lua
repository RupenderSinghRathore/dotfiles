return {
  {
    "github/copilot.vim",
    -- cmd = { "co" },
    event = "InsertEnter",
    config = function()
      vim.g.copilot_enabled = 0
      -- vim.g.copilot_no_tab_map = true
      -- vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
    end,
  },
}
