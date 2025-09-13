vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.makeprg = "go run %"
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        -- vim.opt_local.makeprg = "gcc % -o run && ./run"
        vim.opt_local.makeprg = "gcc % -o run"
        vim.keymap.set("n", "<F1>", ":!./run<CR>", { buffer = true })
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
