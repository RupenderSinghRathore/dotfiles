local wezterm = require("wezterm")
local M = {}

-- can access this via require("utils").common_ignores in other files if needed.
M.common_ignores = {
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
	"-o",
	"-name",
	"dist",
	"-o",
	"-name",
	"build",
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
	"*.jpg",
	"!",
	"-name",
	"*.pdf",
	"!",
	"-name",
	"*.gif",
	")",
	"-print", -- Essential to actually output the files
}

-- 2. HELPER FUNCTION
-- Joins a path with your ignores to create a full command
local function build_find_cmd(path)
	local cmd = { "find", path }
	for _, arg in ipairs(M.common_ignores) do
		table.insert(cmd, arg)
	end
	return cmd
end

-- 3. MAIN FUNCTION
function M.open_file_in_nvim(window, pane)
	local cwd_uri = pane:get_current_working_dir()
	local cwd = cwd_uri and cwd_uri.file_path or "."

	-- Use the helper to build the command
	local find_cmd = build_find_cmd(cwd)

	local success, stdout, stderr = wezterm.run_child_process(find_cmd)

	if not success then
		wezterm.log_error("Find command failed: " .. stderr)
		return
	end

	local choices = {}
	for line in stdout:gmatch("([^\n]*)\n?") do
		if line ~= "" then
			-- Safer path cleaning:
			-- Instead of gsub (which breaks on characters like '-' or '.'),
			-- we check if the line starts with the CWD and strip it.
			local prefix = cwd
			if not prefix:match("/$") then
				prefix = prefix .. "/"
			end

			local label = line
			if line:sub(1, #prefix) == prefix then
				label = line:sub(#prefix + 1)
			end

			table.insert(choices, { label = label })
		end
	end

	window:perform_action(
		wezterm.action.InputSelector({
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
				if label then
					inner_window:perform_action(
						wezterm.action.SpawnCommandInNewTab({
							args = { "nvim", label },
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

return M
