local wezterm = require("wezterm")
local keys = require("keys")

local config = wezterm.config_builder()
local custom_bg = "rgba(26, 27, 38, 0.85)"

-- --- CORE SETTINGS ---
config.term = "xterm-kitty"
config.enable_kitty_graphics = true
config.max_fps = 120
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
-- config.default_domain = "unix"

-- --- APPEARANCE ---
config.font = wezterm.font("SauceCodePro Nerd Font Mono")
config.font_size = 14
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.85
config.use_fancy_tab_bar = false

config.default_cursor_style = "SteadyBlock"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"

config.window_padding = {
	left = 2,
	right = 2,
	top = 15,
	bottom = 0,
}

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

config.unix_domains = {
	{ name = "unix" },
}

-- --- APPLY MODULES ---
keys.apply(config)

return config
