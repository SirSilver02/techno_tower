local character = require("entities.abstract.character")

local player = class(character)

function player:init()
    character.init(self)
end

return player