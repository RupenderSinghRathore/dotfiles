local wezterm = require("wezterm")
local custom_bg = "rgba(26, 27, 38, 0.85)"

local c = {}

function c.apply(config)
	config.color_scheme = "Tokyo Night"
	config.colors = {
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
			},
			new_tab = {
				bg_color = custom_bg,
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = custom_bg,
				fg_color = "#909090",
				italic = true,
			},
		},
	}
end

return c
