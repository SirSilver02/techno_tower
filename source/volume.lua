local audio = assets.audio
local default_master_volume = 0.4

--songs
audio.song1:setVolume(1)
audio.song2:setVolume(1)
audio.song3:setVolume(1)
audio.credits:setVolume(1)
audio.main_menu:setVolume(1)

--sound effects
audio.ding:setVolume(1)
audio.hover:setVolume(0.6)
audio.death:setVolume(1)

--master volume
love.audio.setVolume(default_master_volume)

local file = love.filesystem.getInfo("master_volume.txt")

if file then
    local volume = love.filesystem.read("master_volume.txt")

    if volume then
        love.audio.setVolume(tonumber(volume) or default_master_volume)
    end
end