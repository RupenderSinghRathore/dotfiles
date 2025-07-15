-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = false }

-- save file
vim.keymap.set("n", "<leader>ss", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>sq", "<cmd>wq<CR>", opts)
vim.keymap.set("n", "<leader>sQ", "<cmd>q!<CR>", opts)

-- to Explorer
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", opts)

-- Close the terminal
vim.api.nvim_set_keymap("t", "<C-o>", [[<C-\><C-n><C-o>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })

-- save file without auto-formatting
vim.keymap.set("n", "<leader>ns", "<cmd>noautocmd w <CR>", opts)

vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew ", opts) -- open new tab
-- vim.keymap.set("n", "tx", ":tabclose ", opts)       -- close current tab
vim.keymap.set("n", "tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- remapping u and U
vim.keymap.set("n", "U", "u", { noremap = true })
vim.keymap.set("n", "u", "", { noremap = true })

vim.keymap.set("n", "<C-o>", "<Nop>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-n>", "<Nop>", { noremap = true })
