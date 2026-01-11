return {
  "kevinhwang91/nvim-ufo",
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = "kevinhwang91/promise-async",
  config = function()
    local ufo = require("ufo")
    vim.o.foldenable = true
    vim.o.foldcolumn = "0" -- Show fold column
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    -- vim.o.foldmethod = "expr"
    -- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    --
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })
    --
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)
    -- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    -- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
    vim.keymap.set("n", "<leader>z", "za")
    vim.keymap.set("n", "zk", function() -- Peek folded lines under cursor (like VS Code hover)
      local winid = ufo.peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek fold" })
  end,
}
