local wezterm = require("wezterm")

local config = wezterm.config_builder()
local custom_bg = "rgba(26, 27, 38, 0.85)"

config = {
	-- term = "wezterm",
	-- term = "xterm-256color",
	term = "xterm-kitty",

	enable_kitty_graphics = true,
	max_fps = 120,

	-- Removes the macos bar at the top with the 3 buttons
	window_decorations = "RESIZE",

	-- https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
	-- font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" }),
	-- font = wezterm.font("JetBrainsMono Nerd Font"),
	font = wezterm.font("SauceCodePro Nerd Font Mono"),

	font_size = 14,

	window_close_confirmation = "NeverPrompt",
	-- --
	default_cursor_style = "SteadyBlock",
	-- default_cursor_style = "BlinkingBlock",

	cursor_blink_ease_out = "Constant",
	cursor_blink_ease_in = "Constant",
	-- Setting this to 0 disables blinking
	-- cursor_blink_rate = 0,

	window_padding = {
		left = 2,
		right = 2,
		top = 15,
		bottom = 0,
	},
	colors = {
		tab_bar = {
			background = custom_bg,

			active_tab = {
				bg_color = custom_bg,
				fg_color = "#eb2862",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},

			inactive_tab = {
				bg_color = custom_bg,
				fg_color = "#808080",
			},
			inactive_tab_hover = {
				bg_color = custom_bg,
				fg_color = "#909090",
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab_hover`.
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = custom_bg,
				fg_color = "#808080",

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = custom_bg,
				fg_color = "#909090",
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	},
	unix_domains = {
		{
			name = "unix",
		},
	},
	default_domain = "unix",

	leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000 },

	keys = {
		-- 2. Define bindings that use the 'LEADER' modifier

		-- <Leader> + % (Split Horizontal)
		-- Set Leader to Ctrl + Space
		{
			key = "%",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- <Leader> + " (Split Vertical)
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- <Leader> + z (Toggle Zoom/Fullscreen for pane)
		{
			key = "z",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		-- <Leader> + n (Spawn new tab)
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = "$",
			mods = "LEADER|SHIFT",
			action = wezterm.action.PromptInputLine({
				description = "Enter new workspace name:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivateLastTab,
		},
		{
			key = "Backspace",
			mods = "CTRL",
			-- Sends Ctrl+W (standard "Word Erase" in bash/zsh/vim)
			action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
		},
		{
			key = "E",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({
				-- Replace with your actual script path
				args = { "" },
			}),
		},
	},
}

config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.85
config.use_fancy_tab_bar = false
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action.ActivateTab(i - 1),
	})
end
local act = wezterm.action

local function open_file_in_nvim(window, pane)
	-- 1. Get the current directory of the active pane
	-- WezTerm runs scripts from HOME by default, so we must tell it where to look.
	local cwd_uri = pane:get_current_working_dir()
	local cwd = cwd_uri and cwd_uri.file_path or "."

	-- 2. Define the command
	local find_cmd = {
		"find",
		cwd,
		"-type",
		"d",
		"(",
		"-name",
		".git",
		"-o",
		"-name",
		"node_modules",
		"-o",
		"-name",
		".venv",
		"-o",
		"-name",
		"target",
		")",
		"-prune",
		"-o",
		"-type",
		"f",
		"(",
		"!",
		"-name",
		"*.png",
		"!",
		"-name",
		"*.pdf",
		")",
		"-print",
	}

	-- 3. Run command SYNCHRONOUSLY (No callback function)
	local success, stdout, stderr = wezterm.run_child_process(find_cmd)

	-- 4. debug: If "nothing happens", press Ctrl+Shift+L to see this log
	if not success then
		wezterm.log_error("Find command failed: " .. stderr)
		-- We don't return here because 'find' often returns false
		-- if it hits a single 'permission denied' folder, even if it found files.
	end

	-- 5. Process Output
	local choices = {}
	for line in stdout:gmatch("([^\n]*)\n?") do
		if line ~= "" then
			-- Make path relative for display (remove the cwd prefix)
			-- We escape magic characters in cwd to avoid lua regex errors
			local label = line:gsub(cwd .. "/", ""):gsub("^%./", "")
			table.insert(choices, { label = label })
		end
	end

	-- 6. Show the Selector
	window:perform_action(
		wezterm.action.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
				if label then
					-- Open nvim in a new tab with the selected file
					inner_window:perform_action(
						wezterm.action.SpawnCommandInNewTab({
							args = { "nvim", label },
							-- Important: Ensure the new tab starts in the same directory
							cwd = cwd,
						}),
						inner_pane
					)
				end
			end),
			title = "Select File to Edit",
			choices = choices,
			fuzzy = true,
		}),
		pane
	)
end

-- BINDING: Use table.insert to avoid overwriting your existing keys
table.insert(config.keys, {
	key = "j",
	mods = "LEADER",
	action = wezterm.action_callback(open_file_in_nvim),
})

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane

	-- Get the process name (e.g., "zsh", "nvim")
	local process_name = pane.foreground_process_name
	-- Clean up the path to just get the executable name
	-- (e.g., /usr/bin/zsh -> zsh)
	if process_name then
		process_name = process_name:match("([^/]+)$")
	end

	-- Fallback: If process name is unavailable, use the current title
	local title = process_name or tab.active_pane.title

	-- Optional: Add the tab index number (1:, 2:, etc.)
	local index = tab.tab_index + 1
	return string.format(" %d. %s ", index, title)
end)

-- return the configuration to wezterm
return config
