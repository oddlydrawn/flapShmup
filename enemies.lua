local Enemies = {}
Enemies.enemy = {}
local numEnemies = 3
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
      local offScreenRight = camX + love.graphics.getWidth()
      if currentX < offScreenRight then
        currentX = offScreenRight + 100
      end

      local enemy = Enemies.enemy[i]
      Enemies:setRandomPos(enemy)

      while buildings:overlaps(enemy) do
        Enemies:setRandomPos(enemy)
      end

      enemy.isAlive = true
      enemy.isExploding = false
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

