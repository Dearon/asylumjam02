-- Third party libraries
require "thirdparty.slam"
_ = require "thirdparty.moses_min"
Gamestate = require "thirdparty.gamestate"
Timer = require "thirdparty.timer"

-- Game files
menu = require "menu"
credits = require "credits"

function love.load()
    -- Set the window size and title
    love.window.setMode(1280, 720)
    love.window.setTitle("Graveyard Shift")

    -- Set the default font
    love.graphics.setNewFont("fonts/OpenSans-Regular.ttf", "36")

    -- Load images used in multiple states
    logo = love.graphics.newImage("images/logo.png")

    -- Show the menu
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.update(dt)
    Timer.update(dt)
end

function love.keypressed(key)
    -- Quit the game when escape is pressed
    if key == "escape" then
        love.event.quit()
    end

    -- Toggle fullscreen
    if love.keyboard.isDown("lctrl") and love.keyboard.isDown("return") then
        fullscreen, fstype = love.window.getFullscreen()

        if fullscreen then 
            love.window.setFullscreen(false)
        else
            love.window.setFullscreen(true)
        end
    end
end
