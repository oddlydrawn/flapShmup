Phys = {}

function Phys:new()
  newObj = {accelX = 0, accelY = 0, velX = 0, velY = 0}
  self.__index = self
  return setmetatable(newObj, self)
end

function Phys:zeroAccel()
  self.accelX = 0
  self.accelY = 0
end

function Phys:zeroVel()
  self.velX = 0
  self.velY = 0
end

function Phys:sclAccel(scalar)
  self.accelX = self.accelX * scalar
  self.accelY = self.accelY * scalar
end

function Phys:addAccelToVel()
  self.velX = self.velX + self.accelX
  self.velY = self.velY + self.accelY
end

function Phys:sclVel(scalar)
  self.velX = self.velX * scalar
  self.velY = self.velY * scalar
end


