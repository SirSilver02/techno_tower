local music_manager = require("source.music_manager")
local world         = require("source.world")

local function format_time(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00:00"
    else
        local hours = string.format("%02.f", math.floor(seconds / 3600))
        local mins  = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
        local secs  = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))
        local mili  --todo

        return hours..":"..mins..":"..secs
    end
end

local effect = moonshine(moonshine.effects.chromasep)
local radius = {0}
local increase_radius = true
local angle = 0
local bool = true
local max_radius = 10
local radius_growth = 0  --start it at 0, tween ti to 0.1, then tween it back to 0, and make radius 0 when it gets radius_growth is 0
local shake_magnitude = 2

local state = {}

function state:on_first_enter()
    event.add("change_level", self)
    event.add("on_player_death", self)

    self.camera = camera.new()

    self.transition_canvas = love.graphics.newCanvas(love.graphics.getWidth() * 2, love.graphics.getHeight())

    love.graphics.setCanvas(self.transition_canvas)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, self.transition_canvas:getDimensions())
    love.graphics.setCanvas()

    self.ui = storm_ui.new()
    self.ui:set_draw_background(false)
    self.ui:install(self)
    self.ui:uninstall_event("draw")
    self.ui:uninstall_event("update")

        self.timer_label = self.ui:add("label")
        self.timer_label:set_dropshadow(true)
        self.timer_label.paused_color = math.divide_by_255({255, 100, 100})
        self.timer_label.unpaused_color =  self.timer_label:get_text_color()
        self.timer_label:set_font(assets.fonts.techno3[40])
        self.timer_label:set_align(5)
        self.timer_label:set_dock_margin(0, 0, 0, 60)
        self.timer_label:dock(TOP)

        self.timer_label:add_hook("on_update", function(this, dt)
            if not self.time_paused then
                self.time_passed = self.time_passed + dt
            end

            self.timer_label:set_text(format_time(self.time_passed))
        end)    

    self.message_label = self.ui:add("label")
    self.message_label:set_dropshadow(true)
    self.message_label:set_text("")
    self.message_label:set_align(5)
    self.message_label:set_font(assets.fonts.techno3[46])
    self.message_label:dock(TOP)

    --master volume controller
    self.speaker_panel = self.ui:add("panel")
    self.speaker_panel:set_draw_background(false)
    self.speaker_panel:set_draw_outline(false)
    self.speaker_panel:set_size(240, 40)
    self.speaker_panel:set_pos(love.graphics.getWidth() - 40, love.graphics.getHeight() - 40)

            self.speaker_icon_panel = self.speaker_panel:add("panel")
            self.speaker_icon_panel:set_image(assets.graphics.speaker_mid)
            self.speaker_icon_panel:set_draw_background(false)
            self.speaker_icon_panel:set_draw_outline(false)
            self.speaker_icon_panel:set_width(self.speaker_panel:get_height())
            self.speaker_icon_panel:dock(LEFT)

            self.speaker_icon_panel:add_hook("on_update", function(this)
                if not self.speaker_panel.tween and not self.speaker_panel.extended and this.hovered then
                    self.speaker_panel:move_to(0.6, love.graphics.getWidth() - self.speaker_panel:get_width() - 10, love.graphics.getHeight() - 40, "inOutBack", function()
                        self.speaker_panel.tween = nil
                        self.speaker_panel.extended = true
                    end)
                end
            end)

        self.master_volume_slider = self.speaker_panel:add("slider")
        self.master_volume_slider:set_min_max(0, 1)
        self.master_volume_slider:set_percent(love.audio.getVolume())
        self.master_volume_slider:set_width(200)
        self.master_volume_slider:dock(LEFT)

        self.master_volume_slider:add_hook("on_update", function(this, dt)
            if not this.depressed and not this.hovered and self.normal_speed then
                if not self.speaker_panel.tween and self.speaker_panel.extended then
                    self.speaker_panel:move_to(0.5, love.graphics.getWidth() - 40, love.graphics.getHeight() - 40, "inOutBack", function()
                        self.speaker_panel.tween = nil
                        self.speaker_panel.extended = false
                    end)
                end
            end
        end)

        function self.master_volume_slider.on_value_changed(this, value)
            love.audio.setVolume(value)

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
end

