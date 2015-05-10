Building = {}

function Building:newDown()
  local image = love.graphics.newImage("assets/building.png")
  local upOrDown = false

  return Building:new(image, upOrDown)
end

function Building:newUp()
  local image = love.graphics.newImage("assets/buildingUp.png")
  local upOrDown = true

  return Building:new(image, upOrDown)
end

function Building:new(image, upOrDown)
  newObj = {pos = require "vector",
  rect = require "rectangle",
  img = image,
  up = upOrDown}

  self.__index = self
  return setmetatable(newObj, self)
end

function Building:init()
  self.pos = Vector:new()
  self.rect = Rect:new()
end

function Building:setPos(x, y)
  if self.up then
    y = y - 750
    self.pos:set(x, y)
    self.rect:set(x + 25, y + 5, 160, 560)
  else
    self.pos:set(x, y)
    self.rect:set(x + 25, y + 35, 160, 580)
  end
end

function Building:draw()
  love.graphics.draw(self.img, self.pos.x, self.pos.y, self.rads)

  love.graphics.setColor(255, 255, 255, 255)
  local x = self.rect.x
  local y = self.rect.y
  local w = self.rect.width
  local h = self.rect.height
  love.graphics.rectangle("line", x, y, w, h)
end

