-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = false }
local opts2 = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<leader>s", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>r", "<cmd>w<CR><cmd>make<CR>", opts)
vim.keymap.set("n", "<leader>S", "<cmd>wq<CR>", opts)
vim.keymap.set("n", "<leader>md", "<cmd>call mkdir(expand('%:h'), 'p')<CR>", opts)

-- to Explorer
vim.keymap.set("n", "<leader>nv", "<cmd>Ex<CR>", opts)
vim.keymap.set("n", "<leader>nq", "<cmd>q!<CR>", opts)

vim.keymap.set("n", "<Esc>", ":<BS>", opts)
-- vim.keymap.set("n", "<leader>c", ":fclose<CR>", opts)

-- vim.keymap.set("n", "<leader>o", "<cmd>e #<CR>", opts)

vim.keymap.set({ "n", "v" }, "x", '"_x', opts)
vim.keymap.set({ "n", "v" }, "c", '"_c', opts)
vim.keymap.set({ "n", "v" }, "s", '"_s', opts)

-- Close the terminal
-- vim.keymap.set("n", "<leader>ng", "<cmd>term<CR>ilazygit && exit<CR>", opts)
vim.api.nvim_set_keymap("t", "<C-o>", [[<C-\><C-n><C-o>]], opts)
-- vim.api.nvim_set_keymap("t", "JJ", [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap("t", "<C-q>", [[<C-\><C-n><cmd>bdelete!<CR>]], opts)

-- save file without auto-formatting
-- vim.keymap.set("n", "<leader>ns", "<cmd>noautocmd w <CR>", opts)
vim.keymap.set("n", "<leader>ns", ":mksession!Session.vim<CR>:wqa<CR>", opts)
-- vim.keymap.set("n", "<leader>nS", ":source Session.vim<CR>", opts)

vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts2) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Resize windows with arrow keys
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "Increase window width" })

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew ", opts) -- open new tab
-- vim.keymap.set("n", "tx", ":tabclose ", opts)       -- close current tab
vim.keymap.set("n", "<leader>j", "<cmd>e #<CR>", { noremap = true, desc = "switch buffer" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- remapping u and U
-- vim.keymap.set("n", "U", ":undo<CR>", { noremap = true })
-- vim.keymap.set("n", "u", "", { noremap = true })

-- vim.keymap.set("n", "<CR>", "o<ESC>", { noremap = true })
vim.keymap.set("n", "<C-h>", "O<ESC>", { noremap = true })

-- Snippets
vim.keymap.set("i", "{K", "{<CR>}<Esc>O", { noremap = true })
-- vim.keymap.set("i", "(E", "()<Esc>i", { noremap = true })