function state:on_enter()
    self.timer = timer.new()
    self.pitch_timer = timer.new()

    self.normal_speed = true
    self.dt_multiplier = 1
    self.time_passed = 0
    self.time_paused = true
    self.times_died = 0
    self.levels_changed = 0

    self.transition_color = {0, 0, 0, 1}
    self.transition_rectangle = {x = -love.graphics.getWidth() * 2}

    self.worlds = {}
    self:load_maps()
    self:change_level("one")

    self.music_manager = music_manager.new()
    self.music_manager:add_song(assets.audio.song3)
    self.music_manager:add_song(assets.audio.song1)
    self.music_manager:add_song(assets.audio.song2)
    self.music_manager:play_next_song()

    self.master_volume_slider:set_percent(love.audio.getVolume())
end

function state:keypressed(key)
    if key == "escape" then
        local dt_multiplier

        self.normal_speed = not self.normal_speed

        if self.normal_speed then
            dt_multiplier = 1

            if self.escape_panel then
                self.escape_panel:remove()
                self.escape_panel = nil
            end

            self.message_label:unhide()

            if self.speaker_icon_panel.extended then
                self.speaker_panel:move_to(0.5, love.graphics.getWidth() - 40, love.graphics.getHeight() - 40, "inOutBack", function()
                    self.speaker_panel.tween = nil
                    self.speaker_panel.extended = false
                end)
            end
  
            radius_growth = 0

            if self.chroma_tween then
                self.pitch_timer:cancel(self.chroma_tween)
            end

            self.chroma_tween = self.pitch_timer:tween(1, radius, {0})
        else
            dt_multiplier = 0.8

            radius_growth = 0

            if self.chroma_tween then
                self.pitch_timer:cancel(self.chroma_tween)
            end

            self.chroma_tween = self.pitch_timer:tween(1, radius, {0}, "linear", function()
                radius_growth = 0.1
            end)

            self.message_label:hide()

            if not self.speaker_icon_panel.extended then
                self.speaker_panel:move_to(0.5, love.graphics.getWidth() - self.speaker_panel:get_width() - 10, love.graphics.getHeight() - 40, "inOutBack", function()
                    self.speaker_panel.tween = nil
                    self.speaker_panel.extended = true
                end)
            end

            self.escape_panel = self.ui:add("panel")
            self.escape_panel:set_size(400, 300)
            self.escape_panel:set_draw_background(false)
            self.escape_panel:set_draw_outline(false)
            self.escape_panel:center()

                local escape_label = self.escape_panel:add("label")
                escape_label:set_dropshadow(true)
                escape_label:set_text("Are you trying to leave? =(")
                escape_label:set_font(assets.fonts.techno3[46])
                escape_label:set_align(5)
                escape_label:dock(FILL)

                local bottom_panel = self.escape_panel:add("panel")
                bottom_panel:set_draw_background(false)
                bottom_panel:set_draw_outline(false)
                bottom_panel:dock(BOTTOM)

                    local stay_button = bottom_panel:add("button")
                    stay_button:set_dropshadow(true)
                    stay_button:set_text("I'll stay.")
                    stay_button:set_font(assets.fonts.techno3[24])
                    stay_button:set_text_color(math.divide_by_255({255, 105, 180}))
                    stay_button:set_draw_background(false)
                    stay_button:set_draw_outline(false)
                    stay_button:set_width(200)
                    stay_button:dock(LEFT)

                    stay_button:add_hook("on_hovered", function(this)
                        assets.audio.hover:clone():play()
                    end)

                    if math.random(10) == 10 then
                        escape_label:set_text("Are you trying to leave? >:)")
                        self.mouse_target = {love.mouse.getPosition()}

                        self.timer:after(0.2, function()  --because my docking is bad
                            if self.mouse_tween then
                                self.pitch_timer:cancel(self.mouse_tween)
                                self.mouse_tween = nil
                            end

                            local x, y = stay_button:get_screen_pos()
                            x = x + stay_button:get_width() / 2
                            y = y + stay_button:get_height() / 2

                            self.mouse_tween = self.pitch_timer:tween(0.4, self.mouse_target, {x, y}, "in-out-back", function()
                                if self.mouse_tween then 
                                    self.pitch_timer:cancel(self.mouse_tween)
                                    self.mouse_tween = nil
                                end
                            end)
                        end)
                    end

                    stay_button:add_hook("on_clicked", function(this)
                        self:keypressed("escape")  --this is kinda ghetto
                    end)

                    local main_menu_button = bottom_panel:add("button")
                    main_menu_button:set_dropshadow(true)
                    main_menu_button:set_text("Get me out!")
                    main_menu_button:set_font(assets.fonts.techno3[24])
                    main_menu_button:set_draw_background(false)
                    main_menu_button:set_draw_outline(false)
                    main_menu_button:dock(FILL)

                    main_menu_button:add_hook("on_hovered", function(this)
                        assets.audio.hover:clone():play()
                    end)

                    main_menu_button:add_hook("on_clicked", function(this)
                        if self.transition_tween then
                            return
                        end

                        if self.pitch_tween then
                            self.pitch_timer:cancel(self.pitch_tween)
                            self.pitch_tween = nil
                        end

                        self.pitch_timer:tween(1, self, {dt_multiplier = 0.1})

                        self.transition_tween = self.pitch_timer:tween(1, self.transition_rectangle, {x = 0}, "linear", function()
                            self.pitch_timer:after(0.4, function()
                                self.transition_tween = nil

                                self:keypressed("escape")  --this is kinda ghetto
                                states.set_current_state("main_menu")
                            end)
                        end)
                    end)           
        end

        if self.pitch_tween then
            self.pitch_timer:cancel(self.pitch_tween)
        end

        self.pitch_tween = self.pitch_timer:tween(1, self, {dt_multiplier = dt_multiplier})
    end
