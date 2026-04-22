local M = {}

M.term_buf = nil
M.term_win = nil

M.toggle_terminal = function()
  local current_buf = vim.api.nvim_get_current_buf()

  -- if we're currently in terminal → go back
  if M.term_buf and current_buf == M.term_buf then
    if M.prev_buf and vim.api.nvim_buf_is_valid(M.prev_buf) then
      vim.cmd("buffer " .. M.prev_buf)
    else
      vim.cmd("enew")
    end
    return
  end

  -- otherwise → open terminal full screen
  M.prev_buf = current_buf

  if M.term_buf and vim.api.nvim_buf_is_valid(M.term_buf) then
    vim.cmd("buffer " .. M.term_buf)
  else
    vim.cmd("terminal")
    M.term_buf = vim.api.nvim_get_current_buf()
  end

  vim.cmd("startinsert")
end

return M
