hs.window.animationDuration = 0

hs.alert.defaultStyle.fillColor = {white = 0.2, alpha = 1}
hs.alert.defaultStyle.strokeColor = {white = 0.2, alpha = 0}
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.radius = 8
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0

hs.grid.setGrid({w = 6, h = 1})
hs.grid.setMargins({w = 0, h = 0})

prefix1 = {"ctrl", "alt"}
prefix2 = {"ctrl", "cmd"}

function printTable(t)
  for key, value in pairs(t) do
    print(key, value)
  end
end

function alert(text)
  hs.alert.closeAll()
  hs.alert.show(text, 0.5)
end

function focusNextSameGeometry()
  local windows = sortedWindows()
  local current = hs.window.focusedWindow()
  local curGeom = hs.grid.get(current)
  local windowsSameGeometry = hs.fnutils.ifilter(windows, function(window)
    return curGeom:equals(hs.grid.get(window))
  end)
  focusNextOf(windowsSameGeometry)
  showCurrentTitle(windowsSameGeometry)
end

function focusNext()
  local windows = sortedWindows()
  focusNextOf(windows)
  showCurrentTitle(windows)
end

function sortedBy(tbl, fn)
  tbl = hs.fnutils.copy(tbl)
  table.sort(tbl, fn)
  return tbl
end

function focusNextOf(windows)
  local current = hs.window.focusedWindow()
  local index = hs.fnutils.indexOf(windows, current) or 0
  local n = #windows
  for i = index - 1, n + index do
    local j = (i % n) + 1
    local window = windows[j]
    if window ~= current then
      window:focus()
      break
    end
  end
end

function sortedWindows()
  return sortedBy(hs.window.orderedWindows(), function(a, b)
    return getTitle(a) < getTitle(b)
  end)
end

function getTitle(window)
  local title = window:title()
  if title == "" then
    return window:application():title()
  end
  return title
end

function showCurrentTitle(windows)
  local fwin = hs.window.focusedWindow()
  local lines = hs.fnutils.imap(windows, function(window)
    if window == fwin then
      return "⚪️ " .. getTitle(window)
    else
      return "⚫️ " .. getTitle(window)
    end
  end)
  local str = table.concat(lines, "\n")
  alert(str)
end

function round(x)
  if x % 1 >= 0.5 then
    return math.ceil(x)
  else
    return math.floor(x)
  end
end

function updateVolume(delta)
  local volume = getVolume() + delta
  volume = round(volume / delta) * delta
  volume = clamp(0, 100, volume)
  hs.audiodevice.defaultOutputDevice():setOutputVolume(volume)
  alert(("%3d"):format(volume))
end

function clamp(min, max, x)
  return math.min(max, math.max(min, x))
end

function getVolume()
  return hs.audiodevice.defaultOutputDevice():outputVolume()
end

layouts = {
  leftHalf = {x = 0, y = 0, w = 3, h = 1},
  rightHalf = {x = 3, y = 0, w = 3, h = 1}
}

hs.hotkey.bind(prefix1, "u", function()
  hs.grid.set(hs.window:focusedWindow(), layouts.leftHalf)
end)

hs.hotkey.bind(prefix1, "o", function()
  hs.grid.set(hs.window:focusedWindow(), layouts.rightHalf)
end)

hs.hotkey.bind(prefix1, "Space", function()
  hs.grid.maximizeWindow(hs.window:focusedWindow())
end)

hs.hotkey.bind(prefix1, "j", function()
  hs.window.focusedWindow():focusWindowWest()
end)

hs.hotkey.bind(prefix1, "l", function()
  hs.window.focusedWindow():focusWindowEast()
end)

hs.hotkey.bind(prefix1, "i", function()
  focusNext()
end)

hs.hotkey.bind(prefix1, "k", function()
  focusNextSameGeometry()
end)

hs.hotkey.bind(prefix2, "j", function()
  updateVolume(-5)
end)

hs.hotkey.bind(prefix2, "k", function()
  updateVolume(5)
end)

hs.hotkey.bind(prefix2, "r", function()
  hs.reload()
end)

hs.hotkey.bind(prefix2, "c", function()
  hs.toggleConsole()
end)


alert("hammerspoon loaded " .. os.date("%H:%M:%S"))
