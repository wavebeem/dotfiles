cmd = {}

personalApps = {
  "Firefox Developer Edition",
  "Spotify",
  "Discord",
  "LINE",
}

function cmd.hidePersonalApps()
  for _, appName in ipairs(personalApps) do
    local app = hs.application.get(appName)
    if app then
      app:hide()
    end
  end
end

-- App, Window, Screen, Unit, Frame, Full
-- http://www.hammerspoon.org/docs/hs.layout.html#apply
layout = {
  {"Code", nil, nil, hs.layout.left50, nil, nil},
  {"iTerm2", nil, nil, hs.layout.left50, nil, nil},
  {"Slack", nil, nil, hs.layout.right50, nil, nil},
  {"LINE", nil, nil, hs.layout.right50, nil, nil},
  {"Firefox", nil, nil, hs.layout.right50, nil, nil},
  {"Firefox Developer Edition", nil, nil, hs.layout.right50, nil, nil},
  {"Discord", nil, nil, hs.layout.right50, nil, nil},
  {"Spotify", nil, nil, hs.layout.right50, nil, nil},
}

function cmd.splitUpApps()
  hs.layout.apply(layout)
end

-- If this were a true "unhide all windows" it would uniminimize windows too.
-- But that's slow, and I only ever use Hide Application rather than Minimize
-- Window, so this can be a lot faster knowing that.
function cmd.unhideAll()
  local allApps = {}
  for _, window in ipairs(hs.window.invisibleWindows()) do
    local app = window:application()
    local id = app:bundleID()
    if not allApps[id] then
      allApps[id] = app
      if app:isHidden() then
        app:unhide()
      end
    end
  end
end

function cmd.snapWindowLeft()
  hs.window.focusedWindow():moveToUnit(hs.layout.left50)
end

function cmd.snapWindowRight()
  hs.window.focusedWindow():moveToUnit(hs.layout.right50)
end

function cmd.maximizeWindow()
  hs.window.focusedWindow():moveToUnit(hs.layout.maximized)
end

function cmd.maximizeAllWindows()
  for _, window in ipairs(hs.window:orderedWindows()) do
    window:moveToUnit(hs.layout.maximized)
  end
end

function cmd.keyboardDateTime()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H.%M.%S"))
end

function cmd.keyboardDate()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end

function cmd.showApplicationName()
  hs.alert.show(hs.window:focusedWindow():application():name())
end

function cmd.reload()
  hs.reload()
end

function cmd.toggleConsole()
  hs.toggleConsole()
end

hs.window.animationDuration = 0

hs.alert.defaultStyle.fillColor = {white = 0.1, alpha = 1}
hs.alert.defaultStyle.strokeColor = {white = 0.1, alpha = 0}
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.radius = 4
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0

prefix = {"ctrl", "alt"}

hs.hotkey.bind(prefix, "space", cmd.maximizeWindow)
hs.hotkey.bind(prefix, "h", cmd.hidePersonalApps)
hs.hotkey.bind(prefix, "y", cmd.unhideAll)
hs.hotkey.bind(prefix, "j", cmd.snapWindowLeft)
hs.hotkey.bind(prefix, "l", cmd.snapWindowRight)
hs.hotkey.bind(prefix, "m", cmd.maximizeAllWindows)
hs.hotkey.bind(prefix, "n", cmd.splitUpApps)
hs.hotkey.bind(prefix, "t", cmd.keyboardDateTime)
hs.hotkey.bind(prefix, "d", cmd.keyboardDate)
hs.hotkey.bind(prefix, "v", cmd.showApplicationName)
hs.hotkey.bind(prefix, "r", cmd.reload)
hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

hs.alert.show("hammerspoon", 0.5)
