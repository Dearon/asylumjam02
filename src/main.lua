-- Third party libraries
require "thirdparty.slam"
_ = require "thirdparty.moses_min"
Gamestate = require "thirdparty.gamestate"
Timer = require "thirdparty.timer"

-- Game files
menu = require "menu"

function love.load()
    -- Set the window size and title
    love.window.setMode(800, 600)
    love.window.setTitle("Graveyard Shift")

    -- Set the default font
    love.graphics.setNewFont("fonts/OpenSans-Regular.ttf", "36")

    -- Call the other load functions
    menu:load()

    -- Show the menu
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.keypressed(key)
    -- Quit the game when escape is pressed
    if key == "escape" then
        love.event.quit()
    end
end
