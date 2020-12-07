prefix = {"ctrl", "alt"}

hs.hotkey.bind(prefix, "t", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H.%M.%S"))
end)

hs.hotkey.bind(prefix, "d", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end)
