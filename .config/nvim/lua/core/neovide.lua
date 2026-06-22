if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  --------------------------------------------------------------------------------
  -- Font
  --------------------------------------------------------------------------------

  local default_font_size = 14
  local font_name = "FiraCode Nerd Font Mono"

  vim.g.neovide_font_features = {
    [font_name] = { "-liga", "-calt", "-dlig" },
  }
  local function set_font_size(size)
    vim.o.guifont = string.format("%s:h%d", font_name, size)
  end

  local function get_font_size()
    return tonumber(vim.o.guifont:match(":h(%d+)")) or default_font_size
  end

  vim.keymap.set({ "n", "i", "v", "t" }, "<C-=>", function()
    set_font_size(get_font_size() + 1)
  end, { desc = "Increase font size" })

  vim.keymap.set({ "n", "i", "v", "t" }, "<C-->", function()
    set_font_size(math.max(1, get_font_size() - 1))
  end, { desc = "Decrease font size" })

  vim.keymap.set({ "n", "i", "v", "t" }, "<C-0>", function()
    set_font_size(default_font_size)
  end, { desc = "Reset font size" })

  -- local default_font_size = 14
  -- local config_path = vim.fn.expand("~/.config/neovide/config.toml")
  --
  -- local function read_config()
  --   return vim.fn.readfile(config_path)
  -- end
  --
  -- local function get_current_size()
  --   for _, line in ipairs(read_config()) do
  --     local s = line:match("^size%s*=%s*([%d.]+)")
  --     if s then
  --       return tonumber(s)
  --     end
  --   end
  --   return default_font_size
  -- end
  --
  -- local function write_size(new_size)
  --   local lines = read_config()
  --   local found = false
  --   for i, line in ipairs(lines) do
  --     if line:match("^size%s*=") then
  --       lines[i] = string.format("size = %.1f", new_size)
  --       found = true
  --       break
  --     end
  --   end
  --   if found then
  --     vim.fn.writefile(lines, config_path)
  --   else
  --     vim.notify("Couldn't find 'size =' line in config.toml", vim.log.levels.WARN)
  --   end
  -- end
  --
  -- vim.keymap.set({ "n", "i", "v", "t" }, "<C-=>", function()
  --   write_size(get_current_size() + 1)
  -- end, { desc = "Increase font size" })
  --
  -- vim.keymap.set({ "n", "i", "v", "t" }, "<C-->", function()
  --   write_size(math.max(1, get_current_size() - 1))
  -- end, { desc = "Decrease font size" })
  --
  -- vim.keymap.set({ "n", "i", "v", "t" }, "<C-0>", function()
  --   write_size(default_font_size)
  -- end, { desc = "Reset font size" })

  --------------------------------------------------------------------------------
  -- toggle opacity
  --------------------------------------------------------------------------------
  local opaque = 1.0
  local transparent = 0.8
  vim.g.neovide_opacity = transparent
  vim.g.neovide_normal_opacity = transparent

  local function toggle_opacity()
    if vim.g.neovide_opacity == opaque then
      vim.g.neovide_opacity = transparent
      vim.g.neovide_normal_opacity = transparent
    else
      vim.g.neovide_opacity = opaque
      vim.g.neovide_normal_opacity = opaque
    end
  end
  vim.keymap.set("n", "<leader>tT", toggle_opacity, { desc = "Toggle Neovide opacity" })

  --------------------------------------------------------------------------------
  -- enable mouse setup
  --------------------------------------------------------------------------------
  vim.o.mouse = "a"
  vim.g.neovide_has_mouse_grid_detection = true

  --------------------------------------------------------------------------------
  -- cursor and scroll animation
  --------------------------------------------------------------------------------
  vim.g.neovide_cursor_animation_length = 0.100
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_scroll_animation_far_lines = 1

  --------------------------------------------------------------------------------
  -- ctrl+shift+v -> paste
  --------------------------------------------------------------------------------
  vim.keymap.set({ "i", "c" }, "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })
  vim.keymap.set("t", "<C-S-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { desc = "Paste from system clipboard in terminal" })
end
