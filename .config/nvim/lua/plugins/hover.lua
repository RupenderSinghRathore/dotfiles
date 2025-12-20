return {
  "lewis6991/hover.nvim",
  ft = "html",
  config = function()
    require("hover").setup({
      init = function()
        require("hover.providers.lsp")
      end,
      preview_opts = {
        border = "rounded",
      },
      -- Whether the contents of a currently open hover window should be moved
      -- to a :h preview-window when pressing the hover keymap.
      preview_window = false,
      title = true,
      -- mouse_providers = {
      --   "LSP",
      -- },
      -- mouse_delay = 1000,
    })

    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    vim.keymap.set("n", "gK", function()
      require("hover").hover_select({})
    end, { desc = "hover.nvim (select)" })

    -- Mouse support
    -- vim.keymap.set("n", "<MouseMove>", require("hover").mouse, { desc = "hover.nvim (mouse)" })
    -- vim.o.mousemoveevent = true
  end,
}
