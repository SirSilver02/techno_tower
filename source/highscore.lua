--if a player beats the game write it in their save directory, and create a thin in the main menu that shows their best time!
--format the time please

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

return {
    write = function(time)
        love.filesystem.write("highscore.txt", time)
    end,

    read = function()
        local file = love.filesystem.getInfo("highscore.txt")

        if file then
            local score = love.filesystem.read("highscore.txt")
            score = tonumber(score)

            if score then
                local formatted_score = format_time(score)

                return score, formatted_score
            end
        end
    end
}