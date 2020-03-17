local base = require("entities.abstract.base")

local light = class(base)

function light:init()
    base.init(self)

    self.radius         = 32
    self.light_radius   = 600
    self.color          = {255, 255, 255, 255}
    self.shape_type     = "Circle"
    self.has_shadow     = false
    self.collidable     = false
end

function light:post_init()
    self.light = self.world:add_light(self.light_radius)
    self.light:SetPosition(self:get_center())
    self.light:SetColor(unpack(self.color))

    self.physics.fixture:setMask(1)
end

function light:update(dt)
    self.light:SetPosition(self:get_center())
end

function light:set_z(z)
    local x, y = self.light:GetPosition()
    self.light:SetPosition(x, y, z)
end

function light:draw()
    
end

function light:set_radius(radius)
    self.light_radius = radius
    self.light:SetRadius(radius)
end

function light:set_color(r, g, b, a)
    self.color = type(r) == "table" and r or {r, g, b, a}
    self.light:SetColor(self.color[1], self.color[2], self.color[3], self.color[4])
end

function light:on_remove()
    base.on_remove(self)
    self.light:Remove()
end

return light