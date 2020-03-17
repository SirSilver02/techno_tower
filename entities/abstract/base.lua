local base = class()

function base:init()
    self.mass               = 0.01
    self.friction           = 10
    self.speed              = 160
    self.velocity           = vector.new(0, 0)
    self.force              = vector.new(0, 0)
    self.size               = vector.new(32, 32)
    self.physics            = {}
    self.body_type          = "dynamic"
    self.shape_type         = "Rectangle"
    self.collidable         = true
    self.has_shadow         = true
    self.color              = {1, 1, 1}
end

function base:post_init()

end

function base:update(dt)

end

function base:draw()
    local physics = self.physics
    love.graphics.setColor(self.color)

    if self.shape_type == "Circle" then
        love.graphics.circle("fill", math.floor(physics.body:getX()), math.floor(physics.body:getY()), physics.shape:getRadius(), 32)
    else
        local center_x, center_y = self:get_center()
        local points = {physics.body:getWorldPoints(physics.shape:getPoints())}
        
        for i = 1, #points, 2 do
            local x, y = points[i], points[i + 1]
            love.graphics.line(x, y, center_x, center_y)
        end

        love.graphics.polygon("fill", points)
    end
end

function base:get_shape_arguments()
    if self.shape_type == "Rectangle" then
        return self.size:unpack()
    elseif self.shape_type == "Circle" then
        return self.radius
    end
end

function base:move_towards(x2, y2)
    local x1, y1 = self:get_center()
    local norm_x, norm_y = x2 - x1, y2 - y1
    local len = math.sqrt(norm_x ^ 2 + norm_y ^ 2)

    if len == 0 then
        return
    end

    norm_x, norm_y = norm_x / len, norm_y / len
    self:apply_force(norm_x * self.speed, norm_y * self.speed)
end

function base:on_touch(other)

end

function base:get_center()
    return self.physics.body:getWorldCenter()
end

function base:set_center(x, y)
    self.physics.body:setPosition(x, y)
end

function base:set_angle(angle)
    self.physics.body:setAngle(angle)
end

function base:get_angle()
    return self.physics.body:getAngle()
end

function base:distance(other)
    local center = vector.new(self:get_center())
    local center_2 = vector.new(other:get_center())

    return center:dist(center_2)
end

function base:apply_force(force_x, force_y)
    self.physics.body:applyForce(force_x, force_y)
end

function base:remove()
    self.entity_manager:remove(self)
end

function base:remove()
    self.entity_manager:remove(self)
end

function base:on_remove()
    self.physics.body:destroy()
end

return base