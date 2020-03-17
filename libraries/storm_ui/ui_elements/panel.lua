local tween = tween

local panel = class()

function panel:init()
    self.x = 0
    self.y = 0
    self.w = 60
    self.h = 60

    self.rx = 0
    self.ry = 0

    self.children = {}

    self.wheel_enabled = false
    self.should_draw_background = true
    self.should_draw_outline = true

    self.invisible = false
    self.hidden = false

    self.hover_enabled = true
    self.hovered = false
    self.depressed = false

    self.should_validate = false
    self.should_size_to_contents = false
    self.is_scalable = true

    self.dock_padding = {0, 0, 0, 0} --left, top, right, bottom --padding is for the children
    self.dock_margin = {0, 0, 0, 0} --left, top, right, bottom  --margin is for itself 
    self.dock_type = NONE

    self.image_color = {1, 1, 1, 1}

    self.hooks = {}
end

function panel:update(dt)
    if self.tween then
        local finished = self.tween:update(dt)

        if finished then
            local callback = self.tween.on_finished
            
            if callback then
                callback()
            end

            self.tween = nil
        end
    end
end

function panel:post_init()
    local panel_theme = self.ui_manager.theme.panel

    self.background_color = panel_theme.background_color
    self.outline_color = panel_theme.outline_color

    self.line_width = panel_theme.line_width
end

function panel:set_outline_radius(rx, ry)
    self.rx, self.ry = rx, ry
end

function panel:get_outline_radius()
    return self.rx, self.ry
end

function panel:set_line_width(width)
    self.line_width = width
end

function panel:get_line_width()
    return self.line_width
end

function panel:set_alpha(alpha)
    local r, g, b = unpack(self:get_background_color())
    self:set_background_color(r, g, b, alpha)

    local r, g, b = unpack(self:get_image_color())
    self:set_image_color(r, g, b, alpha)

    local r, g, b = unpack(self:get_outline_color())
    self:set_outline_color(r, g, b, alpha)
end

function panel:get_alpha()
    return self:get_background_color()[4] 
end

function panel:set_image_color(r, g, b, a)
    self.image_color = type(r) == "table" and r or {r, g, b, a}
end

function panel:get_image_color()
    return self.image_color
end

function panel:get_background_color()
    return self.background_color
end

function panel:set_background_color(r, g, b, a)
    self.background_color = type(r) == "table" and r or {r, g, b, a}
end

function panel:get_outline_color()
    return self.outline_color
end

function panel:set_outline_color(r, g, b, a)
    self.outline_color = type(r) == "table" and r or {r, g, b, a}
end

function panel:get_draw_background()
    return self.should_draw_background
end

function panel:set_draw_background(should_draw)
    self.should_draw_background = should_draw
end

function panel:set_background_image(image)
    self.image = image
end

function panel:get_width()
    return self.w
end

function panel:set_width(w, dont_scale)
    local scale_x, scale_y = self.ui_manager:get_scale()
    local scalable = self:get_scalable()

    self.w = not dont_scale and scalable and w * scale_x or w
    self:invalidate_parent()
end

function panel:get_height()
    return self.h
end

function panel:set_height(h, dont_scale)
    local scale_x, scale_y = self.ui_manager:get_scale()
    local scalable = self:get_scalable()

    self.h = not dont_scale and scalable and h * scale_y or h
    self:invalidate_parent()
end

function panel:get_size()
    return self.w, self.h
end

function panel:set_size(w, h, dont_scale)
    local scale_x, scale_y = self.ui_manager:get_scale()
    local scalable = self:get_scalable()

    self.w = not dont_scale and scalable and w * scale_x or w
    self.h = not dont_scale and scalable and h * scale_y or h

    self:invalidate_parent()
end

function panel:get_parent()
    return self.parent
end

function panel:set_parent(parent)
    self.parent = parent
end

function panel:set_pos(x, y)
    self.x, self.y = x, y
    self:invalidate_parent()
end

function panel:get_pos()
    return self.x, self.y
end

function panel:get_screen_pos()
    local x, y = self.x, self.y
    local parent = self:get_parent()

    while parent do
        x, y = x + parent.x, y + parent.y
        parent = parent:get_parent()
    end

    return x, y
end

function panel:dock(dock_enum)
    self.dock_type = dock_enum
    self:invalidate_parent()
end

function panel:get_dock_padding()
    return self.dock_padding
end

function panel:set_dock_padding(left, top, right, bottom)
    self.dock_padding = {
        left or 0,
        top or 0,
        right or 0,
        bottom or 0
    }

    self:invalidate()
