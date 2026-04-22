-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = false }
local opts2 = { noremap = true, silent = true }

-- Compile
vim.keymap.set("n", "<leader>cc", "<cmd>Recompile<CR>", { silent = true, desc = "compile" })
vim.keymap.set("n", "<leader>cC", "<cmd>Compile<CR>", { silent = true, desc = "compile" })

vim.keymap.set("n", "<leader><leader>", ":!", { silent = true, desc = "command" })
vim.keymap.set("n", "<leader>H", ":help ", { silent = true, desc = "help" })

vim.keymap.set("n", "<leader>R", "<cmd>restart<CR>", { silent = true, desc = "restart" })

vim.keymap.set("n", "<leader>cp", "<cmd>pwd<CR>", { silent = true, desc = "pwd" })
vim.keymap.set({ "n", "i" }, "<C-g>", "<cmd>pwd<CR>", { silent = true, desc = "pwd" })

-- Sessionizer
-- vim.keymap.set("n", "<leader>fp", function()
--   require("core.sessionizer").open_project()
-- end, { desc = "Open project" })
--
-- vim.keymap.set("n", "<leader>fn", function()
--   require("core.sessionizer").open_file()
-- end, { desc = "Open file" })
--
-- vim.keymap.set("n", "<leader>fc", function()
--   require("core.sessionizer").change_dir()
-- end, { desc = "Change dir" })

-- save file
vim.keymap.set("n", "<leader>sa", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>sq", "<cmd>wq<CR>", opts)
vim.keymap.set("n", "<leader>qq", "<cmd>qall<CR>", opts)
vim.keymap.set("n", "<leader>nq", "<C-w>c", opts)

-- vim.keymap.set("n", "<leader>te", ":e %:h/", opts)

vim.keymap.set("n", "<Esc>", "<cmd>echo ''<CR>", opts)

-- terminal
vim.keymap.set("n", "<leader>tt", function()
  require("core.terminal").toggle_terminal()
end, { desc = "Toggle terminal" })

-- lsp keymaps
vim.keymap.set("n", "<leader>hr", ":lsp restart", opts)
vim.keymap.set("n", "<leader>hi", "<cmd>checkhealth lsp<CR>", opts)
vim.keymap.set("n", "<leader>hD", ":lsp disable", opts)
vim.keymap.set("n", "<leader>hE", ":lsp enable", opts)
vim.keymap.set("n", "<leader>hs", ":lsp stop", opts)

vim.keymap.set({ "n", "v" }, "x", '"_x', opts)
vim.keymap.set({ "n", "v" }, "c", '"_c', opts)
vim.keymap.set({ "n", "v" }, "s", '"_s', opts)

-- vim.keymap.set("n", "<leader>ng", "<cmd>term<CR>ilazygit && exit<CR>", opts)
vim.keymap.set("n", "<leader>Y", "<cmd>!kitty -e yazi<CR>", opts)
vim.api.nvim_set_keymap("t", "<C-o>", [[<C-\><C-n><C-o>]], opts)
-- vim.api.nvim_set_keymap("t", "JJ", [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
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
-- for i = 1, 9 do
--   vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>" .. i, i .. "gt", { desc = "goto tab " .. i })
-- end
-- vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>c", "<cmd>tabnew<CR>", opts)
-- vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>x", "<cmd>tabclose<CR>", opts)
-- vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>n", "<cmd>tabn<CR>", opts)
-- vim.keymap.set({ "n", "i", "v", "t" }, "<C-Space>p", "<cmd>tabp<CR>", opts)

for i = 1, 9 do
  vim.keymap.set({ "n", "v", "t" }, "<leader>" .. i, i .. "gt", { desc = "goto tab " .. i })
end

-- Buffers
vim.keymap.set("n", "<leader>jk", "<cmd>e #<CR>", { noremap = true, desc = "switch buffer" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap! linebreak! nolist! <CR>", opts)
-- vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- vim.keymap.set("n", "<CR>", "o<ESC>", { noremap = true })
-- vim.keymap.set("n", "<C-h>", "O<ESC>", { noremap = true })

-- Snippets
vim.keymap.set("i", "{K", "{<CR>}<Esc>O", { noremap = true })
-- vim.keymap.set("i", "(E", "()<Esc>i", { noremap = true })
