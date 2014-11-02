local game = {}

local overlayColor = { 0, 0, 0, 0 }
local musicPaused = false

local function suffocate()
    Timer.tween(3, overlayColor, {0, 0, 0, 255}, 'linear', function() Gamestate.switch(suffocation) end)
end

function game:load()
    coffin = love.graphics.newImage("images/coffin.png")

    soundOn = love.graphics.newImage("images/soundon.png")
    soundOff = love.graphics.newImage("images/soundoff.png")

    gameMusic = love.audio.newSource("audio/graveyardshift.mp3", "stream")
    gameMusic:setLooping(true)
    gameMusic:setVolume(.6)
end

function game:enter()
    love.audio.play(gameMusic)

    gameoverTimer = Timer.add(1800, function() suffocate() end)
end

function game:leave()
    Timer.cancel(gameoverTimer)
end

function game:mousepressed(x, y, button)
    if button == "l" then
        if x >= love.window.getWidth() - 160 and x <= love.window.getWidth() and y >= love.window.getHeight() - 140 and y <= love.window.getHeight() then
            if musicPaused then
                love.audio.resume()
                musicPaused = false
            else
                love.audio.pause()
                musicPaused = true
            end
        end
    end
end

function game:draw()
    local x, y = love.mouse.getPosition()
    love.graphics.clear()

    love.graphics.setColor(0, 0, 0, 225)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())

    love.graphics.setColor( 255, 255, 255, 100 )
    love.graphics.circle( "fill", x, y, 150, 150 )

    love.graphics.setBlendMode("multiplicative")
    love.graphics.setColor(255, 255, 255, 20)
    love.graphics.draw(coffin, 0, 0)

    love.graphics.setBlendMode("alpha")

    if musicPaused then
        love.graphics.draw(soundOn, love.window.getWidth() - 160, love.window.getHeight() - 140)
    else
        love.graphics.draw(soundOff, love.window.getWidth() - 160, love.window.getHeight() - 140)
    end

    love.graphics.setColor(overlayColor)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
end

return game
