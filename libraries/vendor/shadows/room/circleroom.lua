--module("shadows.Room.CircleRoom", package.seeall)
local path = (...):gsub("%.", "/")
local folder = path:gsub("%a+$", "")
local previous_folder = folder:gsub("%a+/$", "")

Room = require(previous_folder .. "room")
Shadows = require(previous_folder)
Transform = require(previous_folder .. "transform")

CircleRoom = setmetatable( {}, Room )
CircleRoom.__index = CircleRoom
CircleRoom.__type = "CircleRoom"

CircleRoom.Radius = 0

function CircleRoom:new(World, x, y, Radius)
	
	local self = setmetatable( {}, CircleRoom )
	
	if World and x and y and Radius then
		
		self.Transform = Transform:new()
		self.Transform:SetLocalPosition(x, y)
		self.Transform.Object = self
		
		self.Radius = Radius
		
		World:AddRoom(self)
		
	end
	
	return self
	
end

function CircleRoom:Draw()
	
	local x, y = self.Transform:GetPosition()
	
	love.graphics.setColor(self.R, self.G, self.B, self.A)
	love.graphics.circle("fill", x, y, self.Radius)
	
end

function CircleRoom:SetRadius(Radius)
	
	if Radius ~= self.Radius then
		
		self.Radius = Radius
		self.World.UpdateCanvas = true
		
	end
	
end

function CircleRoom:GetRadius()
	
	return self.Radius
	
end

return CircleRoom