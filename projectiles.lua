Projectiles = {}

smallDecoder = love.sound.newDecoder("assets/smallExplosion.wav")
smallExplosion = love.audio.newSource(smallDecoder)
medDecoder = love.sound.newDecoder("assets/medExplosion.wav")
medExplosion = love.audio.newSource(medDecoder)

function Projectiles:new()
  local img = love.graphics.newImage("assets/particle.png")

  newObj = {projectiles = {},
  particles = love.graphics.newParticleSystem(img, 500),
  capacity = 0,
  speed = 0,}

  self.__index = self
  return setmetatable(newObj, self)
end

function Projectiles:initHero()
  self.capacity = 10
  self.speed = 900

  for i =1, self.capacity do
    self.projectiles[i] = require "projectile"
    self.projectiles[i] = Projectile:newHero()
    self.projectiles[i]:init()
  end

  self:initParticles()
end

function Projectiles:initParticles()
  local accel = 80
  self.particles:setParticleLifetime(0.8, 1.9)
  self.particles:setSizeVariation(0.7)
  self.particles:setLinearAcceleration(-accel, -accel, accel, accel)
  self.particles:setColors(255, 225, 225, 255, 255, 225, 255, 230)
end

function Projectiles:fire(x, y)
  for i =1, self.capacity do
    if self.projectiles[i].isAlive == false then

      if self.projectiles[i].isExploding == false then
        self.projectiles[i].isAlive = true
        self.projectiles[i].isExploding = false
        self.projectiles[i]:setPos(x, y)
        self.projectiles[i]:setVel(self.speed, 0)
        return
      end

    end
  end
end

function Projectiles:update(dt, playerX)
  for i =1, self.capacity do
    local w = love.graphics.getWidth()
    local screenRight = playerX + w
    local screenLeft = playerX - w
    local projectileX = self.projectiles[i].pos.x

    if self.projectiles[i].isAlive then
      self.projectiles[i]:update(dt)

      if projectileX > screenRight or projectileX < screenLeft then
        self.projectiles[i].isAlive = false
      end
    elseif self.projectiles[i].isExploding then

      if projectileX > screenRight or projectileX < screenLeft then
        self.projectiles[i].isExploding = false
      end
    end
  end

  self.particles:update(dt)
end

function Projectiles:checkCol(buildings)
  for x =1, self.capacity do
    if self.projectiles[x].isAlive then

      local projectile = self.projectiles[x]

      if buildings:overlaps(projectile) then
        self.projectiles[x].isAlive = false
        self.projectiles[x].isExploding = true
        self.particles:emit(20)

        love.audio.play(smallExplosion)
      end

    end
  end
end

function Projectiles:checkColEnemies(enemies, numEnemies)
  for i =1, self.capacity do
    if self.projectiles[i].isAlive then

      for j =1, numEnemies do
        if enemies.enemy[j].isAlive then

          local projectileRect = self.projectiles[i].rect
          local enemyRect = enemies.enemy[j].rect

          if enemyRect:overlaps(projectileRect) then
            enemies.enemy[j].isAlive = false

            self.projectiles[i].isExploding = true
            self.projectiles[i].isAlive = false
            self.particles:emit(20)

            love.audio.play(medExplosion)
          end

        end
      end

    end
  end
end

function Projectiles:draw()
  for i =1, self.capacity do

    if self.projectiles[i].isAlive then
      local img = self.projectiles[i].img
      local x = self.projectiles[i].pos.x
      local y = self.projectiles[i].pos.y
      love.graphics.draw(img, x, y)

      x = self.projectiles[i].rect.x
      y = self.projectiles[i].rect.y
      local w = self.projectiles[i].rect.width
      local h = self.projectiles[i].rect.height
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.rectangle("line", x, y, w, h)
    else
      if self.projectiles[i].isExploding then
        x = self.projectiles[i].pos.x
        y = self.projectiles[i].pos.y
        love.graphics.draw(self.particles, x, y)
      end
    end

  end
end

