--Litteraly just make button a label, but it draws different and stuff.

local panel = require((...):gsub("[^/]+$", "/panel"))
local label = require((...):gsub("[^/]+$", "/label"))

local button = class(panel)  --TODO: Maybe change this to class(panel) ?

function button:init()
    panel.init(self)

    self.last_pressed = 0
    self.time_between_double_click = 0.5

    self.should_draw_hovered = true
    self.should_draw_depressed = true
end

function button:post_init()
    panel.post_init(self)

    self:set_draw_outline(true)

    self.hovered_color = self.ui_manager.theme.button.hovered_color
    self.depressed_color = self.ui_manager.theme.button.depressed_color

    self.label = self:add("label")
    self.label:dock(FILL)

    --below code should probably be a helper function somewhere
    --make all methods of label apply to self.label
    for k, func in pairs(label) do
        if not self[k] then
            if type(func) == "function" then
                self[k] = function(_, ...)
                    return func(self.label, ...) 
                end
            end
        end
    end
    
    self:set_text("text")
    self:set_align(5)
end

function button:draw()
    local x, y = self:get_screen_pos()

    panel.draw(self)

    if self.depressed and self.should_draw_depressed then
        love.graphics.setColor(self.depressed_color)
        love.graphics.rectangle("fill", x, y, self.w, self.h)
    elseif self.hovered and self.should_draw_hovered then
        love.graphics.setColor(self.hovered_color)
        love.graphics.rectangle("fill", x, y, self.w, self.h)
    end
end

function button:set_hovered_color(r, g, b)
    self.hovered_color = type(r) == "table" and r or {r, g, b}
end

function button:get_hovered_color()
    return self.hovered_color
end

function button:set_depressed_color()
    self.depressed_color = type(r) == "table" and r or {r, g, b}
end

function button:get_depressed_color()
    return self.depressed_color
end

function button:set_draw_hovered(bool)
    self.should_draw_hovered = bool
end

function button:get_draw_hovered()
    return self.should_draw_hovered
end

function button:set_draw_depressed(bool)
    self.should_draw_depressed = bool
end

function button:get_draw_depressed()
    return self.should_draw_depressed
end

return button