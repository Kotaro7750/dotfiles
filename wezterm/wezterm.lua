local wezterm = require('wezterm')
local default_prog = { "zsh" }
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = { "wsl.exe", "--distribution", "Ubuntu-20.04" }
end
return {
  default_prog = default_prog,

  initial_cols = 160,
  initial_rows = 50,

  audible_bell = "Disabled",

  font = wezterm.font("Cica"),
  font_size = 14,

  color_scheme = "iceberg",
  window_background_opacity = 0.8,
  text_background_opacity = 1.0,

  disable_default_key_bindings = true,
  key_map_preference = "Mapped",
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    { key = "[", mods = "LEADER", action = "ActivateCopyMode" },

    { key = "C", mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "c", mods = "SUPER", action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } },
    { key = "v", mods = "SUPER", action = wezterm.action { PasteFrom = "Clipboard" } },

    { key = "\\", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  }
}
