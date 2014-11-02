local menu = {}

function menu:load()
    menuSound = love.audio.newSource("audio/menuSound.mp3", "static")
end

function menu:draw()
    love.graphics.clear()

    love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(logo, 0, 0)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Start", 440, 370)
    love.graphics.print("Credits", 660, 370)
    love.graphics.print("Quit", 950, 370)
end

function menu:mousepressed(x, y, button)
    if button == "l" then
        if x >= 440 and x <= 520 and y >= 370 and y <= 410 then
            love.audio.play(menuSound)
            Gamestate.switch(game)
        end

        if x >= 660 and x <= 775 and y >= 370 and y <= 410 then
            love.audio.play(menuSound)
            Gamestate.switch(credits)
        end

        if x >= 950 and x <= 1020 and y >= 370 and y <= 410 then
            love.audio.play(menuSound)
            love.event.quit()
        end
    end
end

return menu
