Ceiling = {}
Ceiling.rect = require "rectangle"
Ceiling.rect = Rect:new()
Ceiling.rect:set(0, -15, 1000, 50)

function Ceiling:draw()
  local x = self.rect.x
  local y = self.rect.y
  local w = self.rect.width
  local h = self.rect.height
  love.graphics.setColor(120,40,10,255)
  love.graphics.rectangle("fill", x, y, w, h)
end

function Ceiling:setPos(x, y)
  self.rect.x = x
  self.rect.y = y
end

return Ceiling