end

function panel:get_dock_margin()
    return self.dock_margin
end

function panel:set_dock_margin(left, top, right, bottom)
    self.dock_margin = {
        left or 0,
        top or 0,
        right or 0,
        bottom or 0
    }

    self:invalidate_parent()
end

function panel:get_children()
    return self.children
end

function panel:invalidate()
    self.should_validate = true
end

function panel:invalidate_parent()
    local parent = self:get_parent()

    if parent then
        parent:invalidate()
    end
end

function panel:size_to_contents()
    self.should_size_to_contents = true
end

function panel:get_draw_outline()
    return self.should_draw_outline
end

function panel:set_draw_outline(bool)
    self.should_draw_outline = bool
end

function panel:get_scroll_wheel_enabled()
    return self.wheel_enabled
end

function panel:set_scroll_wheel_enabled(enabled)
    self.wheel_enabled = enabled
end

function panel:get_hover_enabled()
    return self.hover_enabled
end

function panel:set_hover_enabled(bool)
    self.hover_enabled = bool
end

function panel:get_scalable()
    return self.is_scalable
end

function panel:set_scalable(is_scalable)
    self.is_scalable = is_scalable
end

function panel:set_z_pos(z_index) --Lower numbers are drawn first

end

function panel:hide()
    self:set_hover_enabled(false)
    self:set_visible(false)

    self.hidden = true
end

function panel:unhide()
    self:set_hover_enabled(true)
    self:set_visible(true)

    self.hidden = false
end

function panel:is_hidden()
    return not self:get_hover_enabled() and not self:get_visible()
end

function panel:get_visible()
    return not self.invisible
end

function panel:set_visible(is_visible)
    if self:get_visible() ~= is_visible then
		self:invalidate_parent()
    end
    
    self.invisible = not is_visible
end

function panel:get_image()
    return self.image
end

function panel:set_image(image)
    self.image = image
end

function panel:remove()
    self.ui_manager:remove(self)
end

function panel:remove_children()
    local children = self:get_children()

    for i = #children, 1, -1 do
        local child = 
        children[i]:remove()
    end
end

function panel:validate()
    if self.should_validate then
        local padding = self.dock_padding

        local bounds = {
            x = padding[1],
            y = padding[2],
            w = self.w - padding[3],
            h = self.h - padding[4]
        }

        for i = 1, #self.children do
            local child = self.children[i]
            local dock_type = child.dock_type
            local margin = child.dock_margin

            if child.should_center then        
                child.x = self.w / 2 - child.w / 2
                child.y = self.h / 2 - child.h / 2
 
                child.should_center = false
            end
    
            if self:get_visible() and not (dock_type == NONE or dock_type == FILL) then
                if dock_type == TOP then
                    child.x = bounds.x + margin[1]
                    child.y = bounds.y + margin[2]
                    child.w = bounds.w - bounds.x - margin[1] - margin[3]
                    
                    bounds.y = bounds.y + child.h + margin[2] + margin[4]
                elseif dock_type == RIGHT then
                    child.x = bounds.w - child.w - margin[3]
                    child.y = bounds.y + margin[2]
                    child.h = bounds.h - bounds.y - margin[2] - margin[4]
                    
                    bounds.w = bounds.w - child.w - margin[1] - margin[3]
                elseif dock_type == BOTTOM then
                    child.x = bounds.x + margin[1]
                    child.y = bounds.h - child.h - margin[4]
                    child.w = bounds.w - bounds.x - margin[1] - margin[3]
                    
                    bounds.h = bounds.h - child.h - margin[2] - margin[4]
                elseif dock_type == LEFT then
                    child.x = bounds.x + margin[1]
                    child.y = bounds.y + margin[2]
                    child.h = bounds.h - bounds.y - margin[2] - margin[4]
                    
                    bounds.x = bounds.x + child.w + margin[1] + margin[3]
                end
            end

            child:invalidate()
        end

        for i = 1, #self.children do
            local child = self.children[i]
            local dock_type = child.dock_type
            local margin = child.dock_margin
            
            if dock_type == FILL then
                child.x = bounds.x + margin[1]
                child.y = bounds.y + margin[2]
                child.w = bounds.w - bounds.x - margin[1] - margin[3]
                child.h = bounds.h - bounds.y - margin[2] - margin[4]
            
                child:invalidate()
            end
        end

        self.should_validate = false
        self:run_hooks("on_validate")
    end

    if self.should_size_to_contents then
        local new_width, new_height = 0, 0
        local x_margin, y_margin = 0, 0
        local x_padding, y_padding = self.dock_padding[3], self.dock_padding[4]
        local dock_type = self.dock_type

        local count = #self.children

        if not (count == 0) then
            for i = 1, #self.children do
                local child = self.children[i]
                local x, y = child:get_pos()
                local w, h = child:get_size()
                local margin = child:get_dock_margin()
        
                if x + w > new_width then
                    new_width = x + w
                    x_margin = margin[3]
                end
        
                if y + h > new_height then
                    new_height = y + h
                    y_margin = margin[4]
                end
            end
     
            --TODO: Make sure this isn't completely stupid and bug riddled.
            --This was a hotfix to get list_views to layout properly.
            --Problem could actually just be with sizeing to contents in child's on validate 
            --See list_layout for that

           --if dock_type ~= TOP and dock_type ~= BOTTOM and dock_type ~= FILL then
                --self.w = new_width + x_margin + x_padding
            --end

            --if dock_type ~= FILL then
                self.h = new_height + y_margin + y_padding
            --end
        end

        self.should_size_to_contents = false
    end
