local panel = require((...):gsub("[^/]+$", "/panel"))

local list_view = class(panel)

function list_view:init()
    panel.init(self)

    self:add_hook("on_validate", function()
        local count = #self.lines

        for i = 1, count do
            local list_layout = self.lines[i]
            local panels = list_layout:get_children()
            local main_panel_w = self.scroll_panel.main_panel:get_width()

            for i = 1, #panels do
                local panel = panels[i]
                panel:set_width(main_panel_w / #panels)
            end
        end

        local top_children = self.top_panel:get_children()

        for i = 1, #top_children do
            local button = top_children[i]
            button:set_width(self.top_panel:get_width() / #top_children)
        end
    end)
end

function list_view:post_init()
    panel.post_init(self)

    self.lines = {}

    self.top_panel = self:add("panel")
    self.top_panel:dock(TOP)

    self.scroll_panel = self:add("scroll_panel")
    self.scroll_panel:dock(FILL)
end

function list_view:remove_lines() 
    for i = #self.lines, 1, -1 do
        local list_layout = self.lines[i]
        list_layout:remove()

        self.lines[i] = nil
    end
end

function list_view:add_column(name)
    local button = self.top_panel:add("button")
    button:set_text(name)
    button:set_background_color(button:get_hovered_color())
    button:dock(LEFT)
end

function list_view:add_line(...)
    local args = {...}

    local list_layout = self.scroll_panel:add("panel")
    list_layout:set_draw_outline(false)
    list_layout:dock(TOP)

    self.lines[#self.lines + 1] = list_layout

    local button_panel = list_layout:add("panel")
    button_panel:set_draw_background(false)
    button_panel:dock(FILL)

    local button = button_panel:add("button")
    button:set_draw_background(false)
    button:set_text("")
    button:dock(FILL)

    list_layout.button = button

    local label_panel = list_layout:add("panel")
    label_panel:set_draw_background(false)
    label_panel:set_hover_enabled(false)
    label_panel:dock(FILL)

    list_layout.panels = {}

    local main_panel_w = self.scroll_panel.main_panel:get_width()
    local buttons = self.top_panel:get_children()

    for i = 1, #buttons do
        local panel = label_panel:add("panel")
        panel:set_width(main_panel_w / #buttons)
        panel:set_draw_background(false)
        panel:dock(LEFT)

        local label = panel:add("label")
        label:set_text(args[i])
        label:dock(FILL)
    end

    return list_layout
end

return list_view