end

function state:update(dt)
    self.pitch_timer:update(dt)

    dt = dt * self.dt_multiplier

    self.timer:update(dt)

    if self.mouse_tween then
        local x, y = self.mouse_target[1], self.mouse_target[2]
        love.mouse.setPosition(x, y)
    end

    if self.local_player then
        local mouse_x, mouse_y = love.mouse.getPosition()
        local player_x, player_y = self.local_player:get_center()

        self.local_player:set_angle(math.atan2(mouse_y - player_y, mouse_y - player_x))
    end

    if self.active_world then
        self.active_world:update(dt)
    end

    self:update_chromastep()
    self.music_manager:update(dt)
    self.music_manager:set_pitch(self.dt_multiplier)
    self.ui:update(dt)

    local player = self.local_player

    if love.keyboard.isDown("w", "up") then
        if player and self.normal_speed then
            local speed = player.speed

            if love.keyboard.isDown("a", "left") or love.keyboard.isDown("d", "right") then
                speed = speed * math.sin(math.pi / 4)
            end

            player:apply_force(0, -speed)
        end
    end

    if love.keyboard.isDown("s", "down") then
        if player and self.normal_speed then
            local speed = player.speed

            if love.keyboard.isDown("a", "left") or love.keyboard.isDown("d", "right") then
                speed = speed * math.sin(math.pi / 4)
            end

            player:apply_force(0, speed)
        end
    end

    if love.keyboard.isDown("a", "left") then
        if player and self.normal_speed then
            local speed = player.speed

            if love.keyboard.isDown("w", "up") or love.keyboard.isDown("s", "down") then
                speed = speed * math.sin(math.pi / 4)
            end

            player:apply_force(-speed, 0)
        end
    end

    if love.keyboard.isDown("d", "right") then
        if player and self.normal_speed then
            local speed = player.speed

            if love.keyboard.isDown("w", "up") or love.keyboard.isDown("s", "down") then
                speed = speed * math.sin(math.pi / 4)
            end

            player:apply_force(speed, 0)
        end
    end
end

function state:update_chromastep()
    angle = angle + math.rad(1)

    if increase_radius then
        radius[1] = radius[1] + radius_growth

        if radius[1] > max_radius then
            increase_radius = false
        end
    else
        radius[1] = radius[1] - radius_growth

        if radius[1] < -max_radius then
            increase_radius = true
        end
    end

    effect.chromasep.angle = angle
    effect.chromasep.radius = radius[1]
end

function state:draw()
    self.camera:zoomTo(love.graphics.getWidth() / 1024, love.graphics.getHeight() / 768)

    effect(function()
        if self.active_world then
            self.camera:attach()
                self.active_world:draw()
            self.camera:detach()
        end

        self.ui:draw()
    end)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(love.timer.getFPS())

    love.graphics.setColor(self.transition_color)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())

    local rectangle = self.transition_rectangle

    love.graphics.setShader(assets.shaders.gradient)
        love.graphics.setColor(0, 0, 0)
        love.graphics.draw(self.transition_canvas, rectangle.x, 0)
    love.graphics.setShader()
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

