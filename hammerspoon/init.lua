hs.window.animationDuration = 0

hs.alert.defaultStyle.fillColor = {white = 0.1}
hs.alert.defaultStyle.strokeColor = {white = 1}
hs.alert.defaultStyle.strokeWidth = 4
hs.alert.defaultStyle.radius = 4
hs.alert.defaultStyle.fadeInDuration = 0
hs.alert.defaultStyle.fadeOutDuration = 0

hs.grid.setGrid({w = 6, h = 1})
hs.grid.setMargins({w = 0, h = 0})

function printTable(t)
  for key, value in pairs(t) do
    print(key, value)
  end
end

function bindAll(prefix, tbl)
  for key, fn in pairs(tbl) do
    hs.hotkey.bind(prefix, key, fn)
  end
end

function alert(text)
  hs.alert.closeAll()
  hs.alert.show(text)
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

function focusNextWhere(fn)
  -- Repeatedly calling orderedWindows() gives us "toggle" like functionality
  -- swapping between the same two windows, rather than simply giving us the
  -- next window. Switch to some other functions for looking at the windows.
  local windows = hs.window.orderedWindows()
  local current = hs.window.focusedWindow()
  for index, window in pairs(windows) do
    if window ~= current and fn(window) then
      window:focus()
      break
    end
  end
end

function showCurrentTitle()
  alert(hs.window.focusedWindow():title())
end

bindAll("ctrl-alt", {
  u = function()
    hs.grid.set(hs.window:focusedWindow(), {x = 0, y = 0, w = 3, h = 1})
  end,

  o = function()
    hs.grid.set(hs.window:focusedWindow(), {x = 3, y = 0, w = 3, h = 1})
  end,

  Space = function()
    hs.grid.maximizeWindow(hs.window:focusedWindow())
  end,

  j = function()
    hs.window.focusedWindow():focusWindowWest()
    showCurrentTitle()
  end,

  l = function()
    hs.window.focusedWindow():focusWindowEast()
    showCurrentTitle()
  end,

  i = function()
    focusNext()
    showCurrentTitle()
  end,

  k = function()
    focusNextSameGeometry()
    showCurrentTitle()
  end,

  [";"] = function()
    hs.grid.show()
  end,
})
