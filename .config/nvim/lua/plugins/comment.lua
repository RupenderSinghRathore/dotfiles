-- Easily comment visual regions/lines
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("Comment").setup({
      pre_hook = function()
        local ft = vim.bo.filetype

        if ft == "kitty" or ft == "conf" or ft == "tmux" or ft == 'desktop' then
          return "# %s"
        end
      end,
    })
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current, opts)
    -- vim.keymap.set("n", "<C-c>", require("Comment.api").toggle.linewise.current, opts)
    vim.keymap.set("n", "<C-/>", require("Comment.api").toggle.linewise.current, opts)
    vim.keymap.set("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    -- vim.keymap.set("v", "<C-c>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    vim.keymap.set("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
    local ft = require("Comment.ft")
    ft.templ = { "// %s" }
  end,
}