function state:load_maps()
    for name, map in pairs(assets.maps) do
        local map2 = deepcopy(map)

        local world = world.new(map2)
        self.worlds[name] = world

        local entities = world.entity_manager.map.layers.entities.objects

        for _, entity_data in pairs(entities) do
            local type = entity_data.type

            if type and world.entity_manager.types[type] and type ~= "" then  --this is tiled's fault
                local center_x, center_y = tonumber(entity_data.x + entity_data.width / 2), tonumber(entity_data.y + entity_data.height / 2)
                local entity = world.entity_manager.types[type].new()
                entity.type = type

                for k, v in pairs(entity_data.properties) do
                    if k == "path" then
                        local path = {{center_x, center_y}}

                        for id in v:gmatch("%S+") do
                            for _, entity_data in pairs(entities) do
                                if tonumber(id) == entity_data.id then
                                    path[#path + 1] = {tonumber(entity_data.x + entity_data.width / 2), tonumber(entity_data.y + entity_data.height / 2)}
                                end
                            end
                        end

                        entity.path = path
                    else
                        entity[k] = v
                    end
                end

                if type == "wall" or type == "spawn" or type == "exit" then  --me stupid
                    entity.size = vector.new(entity_data.width, entity_data.height)
                end

                world.entity_manager:add(entity)
                entity:set_center(center_x, center_y)
            end
        end
    end
end

function state:resize(w, h)
    if self.active_world then
        self.active_world:resize(w, h)
    end
end

function state:on_player_death()
    --let map keep track of deaths on per map basis
    --after dying too many times on a map, the mop might give you some insight advice...

    local orig_x, orig_y = self.camera:position()

    self.timer:during(0.2, function()
        radius[1] = math.random(1,2) * shake_magnitude
        self.camera:lookAt(orig_x + math.random(-1, 1) * shake_magnitude, orig_y + math.random(-1, 1) * shake_magnitude)
    end, function() 
        radius[1] = 0
        self.camera:lookAt(orig_x, orig_y)
    end)

    assets.audio.death:clone():play()

    self.times_died = self.times_died + 1

    if self.times_died == 1 then
        local message = "And try not to die."

        if self.levels_changed > 3 then
            message = "It took you that long to die, huh?"
        end

        self.message_label:set_text(message)

        self.timer:after(5, function()
            if self.message_label:get_text() == message then
                self.message_label:set_text("")
            end
        end)
    end

    local canvas2 = self.active_world.entity_manager.decals
    local canvas1 = love.graphics.getCanvas()
    local r, g, b, a = love.graphics.getColor()
    local blood = {math.random(200, 255), math.random(0, 50), math.random(0, 10)}

    for k, v in pairs(blood) do
        blood[k] = v / 255
    end

    love.graphics.setCanvas(canvas2)
        love.graphics.setColor(blood)
            local x, y = self.local_player:get_center()
            love.graphics.circle("fill", x, y, 32)
        love.graphics.setColor(r, g, b, a)
    love.graphics.setCanvas(canvas1)

    self:move_player_to_spawn()
end

function state:move_player_to_spawn()
    for entity in pairs(self.active_world.entity_manager.entities) do
        if entity.type == "spawn" then
            self.local_player:set_center(entity:get_center())
            break
        end
    end
end

function state:change_level(map_name)
    self:resize(love.graphics.getDimensions())

    self.levels_changed = self.levels_changed + 1
    self.time_paused = true
    self.timer_label:set_text_color(self.timer_label.paused_color)
    self.message_label:set_text("")

    if self.local_player then
        self.local_player:remove()
        self.local_player = nil
    end

    self.timer:tween(0.5, self.transition_color, {0, 0, 0, 1}, "linear", function()
        self.active_world = assert(self.worlds[map_name], string.format("'%s' is not a valid map name.", map_name))

        self.timer:tween(0.5, self.transition_color, {0, 0, 0, 0}, "linear", function()
            assets.audio.ding:play()

            self.time_paused = false
            self.timer_label:set_text_color(self.timer_label.unpaused_color)

            self.local_player = self.active_world.entity_manager:add("player")
            self:move_player_to_spawn()

            local properties = assets.maps[map_name].properties
            local on_enter = properties.on_enter

            if on_enter then
                assert(loadstring(on_enter), string.format("on_enter failed in map %s", map_name))()
            end
        end)
    end)
end

function state:on_state_changed()
    self.music_manager:stop()

    if self.escape_panel then
        self.escape_panel:remove()
        self.escape_panel = nil
    end

    radius[1] = 0
    radius_growth = 0
end

return state