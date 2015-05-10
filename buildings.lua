Buildings = {}
Buildings.building = {}
for i =1, 5 do
  Buildings.building[i] = {}
  for j = 1, 2 do

    Buildings.building[i][j] = require "building"
    if (j == 2) then
      Buildings.building[i][j] = Building:newUp()
      Buildings.building[i][j]:init()
    else
      Buildings.building[i][j] = Building:newDown()
      Buildings.building[i][j]:init()
    end

  end
end

local xInitial = 300
local xCurrent = 0
local xSpacing = 600
local yMin = 270
local yMax = 530
local yRange = yMax - yMin

function Buildings:init()
  xCurrent = xInitial
  local y = love.math.random() * yRange
  y = y + yMin

  for i =1, 5 do
    xCurrent = xCurrent + xSpacing
    y = love.math.random() * yRange
    y = y + yMin
    for j = 1, 2 do
      Buildings.building[i][j]:setPos(xCurrent, y)
    end
  end
end

function Buildings:overlaps(object)
  for i =1, 5 do
    for j = 1, 2 do

      if Buildings.building[i][j].rect:overlaps(object.rect) then
        return true
      end

    end
  end
  return false
end

function Buildings:update(cameraX)
  for i =1, 5 do
    local x = Buildings.building[i][1].pos.x;
    local w = Buildings.building[i][1].img:getWidth()

    if x + w < cameraX then
      xCurrent = xCurrent + xSpacing
      local y = love.math.random() * yRange
      y = y + yMin

      Buildings.building[i][1]:setPos(xCurrent, y)
      Buildings.building[i][2]:setPos(xCurrent, y)
    end
  end
end

function Buildings:draw()
  for i =1, 5 do
    for j = 1, 2 do
      Buildings.building[i][j]:draw()
    end
  end
end

return Buildings

