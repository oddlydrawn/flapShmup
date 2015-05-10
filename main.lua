
function love.load()
  hero = require "hero"
  camera = require "camera"
  ground = require "ground"
  ceiling = require "ceiling"
  buildings = require "buildings"
  enemies = require "enemies"

  local FONT_LOC = "assets/Amble-Bold.ttf"
  local size = 30
  font = love.graphics.newFont(FONT_LOC, size)

  decoder = love.sound.newDecoder("assets/medExplosion.wav")
  medExplosion = love.audio.newSource(decoder)
  init()
end

function init()
  hero:init()

  isPaused = false
  hasUnpressedPause = true

  buildings:init()
  enemies:init()

  enemies:setPositions(1, buildings)
end

function love.update(dt)
  processPauseButtons()

  if isPaused or hero.isAlive == false then
    if quitPressed() then
      love.event.quit()
    end

    if restartPressed() then
      init()
    end
  else
    updateHero(dt)
    updateCamera()
    updateBuildings()
    updateGroundCeiling()
    updateEnemies(dt)
    camera:draw()
  end
end

function love.draw()
  camera:set()

  buildings:draw()
  ceiling:draw()
  ground:draw()
  enemies:draw()
  hero:draw()

  if isPaused then
    drawPausePrompt()
  end

  if hero.isAlive == false then
    drawGameOverPrompt()
  end

  camera:unset()
end

function processPauseButtons()
  if pausePressed() then
    if hasUnpressedPause and hero.isAlive then
      isPaused = not isPaused
      hasUnpressedPause = false
    end
  else
    hasUnpressedPause = true
  end
end

function drawPausePrompt()
  love.graphics.setFont(font)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("-PAUSED-", camera.x + 340, 240)
  love.graphics.print("Press 'Space' or 'Escape' to Unpause", camera.x + 170, 280)
  love.graphics.print("Press 'Q' to Quit", camera.x + 300, 320)
end

function drawGameOverPrompt()
  love.graphics.setFont(font)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print("-Game Over-", camera.x + 320, 240)
  love.graphics.print("Press 'R' to Restart", camera.x + 280, 280)
  love.graphics.print("Press 'Q' to Quit", camera.x + 300, 320)
end

function pausePressed()
  return love.keyboard.isDown("escape") or love.keyboard.isDown(" ") -- space
end

function restartPressed()
  return love.keyboard.isDown("r")
end

function quitPressed()
  return love.keyboard.isDown("q")
end

function updateHero(dt)
  hero:update(dt)

  hero:checkGroundCol(ground)
  hero:checkCeilingCol(ceiling)

  if buildings:overlaps(hero) then
    hero.isAlive = false
    love.audio.play(medExplosion)
  end

  hero:checkProjectileBuildingCol(buildings)
end

function updateCamera()
  local x = hero.pos.x
  camera:setPos(x, 0)
end

function updateBuildings()
  local x = camera.x
  buildings:update(x)
end

function updateGroundCeiling()
  local x = camera.x

  ground:setXPos(x)
  ceiling:setXPos(x)
end

function updateEnemies(dt)
  enemies:update(dt)
  enemies:setPositions(camera.x, buildings)

  local numEnemies = enemies:getNumEnemies()
  hero:checkProjectilesEnemyCol(enemies, numEnemies)
end

