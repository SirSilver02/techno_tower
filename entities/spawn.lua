local base = require("entities.abstract.base")

local spawn = class(base)

function spawn:init()
    base.init(self)

    self.collidable = false
    self.has_shadow = false

    self.color = {1, 0.8, 0.4}
end

return spawn