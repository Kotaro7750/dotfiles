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

-- The filled in variant of the < symbol
-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

local color_palette = {
  background = from_color_scheme("background"),
  ansi = {
    black = from_color_scheme("Black"),
    green = from_color_scheme("Green"),
    grey = from_color_scheme("Grey"),
  }
}

local function on_format_tab_title(tab, tabs, panes, config, hover, max_width)
  local  background = color_palette.ansi.grey
  local  foreground = color_palette.ansi.black

  if tab.is_active then
    background = color_palette.ansi.green
    foreground = color_palette.ansi.black
  elseif hover then
    background = color_palette.ansi.grey
    foreground = color_palette.ansi.green
  end

  local edge_background = color_palette.background
  local edge_foreground = background

  local title = tab_title(tab)

  local LEFT_TRIANGLE = wezterm.nerdfonts.ple_lower_right_triangle
  local RIGHT_TRIANGLE = wezterm.nerdfonts.ple_upper_left_triangle

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = LEFT_TRIANGLE },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = RIGHT_TRIANGLE },
  }
end

wezterm.on('format-tab-title',on_format_tab_title)


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
  local battery_percentage = 100;
  local has_battery = false
  local charging = false

  for _, b in ipairs(wezterm.battery_info()) do
    has_battery = true
    battery_percentage = math.ceil(b.state_of_charge * 100);

    if b.state == "Charging" then
      charging = true
    end
  end

  local color = "Lime";
  if battery_percentage < 20 then
    color = "Red";
  elseif battery_percentage < 50 then
    color = "Yellow";
  end

  local power_status = ""

  if has_battery then
    -- Specify nerdfont icon like md_battery_50
    local battery_percentage_roundup = math.ceil(battery_percentage / 10) * 10
    local battery_emoji = wezterm.nerdfonts["md_battery" .. (battery_percentage_roundup == 100 and "" or "_" .. battery_percentage_roundup)]
    local battery_status = ""

    if charging then
      battery_status = wezterm.nerdfonts["md_lightning_bolt"]
    end

    power_status = battery_status .. battery_emoji .. battery_percentage .. "%"
  else
    power_status = wezterm.nerdfonts["md_power_plug_outline"]
  end

  return {
    { Foreground = { AnsiColor = color } },
    { Background = { Color = color_palette.background } },
    { Text = power_status .. " " },
  }
end

wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("%a %F  %H:%M:%S ");

  local format = {}
  flatten_array({ construct_battery_info_format(), { Foreground = { Color = color_palette.ansi.grey } },{ Background = { Color = color_palette.background } }, { Text = " " .. date }, }, format);

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

  show_new_tab_button_in_tab_bar = false,

  window_frame = {
    font = wezterm.font("Cica"),
    font_size = 14,
    inactive_titlebar_bg = color_palette.background,
    active_titlebar_bg = color_palette.background
  },

  colors = {
    tab_bar = {
      inactive_tab_edge = color_palette.background,
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
