hs.window.animationDuration = 0

hs.alert.defaultStyle.fillColor = {white = 0.1, alpha = 1}
hs.alert.defaultStyle.strokeColor = {white = 0.1, alpha = 0}
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

function alertForever(text)
  hs.alert.closeAll()
  hs.alert.show(text, "forever")
end

function focusNextSameGeometry()
  local windowsSameGeometry = sortedWindows(wfColumn:getWindows())
  focusNextOf(windowsSameGeometry)
  showCurrentTitle(windowsSameGeometry)
end

function focusNext()
  local windows = sortedWindows(wfAll:getWindows())
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

function sortedWindows(windows)
  return sortedBy(windows, function(a, b)
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

function getCurrentTitle(windows, fwin)
  local lines = hs.fnutils.imap(windows, function(window)
    if window == fwin then
      return "⚪️ " .. getTitle(window)
    else
      return "⚫️ " .. getTitle(window)
    end
  end)
  return table.concat(lines, "\n")
end

function showCurrentTitle(windows)
  alert(getCurrentTitle(windows), hs.window.focusedWindow())
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

hs.hotkey.bind(prefix1, "t", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d %H.%M.%S"))
end)

hs.hotkey.bind(prefix1, "d", function()
  hs.eventtap.keyStrokes(os.date("%Y-%m-%d"))
end)

switcherOpen = false
switcherWindows = {}
switcherIndex = 0
switcherStart = function(windows, index)
  switcherOpen = true
  switcherWindows = windows
  switcherIndex = index
  switcherUpdate()
end
switcherStep = function(delta)
  print("switcherStep", delta)
  local j = switcherIndex - 1
  switcherIndex = 1 + ((j + delta) % #switcherWindows)
  switcherUpdate()
end
switcherUpdate = function()
  alertForever(getCurrentTitle(switcherWindows, switcherWindows[switcherIndex]))
end
switcherChoose = function()
  switcherOpen = false
  switcherWindows[switcherIndex]:focus()
  hs.alert.closeAll()
end

hs.hotkey.bind(prefix1, "k", function()
  if switcherOpen then
    switcherStep(1)
  else
    local windows = sortedWindows(wfColumn:getWindows())
    local index = hs.fnutils.indexOf(windows, hs.window:focusedWindow())
    switcherStart(windows, index)
    switcherStep(1)
  end
end)

hs.hotkey.bind(prefix1, "i", function()
  if switcherOpen then
    switcherStep(-1)
  else
    local windows = sortedWindows(wfColumn:getWindows())
    local index = hs.fnutils.indexOf(windows, hs.window:focusedWindow())
    switcherStart(windows, index)
    switcherStep(-1)
  end
end)

-- prefix 2

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

wfAll = hs.window.filter.new()
wfColumn = hs.window.filter.new(function(window)
  local cur = hs.window.focusedWindow()
  return hs.grid.get(cur):equals(hs.grid.get(window))
end)

modifierTap = hs.eventtap.new(
  { hs.eventtap.event.types.flagsChanged },
  function(event)
    local mods = event:getFlags()
    if not mods.ctrl and not mods.alt and switcherOpen then
      switcherChoose()
    end
    return false
  end
)
modifierTap:start()

alert("hammerspoon loaded " .. os.date("%H:%M:%S"))
