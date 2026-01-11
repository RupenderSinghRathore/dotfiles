return {
  "kristijanhusak/vim-dadbod-ui",
  lazy = true,
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
      lazy = true,
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 1

    vim.keymap.set("n", "<leader>ui", "<cmd>DBUIToggle<CR>", { desc = "Toggle DBUI" })
  end,

  config = function()
    -- This is the correct place for autocommands when using Lazy.nvim
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbout",
      group = vim.api.nvim_create_augroup("dadbod_ui_custom", { clear = true }),
      callback = function()
        vim.wo.foldenable = false -- no more +-- 5 lines nonsense
        vim.wo.wrap = true
        -- vim.wo.linebreak = true
        vim.bo.buflisted = false
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        vim.keymap.set("n", "<leader>k", function()
          -- Get the word under the cursor (table name)
          print "hello"
          local table_name = vim.fn.expand("<cword>")

          -- Run the Dadbod command.
          -- Note: This assumes you are connected to a DB via Dadbod UI
          -- For Postgres use '\d', for MySQL use 'DESCRIBE'
          vim.cmd("DB \\d " .. table_name)
        end, { buffer = true, desc = "Dadbod: Describe table/view" })
      end,
    })
  end,
}
