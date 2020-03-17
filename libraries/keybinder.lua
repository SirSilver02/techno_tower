local key_to_mouse = {
    mouse1 = 1,
    mouse2 = 2,
    mouse3 = 3
}

local keybinder = {}
keybinder.__index = keybinder

function keybinder.__call()
    local keybinder = setmetatable({}, keybinder)
    keybinder:init()

    return keybinder
end

function keybinder:init()
    self.defines        = {}

    self.keybinds = {
        keypressed      = {},
        keyreleased     = {},
        hold            = {}
    }

    self.depressed_keys = {}
end

function keybinder:update(dt)
    for key, id in pairs(self.keybinds.hold) do
        if not key:find("mouse") and love.keyboard.isDown(key) or love.mouse.isDown(key_to_mouse[key] or 0) then
            if type(id) == "function" then
                id(dt)
            else
                local func = self.defines[id]
    
                if func then
                    func(dt)
                end
            end
        end
    end
end

function keybinder:keypressed(key)
    self.depressed_keys[key] = true

    local id = self.keybinds.keypressed[key]

    if id then
        if type(id) == "function" then
            id()
        else
            local func = self.defines[id]

            if func then
                func()
            end
        end
    end
end

function keybinder:keyreleased(key)
    self.depressed_keys[key] = nil

    local id = self.keybinds.keyreleased[key]

    if id then
        if type(id) == "function" then
            id()
        else
            local func = self.defines[id]

            if func then
                func()
            end
        end
    end
end

function keybinder:mousepressed(x, y, button)
    self.depressed_keys["mouse" .. button] = true

    local id = self.keybinds.keypressed["mouse" .. button]

    if id then
        if type(id) == "function" then
            id()
        else
            local func = self.defines[id]

            if func then
                func()
            end
        end
    end
end

function keybinder:mousereleased(x, y, button)
    self.depressed_keys["mouse" .. button] = nil

    local id = self.keybinds.keyreleased["mouse" .. button]

    if id then
        if type(id) == "function" then
            id()
        else
            local func = self.defines[id]

            if func then
                func()
            end
        end
    end
end

function keybinder:is_down(id)
    for key in pairs(self.depressed_keys) do
        if self.keybinds.keypressed[key] == id or self.keybinds.hold[key] == id then
            return true
        end
    end

    return false
end

function keybinder:define(id, func)
    self.defines[id] = func
end

function keybinder:bind(key, event, id)
    local event = assert(self.keybinds[event], "Argument #2 must be \"keypressed\", \"keyreleased\", or \"hold\".")
    event[key] = id
end

function keybinder:unbind(key, event)
    local event = assert(self.keybinds[event], "Argument #2 must be \"keypressed\", \"keyreleased\", or \"hold\".")
    event[key] = nil
end

function keybinder:get_keybind(id)
    for _, event in pairs(self.keybinds) do
        for key, id2 in pairs(event) do
            if id == id2 then
                return key
            end
        end
    end
end

function keybinder:install(table)
    local events = {"update", "keypressed", "keyreleased", "mousepressed", "mousereleased"}

    for _, event in ipairs(events) do
        local old_event = table[event]

        table[event] = function(...)
            local _, a, b, c, d, e = ...

            if type(_) == "table" then
                self[event](self, a, b, c, d, e)
            else
                self[event](self, ...)
            end

            if old_event then
                old_event(...)
            end
        end
    end
end

return setmetatable({new = keybinder.__call}, keybinder)