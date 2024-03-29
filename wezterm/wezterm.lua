local wezterm = require('wezterm')

local default_prog = { "zsh" }
local launch_menu = { { label = "zsh", args = { "zsh", "-l" } } }
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = { "wsl.exe", "--distribution", "Ubuntu-20.04" }

  table.insert(launch_menu, {
    label = "PowerShell",
    args = { "pwsh.exe", "-NoLogo" },
  })

  -- 新しく開いたタブにアタッチできればさらによい
  table.insert(launch_menu, {
    label = "PowerShell Admin",
    args = { "pwsh.exe", "-Command", "Start-Process pwsh.exe -Verb RunAs" },
  })
end

local color_scheme = "iceberg-dark";
-- 現在のカラースキームのカラーパレットからbackgroundやAnsiColorの色を取得する
local function from_color_scheme(name)
  local color_palette = wezterm.get_builtin_color_schemes()[color_scheme];

  local ansi_map = {
    Black = { table = "ansi", index = 1 },
    Maroon = { table = "ansi", index = 2 },
    Green = { table = "ansi", index = 3 },
    Olive = { table = "ansi", index = 4 },
    Navy = { table = "ansi", index = 5 },
    Purple = { table = "ansi", index = 6 },
    Teal = { table = "ansi", index = 7 },
    Silver = { table = "ansi", index = 8 },
    Grey = { table = "brights", index = 1 },
    Red = { table = "brights", index = 2 },
    Lime = { table = "brights", index = 3 },
    Yellow = { table = "brights", index = 4 },
    Blue = { table = "brights", index = 5 },
    Fuchsia = { table = "brights", index = 6 },
    Aque = { table = "brights", index = 7 },
    White = { table = "brights", index = 8 },
  }

  -- backgroundやcursor_bgといった指定は直接取得できる
  if color_palette[name] ~= nil then
    return color_palette[name]
    -- GreenやRedといった指定はテーブル経由
  elseif ansi_map[name] ~= nil then
    local table_name = ansi_map[name]["table"];
    local index = ansi_map[name]["index"];

    return color_palette[table_name][index]
  else
    return "#000000"
  end
end

local function is_array(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

local function flatten_array(arr, result)
  for _, v in ipairs(arr) do
    if type(v) == "table" and is_array(v) then
      flatten_array(v, result)
    else
      table.insert(result, v);
    end
  end
end

local function construct_battery_info_format()

  local PLUG_EMOJI = utf8.char(0x1f50c);
  local BATTERY_EMOJI = utf8.char(0x1f50b);

  local battery_percentage = 100;
  local battery = PLUG_EMOJI;

  for _, b in ipairs(wezterm.battery_info()) do
    battery_percentage = math.ceil(b.state_of_charge * 100);

    local icon = BATTERY_EMOJI;
    if b.state == "Charging" then
      icon = PLUG_EMOJI;
    end

    battery = icon .. battery_percentage .. "%";
  end


  local color = "Lime";
  if battery_percentage < 20 then
    color = "Red";
  elseif battery_percentage < 50 then
    color = "Yellow";
  end

  return {
    { Foreground = { AnsiColor = color } },
    { Text = battery .. " " },
  }
end

wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%a %F  %H:%M ");

  local format = {};
  flatten_array({ construct_battery_info_format(), { Foreground = { AnsiColor = "Grey" } }, { Text = " " .. date }, }, format);

  window:set_right_status(wezterm.format(format));
end);

return {
  default_prog = default_prog,

  initial_cols = 160,
  initial_rows = 50,

  audible_bell = "Disabled",

  font = wezterm.font("Cica"),
  font_size = 14,

  color_scheme = color_scheme,
  window_background_opacity = 0.8,
  text_background_opacity = 1.0,

  window_frame = {
    inactive_titlebar_bg = from_color_scheme("background"),
    active_titlebar_bg = from_color_scheme("background"),
  },

  colors = {
    tab_bar = {
      background = from_color_scheme("background"),
      active_tab = { bg_color = from_color_scheme("Grey"), fg_color = from_color_scheme("foreground") },
      inactive_tab = { bg_color = from_color_scheme("background"), fg_color = from_color_scheme("Grey") },
      inactive_tab_hover = { bg_color = from_color_scheme("background"), fg_color = from_color_scheme("foreground") },
      inactive_tab_edge = from_color_scheme("background"),
      new_tab = { bg_color = from_color_scheme("background"), fg_color = from_color_scheme("Grey") },
      new_tab_hover = { bg_color = from_color_scheme("background"), fg_color = from_color_scheme("foreground") },
    }
  },

  launch_menu = launch_menu,

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

    { key = "l", mods = "LEADER", action = "ShowLauncher" },
    { key = "w", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
    { key = "t", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
    { key = "T", mods = "LEADER|SHIFT", action = wezterm.action { ActivateTabRelative = -1 } },
  }
}
