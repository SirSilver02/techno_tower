local base = require("entities.abstract.base")

local character = class(base)

function character:init()
    base.init(self)

    self.shape_type = "Circle"
    self.radius     = 16
    self.mass       = 0.02
    self.friction   = 48
    self.speed      = 120
end

function character:post_init()
    base.post_init(self)

    local x, y, z = self.body:GetPosition()
    self.body:SetPosition(x, y, 0.1)
end

function character:kill()
    event.run("on_player_death")
end


return character