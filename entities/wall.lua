local base = require("entities.abstract.base")

local wall = class(base)

function wall:init()
    base.init(self)

    self.body_type = "static"
end

function wall:post_init()
    base.post_init(self)

    self.physics.fixture:setGroupIndex(-2)
end

return wall