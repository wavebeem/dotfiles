local sprite = app.activeSprite
if not sprite then
  return app.alert("There is no active sprite")
end

function colorTo15bit(color)
  return Color {
    r = math.floor(color.red / 8) * 8,
    g = math.floor(color.green / 8) * 8,
    b = math.floor(color.blue / 8) * 8,
  }
end

function downgradePalette()
  local palette = sprite.palettes[1]
  for i = 0, #palette - 1 do
    palette:setColor(i, colorTo15bit(palette:getColor(i)))
  end
end

app.transaction(downgradePalette)
app.refresh()
