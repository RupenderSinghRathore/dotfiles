return {
  "3rd/image.nvim",
  build = false, -- Disable build to prevent compilation errors

  opts = {
    -- CRITICAL: Use the CLI wrapper.
    -- This uses your system 'magick' binary instead of the Lua rock.
    processor = "magick_cli",

    backend = "kitty",

    integrations = {
      markdown = {
        enabled = true,
        download_remote_images = true,
        only_render_image_at_cursor = true,
      },
      ["leetcode.nvim"] = {
        enabled = true,
        download_remote_images = true,
        only_render_image_at_cursor = true,
      },
    },

    -- max_width = nil,
    -- max_height = nil,
    -- max_width_window_percentage = nil,
    -- max_height_window_percentage = 50,
    -- window_overlap_clear_enabled = false,
    -- editor_only_render_when_focused = false,
    -- tmux_show_only_in_active_window = true,
    -- hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
  },
}
