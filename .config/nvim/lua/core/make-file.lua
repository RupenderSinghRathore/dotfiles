vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.makeprg = "go run %"
    -- vim.keymap.set("i", "<C-e>", "if err != nil {<CR>}<Esc>Oreturn err<Esc>")
    vim.keymap.set("i", "<C-e>", "if err != nil {<CR>}<Esc>O")
    vim.keymap.set("i", "<C-p>", 'fmt.Printf("\\n")<Esc>hhhi', { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    -- vim.opt_local.makeprg = "gcc % -o run && ./run"
    vim.opt_local.makeprg = "gcc % -o run"
    vim.keymap.set("n", "<F1>", ":!./run<CR>", { buffer = true })
    vim.keymap.set("i", "<C-p>", 'printf("\\n");<Esc>hhhhi', { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.makeprg = "firefox %"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local classname = vim.fn.expand("%:t:r")
    vim.opt_local.makeprg = "javac % && java " .. classname
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function()
    vim.opt_local.makeprg = ""
    vim.keymap.set("i", "<C-p>", 'console.log("")<C-o>h<C-o>i', { buffer = true })
    -- vim.keymap.set("n", "<F1>", 'iconsole.log("")<Esc>hi', { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.makeprg = "firefox %"
    -- vim.keymap.set("n", "<leader>r", "<cmd>RenderMarkdown toggle<CR>", { buffer = true })
  end,
})
