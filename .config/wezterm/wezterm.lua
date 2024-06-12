local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Modus Vivendi"
	else
		return "Modus Operandi"
	end
end

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.check_for_updates = false
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font = wezterm.font_with_fallback({
	"PragmataPro",
	"Symbols Nerd Font Mono",
})
config.line_height = 0.95
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
	left = "1.5cell",
	right = "0.5cell",
	top = 1,
	bottom = "0.5cell",
}

return config
