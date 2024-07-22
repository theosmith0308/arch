-- Pull in the wezterm API
local wezterm = require("wezterm")
-- Action
local act = wezterm.action
-- This will hold the configuration.
local config = {}
-- local config = wezterm.config_builder()
-- Default shell
config.default_prog = { "/usr/bin/bash" }

-- This is where you actually apply your config choices

-- Window decorations
config.window_decorations = "TITLE|RESIZE"

-- Cursor
config.default_cursor_style = "SteadyBlock" -- Acceptable values are SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.
config.hide_mouse_cursor_when_typing = true
-- config.cursor_blink_rate = 600
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
-- config.cursor_blink_ease_in = "Linear"
-- config.cursor_blink_ease_out = "Linear"

-- Font settngs
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 12
config.enable_tab_bar = false

-- Colorscheme
-- config.color_scheme = "tokyonight_night"
-- config.window_background_opacity = 1.0

-- Coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- Window size
config.initial_cols = 100
config.initial_rows = 24

-- Scrollbar
config.enable_scroll_bar = true
config.min_scroll_bar_height = "1cell"

--Tabs
config.keys = {}
for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = act.ActivateTab(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
