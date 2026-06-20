if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  -- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
  vim.o.guifont = "FiraCode Nerd Font Mono:h14"

  -- toggle opacity
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

  -- enable mouse setup
  vim.o.mouse = "a"
  vim.g.neovide_has_mouse_grid_detection = true

  -- cursor and scroll animation
  vim.g.neovide_cursor_animation_length = 0.100
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_scroll_animation_far_lines = 1

  -- ctrl+shift+v -> paste
  vim.keymap.set("i", "<C-S-v>", "<C-r>+", { desc = "Paste from system clipboard" })
  vim.keymap.set("t", "<C-S-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { desc = "Paste from system clipboard in terminal" })
end
