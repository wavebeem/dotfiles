hs.window.animationDuration = 0

-- hs.alert.defaultStyle.fillColor = {white = 0.1, alpha = 1}
-- hs.alert.defaultStyle.strokeColor = {white = 0.1, alpha = 0}
-- hs.alert.defaultStyle.strokeWidth = 0
-- hs.alert.defaultStyle.textSize = 24
-- hs.alert.defaultStyle.radius = 8
-- hs.alert.defaultStyle.fadeInDuration = 0
-- hs.alert.defaultStyle.fadeOutDuration = 0

hs.grid.setGrid({w = 6, h = 1})
hs.grid.setMargins({w = 0, h = 0})

prefix = {"ctrl", "alt"}

-- layoutMax = {
--   -- App, Title, Display, Unit, Frame, Full Frame
--   {nil, nil, hs.layout.maximized, nil, nil}
-- }

hs.hotkey.bind(prefix, "m", function()
  for _, window in ipairs(hs.window:orderedWindows()) do
    window:moveToUnit({ x = 0, y = 0, w = 1, h = 1 })
  end
end)

hs.hotkey.bind(prefix, "t", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H.%M.%S"))
end)

hs.hotkey.bind(prefix, "d", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end)

hs.hotkey.bind(prefix, "r", function()
  hs.reload()
end)

hs.hotkey.bind(prefix, "c", function()
  hs.toggleConsole()
end)

hs.alert.show("hammerspoon", 0.5)
