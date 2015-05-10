Enemy = {}

function Enemy:new()
  newObj = {pos = require "vector",
  img = love.graphics.newImage("assets/enemy.png"),
  rect = require "rectangle",
  fireTimer = 0,
  timeToFire = 0,
  isExploding = false,
  isAlive = false}

  self.__index = self
  return setmetatable(newObj, self)
end

function Enemy:init()
  self.pos = Vector:new()
  self.pos:init()

  self.rect = Rect:new()
  self.rect:set(-100, 50, 20, 20)

  self.fireTimer = 0
  self.isAlive = true
  self.isExploding = false

  local timeToFireMin = 1
  local timeToFireMax = 3
  local timeToFireRange = timeToFireMax - timeToFireMin

  self.timeToFire = love.math.random() * timeToFireRange
  self.timeToFire = self.timeToFire + timeToFireMin
end

function Enemy:setPos(x, y)
  self.pos:set(x, y)
  self.rect:setPos(x, y)
end

function Enemy:update(dt)
  self.timeToFire = self.timeToFire + dt
end

function Enemy:draw()
  if (self.isAlive) then
    love.graphics.draw(self.img, self.pos.x - 30, self.pos.y - 5)
    love.graphics.rectangle("line", self.rect.x, self.rect.y, self.rect.width, self.rect.height)
  end
end
