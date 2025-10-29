vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.makeprg = "go run %"
    vim.keymap.set("n", "<leader>r", "<cmd>!go run %<CR>", { buffer = true })
    -- vim.keymap.set("i", "<C-e>", "if err != nil {<CR>}<Esc>Oreturn err<Esc>")
    vim.keymap.set("i", "<C-e>", "if err != nil {<CR>}<Esc>O")
    -- vim.keymap.set("i", "<C-p>", 'fmt.Printf("\\n")<Esc>hhhi', { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.makeprg = "firefox %"
    vim.keymap.set("n", "<leader>r", "<cmd>!firefox %<CR>", { buffer = true })

    vim.keymap.set("i", "<F2>", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "htmldjango",
  callback = function()
    vim.keymap.set("i", "<C-p>", "{{% block  %}}{{% endblock %}}<Esc>Fk;la")
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
    vim.keymap.set("n", "<leader>r", "<cmd>!node %<CR>", { buffer = true })

    vim.keymap.set("i", "<C-p>", "console.log(``)<C-o>h<C-o>i", { buffer = true })
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
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<leader>r", "<cmd>!python %<CR>", { buffer = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    -- vim.opt_local.makeprg = "rustc % -o run && ./run"
    -- vim.opt_local.makeprg = "cargo run"
    -- vim.keymap.set("n", "<leader>r", "<cmd>!cargo run<CR>", { buffer = true })
    -- vim.keymap.set("n", "<leader>r", "<cmd>sp | term bash -c 'cargo run; echo;'<CR>i", { buffer = true })
    -- vim.keymap.set("n", "<leader>r", "<cmd>term bash -c 'cargo run; echo;'<CR>i", { buffer = true })
    vim.keymap.set("n", "<leader>r", "<cmd>!cargo run<CR>", { buffer = true })
    vim.keymap.set("n", "<F2>", "<cmd>term<CR>icargo run<CR>", { buffer = true })

    vim.keymap.set("n", "<F1>", ":!rustc % -o run && ./run<CR>", { buffer = true })
    -- vim.keymap.set("n", "<F2>", ":!cargo run<CR>", { buffer = true })
    vim.keymap.set("n", "<F3>", ":!cargo check<CR>", { buffer = true })
  end,
})
