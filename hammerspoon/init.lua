-- Namespaces
cmd = {}
layout = {}
g = {}

personalApps = {
  "Vivaldi",
  "Discord",
  "LINE",
  "Music",
  "Doppler",
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

g.big = 5 / 8
g.small = 1 - g.big
g.left_big_rect = hs.geometry.rect(0, 0, g.big, 1)
g.left_small_rect = hs.geometry.rect(0, 0, g.small, 1)
g.right_small_rect = hs.geometry.rect(1 - g.small, 0, g.small, 1)
g.right_big_rect = hs.geometry.rect(1 - g.big, 0, g.big, 1)

function cmd.snapWindowLeftBig()
  hs.window.focusedWindow():moveToUnit(g.left_big_rect)
end

function cmd.snapWindowLeftSmall()
  hs.window.focusedWindow():moveToUnit(g.left_small_rect)
end

function cmd.snapWindowLeftHalf()
  hs.window.focusedWindow():moveToUnit(hs.layout.left50)
end

function cmd.snapWindowRightHalf()
  hs.window.focusedWindow():moveToUnit(hs.layout.right50)
end

function cmd.snapWindowRightBig()
  hs.window.focusedWindow():moveToUnit(g.right_big_rect)
end

function cmd.snapWindowRightSmall()
  hs.window.focusedWindow():moveToUnit(g.right_small_rect)
end

function cmd.maximizeWindow()
  hs.window.focusedWindow():moveToUnit(hs.layout.maximized)
end

function cmd.maximizeAllWindows()
  local screen = hs.screen.primaryScreen()
  for _, window in ipairs(hs.window:orderedWindows()) do
    window:moveToScreen(screen)
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

function cmd.typeDate()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end

function cmd.typeTime()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H:%M"))
end

function cmd.typeUnixTime()
  hs.eventtap.keyStrokes(tostring(os.time()))
end

function hex(code, alpha)
  alpha = alpha or 100
  return {
    hex = "#" .. code,
    alpha = alpha / 100
  }
end

-- Configuration
hs.window.animationDuration = 0

hs.alert.defaultStyle.strokeWidth = 8
hs.alert.defaultStyle.strokeColor = hex"222222"
hs.alert.defaultStyle.fillColor = hex"eeeeee"
hs.alert.defaultStyle.textColor = hex"222222"
-- hs.alert.defaultStyle.textFont = ".AppleSystemUIFont"
hs.alert.defaultStyle.textSize = 32
hs.alert.defaultStyle.radius = 8
-- hs.alert.defaultStyle.atScreenEdge = 0
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0
hs.alert.defaultStyle.padding = 16

prefix = {"ctrl", "alt"}

hs.hotkey.bind(prefix, "y", cmd.unhideAll)
hs.hotkey.bind(prefix, "h", cmd.hidePersonalApps)

hs.hotkey.bind(prefix, "m", cmd.snapWindowLeftSmall)
hs.hotkey.bind(prefix, "u", cmd.snapWindowLeftBig)
hs.hotkey.bind(prefix, "j", cmd.snapWindowLeftHalf)
hs.hotkey.bind(prefix, "k", cmd.maximizeWindow)
hs.hotkey.bind(prefix, "l", cmd.snapWindowRightHalf)
hs.hotkey.bind(prefix, "o", cmd.snapWindowRightBig)
hs.hotkey.bind(prefix, ".", cmd.snapWindowRightSmall)

hs.hotkey.bind(prefix, "d", cmd.typeDate)
hs.hotkey.bind(prefix, "t", cmd.typeTime)
hs.hotkey.bind(prefix, "x", cmd.typeUnixTime)

hs.hotkey.bind(prefix, "space", cmd.maximizeAllWindows)
hs.hotkey.bind(prefix, "v", cmd.showApplicationName)
hs.hotkey.bind(prefix, "r", cmd.reload)
hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

hs.alert.show("Hammerspoon loaded", 0.5)
