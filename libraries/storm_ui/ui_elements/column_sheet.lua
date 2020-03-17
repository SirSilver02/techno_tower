local panel = require((...):gsub("[^/]+$", "/panel"))
local button = require((...):gsub("[^/]+$", "/button"))

local column_sheet = class(panel)

function column_sheet:init()
    panel.init(self)
end

function column_sheet:post_init()
    panel.post_init(self)

    self.left_panel = self:add("panel")
    self.left_panel:dock(LEFT)

    self.right_panel = self:add("panel")
    self.right_panel:dock(FILL)
end

function column_sheet:add_sheet(button_name)
    local sheet = self.right_panel:add("panel")
    sheet:dock(FILL)

    function sheet:get_button()
        return self.button
    end

    local button = self.left_panel:add("button")
    button:set_text(button_name)
    button:dock(TOP)

    sheet.button = button
    button.sheet = sheet

    function button:get_sheet()
        return self.sheet
    end

    button:add_hook("on_clicked", function()
        self:set_active_sheet(sheet)
    end)

    return sheet
end

function column_sheet:set_active_sheet(sheet)
    local children = self.right_panel.children

    for i = 1, #children do
        local child = children[i]

        if child == sheet then
            table.remove(children, i)
            table.insert(children, sheet)
            break
        end
    end
end

function column_sheet:get_left_panel()
    return self.left_panel
end

function column_sheet:get_right_panel()
    return self.right_panel
end

return column_sheet