local panel = require((...):gsub("[^/]+$", "/panel"))

local menu_panel = class(panel)

function menu_panel:init()
    panel.init(self)
end

function menu_panel:post_init()
    panel.post_init(self)
end

function menu_panel:add_menu(name)
    local options_button = self:add("button")
    options_button:set_text(name)
    options_button:dock(LEFT)

    local scr_x, scr_y = options_button:get_screen_pos()

    local options_panel = self.ui_manager:add("panel")
    options_panel:set_width(200)
    options_panel:set_pos(scr_x, scr_y + options_button:get_height())
    options_panel:hide()
    
    options_button:add_hook("on_validate", function(this)
        local scr_x, scr_y = this:get_screen_pos()
        options_panel:set_pos(scr_x, scr_y + this:get_height())
    end)

    function options_panel:add_option(name, func)
        local button = self:add("button")
        button:set_text(name)
        button:dock(TOP)

        button:add_hook("on_clicked", func)

        return button
    end

    options_panel:add_hook("on_update", function(this)
        if self.ui_manager.active_child ~= options_button then
            if not this:is_hidden() then
                this:hide()
            end
        end
    end)

    options_button:add_hook("on_clicked", function(this)
        if options_panel:is_hidden() then
            options_panel:unhide()
        else
            options_panel:hide()
        end
    end)

    return options_panel
end

return menu_panel