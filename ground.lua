Ground = {}
Ground.rect = require "rectangle"
Ground.rect = Rect:new()
Ground.rect:set(0,565, 1000, 50)

function Ground:draw()
  local x = self.rect.x
  local y = self.rect.y
  local w = self.rect.width
  local h = self.rect.height
  love.graphics.setColor(120,40,10,255)
  love.graphics.rectangle("fill", x, y, w, h)
end

function Ground:setPos(x, y)
  self.rect.x = x
  self.rect.y = y
end

return Ground

