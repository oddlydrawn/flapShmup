Vector = {}

function Vector:new()
  newObj = {x=0, y=0}
  self.__index = self
  return setmetatable(newObj, self)
end

function Vector:init()
  self.x = 0
  self.y = 0
end

function Vector:set(x, y)
  self.x = x
  self.y = y
end

function Vector:scl(scalar)
  self.x = self.x * scalar
  self.y = self.y * scalar
end

function Vector:add(v)
  self.x = self.x + v.x
  self.y = self.y + v.y
end

