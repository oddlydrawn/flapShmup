Building = {}

function Building:newDown()
  newObj = {pos = require "vector", 
  rect = require "rectangle", 
  img = love.graphics.newImage("assets/building.png"), 
  up = false}

  self.__index = self
  return setmetatable(newObj, self)
end

function Building:newUp()
  newObj = {pos = require "vector", 
  rect = require "rectangle", 
  img = love.graphics.newImage("assets/buildingUp.png"), 
  up = true}

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