end

function panel:center()
    self.should_center = true
    self:invalidate_parent()
end

function panel:center_on(x, y)
    local w, h = self:get_size()
    self:set_pos(x - w / 2, y - h / 2)
end

function panel:mouse_to_local(mx, my)
    local mx, my = mx or love.mouse.getX(), my or love.mouse.getY()
    local x, y = self:get_screen_pos()

    return mx - x, my - y
end

function panel:add(ui_element, ...)
    return self.ui_manager.add(self, ui_element, ...)
end

function panel:run_hooks(hook_name, ...)
    local hooks = self.hooks[hook_name]

    if hooks then
        for name, func in pairs(hooks) do
            func(self, ...)
        end
    end
end

function panel:add_hook(hook_name, func)
    local hooks = self.hooks[hook_name]

    if not hooks then
        hooks = {}
        self.hooks[hook_name] = hooks
    end

    hooks[func] = func
end

function panel:remove_hook(hook_name, func)
    local hooks = self.hooks[hook_name]

    if hooks then
        hooks[func] = nil
    end
end

function panel:remove_hooks(hook_name)
    self.hooks[hook_name] = {}
end

function panel:scale(scale_x, scale_y)
    if self:get_scalable() then
        local padding = self:get_dock_padding()
        local margin = self:get_dock_margin()
        
        for i = 1, 3, 2 do
            padding[i] = padding[i] * scale_x
            margin[i] = margin[i] * scale_x
        end

        for i = 2, 4, 2 do
            padding[i] = padding[i] * scale_y
            margin[i] = margin[i] * scale_y
        end
        
        self.x = self.x * scale_x
        self.y = self.y * scale_y 
        self.w = self.w * scale_x
        self.h = self.h * scale_y

        for i = 1, #self.children do
            self.children[i]:scale(scale_x, scale_y)
        end
    end
end

function panel:move_to(duration, x, y, move_type, on_finished)
    self.tween = tween.new(duration, self, {x = x, y = y}, move_type)
    self.tween.on_finished = on_finished
end

function panel:get_smallest_parent_vertically()
    local parent = self:get_parent() or self
    local smallest_height = parent.h
    local smallest_parent_vertically = parent

    while parent do
        local h = parent.h
        
        if h < smallest_height then
            smallest_height = h
            smallest_parent_vertically = parent
        end

        parent = parent:get_parent()
    end

    return smallest_parent_vertically, math.max(smallest_height, 0)
end

function panel:get_smallest_parent_horizontally()
    local parent = self:get_parent() or self
    local smallest_width = parent.w
    local smallest_parent_horizontally = parent

    while parent do
        local w = parent.w
        
        if w < smallest_width then
            smallest_width = w
            smallest_parent_horizontally = parent
        end

        parent = parent:get_parent()
    end

    return smallest_parent_horizontally, math.max(smallest_width, 0)
end

function panel:draw()
    local x, y = self:get_screen_pos()

    if self.should_draw_background then
        love.graphics.setColor(self.background_color)
        love.graphics.rectangle("fill", x, y, self.w, self.h)
    end

    if self.image then
        local image = self.image
        local w, h = image:getDimensions()
        local scale_x = self.w / w
        local scale_y = self.h / h

        love.graphics.setColor(self.image_color)
        love.graphics.draw(image, x + self.w / 2, y + self.h / 2, 0, scale_x, scale_y, w / 2, h / 2)
    end
end

return panel