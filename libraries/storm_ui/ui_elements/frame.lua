local panel = require((...):gsub("[^/]+$", "/panel"))

local frame = class(panel)

function frame:init()
    panel.init(self)
end

function frame:post_init()
    panel.post_init(self)

    local top_panel = self:add("panel")
    top_panel:dock(TOP)

    top_panel:add_hook("on_dragged", function(this, x, y, dx, dy)
        x, y = self.x, self.y
        self:set_pos(x + dx, y + dy)
        self:dock(NONE)
    end)

    local close_button = top_panel:add("button")
    close_button:set_width(top_panel:get_height())
    close_button:set_text("X")
    close_button:dock(RIGHT)

    close_button:add_hook("on_clicked", function(this)
        self:remove()
    end)
end

return frame