local wezterm = require('wezterm')

-- Some configuration should be overrided from non-tracked file
local override_config = {}

local override_config_path = wezterm.home_dir .. "/dotfiles/wezterm/override_config.lua"
local override_config_file = io.open(override_config_path, "r")
if override_config_file then
  override_config_file:close()
  override_config = dofile(override_config_path)
end

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

local git_cache = {}

local function cwd_from_uri(cwd_uri)
  if not cwd_uri then
    return nil
  end

  if type(cwd_uri) == "string" then
    local parsed = wezterm.url.parse(cwd_uri)
    if parsed and parsed.file_path then
      return parsed.file_path
    end
    if parsed and parsed.path then
      return parsed.path
    end
    return cwd_uri
  end

  if cwd_uri.file_path then
    return cwd_uri.file_path
  end
  if cwd_uri.path then
    return cwd_uri.path
  end

  return nil
end

local function trim(s)
  return (s or ""):gsub("%s+$", "")
end

local function get_git_branch(cwd)
  if not cwd then
    return nil
  end

  local now = os.time()
  local cached = git_cache[cwd]
  if cached and (now - cached.time) < 3 then
    return cached.branch
  end

  local ok, stdout = wezterm.run_child_process({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" })
  if not ok then
    git_cache[cwd] = { branch = nil, time = now }
    return nil
  end

  local branch = trim(stdout)
  if branch == "HEAD" then
    local ok_detached, sha = wezterm.run_child_process({ "git", "-C", cwd, "rev-parse", "--short", "HEAD" })
    if ok_detached then
      branch = "@" .. trim(sha)
    end
  end

  git_cache[cwd] = { branch = branch, time = now }
  return branch
end

wezterm.on("update-right-status", function(window, pane)
  local cwd = cwd_from_uri(pane:get_current_working_dir())
  local branch = get_git_branch(cwd)

  local right_status = " " .. cwd .. " "

  if branch and #branch > 0 then
    right_status = right_status .. "" .. branch
  else
    right_status = right_status .. "not a git repo"
  end

  window:set_right_status(right_status)
end)

local color_palette = {
  background = from_color_scheme("background"),
  ansi = {
    black = from_color_scheme("Black"),
    green = from_color_scheme("Green"),
    grey = from_color_scheme("Grey"),
  }
}

local function on_format_tab_title(tab, tabs, panes, config, hover, max_width)
  local background = color_palette.ansi.grey
  local foreground = color_palette.ansi.black

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

wezterm.on('format-tab-title', on_format_tab_title)

return {
  default_prog = default_prog,

  initial_cols = 160,
  initial_rows = 50,

  audible_bell = "Disabled",

  font = wezterm.font("Moralerspace Neon HW"),
  font_size = override_config.font_size or 18,

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
    split = color_palette.background,
    tab_bar = {
      inactive_tab_edge = color_palette.background,
    }
  },

  inactive_pane_hsb = {
    saturation = 1,
    brightness = 0.75,
  },

  launch_menu = launch_menu,

  disable_default_key_bindings = true,
  key_map_preference = "Mapped",
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    { key = "[", mods = "LEADER",       action = "ActivateCopyMode" },
    { key = "n", mods = "LEADER",       action = "ShowLauncher" },
    { key = "R", mods = "LEADER",       action = wezterm.action.ReloadConfiguration },

    -- Font size
    { key = "+", mods = "LEADER|SHIFT", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "LEADER",       action = wezterm.action.DecreaseFontSize },
    { key = "0", mods = "LEADER",       action = wezterm.action.ResetFontSize },

    -- Content management
    -- -- Tab
    { key = "t", mods = "LEADER",       action = wezterm.action { ActivateTabRelative = 1 } },
    { key = "T", mods = "LEADER|SHIFT", action = wezterm.action { ActivateTabRelative = -1 } },

    { key = "X", mods = "LEADER",       action = wezterm.action { CloseCurrentTab = { confirm = true } } },

    -- -- Pane
    { key = "z", mods = "LEADER",       action = wezterm.action.TogglePaneZoomState },

    { key = "h", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER",       action = wezterm.action.ActivatePaneDirection("Right") },

    { key = "x", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },

    { key = "H", mods = "LEADER",       action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "J", mods = "LEADER",       action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { key = "K", mods = "LEADER",       action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    { key = "L", mods = "LEADER",       action = wezterm.action.AdjustPaneSize { "Right", 5 } },

    -- Clipboard
    { key = "C", mods = "CTRL|SHIFT",   action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "c", mods = "SUPER",        action = wezterm.action { CopyTo = "Clipboard" } },
    { key = "V", mods = "CTRL|SHIFT",   action = wezterm.action { PasteFrom = "Clipboard" } },
    { key = "v", mods = "SUPER",        action = wezterm.action { PasteFrom = "Clipboard" } },


    -- Custom
    {
      key = "a",
      mods = "LEADER",
      action = wezterm.action_callback(
        function(_, pane)
          pane:split { direction = "Left", size = 0.4, args = { "zsh", "-ic", "${CLI_CODING_AGENT:-codex}" } }
          pane:split { direction = "Top", size = 0.7, args = { "zsh", "-ic", "nvim" } }

          pane:activate()
        end
      ),
    },

  }
}
