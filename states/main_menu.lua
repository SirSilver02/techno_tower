local effect = moonshine(moonshine.effects.chromasep)
local radius = 0
local increase_radius = true
local angle = 0
local bool = true
local max_radius = 5
local radius_growth = 0.5

local music_manager = require("source.music_manager")

local state = {}

function state:on_first_enter()
    self.timer = timer.new()

    self.transition_canvas = love.graphics.newCanvas(love.graphics.getWidth() * 2, love.graphics.getHeight())

    love.graphics.setCanvas(self.transition_canvas)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, self.transition_canvas:getDimensions())
    love.graphics.setCanvas()

    self.master_volume = {love.audio.getVolume()}

    self.music_manager = music_manager.new()
    self.music_manager:add_song(assets.audio.main_menu)
    self.music_manager:play_next_song()

    self.ui = storm_ui.new()
    self.ui:set_draw_background(false)
    self.ui:install(self)
    self.ui:uninstall_event("draw")

        local title_label = self.ui:add("label")
        title_label:set_font(assets.fonts.techno[64])
        title_label:set_align(5)
        title_label:set_text("Techno Tower")
        title_label:set_height(300)
        title_label:dock(TOP)

        local old_draw = title_label.draw

        function title_label.draw(this)
            love.graphics.setScissor()
            
            effect(function()
                old_draw(this)

                if self.speaker_icon_panel then
                    self.speaker_icon_panel:draw()
                end

                if self.speaker_label and self.speaker_label:get_visible() then
                    self.speaker_label:draw()
                end

                if self.highscore_label and self.highscore_label:get_visible() then
                    self.highscore_label:draw()
                end
            end)
        end

        self.highscore_label = self.ui:add("label")
        self.highscore_label:set_font(assets.fonts.techno3[32])
        self.highscore_label:set_size(200, 200)
        self.highscore_label:set_align(4)
        self.highscore_label:set_pos(783, 176)
        self.highscore_label:set_text("Best Time")
        self.highscore_label.rotation = math.rad(7)
        self.highscore_label:set_visible(false)

        local speaker_label_messages = {
            "*tap dances towards you*",
            "High friction beats!",
            "#1 most recommended by doctors, I think.",
            "up up down down left right left right",
            "*tap dances towards your desk*",
            "*walks audibly in your direction*",
            "*wiggles rhythmically*",
            "*teleports behind you*"
        }

        self.speaker_label_messages = {}

        function self.speaker_label_messages:shuffle()
            local random

            repeat 
                local random_message = speaker_label_messages[math.random(#speaker_label_messages)]
                local exists = false

                for i = 1, #self do
                    if self[i] == random_message then
                        exists = true
                        break
                    end
                end

                if not exists then
                    self[#self + 1] = random_message
                end

            until #self == #speaker_label_messages
        end

        self.speaker_label_messages:shuffle()

        self.speaker_panel = self.ui:add("panel")
        self.speaker_panel:set_draw_background(false)
        self.speaker_panel:set_draw_outline(false)
        self.speaker_panel:set_size(800, 40)
        self.speaker_panel:set_pos(80, 200)

                self.speaker_icon_panel = self.speaker_panel:add("panel")
                self.speaker_icon_panel:set_image(assets.graphics.speaker_mid)
                self.speaker_icon_panel:set_draw_background(false)
                self.speaker_icon_panel:set_draw_outline(false)
                self.speaker_icon_panel:set_width(self.speaker_panel:get_height())
                self.speaker_icon_panel:dock(LEFT)

                self.speaker_label = self.speaker_panel:add("label")
                self.speaker_label:set_font(assets.fonts.techno3[24])
                self.speaker_label:set_align(4)
                self.speaker_label:dock(FILL)

                self.speaker_label:add_hook("on_update", function(this, dt)
                    if this.hovered then
                        this:hide()
                        this:set_visible(false)
                        self.master_volume_slider:set_visible(true)
                    end
                end)

            self.master_volume_slider = self.speaker_panel:add("slider")
            self.master_volume_slider:set_min_max(0, 1)
            self.master_volume_slider:set_percent(love.audio.getVolume())
            self.master_volume_slider:set_size(200, self.speaker_panel:get_height())

            self.master_volume_slider:add_hook("on_validate", function(this)
                this:set_pos(self.speaker_label:get_pos())
            end)

            self.master_volume_slider:add_hook("on_update", function(this, mx, my, button)
                if not this.hovered and not this.depressed then
                    self.speaker_label:unhide()
                    self.master_volume_slider:set_visible(false)
                end

                this:set_percent(self.master_volume[1])
            end)

            function self.master_volume_slider.on_value_changed(this, value)
                love.audio.setVolume(value)
                self.master_volume[1] = value

                if value <= 0 then
                    self.speaker_icon_panel:set_image(assets.graphics.speaker_off)
                elseif value <= 0.33 then
                    self.speaker_icon_panel:set_image(assets.graphics.speaker_low)
                elseif value <= 0.66 then
                    self.speaker_icon_panel:set_image(assets.graphics.speaker_mid)
                else
                    self.speaker_icon_panel:set_image(assets.graphics.speaker_full)
                end
            end
            
            local function change_message()
                local message = self.speaker_label_messages[#self.speaker_label_messages]
                self.speaker_label_messages[#self.speaker_label_messages] = nil

                if #self.speaker_label_messages == 0 then
                    self.speaker_label_messages:shuffle()
                end

                self.speaker_label:set_text(message)
            end

            change_message()

            local rotation = {0}

            self.speaker_label:add_hook("on_update", function(this, dt)
                this.rotation = rotation[1]
            end)

            local func

            func = function()
                self.timer:tween(0.41, rotation, {math.rad(0.5)}, "linear", function()
                    self.timer:tween(0.41, rotation, {math.rad(-0.5)}, "linear", function()
                        func()
                    end)
                end)
            end

            func()

            self.timer:every(10, function()
                change_message()
            end)

        local bottom_panel = self.ui:add("panel")
        bottom_panel:set_draw_outline(false)
        bottom_panel:set_draw_background(false)
        bottom_panel:dock(FILL)

            local button_panel = bottom_panel:add("panel")
            button_panel:set_size(200, 300)
            button_panel:set_draw_outline(false)
            button_panel:set_draw_background(false)
            button_panel:center()

                local bottom_padding = 10

                self.play_button = button_panel:add("button")
                self.play_button:set_text("Play")
                self.play_button:set_font(assets.fonts.techno3[46])
                self.play_button:set_draw_outline(false)
                self.play_button:set_draw_background(false)
                self.play_button:set_dock_margin(0, 0, 0, bottom_padding)
                self.play_button:dock(TOP)

                self.play_button:add_hook("on_clicked", function(this)
                    if self.master_volume_tween then
                        return
                    end

                    local current_volume = love.audio.getVolume()

                    self.master_volume_tween = self.timer:tween(1, self.master_volume, {0}, "linear", function()
                        love.audio.setVolume(current_volume)
                        self.master_volume[1] = current_volume

                        self.master_volume_tween = nil

                        states.set_current_state("game")
                    end)

                    self.timer:tween(1, self.transition_rectangle, {x = 0})
                end)

                self.play_button:add_hook("on_hovered", function(this)
                    assets.audio.hover:clone():play()
                end)

                self.credits_button = button_panel:add("button")
                self.credits_button:set_text("Credits")
                self.credits_button:set_font(assets.fonts.techno3[46])
                self.credits_button:set_draw_outline(false)
                self.credits_button:set_draw_background(false)
                self.credits_button:set_dock_margin(0, 0, 0, bottom_padding)
                self.credits_button:dock(TOP)

                self.credits_button:add_hook("on_clicked", function(this)
                    if self.master_volume_tween then
                        return
                    end

                    local current_volume = love.audio.getVolume()
    
                    self.master_volume_tween = self.timer:tween(1, self.master_volume, {0}, "linear", function()
                        love.audio.setVolume(current_volume)
                        self.master_volume[1] = current_volume

                        self.master_volume_tween = nil

                        states.set_current_state("credits")
                    end)

                    self.timer:tween(1, self.transition_rectangle, {x = 0})
                end)

                self.credits_button:add_hook("on_hovered", function(this)
                    assets.audio.hover:clone():play()
                end)

                self.exit_button = button_panel:add("button")
                self.exit_button:set_text("Exit")
                self.exit_button:set_font(assets.fonts.techno3[46])
                self.exit_button:set_draw_outline(false)
                self.exit_button:set_draw_background(false)
                self.exit_button:dock(TOP)

                self.exit_button:add_hook("on_hovered", function(this)
                    assets.audio.hover:clone():play()
                end)

                self.exit_button:add_hook("on_clicked", function(this)
                    if self.fullscreen_panel then
                        self.fullscreen_panel:remove()
                        self.fullscreen_panel = nil
                    end

                    if self.can_quit then
                        return 
                    end

                    self.fullscreen_panel = self.ui:add("panel")
                    self.fullscreen_panel:set_draw_outline(false)
                    self.fullscreen_panel:set_background_color(0, 0, 0)
                    self.fullscreen_panel:set_size(love.graphics.getDimensions())

                    self.fullscreen_panel:add_hook("on_mousepressed", function(this, x, y, button)
                        this:remove()
                    end)

                    self.guilt_panel = self.fullscreen_panel:add("panel")
                    self.guilt_panel:set_size(400, 300)
                    self.guilt_panel:set_draw_background(false)
                    self.guilt_panel:set_draw_outline(false)
                    self.guilt_panel:center()

                        local guilt_label = self.guilt_panel:add("label")
                        guilt_label:set_text("Please don't go =(")
                        guilt_label:set_font(assets.fonts.techno3[40])
                        guilt_label:set_align(5)
                        guilt_label:dock(FILL)
                        
                        local bottom_panel = self.guilt_panel:add("panel")
                        bottom_panel:set_draw_background(false)
                        bottom_panel:set_draw_outline(false)
                        bottom_panel:dock(BOTTOM)

                            local stay_button = bottom_panel:add("button")
                            stay_button:set_text("Okay, I'll stay!")
                            stay_button:set_font(assets.fonts.techno3[24])
                            stay_button:set_text_color(math.divide_by_255({255, 105, 180}))
                            stay_button:set_width(200)
                            stay_button:set_draw_background(false)
                            stay_button:set_draw_outline(false)
                            stay_button:dock(LEFT)

                            stay_button:add_hook("on_clicked", function(this)
                                self.fullscreen_panel:remove()
                            end)

                            stay_button:add_hook("on_hovered", function(this)
                                assets.audio.hover:clone():play()
                            end)

                            local quit_button = bottom_panel:add("button")
                            quit_button:set_text("Goodbye.")
                            quit_button:set_font(assets.fonts.techno3[24])
                            quit_button:set_draw_background(false)
                            quit_button:set_draw_outline(false)
                            quit_button:dock(FILL)

                            quit_button:add_hook("on_hovered", function(this)
                                assets.audio.hover:clone():play()
                            end)

                            quit_button:add_hook("on_clicked", function(this)
                                self.guilt_panel:remove()

                                local goodbye_label = self.fullscreen_panel:add("label")
                                goodbye_label:set_text("I-I'll miss you! =(")
                                goodbye_label:set_font(assets.fonts.techno3[90])
                                goodbye_label:set_align(5)
                                goodbye_label:dock(FILL)

                                self.fullscreen_panel:remove_hooks("on_mousepressed")
                                self.can_quit = true

                                love.filesystem.write("master_volume.txt", love.audio.getVolume())

                                if self.master_volume_tween then
                                    self.timer:cancel(self.master_volume_tween)
                                end

                                self.master_volume_tween = self.timer:tween(2, self.master_volume, {0})

                                self.timer:after(2, function()
                                    love.event.quit()
                                end)
                            end)
                end)
end

local current_key = 1

local konami = {
    "up",
    "up",
    "down",
    "down",
    "left",
    "right",
    "left",
    "right"
}

local konami_check = function(key)
    if key == konami[current_key] then
        current_key = current_key + 1

        if current_key > #konami then
            current_key = 1
            return true
        end
    else
        if konami[current_key - 1] and konami[current_key -1] == key then

        else
            if key == konami[1] then
                current_key = 2
            else
                current_key = 1
            end
        end
    end

    return false
end

function state:keypressed(key)
    if konami_check(key) then
        if self.pitch_tween then
            self.timer:cancel(self.pitch_tween)
        else
            self.slowmo = not self.slowmo
        end

        self.pitch_tween = self.timer:tween(1, self.pitch, {self.slowmo and 0.8 or 1}, "linear", function()
            self.pitch_tween = nil
        end)
    end

    if key == "escape" then
        if not self.can_quit and not self.master_volume_tween then
            if self.fullscreen_panel then
                self.fullscreen_panel:remove()
                self.fullscreen_panel = nil
            else
                self.exit_button:run_hooks("on_clicked")
            end
        end
    end
end

function state:draw()
    love.graphics.setColor(1, 1, 1)
    self.ui:draw()

    love.graphics.setColor(self.transition_color)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())

    local rectangle = self.transition_rectangle

    love.graphics.setShader(assets.shaders.gradient)
        love.graphics.setColor(0, 0, 0)
        love.graphics.draw(self.transition_canvas, rectangle.x, 0)
    love.graphics.setShader()
end

function state:on_enter()
    self.pitch = {1}
    self.slowmo = false
    current_key = 1

    self.transition_color = {0, 0, 0, 1}
    self.transition_rectangle = {x = -love.graphics.getWidth() * 2}

    self.timer:tween(0.5, self.transition_color, {0, 0, 0, 0})

    local volume = love.audio.getVolume()

    self.master_volume = {0}
    love.audio.setVolume(0)

    self.master_volume_tween = self.timer:tween(1, self.master_volume, {volume}, "linear", function()
        self.master_volume_tween = nil
    end)

    self.master_volume_slider:set_percent(love.audio.getVolume())
    self.highscore_label:set_visible(false)

    local score, formatted_score = highscore.read()

    if formatted_score then
        self.highscore_label:set_visible(true)
        self.highscore_label:set_text("Best Time\n" .. formatted_score)
    end

    self.music_manager:play_next_song()
end

function state:update(dt)
    self.music_manager:update(dt)
    self.music_manager:set_pitch(self.pitch[1])
    self.timer:update(dt)

    angle = angle + math.rad(1)

    if increase_radius then
        radius = radius + radius_growth

        if radius > max_radius then
            increase_radius = false
        end
    else
        radius = radius - radius_growth

        if radius < -max_radius then
            increase_radius = true
        end
    end

    effect.chromasep.angle = angle
    effect.chromasep.radius = radius
end

function state:on_state_changed()
    self.music_manager:pause()
end

return state