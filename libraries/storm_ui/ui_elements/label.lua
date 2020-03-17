local panel = require((...):gsub("[^/]+$", "/panel"))

local label = class(panel)

function label:init()
    panel.init(self)

    self:set_hover_enabled(false)
end

function label:post_init()
    panel.post_init(self)

    self:set_draw_outline(false)

    self.font = self.ui_manager.theme.label.font
    self.text = "label"
    self.align = 1
    self.rotation = 0
    self.text_object = love.graphics.newText(self.font, self.text)

    self:set_text_color(self.ui_manager.theme.label.text_color)
end

--TODO Make it so it can align at 1, 2, 3
--                                4, 5, 6
--                                7, 8, 9

function label:set_width_internal(w)
    local scale_x, scale_y = self:get_text_scale()

    panel.set_width_internal(self, w)
    self.text_object:setf(self.text, w / scale_x, self:need_a_better_name())
end

function label:get_horizontal_align()
    local align = self.align

    if align == 1 or align == 4 or align == 7 then
        return "left"
    elseif align == 2 or align == 5 or align == 8 then
        return "center"
    elseif align == 3 or align == 6 or align == 9 then
        return "right"
    end
end

function label:get_align()
    return self.align
end

function label:set_align(align)
    self.align = align
    self:set_text(self.text)
end

function label:get_text()
    return self.text
end

function label:set_text(text)
    if not text then
        text = ""
    end

    local scale_x, scale_y = self:get_text_scale()

    self.text = tostring(text)
    self.text_object:setf(self.text, self.w / scale_x , self:get_horizontal_align())
end

function label:get_font()
    return self.font
end

function label:set_font(font)
    self.font = font
    self.text_object:setFont(self.font)
end

function label:set_text_color(r, g, b)
    self.text_color = type(r) == "table" and r or {r, g, b, a}
end

function label:get_text_color()
    return self.text_color
end

function label:get_text_scale()
    local manager = self.ui_manager

    local scale_x = manager.w / manager.theme.window.designed_width
    local scale_y = manager.h / manager.theme.window.designed_height
    
    return scale_x, scale_y
end

function label:set_dropshadow(bool)
    self.should_draw_dropshadow = bool
end

function label:get_dropshadow()
    return self.should_draw_dropshadow
end


function label:update(dt)
    if self.should_reset_text then
        self:set_text(self:get_text())
        self.should_reset_text = false
    end

    if self.should_validate then
        self.should_reset_text = true
    end
end

--TODO Clean this shit up. looks NASTY and don't even work right
function label:draw()
    if self.text then
        local x, y = self:get_screen_pos()
        local scale_x, scale_y = self:get_text_scale()
        local font_height = self.text_object:getFont():getHeight()
        local text_width = self.text_object:getWidth()
        local draw_dropshadow = self:get_dropshadow()
        local rotation = self.rotation

        local align = self.align

        if align == 1 then
            if draw_dropshadow then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.draw(self.text_object, x + 2 * scale_x, y + 2 * scale_y, 0, scale_x, scale_y)
            end

            love.graphics.setColor(self.text_color)
            love.graphics.draw(self.text_object, x, y, 0, scale_x, scale_y)
        elseif align == 2 then

        elseif align == 3 then

        elseif align == 4 then
            love.graphics.setColor(self.text_color)
            love.graphics.draw(self.text_object, x + text_width / 2, y + self.h / 2, rotation, scale_x, scale_y, text_width / 2, font_height / 2)
        elseif align == 5 then
            if draw_dropshadow then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.draw(self.text_object, x + 2 * scale_x, y + 2 * scale_y + self.h / 2, 0, scale_x, scale_y, 0, font_height / 2)
            end

            love.graphics.setColor(self.text_color)
            love.graphics.draw(self.text_object, x, y + self.h / 2, 0, scale_x, scale_y, 0, font_height / 2)
        elseif align == 6 then

        elseif align == 7 then
            love.graphics.setColor(self.text_color)
            love.graphics.draw(self.text_object, x, y + self.h, 0, scale_x, scale_y, 0, font_height)
        elseif align == 8 then

        elseif align == 9 then

        end
    end
end

return label