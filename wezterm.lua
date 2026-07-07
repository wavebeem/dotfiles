local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_background_opacity = 1.0
config.quit_when_all_windows_are_closed = false

config.window_decorations = "RESIZE"

config.initial_cols = 90
config.initial_rows = 48

config.font = wezterm.font("Iosevka Term", {
  weight = "Regular",
  stretch = "Expanded",
})
config.font_rules = {
  -- Keep dim text at the same weight instead of swapping to a lighter face.
  {
    intensity = "Half",
    font = config.font,
  },
  {
    intensity = "Bold",
    font = wezterm.font("Iosevka Term", {
      weight = "Bold",
      stretch = "Expanded",
    }),
  },
}
config.font_size = 17.0
config.line_height = 1.2

config.color_scheme = "GruvboxDark"

config.command_palette_font_size = 24.0

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = false

-- Pin exact Gruvbox hex values instead of trusting the bundled scheme's
-- fidelity (WezTerm's "GruvboxDark" scheme is sourced from a community
-- repo, not the original gruvbox palette, and can drift from it).
config.colors = {
  background = "#282828",
  foreground = "#ebdbb2",
  cursor_bg = "#ebdbb2",
  cursor_border = "#ebdbb2",
  cursor_fg = "#282828",
  selection_bg = "#665c54",
  selection_fg = "#ebdbb2",
  ansi = {
    "#282828",
    "#cc241d",
    "#98971a",
    "#d79921",
    "#458588",
    "#b16286",
    "#689d6a",
    "#a89984",
  },
  brights = {
    "#928374",
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",
  },
  tab_bar = {
    background = "#3c3836",
    active_tab = {
      bg_color = "#282828",
      fg_color = "#ebdbb2",
    },
    inactive_tab = {
      bg_color = "#3c3836",
      fg_color = "#928374",
    },
    inactive_tab_hover = {
      bg_color = "#3c3836",
      fg_color = "#b8bb26",
    },
    new_tab = {
      bg_color = "#3c3836",
      fg_color = "#ebdbb2",
    },
    new_tab_hover = {
      bg_color = "#3c3836",
      fg_color = "#b8bb26",
    },
  },
}

config.window_padding = {
  left = 16,
  right = 16,
  top = 12,
  bottom = 12,
}

config.window_frame = {
  font = wezterm.font({
    family = "Roboto",
    weight = "Medium",
  }),
  font_size = 16.0,
  active_titlebar_bg = "#3c3836",
  inactive_titlebar_bg = "#3c3836",
}

wezterm.on("update-right-status", function(window)
  window:set_left_status("")
  window:set_right_status("")
end)

-- The fancy tab bar ignores tab_max_width, so we truncate the title here
-- ourselves. This handler also supplies a fallback so tabs never go blank
-- when a program sets an empty OSC title.
local tab_max_width = 40

wezterm.on("format-tab-title", function(tab)
  local title = tab.tab_title
  if title == nil or title == "" then
    title = tab.active_pane.title
  end
  if title == nil or title == "" then
    -- last resort: basename of the running program, e.g. "zsh", "nvim"
    local proc = tab.active_pane.foreground_process_name or ""
    title = proc:gsub("(.*[/\\])(.*)", "%2")
    if title == "" then
      title = "shell"
    end
  end
  if wezterm.column_width(title) > tab_max_width then
    title = wezterm.truncate_right(title, tab_max_width - 1) .. "…"
  end
  return title
end)

return config
