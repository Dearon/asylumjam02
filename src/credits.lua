local credits = {}

function credits:enter()
    pos = {y = 500}
    Timer.tween(10, pos, {y = -800}, 'linear', function() Gamestate.switch(menu) end)
end

function credits:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.setColor(255, 255, 255)

    love.graphics.draw(logo, 0, pos.y + 0)

    love.graphics.setColor(0, 0, 0)

    local text = [[This game was made for the Asylum Jam 2
    Art and design was done by @CScribes
    Coding was done by @_Dearon
    Music and SFX was done by @antisocialiteuk
    
    We hope you enjoyed the game, let us know!]]

    love.graphics.printf(text, 250, pos.y + 480, 800, "center")
end

function credits:mousepressed(x, y, button)
    Gamestate.switch(menu)
end

function credits:keypressed(key)
    Gamestate.switch(menu)
end

return credits
