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

function focusNextSameGeometry()
  local current = hs.window.focusedWindow()
  local curGeom = hs.grid.get(current)
  return focusNextWhere(function(window)
    return curGeom:equals(hs.grid.get(window))
  end)
end

function focusNext()
  return focusNextWhere(function() return true end)
end

function filter(array, fn)
  local newArray = {}
  for key, value in array do
    if fn(value, key) then
      newArray[key] = value
    end
  end
  return newArray
end

function sortedBy(tbl, fn)
  tbl = {table.unpack(tbl)}
  table.sort(tbl, fn)
  return tbl
end

function focusNextWhere(fn)
  local windows = sortedWindows()
  local current = hs.window.focusedWindow()
  for index, window in ipairs(windows) do
    if window ~= current and fn(window) then
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
    title = window:application():title()
  end
  return title
end

function showCurrentTitle()
  local s = ""
  local fwin = hs.window.focusedWindow()
  for _, window in ipairs(hs.window.orderedWindows()) do
    if window == fwin then
      s = s .. "> " .. getTitle(window) .. "\n"
    else
      s = s .. "< " .. getTitle(window) .. "\n"
    end
  end
  alert(s)
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
  local str = textBar(volume / 100, 10) .. " " .. volume
  local styl = hs.styledtext.new(str, {
    font = {
      name = "JetBrainsMono-Regular",
      size = 40,
    },
    ligature = 0,
    color = {white = 1,}
  })
  alert(styl)
end

function clamp(min, max, x)
  return math.min(max, math.max(min, x))
end

function textBar(ratio, width)
  local ret = ""
  local before = math.floor(ratio * width)
  local after = width - before
  for i = 1, before do
    ret = ret .. "⚪️"
  end
  for i = 1, after do
    ret = ret .. "⚫️"
  end
  return ret
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
  showCurrentTitle()
end)

hs.hotkey.bind(prefix1, "l", function()
  hs.window.focusedWindow():focusWindowEast()
  showCurrentTitle()
end)

hs.hotkey.bind(prefix1, "i", function()
  focusNext()
  showCurrentTitle()
end)

hs.hotkey.bind(prefix1, "k", function()
  focusNextSameGeometry()
  showCurrentTitle()
end)

hs.hotkey.bind(prefix2, "j", function()
  updateVolume(-5)
end)

hs.hotkey.bind(prefix2, "k", function()
  updateVolume(5)
end)
