local base = require("entities.abstract.base")

local kill_ball = class(base)

function kill_ball:init()
    base.init(self)

    self.mass       = 0.05
    self.shape_type = "Circle"
    self.radius     = 8
    self.path_index = 1
    self.speed      = 40
    self.has_shadow = false
    self.collidable = false
    self.path       = {}
end

function kill_ball:post_init()
    self.light = self.entity_manager:add("light")
    self.light:set_radius(260)
    self.light:set_color(255, 50, 10, 200)

    self.physics.fixture:setGroupIndex(-2)
end

function kill_ball:update(dt)
    self.light:set_center(self:get_center())

    if #self.path > 0 then
        local center_x, center_y = self:get_center()
        local path_point = self.path[self.path_index]
        local path_x, path_y = path_point[1], path_point[2]

        self:move_towards(path_x, path_y)

        if vector.new(center_x, center_y):dist(vector.new(path_x, path_y)) < self.radius then
            self.path_index = self.path_index + 1

            if self.path_index > #self.path then
                self.path_index = 1
            end
        end
    end
end

function kill_ball:set_path(...)
    self.path = {...}
end

function kill_ball:on_touch(other)
    local game = states.get_state("game")
    --Doing this to avoid some bug in love.physics collision callbacks
    if other.type == "player" then
        game.timer:after(0, function()
            other:kill()
        end)
    end
end

return kill_ball