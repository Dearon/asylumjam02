local suffocation = {}

local defaultColor = { 255, 255, 255, 255 }
local overlayColor = { 0, 0, 0, 255 }
local breathing = {volume = .0}

local function fadeout()
    Timer.tween(3, overlayColor, {0, 0, 0, 255}, "linear")
    Timer.tween(3, breathing, {volume = .0}, "linear", function()
        Timer.tween(3, overlayColor, {255, 255, 255, 255}, "linear", function() Gamestate.switch(credits) end)
    end)
end

function suffocation:load()
    CoffinSuffocate = love.graphics.newImage("images/CoffinSuffocate.png")
    heavyBreathing = love.audio.newSource("audio/HeavyBreathing.mp3", "stream")
end

function suffocation:enter()
    love.audio.play(heavyBreathing)

    Timer.tween(3, breathing, {volume = 1.0}, "linear")
    Timer.tween(3, overlayColor, {0, 0, 0, 0}, "linear", function() Timer.add(5, function() fadeout() end) end)
end

function suffocation:update()
    print(breathing.volume)
    heavyBreathing:setVolume(breathing.volume)
end

function suffocation:draw()
    love.graphics.clear()

    love.graphics.setColor(defaultColor)
    love.graphics.draw(CoffinSuffocate, 0, 0)

    love.graphics.printf("As you struggle the air becomes less and less, until eventually it all ran out. You have suffocated!", 200, 200 , 880 ,"center") 

    love.graphics.setColor(overlayColor)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
end

return suffocation
