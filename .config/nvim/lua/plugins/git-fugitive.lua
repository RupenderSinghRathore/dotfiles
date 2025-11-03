return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    vim.keymap.set("n", "<leader>ga", ":Git add .", { noremap = true }),
    -- vim.keymap.set("n", "<leader>gc", ":Git commit -m ", { noremap = true }),
    vim.keymap.set("n", "<leader>gp", ":Git push ", { noremap = true }),
  },
}
