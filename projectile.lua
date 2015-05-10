Projectile = {}

function Projectile:newHero()
  newObj = {pos = require "vector",
  img = love.graphics.newImage("assets/projectile.png"),
  vel = require "vector",
  rect = require "rectangle",
  isExploding = false,
  isAlive = false}

  self.__index = self
  return setmetatable(newObj, self)
end

function Projectile:init()
  self.pos = Vector:new()
  self.pos:init()

  self.vel = Vector:new()
  self.vel:init()

  self.rect = Rect:new()
  self.rect:set(0, 0, 10, 8)

  self.isAlive = false
  self.isExploding = false
end

function Projectile:setPos(x, y)
  self.pos:set(x, y)
end

function Projectile:setVel(x, y)
  self.vel:set(x, y)
end

function Projectile:update(dt)
  self.pos.x = self.pos.x + self.vel.x * dt
  self.pos.y = self.pos.y + self.vel.y * dt
  self.rect:setPos(self.pos.x, self.pos.y)
end

function Projectile:checkCol(r)
  return self.rect:overlaps(r)
end

