return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPre", "BufNewFile" },
  lazy = false,

  dependencies = "kevinhwang91/promise-async",
  config = function()
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" 󰁂 %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end
    local ufo = require("ufo")
    vim.o.foldenable = true
    vim.o.foldcolumn = "0" -- Show fold column
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    -- vim.o.foldmethod = "expr"
    -- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

    -- vim.api.nvim_set_hl(0, "UfoPreviewNormal", { link = "NormalFloat" })
    -- vim.api.nvim_set_hl(0, "UfoPreviewBorder", { link = "FloatBorder" })
    --
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
      end,
      fold_virt_text_handler = handler,
      preview = {
        win_config = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
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
