local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- General settings
	adjust_window_size_when_changing_font_size = false,
	front_end = "WebGpu",
	animation_fps = 60,

	-- Font configuration with JetBrains Mono Nerd Font and ligatures
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "Regular", stretch = "Normal", style = "Normal" },
	}),
	font_size = 14.0,
	harfbuzz_features = { "calt", "liga", "dlig" },

	-- Window and menubar settings
	window_decorations = "TITLE|RESIZE", -- Enables macOS titlebar with menubar (File, Edit, etc.)
	window_close_confirmation = "AlwaysPrompt",
	window_background_opacity = 0.95,
	macos_window_background_blur = 20,

	-- Padding for a clean look
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	-- Tab bar configuration
	enable_tab_bar = true,
	tab_bar_at_bottom = false,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = true,

	-- Color scheme (Nord-inspired for Omarchy aesthetic)
	color_scheme = "Catppuccin Mocha",

	-- Key bindings
	keys = {
		{ key = "q", mods = "CTRL", action = act.ToggleFullScreen },
		{ key = "'", mods = "CTRL", action = act.ClearScrollback("ScrollbackAndViewport") },
		{ key = "s", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) }, -- Close tab
		{ key = "h", mods = "CMD", action = act.Hide }, -- Hide window
		{ key = "m", mods = "CMD", action = act.ToggleFullScreen }, -- Maximize/restore (overriding Ctrl+Q)
	},

	-- Mouse bindings
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
	},
}
