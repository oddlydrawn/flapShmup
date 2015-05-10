Enemies = {}
Enemies.enemy = {}
local numEnemies = 5
for i =1, numEnemies do
  Enemies.enemy[i] = require "enemy"
  Enemies.enemy[i] = Enemy:new()
  Enemies.enemy[i]:init()
end

Enemies.projectiles = require "projectiles"
Enemies.projectiles = Projectiles:new()

local minXSpacing = 450
local maxXSpacing = 1200
local xSpacingRange = maxXSpacing - minXSpacing
local currentX = 660

local minYSpacing = 100
local maxYSpacing = 500
local ySpacingRange = maxYSpacing - minYSpacing

function Enemies:init()
  for i =1, numEnemies do
    Enemies.enemy[i] = require "enemy"
    Enemies.enemy[i] = Enemy:new()
    Enemies.enemy[i]:init()
    Enemies.enemy[i]:setPos(-100, 0)
  end

  currentX = 660
end

function Enemies:update(dt)
  for i =1, numEnemies do
    Enemies.enemy[i]:update(dt)
  end
end

function Enemies:setPositions(camX, buildings)
  for i =1, numEnemies do
    if Enemies.enemy[i].pos.x < camX - 100 then

      if currentX < camX + love.graphics.getWidth() then
        currentX = camX + love.graphics.getWidth() + 100
      end

      Enemies:setRandomPos(Enemies.enemy[i])

      while buildings:overlaps(Enemies.enemy[i]) do
        Enemies:setRandomPos(Enemies.enemy[i])
      end

      Enemies.enemy[i].isAlive = true
      Enemies.enemy[i].isExploding = false
      currentX = currentX + additionalX
    end
  end
end

function Enemies:setRandomPos(enemy)
  local randX = love.math.random() * xSpacingRange
  local randY = love.math.random() * ySpacingRange

  randX = randX + minXSpacing
  additionalX = randX

  randX = randX + currentX
  randY = randY + minYSpacing

  enemy:setPos(randX, randY)
end

function Enemies:getNumEnemies()
  return numEnemies
end

function Enemies:draw()
  love.graphics.setColor(255, 255, 255, 255)
  for i =1, numEnemies do
    Enemies.enemy[i]:draw()
  end
end

return Enemies
