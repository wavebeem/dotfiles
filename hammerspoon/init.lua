prefix = {"ctrl", "alt"}

-- Namespaces
cmd = {}

function cmd.reload()
  hs.reload()
end

hs.hotkey.bind(prefix, "r", cmd.reload)

function main()
    -- Configuration
  hs.window.animationDuration = 0

  hs.alert.defaultStyle.strokeWidth = 4
  hs.alert.defaultStyle.strokeColor = { hex = "ffffff" }
  hs.alert.defaultStyle.fillColor = { hex = "222222" }
  hs.alert.defaultStyle.textColor = { hex = "ffffff" }
  -- hs.alert.defaultStyle.textFont = ".AppleSystemUIFont"
  hs.alert.defaultStyle.textSize = 24
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
  hs.hotkey.bind(prefix, "i", cmd.snapWindowCenterBig)
  hs.hotkey.bind(prefix, "l", cmd.snapWindowRightHalf)
  hs.hotkey.bind(prefix, "o", cmd.snapWindowRightBig)
  hs.hotkey.bind(prefix, ".", cmd.snapWindowRightSmall)
  hs.hotkey.bind(prefix, ",", cmd.snapWindowCenterSmall)

  hs.hotkey.bind(prefix, "d", cmd.typeDate)
  hs.hotkey.bind(prefix, "t", cmd.typeTime)
  hs.hotkey.bind(prefix, "x", cmd.typeUnixTime)

  hs.hotkey.bind(prefix, "space", cmd.maximizeAllWindows)
  hs.hotkey.bind(prefix, "v", cmd.showApplicationName)
  hs.hotkey.bind(prefix, "r", cmd.reload)
  hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

  hs.alert.show("Hammerspoon loaded", 0.5)
end

personalApps = {
  "Firefox Developer Edition",
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

do
  local pad1 = 2/12
  local pad2 = 4/12
  local size1 = 4/12
  local size2 = 8/12
  local rect = hs.geometry.rect

  function cmd.snapWindowCenterBig()
    hs.window.focusedWindow():moveToUnit(rect(pad1, 0, size2, 1))
  end

  function cmd.snapWindowCenterSmall()
    hs.window.focusedWindow():moveToUnit(rect(size1, 0, size1, 1))
  end

  function cmd.snapWindowLeftBig()
    hs.window.focusedWindow():moveToUnit(rect(0, 0, size2, 1))
  end

  function cmd.snapWindowLeftSmall()
    hs.window.focusedWindow():moveToUnit(rect(0, 0, size1, 1))
  end

  function cmd.snapWindowLeftHalf()
    hs.window.focusedWindow():moveToUnit(rect(0, 0, 1/2, 1))
  end

  function cmd.snapWindowRightHalf()
    hs.window.focusedWindow():moveToUnit(rect(1/2, 0, 1/2, 1))
  end

  function cmd.snapWindowRightBig()
    hs.window.focusedWindow():moveToUnit(rect(1 - size2, 0, size2, 1))
  end

  function cmd.snapWindowRightSmall()
    hs.window.focusedWindow():moveToUnit(rect(1 - size1, 0, size1, 1))
  end

  function cmd.maximizeWindow()
    hs.window.focusedWindow():moveToUnit(rect(0, 0, 1, 1))
  end
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

main()
