local panel = require((...):gsub("[^/]+$", "/panel"))

local list_layout = class(panel)

function list_layout:init()
    panel.init(self)
end

function list_layout:post_init()
    panel.post_init(self)
end

function list_layout:add(...)
    local child = panel.add(self, ...)
    child:dock(TOP)

    child:add_hook("on_validate", function()
        self:size_to_contents()
    end)

    self:invalidate_parent()

    return child
end

return list_layout