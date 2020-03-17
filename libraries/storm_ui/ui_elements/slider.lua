local progress_bar = require((...):gsub("[^/]+$", "/progress_bar"))

local panel = require((...):gsub("[^/]+$", "/panel"))
local slider = class(panel)

function slider:init()
    panel.init(self)

    self.w = 400
    self.h = 32
end

function slider:post_init()
    panel.post_init(self)

    self:set_draw_background(false)
    self:set_draw_outline(false)

    self.progress_bar = self:add("progress_bar")
    self.progress_bar:set_hover_enabled(false)
    self.progress_bar:dock(FILL)

    self:add_hook("on_update", self.on_update)
end

function slider:get_percent()
    return self.progress_bar:get_percent()
end

function slider:set_percent(percent)
    self.progress_bar:set_percent(percent)
    self:on_value_changed(self:get_value())

    return self.progress_bar:get_percent()
end

function slider:on_value_changed()
    --override
end

function slider:set_min_max(min, max)
    self.progress_bar:set_min_max(min, max)
end

function slider:get_value()
    return self.progress_bar:get_value()
end

function slider:set_value(value)
    self.progress_bar:set_value(value)
end

function slider:on_update(dt)
    local x, y = self:get_screen_pos()
    
    x = love.mouse.getX() - x 
    y = love.mouse.getY() - y 

    if self.depressed then
        self:set_percent(x / self:get_width())
    end
end


return slider