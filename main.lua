assets      = require("assets")
camera      = require("libraries.vendor.hump.camera")
class       = require("libraries.class")
event       = require("libraries.event")
highscore   = require("source.highscore")
keybinder   = require("libraries.keybinder")
moonshine   = require("libraries.vendor.moonshine")
shadows     = require("libraries.vendor.shadows")
states      = require("libraries.state")
sti         = require("libraries.vendor.sti")
storm_ui    = require("libraries.storm_ui")
timer       = require("libraries.vendor.hump.timer")
vector      = require("libraries.vendor.hump.vector")

require("source.volume")

function love.load()
    states.load_states("states")
    states.set_current_state("splash")
end

function love.quit()
    local main_menu = states.get_state("main_menu")

    states.set_current_state("main_menu")
    main_menu.exit_button:run_hooks("on_clicked")

    if main_menu.can_quit then
        return false
    end

    return true
end

--make game scalable to any resolution
--make konami code more interesting in main menu
--add challenge levels in main menu after completeing the game.
--add gear icon in game for escape menu
