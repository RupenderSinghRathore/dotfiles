vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.makeprg = "go run %"
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        vim.opt_local.makeprg = "gcc % -o run && ./run"
        vim.keymap.set("n", "<F1>", ":!./run<CR>", { buffer = true })
    end,
})
