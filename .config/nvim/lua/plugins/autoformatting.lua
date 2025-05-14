return {
  {
    "mhartington/formatter.nvim",
    lazy = false, -- disable lazy-loading so the plugin is immediately available
    config = function()
      local ok, formatter = pcall(require, "formatter")
      if not ok then
        vim.notify("formatter.nvim not loaded; please run :Lazy sync", vim.log.levels.ERROR)
        return
      end

      formatter.setup({
        logging = false,
        filetype = {
          lua = {
            function()
              return {
                exe = "stylua",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" },
                stdin = true,
              }
            end,
          },
          go = {
            function()
              return {
                exe = "gofmt",
                args = { "--" },
                stdin = true,
              }
            end,
          },
          python = {
            function()
              return {
                exe = "black",
                args = { "-" },
                stdin = true,
              }
            end,
          },
          c = {
            function()
              return {
                exe = "clang-format",
                -- args = { "--style=Google" },
                args = { "--style=file" },
                stdin = true,
              }
            end,
          },
          cpp = {
            function()
              return {
                exe = "clang-format",
                args = { "--style=file" },
                stdin = true,
              }
            end,
          },
          javascript = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          html = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          json = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
          css = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
                stdin = true,
              }
            end,
          },
        },
      })

      -- Auto-format on save using the provided Vim command.
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function()
          vim.cmd("FormatWrite")
        end,
      })
    end,
  },
}
