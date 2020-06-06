cmd = {}

function cmd.hidePersonalApps()
  local appNames = {
    "Firefox Developer Edition",
    "Spotify",
    "Discord",
    "LINE",
  }
  for _, appName in ipairs(appNames) do
    local app = hs.application.get(appName)
    if app then
      app:hide()
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
hs.hotkey.bind(prefix, "j", cmd.snapWindowLeft)
hs.hotkey.bind(prefix, "l", cmd.snapWindowRight)
hs.hotkey.bind(prefix, "m", cmd.maximizeAllWindows)
hs.hotkey.bind(prefix, "t", cmd.keyboardDateTime)
hs.hotkey.bind(prefix, "d", cmd.keyboardDate)
hs.hotkey.bind(prefix, "r", cmd.reload)
hs.hotkey.bind(prefix, "c", cmd.toggleConsole)

hs.alert.show("hammerspoon", 0.5)
