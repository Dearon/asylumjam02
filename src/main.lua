require "thirdparty.slam"
_ = require "thirdparty.moses_min"
Gamestate = require "thirdparty.gamestate"
Timer = require "thirdparty.timer"

function love.load()
    love.window.setMode( 800, 600 )
    love.window.setTitle( "Graveyard Shift" )
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
