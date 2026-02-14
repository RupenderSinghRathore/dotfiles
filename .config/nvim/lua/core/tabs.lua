-- Force the tabline to always show
-- vim.opt.showtabline = 2

-- Define the function that returns purely the filename
function _G.MinimalTabLine()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    -- Select the highlighting (Active vs Inactive)
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end

    -- Get the buffer number of the active window in this tab
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)

    -- Get ONLY the tail (filename)
    local filename = vim.fn.fnamemodify(bufname, ":t")

    -- Handle empty buffers (new files)
    if filename == "" then
      filename = "No Name"
    end

    if string.len(filename) > 20 then
      filename = string.sub(filename, 1, 18) .. ".."
    end
    -- Add the filename to the string with 1 space of padding
    s = s .. " " .. filename .. " "
  end

  -- Clear the rest of the line
  s = s .. "%#TabLineFill#%T"
  return s
end

-- Apply the function
vim.opt.tabline = "%!v:lua.MinimalTabLine()"
