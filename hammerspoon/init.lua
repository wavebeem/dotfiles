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

function bindAll(tbl)
  local prefix = {"alt", "ctrl"}
  for key, fn in pairs(tbl) do
    hs.hotkey.bind(prefix, key, fn)
  end
end

function alert(text)
  hs.alert.closeAll()
  hs.alert.show(text)
end

bindAll({
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
    alert(hs.window.focusedWindow():title())
  end,

  l = function()
    hs.window.focusedWindow():focusWindowEast()
    alert(hs.window.focusedWindow():title())
  end,

  k = function()
    focusNext()
  end,

  [";"] = function()
    hs.grid.show()
  end,
})

function focusNext()
  local windows = hs.window.orderedWindows()
  local current = hs.window.focusedWindow()
  local curGeom = hs.grid.get(current)
  for index, window in pairs(windows) do
    local winGeom = hs.grid.get(window)
    if window ~= current and winGeom:equals(curGeom) then
      window:focus()
      alert(window:title())
      break
    end
  end
end
