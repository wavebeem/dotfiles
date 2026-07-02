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
}
config.font_size = 17.0
config.line_height = 1.213

config.color_scheme = "GruvboxDark"

config.command_palette_font_size = 24.0
config.command_palette_bg_color = "#141617"
config.command_palette_fg_color = "#ebdbb2"

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 12

-- Two-tone: strip + inactive tabs sit darker than the active tab / content.
config.colors = {
  tab_bar = {
    background = "#1d2021",
    active_tab = {
      bg_color = "#282828",
      fg_color = "#ebdbb2",
    },
    inactive_tab = {
      bg_color = "#1d2021",
      fg_color = "#928374",
    },
    inactive_tab_hover = {
      bg_color = "#1d2021",
      fg_color = "#b8bb26",
    },
  },
}

config.window_padding = {
  left = 8,
  right = 8,
  top = 16,
  bottom = 16,
}

config.window_frame = {
  font = wezterm.font({
    family = "Roboto",
    weight = "Medium",
  }),
  font_size = 16.0,
  active_titlebar_bg = "#1d2021",
  inactive_titlebar_bg = "#1d2021",
}

return config
