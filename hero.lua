Hero = {}
Hero.pos = require "vector"
Hero.pos = Vector:new()

Hero.rect = require "rectangle"
Hero.rect = Rect:new()

Hero.phys = require "phys"
Hero.phys = Phys:new()

Hero.img = love.graphics.newImage("assets/ship.png")

Hero.projectiles = require "projectiles"
Hero.projectiles = Projectiles:new()

laserDecoder = love.sound.newDecoder("assets/laser.wav")
laserSound = love.audio.newSource(laserDecoder)

function Hero:init()
  self.pos.x = 300
  self.pos.y = 150

  self.phys:zeroAccel()
  self.phys:zeroVel()
  self.phys.velX = 6.8

  self.rect:set(300, 450, 30, 15)
  self.hasShot = false
  self.hasJumped = false
  self.isAlive = true

  self.projectiles:initHero()
end

function Hero:update(dt)
  self.phys.accelY = 6

  if jumpPressed() then
    if self.hasJumped == false then
      self.phys.velY = 0
      self.phys.accelY = -225
      self.hasJumped = true
    end
  else
    self.hasJumped = false
  end

  if love.keyboard.isDown("x") then
    if self.hasShot == false then
      self.projectiles:fire(self.pos.x, self.pos.y)
      self.hasShot = true

      love.audio.play(laserSound)
    end
  else
    self.hasShot = false
  end

  self.phys:sclAccel(dt)
  self.phys:addAccelToVel()

  self.pos.x = self.pos.x + self.phys.velX
  self.pos.y = self.pos.y + self.phys.velY

  self.projectiles:update(dt, self.pos.x)
end

function Hero:finishUpdate()
  self.rect:setPos(self.pos.x, self.pos.y)
end

function Hero:checkGroundCol(r)
  if self.rect:overlaps(r.rect) then
    self.pos.y = r.rect.y - 0.05 - self.rect.height
    self.phys.velY = 0
    self.phys.accelY = 0
    self.hasJumped = false
  end
end

function Hero:checkCeilingCol(r)
  if hero.rect:overlaps(ceiling.rect) then
    self.pos.y = r.rect.y + r.rect.height + 0.05
    self.phys.velY = 0
    self.phys.accelY = 0
  end
  self:finishUpdate()
end

function Hero:checkProjectileBuildingCol(buildings)
  self.projectiles:checkCol(buildings)
end

function Hero:checkProjectilesEnemyCol(enemies, numEnemies)
  self.projectiles:checkColEnemies(enemies, numEnemies)
end

function Hero:draw()
  self.projectiles:draw()

  love.graphics.setColor(128, 128, 128, 255)
  love.graphics.setColor(255, 255, 255, 255)
  local x = self.pos.x - 20
  local y = self.pos.y - 10
  love.graphics.draw(self.img, x, y)
end

function jumpPressed()
  return love.keyboard.isDown("z")
end

return Hero

