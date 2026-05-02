local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.window_background_opacity = 1.0

config.quit_when_all_windows_are_closed = false

config.initial_cols = 90
config.initial_rows = 48

-- config.default_cursor_style = "SteadyBar"
-- config.cursor_thickness = 2

-- or, changing the font size and color scheme.
config.font = wezterm.font("Lilex", { weight = "Medium" })
config.font_size = 16
-- config.line_height = 1.2
config.color_scheme = 'Catppuccin Latte'

-- Copy the configuration below and add it to your
-- ~/.wezterm.lua or ~/.config/wezterm/wezterm.lua file

-- NOTE: make sure to *not* use any config.color_scheme option
--       if you want to define your own root loops color scheme

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.window_padding = {
  left = 8,
  right = 8,
  top = 16,
  bottom = 16,
}

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 20.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#8da600',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#8da600',
}

-- Root Loops color scheme
-- via https://rootloops.sh?sugar=6&colors=10&sogginess=2&flavor=0&fruit=3&milk=3
config.colors = {
  foreground = "#070603",
  background = "#f5f3ef",
  cursor_bg = "#585140",
  cursor_border = "#262219",
  cursor_fg = "#f5f3ef",
  selection_bg = "#070603",
  selection_fg = "#f5f3ef",
  ansi = {
    "#585140",
    "#ed007e",
    "#798f00",
    "#c16b00",
    "#008dcf",
    "#9f4dff",
    "#009986",
    "#e6e2d8",
  },
  brights = {
    "#262219",
    "#ff4593",
    "#8da600",
    "#de7c00",
    "#00a3ee",
    "#ad75ff",
    "#00b19c",
    "#ffffff",
  },
    tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#8da600',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#f5f3ef',
      -- The color of the text for the tab
      fg_color = '#262219',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Bold',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#8da600',
      fg_color = '#ffffff',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#8da600',
      fg_color = '#ffffff',
      -- italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#8da600',
      fg_color = '#ffffff',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#8da600',
      fg_color = '#ffffff',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },

}

return config
