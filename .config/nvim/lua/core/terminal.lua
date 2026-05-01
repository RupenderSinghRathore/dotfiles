local M = {}

M.term_buf = nil
M.term_win = nil

M.toggle_terminal = function()
  if M.term_buf and not vim.api.nvim_buf_is_valid(M.term_buf) then
    M.term_buf = nil
  end

  -- if terminal window exists → close it
  if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
    local buf = vim.api.nvim_win_get_buf(M.term_win)

    if buf == M.term_buf then
      if #vim.api.nvim_list_wins() > 1 then
        vim.api.nvim_win_close(M.term_win, true)
      else
        vim.cmd("enew")
      end
    end

    M.term_win = nil
    return
  end
  -- open bottom split
  vim.cmd("botright 12split")

  local win = vim.api.nvim_get_current_win()
  M.term_win = win

  -- if terminal buffer exists → reuse it
  if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
    vim.api.nvim_win_set_buf(win, M.term_buf)
  else
    vim.cmd("terminal")
    M.term_buf = vim.api.nvim_get_current_buf()
  end

  -- optional: terminal settings
  vim.cmd("startinsert")
end

return M
