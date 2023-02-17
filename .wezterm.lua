local wezterm = require("wezterm")

local modus_operandi = {
	foreground = "black",
	background = "white",
	cursor_bg = "black",
	cursor_fg = "white",
	cursor_border = "black",
	selection_bg = "#bcbcbc",
	selection_fg = "black",
	ansi = {
		"#595959",
		"#a60000",
		"#005e00",
		"#813e00",
		"#0030a6",
		"#721045",
		"#00538b",
		"#a6a6a6",
	},
	brights = {
		"#595959",
		"#a60000",
		"#005e00",
		"#813e00",
		"#0030a6",
		"#721045",
		"#00538b",
		"#a6a6a6",
	},
}

local modus_vivendi = {
	foreground = "white",
	background = "black",
	cursor_bg = "white",
	cursor_fg = "black",
	cursor_border = "white",
	selection_bg = "#361586",
	selection_fg = "white",
	ansi = {
		"#595959",
		"#ff8059",
		"#44bc44",
		"#d0bc00",
		"#2fafff",
		"#feacd0",
		"#00d3d0",
		"#a6a6a6",
	},
	brights = {
		"#595959",
		"#ff8059",
		"#44bc44",
		"#d0bc00",
		"#2fafff",
		"#feacd0",
		"#00d3d0",
		"#a6a6a6",
	},
}

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
	color_schemes = {
		["Modus Operandi"] = modus_operandi,
		["Modus Vivendi"] = modus_vivendi,
	},
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}
