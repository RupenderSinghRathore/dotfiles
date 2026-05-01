local M = {}

M.open_project = function()
  local dirs = {
    vim.fn.expand("~/dotfiles"),
    vim.fn.expand("~/lunaar"),
  }
  local find_cmd = {
    "fd",
    ".", -- match everything
    table.concat(dirs, " "),
    "--type d",
    "--max-depth 2",
    "--hidden",
    "--no-ignore",
    "--absolute-path",
    "--exclude .git",
    "--exclude themes",
    "--exclude .venv",
    "--exclude node_modules",
    "--exclude env",
    "--exclude venv",
    "--exclude .gradle",
    "--exclude META-INF",
    "--exclude target",
    "--exclude .cache",
    "--exclude utils",
  }

  local cmd = table.concat(find_cmd, " ")

  local results = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    print("Error running find")
    return
  end

  -- remove $HOME prefix
  for i, path in ipairs(results) do
    results[i] = path:gsub("^" .. vim.fn.expand("~") .. "/", "")
  end
  vim.ui.select(results, { prompt = "Select Project:" }, function(choice)
    if not choice or choice == "" then
      return
    end

    local full_path = vim.fn.expand(choice)

    vim.cmd("tabnew")
    vim.cmd("tcd " .. vim.fn.fnameescape(full_path))

    -- vim.cmd("Telescope find_files")
  end)
end

M.open_file = function()
  local dir = {
    vim.fn.expand("~/dotfiles"),
    -- vim.fn.expand("~/lunaar"), -- add if needed
  }
  local find_cmd = {
    "fd",
    ".",
    table.concat(dir, " "),
    "--type f",
    "--hidden",
    "--no-ignore",
    "--absolute-path",
    "--exclude .git",
    "--exclude tmux-resurrect",
    "--exclude .repos",
    "--exclude '*.png'",
    "--exclude '*.pdf'",
    "--exclude '*.epub'",
    "--exclude '*.zip'",
    "--exclude '*.svg'",
  }

  local cmd = table.concat(find_cmd, " ")
  -- local results = vim.fn.systemlist(cmd)
  --
  -- if vim.v.shell_error ~= 0 then
  --   print("Error running find")
  --   return
  -- end
  local results = vim.fn.systemlist(cmd .. " 2>&1")

  if vim.v.shell_error ~= 0 then
    print("fd failed:")
    print(table.concat(results, "\n"))
    return
  end

  vim.ui.select(results, { prompt = "Select file:" }, function(choice)
    if not choice then
      return
    end

    local full_path = vim.fn.expand(choice)

    print(full_path)
    vim.cmd("e " .. full_path)
  end)
end

M.change_dir = function()
  local dirs = {
    vim.fn.expand("~/dotfiles"),
    vim.fn.expand("~/lunaar"),
    vim.fn.expand("~/Documents"),
    vim.fn.expand("~/Downloads"),
    vim.fn.expand("~/lunaar/languages/go"),
    vim.fn.expand("~/Notes"),
  }

  local find_cmd = {
    "fd",
    ".",
    table.concat(dirs, " "),
    "--type d",
    "--max-depth 2",
    "--hidden",
    "--no-ignore",
    "--absolute-path",
    "--exclude .git",
    "--exclude .cache",
    "--exclude .obsidian",
  }
  local cmd = table.concat(find_cmd, " ")
  local results = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 then
    print("Error running find")
    return
  end

  -- remove duplicates (like awk '!seen[$0]++')
  local seen = {}
  local unique = {}
  for _, path in ipairs(results) do
    if not seen[path] then
      table.insert(unique, path)
      seen[path] = true
    end
  end

  vim.ui.select(unique, { prompt = "Select directory:" }, function(choice)
    if not choice then
      return
    end

    vim.cmd("tcd " .. vim.fn.fnameescape(choice))
  end)
end

return M
