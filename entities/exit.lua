local base = require("entities.abstract.base")

local exit = class(base)

function exit:init()
    base.init(self)

    self.collidable = false
    self.has_shadow = false

    self.color = {0.8, 1, 0.4}
end

function exit:on_touch(other)
    if other.type == "player" then
        event.run("change_level", self.map_name)
    end
end

return exit