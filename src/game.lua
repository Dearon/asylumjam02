local game = {}

function game:load()
    coffinBackground = love.graphics.newImage("images/coffin.png")
end

function game:draw()
    local x, y = love.mouse.getPosition()
    love.graphics.clear()

    love.graphics.setColor(0, 0, 0, 225)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())

    love.graphics.setColor( 255, 255, 255, 100 )
    love.graphics.circle( "fill", x, y, 100, 100 )

    love.graphics.setBlendMode("multiplicative")
    love.graphics.setColor(255, 255, 255, 20)
    love.graphics.draw(coffinBackground, 0, 0)

    love.graphics.setBlendMode("alpha")
end

return game
