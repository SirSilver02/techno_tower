local body              = require("libraries.vendor.shadows.body")
local polygon_shadow    = require("libraries.vendor.shadows.shadowshapes.polygonshadow")
local circle_shadow     = require("libraries.vendor.shadows.shadowshapes.circleshadow")

local entities = {}

for _, file in pairs(love.filesystem.getDirectoryItems("entities")) do
    local info = love.filesystem.getInfo("entities/" .. file, "file")

    if info then
        local name = file:gsub(".lua", "")
        entities[name] = require("entities/" .. name)
    end
end

local entity_manager = class()
entity_manager.types = entities

function entity_manager:init(world, map)
    love.physics.setMeter(32)

    self.world              = world
    self.entities           = {}
    self.physics_world      = love.physics.newWorld()
    self.map                = sti(map, {"box2d"})
    self.decals             = love.graphics.newCanvas(self.map:getSize())

    self.map:box2d_init(self.physics_world)

    local decals_layer = self.map:addCustomLayer("decals", 2)

    function decals_layer.draw()
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.draw(self.decals)
    end

    local entities_layer = self.map.layers.entities

    function entities_layer.draw()
        self:draw()
    end

    self.physics_world:setCallbacks(
        --begin contact
        function(a, b, contact) 
            local first_entity = a:getUserData()
            local second_entity = b:getUserData()

            if first_entity.on_touch then
                first_entity:on_touch(second_entity)
            end

            if second_entity.on_touch then
                second_entity:on_touch(first_entity)
            end
        end,

        --end contact
        function(a, b, contact)
 
        end, 

        --pre solve
        function(a, b, contact)
            local first_entity = a:getUserData()
            local second_entity = b:getUserData()

            --explicitly checking for false because not everything on the map is an entity
            if not (first_entity.collidable and second_entity.collidable) then
                contact:setEnabled(false)
            end
        end,

        --post solve
        function(a, b, contact)

        end
    )
end

function entity_manager:add(entity_type)
    local entity

    if type(entity_type) == "table" then
        entity                  = entity_type
    else
        entity                  = assert(entities[entity_type], "Can't spawn that type of entity.").new()
    end

    entity.type                 = type(entity_type) == "table" and entity.type or entity_type
    entity.entity_manager       = self
    entity.world                = self.world

    entity.physics.body         = love.physics.newBody(self.physics_world, 0, 0, entity.body_type)
    entity.physics.shape        = love.physics[string.format("new%sShape", entity.shape_type)](entity:get_shape_arguments())
    entity.physics.fixture      = love.physics.newFixture(entity.physics.body, entity.physics.shape, entity.mass)
    entity.physics.fixture:setUserData(entity)
    entity.physics.body:setLinearDamping(entity.friction)

    if entity.has_shadow then
        entity.body = body:new(entity.world.light_world)
        entity.body:TrackPhysics(entity.physics.body)
    
        if entity.shape_type == "Circle" then
            local x, y = entity:get_center()
            entity.shadow = circle_shadow:new(entity.body, x, y, entity.radius)
        else
            entity.shadow = polygon_shadow:new(entity.body, entity.physics.shape:getPoints())
        end
    end
  
    self.entities[entity] = entity
    entity:post_init()

    return entity
end

function entity_manager:update(dt)
    self.map:update(dt)
    self.physics_world:update(dt)

    for entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function entity_manager:draw()
    local players = {}

    for entity in pairs(self.entities) do
        if entity.type == "player" then
            players[#players] = entity
        else
            entity:draw()
        end
    end

    for _, player in pairs(players) do
        player:draw()
    end
end

function entity_manager:find_by_type(type)
    local entities = {}

    for entity in pairs(self.entities) do
        if entity.type == type then
            entities[#entities + 1] = entity
        end
    end

    return entities
end

function entity_manager:find_in_box(x1, y1, x2, y2)

end

function entity_manager:remove(entity)
    entity:on_remove()
    self.entities[entity] = nil
end

return entity_manager