-- Namespaces
cmd = {}
layout = {}

personalApps = {
  "Firefox Developer Edition",
  "Discord",
  "LINE",
  "Music",
}

function cmd.hidePersonalApps()
  for _, appName in ipairs(personalApps) do
    local app = hs.application.get(appName)
    if app then
      app:hide()
    end
  end
end

function layout.new(name, size)
  -- App, Window, Screen, Unit, Frame, Full
  -- http://www.hammerspoon.org/docs/hs.layout.html#apply
  return { name, nil, nil, size, nil, nil }
end

function layout.left50(name)
  return layout.new(name, hs.layout.left50)
end

function layout.right50(name)
  return layout.new(name, hs.layout.right50)
end

function cmd.splitUpApps()
  hs.layout.apply {
    -- Left
    layout.left50 "Code",
    layout.left50 "iTerm2",
    layout.left50 "Terminal",
    layout.left50 "zoom.us",
    -- Right
    layout.right50 "Slack",
    layout.right50 "LINE",
    layout.right50 "Firefox",
    layout.right50 "Google Chrome",
    layout.right50 "Cypress",
    layout.right50 "Finder",
    layout.right50 "Hammerspoon",
    layout.right50 "Firefox Developer Edition",
    layout.right50 "Discord",
    layout.right50 "Spotify",
    layout.right50 "Music",
  }
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

function cmd.showApplicationName()
  hs.alert.show(hs.window.focusedWindow():application():name())
end

function cmd.reload()
  hs.reload()
end

function cmd.toggleConsole()
  hs.toggleConsole()
end


function hex(code, alpha)
  return {
    hex = "#" .. code,
    alpha = (alpha or 100) / 100
  }
end

-- Configuration
hs.window.animationDuration = 0

hs.alert.defaultStyle.strokeWidth = 8
hs.alert.defaultStyle.strokeColor = hex"1c1736"
hs.alert.defaultStyle.fillColor = hex"93f20d"
hs.alert.defaultStyle.textColor = hex"1c1736"
-- hs.alert.defaultStyle.textFont = ".AppleSystemUIFont"
hs.alert.defaultStyle.textSize = 32
hs.alert.defaultStyle.radius = 16
-- hs.alert.defaultStyle.atScreenEdge = 0
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0
hs.alert.defaultStyle.padding = 16

prefix = {"ctrl", "alt"}

hs.hotkey.bind(prefix, "y", cmd.unhideAll)
hs.hotkey.bind(prefix, "h", cmd.hidePersonalApps)
hs.hotkey.bind(prefix, "n", cmd.splitUpApps)

hs.hotkey.bind(prefix, "j", cmd.snapWindowLeft)
hs.hotkey.bind(prefix, "k", cmd.maximizeWindow)
hs.hotkey.bind(prefix, "l", cmd.snapWindowRight)

hs.hotkey.bind(prefix, "space", cmd.maximizeAllWindows)
hs.hotkey.bind(prefix, "v", cmd.showApplicationName)
hs.hotkey.bind(prefix, "r", cmd.reload)
hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

hs.alert.show("Hammerspoon loaded", 0.5)
