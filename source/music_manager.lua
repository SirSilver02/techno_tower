local music_manager = class()

function music_manager:init()
    self.songs              = {}
    self.current_song_index = 0
    self.paused             = false
    self.pitch              = 1
end

function music_manager:update(dt)
    if self.paused then
        return
    end

    local song = self.songs[self.current_song_index]

    if song and not song:isPlaying() then
        self:play_next_song()
    end
end

function music_manager:add_song(song)
    self.songs[#self.songs + 1] = song
end

function music_manager:play_next_song()
    for _, song in pairs(self.songs) do
        song:stop()
    end

    self.current_song_index = self.current_song_index + 1

    if self.current_song_index > #self.songs then
        self.current_song_index = 1
    end

    self.songs[self.current_song_index]:play()
    self.songs[self.current_song_index]:setPitch(self.pitch)
end

function music_manager:pause()
    local song = self.songs[self.current_song_index]

    if song then
        song:pause()
    end
end

function music_manager:stop()
    local song = self.songs[self.current_song_index]

    if song then
        song:stop()
        self.paused = true
    end
end

function music_manager:unpause()
    local song = self.songs[self.current_song_index]

    if song then
        song:play()
        song:setPitch(self.pitch)
    end
end

function music_manager:set_pitch(pitch)
    if type(pitch) ~= "number" or pitch < 0 then
        return
    end

    self.pitch = pitch

    local song = self.songs[self.current_song_index]

    if song then
        song:setPitch(self.pitch)
    end
end

return music_manager