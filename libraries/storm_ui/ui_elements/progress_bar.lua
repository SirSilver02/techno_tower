local panel = require((...):gsub("[^/]+$", "/panel"))

local progress_bar = class(panel)

function progress_bar:init()
    panel.init(self)

    self.w = 200
    self.h = 24
    
    self.min_value = 0
    self.max_value = 100
    self.value = 50

    self.should_draw_lines = true
    self.lines = 8
end

function progress_bar:post_init()
    panel.post_init(self)

    self:set_draw_background(false)
    self:set_draw_outline(false)

    self.background_color = self.ui_manager.theme.panel.background_color
    self.bar_color = self.ui_manager.theme.button.depressed_color
    self.bar_height = 6
    self.grabber_height = 12
    self.grabber_width = 6
end

function progress_bar:get_percent()
    return (self.value - self.min_value) / (self.max_value - self.min_value)
end

function progress_bar:set_value(value)
    self.value = value
end

function progress_bar:get_value()
    return self.value
end

function progress_bar:set_min_max(min, max)
    self.min_value = min
    self.max_value = max
end

function progress_bar:set_percent(percent)
    percent = math.max(0, math.min(percent, 1))
    self:set_value((self.max_value - self.min_value) * percent)
end

--whoops, stuff for slider is in here... oh well...
function progress_bar:draw()
    local x, y = self:get_screen_pos()
    local w, h = self:get_size()
    local percent = self:get_percent()
    local bar_height = self.bar_height
    local grabber_height = self.grabber_height

    love.graphics.setColor(self.background_color)
    love.graphics.rectangle("fill", x, y + h / 2 - (bar_height / 2) , w, bar_height)

    love.graphics.setColor(self.bar_color)
    love.graphics.rectangle("fill", x, y + h / 2 - (bar_height / 2) , w * percent, bar_height)

    --vertical bar grabber
    love.graphics.rectangle("fill", x + (w * percent) - self.grabber_width / 2, y + h / 2 - grabber_height / 2, self.grabber_width, grabber_height)
end

return progress_bar