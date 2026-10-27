function main()
  bind("r", hs.reload)

    -- Configuration
  hs.window.animationDuration = 0
  hs.alert.defaultStyle.strokeWidth = 4
  hs.alert.defaultStyle.strokeColor = { hex = "ffffff" }
  hs.alert.defaultStyle.fillColor = { hex = "111111" }
  hs.alert.defaultStyle.textColor = { hex = "ffffff" }
  hs.alert.defaultStyle.textSize = 24
  hs.alert.defaultStyle.radius = 8
  hs.alert.defaultStyle.atScreenEdge = 0
  hs.alert.defaultStyle.fadeInDuration = 0
  hs.alert.defaultStyle.fadeOutDuration = 0
  hs.alert.defaultStyle.padding = 16

  bind("y", unhideAll)
  bind("h", hidePersonalApps)
  bind("m", snapWindowLeftSmall)
  bind("u", snapWindowLeftBig)
  bind("j", snapWindowLeftHalf)
  bind("k", maximizeWindow)
  bind("i", snapWindowCenterBig)
  bind("l", snapWindowRightHalf)
  bind("o", snapWindowRightBig)
  bind(".", snapWindowRightSmall)
  bind(",", snapWindowCenterSmall)

  bind("d", typeDate)
  bind("t", typeTime)
  bind("x", typeUnixTime)

  bind("space", maximizeAllWindows)
  bind("v", showApplicationName)
  bind("c", toggleConsole)

  hs.alert.show("Hammerspoon loaded", 0.5)
end


function bind(key, fn)
  hs.hotkey.bind(prefix, key, fn)
end

prefix = {"ctrl", "alt"}

personalApps = {
  "Firefox Developer Edition",
  "Vivaldi",
  "Discord",
  "LINE",
  "Signal",
  "WhatsApp",
  "Music",
  "Doppler",
  "OBSBOT Center",
}

function hidePersonalApps()
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
function unhideAll()
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

  local function move(x, y, w, h)
    hs.window.focusedWindow():moveToUnit(hs.geometry.rect(x, y, w, h))
  end

  function snapWindowCenterBig()
    move(pad1, 0, size2, 1)
  end

  function snapWindowCenterSmall()
    move(size1, 0, size1, 1)
  end

  function snapWindowLeftBig()
    move(0, 0, size2, 1)
  end

  function snapWindowLeftSmall()
    move(0, 0, size1, 1)
  end

  function snapWindowLeftHalf()
    move(0, 0, 1/2, 1)
  end

  function snapWindowRightHalf()
    move(1/2, 0, 1/2, 1)
  end

  function snapWindowRightBig()
    move(1 - size2, 0, size2, 1)
  end

  function snapWindowRightSmall()
    move(1 - size1, 0, size1, 1)
  end

  function maximizeWindow()
    move(0, 0, 1, 1)
  end
end

function maximizeAllWindows()
  local screen = hs.screen.primaryScreen()
  for _, window in ipairs(hs.window:orderedWindows()) do
    window:moveToScreen(screen)
    window:moveToUnit(hs.layout.maximized)
  end
end

function showApplicationName()
  hs.alert.show(hs.window.focusedWindow():application():name())
end

function toggleConsole()
  hs.toggleConsole()
end

function typeDate()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end

function typeTime()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H:%M"))
end

function typeUnixTime()
  hs.eventtap.keyStrokes(tostring(os.time()))
end

main()
