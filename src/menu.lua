local menu = {}

function menu:load()
    -- Load the logo
    logo = love.graphics.newImage("images/logo.png")
end

function menu:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.draw(logo, 150, 25)

    love.graphics.setColor(0, 0, 0)

    love.graphics.print("Start", 380, 180)
    love.graphics.print("Credits", 360, 230)
    love.graphics.print("Quit", 385, 280)
end

function menu:mousepressed(x, y, button)
    if button == "l" then
        if x >= 380 and x <= 460 and y >= 180 and y <= 220 then
            print("Start")
        end

        if x >= 360 and x <= 475 and y >= 230 and y <= 270 then
            print("Credits")
        end

        if x >= 385 and x <= 455 and y >= 280 and y <= 320 then
            love.event.quit()
        end
    end
end

return menu
