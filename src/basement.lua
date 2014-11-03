local basement = {}

local overlayColor = { 0, 0, 0, 255 }

local function fadeout()
    Timer.tween(3, overlayColor, {0, 0, 0, 255}, "linear", function()
        Timer.tween(3, overlayColor, {255, 255, 255, 255}, "linear", function() Gamestate.switch(credits) end)
    end)
end

function basement:enter()
    Timer.tween(3, overlayColor, {0, 0, 0, 0}, "linear", function() Timer.add(5, function() fadeout() end) end)
end

function basement:draw()
    love.graphics.clear()

    love.graphics.setBackgroundColor(255, 255, 255)

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf("You open the hatch and go through into a basement of sorts.\nIt seems you've escape death... for now.", 200, 200 , 880 ,"center") 

    love.graphics.setColor(overlayColor)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
end

return basement
