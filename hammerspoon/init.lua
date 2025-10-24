-- Namespaces
cmd = {}
layout = {}

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

function layout.left50(name)
  return layout.new(name, hs.layout.left50)
end

function layout.right50(name)
  return layout.new(name, hs.layout.right50)
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

hs.hotkey.bind(prefix, "j", cmd.snapWindowLeft)
hs.hotkey.bind(prefix, "k", cmd.maximizeWindow)
hs.hotkey.bind(prefix, "l", cmd.snapWindowRight)

hs.hotkey.bind(prefix, "d", cmd.typeDate)
hs.hotkey.bind(prefix, "t", cmd.typeTime)
hs.hotkey.bind(prefix, "x", cmd.typeUnixTime)

hs.hotkey.bind(prefix, "space", cmd.maximizeAllWindows)
hs.hotkey.bind(prefix, "v", cmd.showApplicationName)
hs.hotkey.bind(prefix, "r", cmd.reload)
hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

hs.alert.show("Hammerspoon loaded", 0.5)
