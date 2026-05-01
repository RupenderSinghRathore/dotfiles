vim.o.showtabline = 1
vim.o.scrollback = 100000

vim.o.tabline = "%!v:lua.MyTabLine()"


function _G.MyTabLine()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local buf = buflist[winnr]

    -- get tab-local cwd (fallback to global)
    local cwd = vim.fn.getcwd(-1, i)

    -- extract last folder name
    local name = vim.fn.fnamemodify(cwd, ":t")

    if vim.fn.strchars(name) > 7 then
      name = vim.fn.strcharpart(name, 0, 7) .. ".."
    end

    -- highlight active tab
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end

    s = s .. " " .. i .. "." .. name .. " "
  end

  s = s .. "%#TabLineFill#"
  return s
end
