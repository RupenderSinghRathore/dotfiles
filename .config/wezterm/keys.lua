local wezterm = require("wezterm")
local utils = require("utils")
local M = {}

function M.apply(config)
	-- Your keybindings logic here
	config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000 }

	config.keys = {
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
		-- {
		-- 	key = "E",
		-- 	mods = "LEADER",
		-- 	action = wezterm.action.SplitHorizontal({
		-- 		-- Replace with your actual script path
		-- 		args = { "" },
		-- 	}),
		-- },

		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action_callback(utils.open_file_in_nvim),
		},
	}

	-- Add the loop for tab numbers
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
end

return M
