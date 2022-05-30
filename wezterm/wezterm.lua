local wezterm = require('wezterm')
return {
	default_prog = {"wsl.exe", "--distribution", "Ubuntu-20.04"},
	color_scheme = "iceberg",
	font = wezterm.font("Cica"),
	font_size = 14,
	initial_cols = 160,
	initial_rows = 48,
	window_background_opacity = 0.8,
	text_background_opacity = 1.0,
}
