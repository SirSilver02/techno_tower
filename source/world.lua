local entity_manager    = require("source.entity_manager")
local light_world       = require("libraries.vendor.shadows.lightworld")
local light             = require("libraries.vendor.shadows.light")
local body              = require("libraries.vendor.shadows.body")
local polygon_shadow    = require("libraries.vendor.shadows.shadowshapes.polygonshadow")
local normal_shadow     = require("libraries.vendor.shadows.shadowshapes.normalshadow")
local height_shadow     = require("libraries.vendor.shadows.shadowshapes.heightshadow")
local image_shadow      = require("libraries.vendor.shadows.shadowshapes.imageshadow")

local world = class()

function world:init(map)
    self.entity_manager = entity_manager.new(self, map)
    self.light_world    = light_world:new()

    self:set_ambient_color(40, 50, 60)  --self:set_ambient_color(100, 100, 100)
end

function world:update(dt)
    self.entity_manager:update(dt)
    self.light_world:Update(dt)
end

function world:draw()
    self.entity_manager.map:draw()
    self.light_world:Draw()
end

function world:add(entity_type)
    return self.entity_manager:add(entity_type)
end

function world:add_light(radius)
    return light:new(self.light_world, radius)
end

function world:set_ambient_color(r, g, b)
    self.light_world:SetColor(r, g, b)
end 

function world:resize(w, h)
    --self.entity_manager.map:resize(w, h)
    --self.light_world:Resize(w, h)
end

return world