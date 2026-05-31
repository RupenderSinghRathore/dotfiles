local M = {}

-- store terminals per tab
M.terminals = {}

M.toggle_terminal = function()
  local tab = vim.api.nvim_get_current_tabpage()

  -- init table for this tab
  if not M.terminals[tab] then
    M.terminals[tab] = { buf = nil, win = nil }
  end

  local term = M.terminals[tab]

  -- invalidate buffer if needed
  if term.buf and not vim.api.nvim_buf_is_valid(term.buf) then
    term.buf = nil
  end

  -- if terminal window exists → close it
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    local buf = vim.api.nvim_win_get_buf(term.win)

    if buf == term.buf then
      if #vim.api.nvim_list_wins() > 1 then
        vim.api.nvim_win_close(term.win, true)
      else
        vim.cmd("enew")
      end
    end

    term.win = nil
    return
  end

  -- open split
  vim.cmd("botright 12split")
  term.win = vim.api.nvim_get_current_win()

  -- reuse or create terminal
  if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
    vim.api.nvim_win_set_buf(term.win, term.buf)
  else
    vim.cmd("terminal")
    term.buf = vim.api.nvim_get_current_buf()
  end

  vim.cmd("startinsert")
end

-- vim.api.nvim_create_autocmd("TabClosed", {
--   callback = function(args)
--     M.terminals[tonumber(args.match)] = nil
--   end,
-- })

return M
