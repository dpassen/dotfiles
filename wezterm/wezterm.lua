local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Alabaster-Dark"
config.default_cursor_style = "BlinkingBar"
config.font_size = 12
config.freetype_load_flags = "NO_HINTING"
config.harfbuzz_features = {
	"calt=0",
	"dlig=0",
	"liga=0",
}
config.font = wezterm.font({
	family = "Berkeley Mono Variable",
	style = "Normal",
	weight = 375,
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "Berkeley Mono Variable",
			style = "Normal",
			weight = 600,
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "Berkeley Mono Variable",
			style = "Oblique",
			weight = 375,
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "Berkeley Mono Variable",
			style = "Oblique",
			weight = 600,
		}),
	},
}
config.keys = {
	{
		key = "p",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal,
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical,
	},
	{
		key = "UpArrow",
		mods = "CMD|ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "LeftArrow",
		mods = "CMD|ALT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|ALT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
}
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

return config
