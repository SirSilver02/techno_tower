local base = require("entities.kill_ball")

local kill_spinner = class(base)

function kill_spinner:init()
    base.init(self)

    self.body_type      = "static"
    self.blades         = 3
    self.distance       = 32
    self.teeth          = 2
    self.rotation_speed = 3
    self.time_passed    = 0
    self.kill_balls     = {}
end

function kill_spinner:post_init()
    base.post_init(self)

    for angle = 0, 360 - 360 / self.blades, 360 / self.blades do
        for distance_multiplier = 1, self.teeth do
            local kill_ball = self.entity_manager:add("kill_ball")
            self.kill_balls[kill_ball] = kill_ball

            function kill_ball.update(this, dt)
                base.update(this, dt)

                local center_x, center_y = self:get_center()
                this:set_center(center_x + math.cos(self.time_passed * self.rotation_speed + math.rad(angle)) * self.distance * distance_multiplier, center_y + math.sin(self.time_passed * self.rotation_speed + math.rad(angle)) * self.distance * distance_multiplier)
            end
        end
    end

    self:set_center(400, 400)
end

function kill_spinner:update(dt)
    base.update(self, dt)

    self.time_passed = self.time_passed + dt
end

function kill_spinner:remove()
    for kill_ball in pairs(self.kill_balls) do
        kill_ball:remove()
    end
end

return kill_spinner