-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness
local opts = { noremap = true, silent = false }

-- Esc
-- vim.keymap.set("i", "nn", "<Esc>", opts)
-- vim.keymap.set("i", "NN", "<Esc>", opts)

-- save file
vim.keymap.set("n", "<leader>ss", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>sq", "<cmd>wq<CR>", opts)
vim.keymap.set("n", "<leader>sQ", "<cmd>q!<CR>", opts)

-- to Explorer
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", opts)

-- open the terminal
vim.keymap.set("n", "<leader>pr", "<cmd>term<CR>", opts)

-- Move current line up/down in Normal mode
vim.keymap.set("n", "<", "<cmd>m -2<CR>", opts) -- move line up
vim.keymap.set("n", ">", "<cmd>m +1<CR>", opts) -- move line down

-- Close the terminal
vim.api.nvim_set_keymap("t", "<C-o>", [[<C-\><C-n><C-o>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "jj", [[<C-\><C-n>]], { noremap = true, silent = true })
-- save file without auto-formatting
-- Delete the key sequence <Space>ns in normal mode
vim.keymap.set("n", "<leader>ns", "<cmd>noautocmd w <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-d>zz", opts)
vim.keymap.set({ "n", "v" }, "<C-y>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
-- vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
-- vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
-- vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
-- vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>=", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>nq", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew ", opts) -- open new tab
vim.keymap.set("n", "tx", ":tabclose ", opts) -- close current tab
vim.keymap.set("n", "tp", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "tu", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>nd", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Function to toggle the statusline
function _G.toggle_statusline()
  if vim.o.laststatus == 0 then -- just works even with the warning
    vim.opt.laststatus = 3
  else
    vim.opt.laststatus = 0
  end
end

--
-- Key mapping to toggle the statusline (e.g., <leader>ts)
vim.keymap.set("n", "<leader>ts", "<cmd>lua toggle_statusline()<cr>", opts)
-- Press `<leader><C-r>` to reload your entire Neovim config
vim.keymap.set("n", "<leader><C-r>", function()
  vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/init.lua") -- Always targets your config
  vim.notify("Neovim config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Neovim config" })

vim.api.nvim_set_keymap("n", "e", "", { noremap = true })
vim.api.nvim_set_keymap("v", "e", "", { noremap = true })
vim.api.nvim_set_keymap("o", "e", "", { noremap = true })

vim.keymap.set("n", "E", vim.lsp.buf.hover, { desc = "Show LSP hover information" })

-- Scrolling in place
vim.keymap.set({ "n", "v", "i" }, "<c-m>", "<c-e>", { desc = "scrolling up in place" })

vim.api.nvim_set_keymap("n", "<C-e>", "<C-p>", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-e>", "<C-p>", { noremap = true })
vim.api.nvim_set_keymap("o", "<C-e>", "<C-p>", { noremap = true })

vim.api.nvim_set_keymap("n", "k", "n", { noremap = true })
vim.api.nvim_set_keymap("n", "K", "N", { noremap = true })

vim.api.nvim_set_keymap("n", "n", "", { noremap = true })
vim.api.nvim_set_keymap("v", "n", "", { noremap = true })
vim.api.nvim_set_keymap("o", "n", "", { noremap = true })

-- remapping u and U
vim.api.nvim_set_keymap("n", "U", "u", { noremap = true })
vim.api.nvim_set_keymap("n", "u", "", { noremap = true })
