local M = {}

M.open_project = function()
  local dirs = {
    vim.fn.expand("~/dotfiles"),
    vim.fn.expand("~/lunaar"),
  }
  local find_cmd = {
    "find",
    table.concat(dirs, " "),
    "-maxdepth 2 -type d",
    [[\( -name '.git' -o -name 'themes' -o -name '.venv' -o -name 'node_modules' -o -name 'env' -o -name 'venv' -o -name '.gradle' -o -name 'META-INF' -o -name 'target' -o -name '.cache' -o -name 'utils' \) -prune -o -type d -print]],
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
    "find",
    table.concat(dir, " "),
    "-type d",
    [[\( -name '.git' -o -name '.repos' \) -prune -o]],
    "-type f",
    [[! -name '*.png' ! -name '*.pdf' ! -name '*.epub' ! -name '*.zip' ! -name '*.svg' -print]],
  }

  local cmd = table.concat(find_cmd, " ")
  local results = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 then
    print("Error running find")
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
    "find",
    table.concat(dirs, " "),
    "-maxdepth 2 -type d",
    [[\( -name '.git' -o -name '.cache' -o -name '.obsidian' \) -prune -o -type d -print]],
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
