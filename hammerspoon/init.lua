do
  local ui = hs.window.switcher.ui
  ui.showThumbnails = false
  ui.showSelectedThumbnail = false
  ui.textSize = 12
end
hs.window.animationDuration = 0

prefix = {"alt", "ctrl"}

hs.hotkey.bind(prefix, "W", function()
  hs.alert.show("Hello World!")
end)

hs.hotkey.bind(prefix, "U", function()
  hs.window.focusedWindow():moveToUnit({
    x = 0,
    y = 0,
    w = 0.5,
    h = 1,
  })
end)

hs.hotkey.bind(prefix, "O", function()
  hs.window.focusedWindow():moveToUnit({
    x = 0.5,
    y = 0,
    w = 0.5,
    h = 1,
  })
end)

hs.hotkey.bind(prefix, "M", function()
  hs.window.focusedWindow():moveToUnit({
    x = 0,
    y = 0,
    w = 1,
    h = 1,
  })
end)

function focusWindowStep(step)
  local windows = hs.window.orderedWindows()
  local current = hs.window.focusedWindow()
  local newIndex = nil
  for index, window in pairs(windows) do
    if window === current then
      newIndex = index
    end
  end
  if newIndex 
end

hs.hotkey.bind(prefix, "I", "N", function()
  hs.window.focusedWindow():focusWindowNorth()
end)

hs.hotkey.bind(prefix, "K", "S", function()
  hs.window.focusedWindow():focusWindowSouth()
end)

hs.hotkey.bind(prefix, "L", "E", function()
  hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind(prefix, "J", "W", function()
  hs.window.focusedWindow():focusWindowWest()
end)
