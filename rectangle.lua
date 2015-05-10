Rect = {}

function Rect:new()
  newObj = {x=0, y=0, width=0, height=0}
  self.__index = self
  return setmetatable(newObj, self)
end

function Rect:set(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
end

function Rect:setPos(x, y)
  self.x = x
  self.y = y
end

function Rect:overlaps(r)
  return self.x < r.x + r.width and
  self.x + self.width > r.x and
  self.y < r.y + r.height and
  self.y + self.height > r.y
end

