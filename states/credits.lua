local state = {}

function state:on_first_enter()
    local back_to_main_menu_delay = 5

    self.timer = timer.new()

    self.ui = storm_ui.new()
    self.ui:install(self)
    self.ui:set_draw_background(false)

        self.credits_panel = self.ui:add("panel")
        self.credits_panel:set_width(400)
        self.credits_panel:set_draw_outline(false)
        self.credits_panel:set_draw_background(false)

            local firehawk_job_label = self.credits_panel:add("label")
            firehawk_job_label:set_text("Music")
            firehawk_job_label:set_align(5)
            firehawk_job_label:set_font(assets.fonts.techno3[38])
            firehawk_job_label:set_text_color(math.divide_by_255({121, 146, 247}))
            firehawk_job_label:dock(TOP)

            local firehawk_label = self.credits_panel:add("label")
            firehawk_label:set_text("Firehawk")
            firehawk_label:set_align(5)
            firehawk_label:set_font(assets.fonts.techno3[24])
            firehawk_label:dock(TOP)

            local silver_job_label = self.credits_panel:add("label")
            silver_job_label:set_text("Programming")
            silver_job_label:set_align(5)
            silver_job_label:set_font(assets.fonts.techno3[34])
            silver_job_label:set_text_color(math.divide_by_255({211, 47, 45}))

            silver_job_label:dock(TOP)

            local silver_label = self.credits_panel:add("label")
            silver_label:set_text("Sir_Silver")
            silver_label:set_align(5)
            silver_label:set_font(assets.fonts.techno3[24])
            silver_label:dock(TOP)

        local height = 0

        for _, child in pairs(self.credits_panel:get_children()) do
            height = height + child:get_height()
        end

        self.credits_panel:set_height(height)
end

function state:on_enter()
    self.time_passed = 0

    local delay = 9

    self.credits_timer = self.timer:after(delay, function()
        self.credits_panel:move_to(assets.audio.credits:getDuration() - delay, love.graphics.getWidth() / 2 - self.credits_panel:get_width() / 2, -self.credits_panel:get_height(), "linear", function()
            states.set_current_state("main_menu")
        end)
    end)

    self.credits_panel:set_pos(love.graphics.getWidth() / 2 - self.credits_panel:get_width() / 2, love.graphics.getHeight())
    assets.audio.credits:play()
end

function state:update(dt)
    self.timer:update(dt)

    self.time_passed = self.time_passed + dt
end

function state:on_state_changed()
    assets.audio.credits:stop()

    self.timer:cancel(self.credits_timer)
    self.credits_panel.tween = nil
end

function state:mousepressed()
    if self.time_passed > 2 then
        states.set_current_state("main_menu")
    end
end

function state:keypressed(key)
    if self.time_passed > 2 then
        if key == "space" or key == "escape" then
            states.set_current_state("main_menu")
        end
    end
end

return state