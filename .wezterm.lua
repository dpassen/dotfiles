local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Modus Vivendi"
	else
		return "Modus Operandi"
	end
end

return {
	font = wezterm.font("PragmataPro"),
	line_height = 0.95,
	freetype_load_flags = "NO_HINTING",
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = "0.5cell",
		right = "0.5cell",
		top = 1,
		bottom = "0.5cell",
	},
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}
