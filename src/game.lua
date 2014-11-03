local game = {}

local overlayColor = { 0, 0, 0, 0 }
local musicPaused = false
local gameState = "start"
local inventory = {picture = false, key = false}
local overlay = false
local numberpuzzleNumbers = { ["1"] = 0, ["2"] = 0, ["3"] = 0 }
local numberpuzzleSolution = { ["1"] = 5, ["2"] = 2, ["3"] = 8 }

local function suffocate()
    Timer.tween(3, overlayColor, {0, 0, 0, 255}, 'linear', function() Gamestate.switch(suffocation) end)
end

local function escape()
    Timer.tween(3, overlayColor, {0, 0, 0, 255}, 'linear', function() Gamestate.switch(basement) end)
end

function game:load()
    coffin = love.graphics.newImage("images/coffin.png")
    CoffinLockbox1 = love.graphics.newImage("images/CoffinLockbox1.png")
    CoffinLockbox2 = love.graphics.newImage("images/CoffinLockbox2.png")
    CoffinLockbox3 = love.graphics.newImage("images/CoffinLockbox3.png")
    CoffinPadlock = love.graphics.newImage("images/CoffinPadlock.png")

    key = love.graphics.newImage("images/key.png")

    picturefront = love.graphics.newImage("images/picturefront.png")
    pictureback = love.graphics.newImage("images/pictureback.png")

    soundOn = love.graphics.newImage("images/soundon.png")
    soundOff = love.graphics.newImage("images/soundoff.png")

    gameMusic = love.audio.newSource("audio/graveyardshift.mp3", "stream")
    gameMusic:setLooping(true)
    gameMusic:setVolume(.6)
end

function game:enter()
    love.audio.play(gameMusic)

    gameoverTimer = Timer.add(1, function() suffocate() end)
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

        if not overlay then
            if gameState == "start" then
                if x >= 201 and x <= 330 and y >= 47 and y <= 215 then
                    gameState = "lockbox"
                end
            elseif gameState == "lockbox" then
                if x >= 201 and x <= 330 and y >= 47 and y <= 215 then
                    overlay = "numberpuzzle"
                end
            elseif gameState == "openlockbox" then
                if x >= 217 and x <= 304 and y >= 138 and y <= 199 then
                    inventory.key = true
                    gameState = "lockboxkeytaken"
                end
            elseif gameState == "lockboxkeytaken" then
                if x >= 0 and x <= 1280 and y >= 420 and y <= 720 then
                    gameState = "lockexposed"
                end
            elseif gameState == "lockexposed" then
                if x >= 798 and x <= 902 and y >= 438 and y <= 550 then
                    escape()
                end
            end

            if not inventory.picture then
                if x >= 873 and x <= 944 and y >= 303 and y <= 372 then
                    inventory.picture = true
                    overlay = "picturefront"
                end
            else
                if x >= 10 and x <= 81 and y >= 646 and y <= 715 then
                    overlay = "picturefront"
                end
            end
        else
            if overlay == "picturefront" or overlay == "pictureback" then
                if x >= 474 and x <= 806 and y >= 35 and y <= 685 then
                    if overlay == "picturefront" then
                        overlay = "pictureback"
                    else
                        overlay = "picturefront"
                    end
                else
                    overlay = false
                end
            end

            if overlay == "numberpuzzle" then
                if x >= 565 and x <= 605 and y >= 335 and y <= 385 then
                    if numberpuzzleNumbers["1"] == 9 then
                        numberpuzzleNumbers["1"] = 0
                    else
                        numberpuzzleNumbers["1"] = numberpuzzleNumbers["1"] + 1
                    end
                elseif x >= 615 and x <= 655 and y >= 335 and y <= 385 then
                    if numberpuzzleNumbers["2"] == 9 then
                        numberpuzzleNumbers["2"] = 0
                    else
                        numberpuzzleNumbers["2"] = numberpuzzleNumbers["2"] + 1
                    end
                elseif x >= 665 and x <= 705 and y >= 335 and y <= 385 then
                    if numberpuzzleNumbers["3"] == 9 then
                        numberpuzzleNumbers["3"] = 0
                    else
                        numberpuzzleNumbers["3"] = numberpuzzleNumbers["3"] + 1
                    end
                end

                if numberpuzzleNumbers["1"] == numberpuzzleSolution["1"] and numberpuzzleNumbers["2"] == numberpuzzleSolution["2"] and numberpuzzleNumbers["3"] == numberpuzzleSolution["3"] then
                    overlay = false
                    gameState = "openlockbox"
                 end
            end
        end
    end
end

function game:draw()
    -- Draw the background
    local x, y = love.mouse.getPosition()
    love.graphics.clear()

    love.graphics.setColor(0, 0, 0, 225)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())

    love.graphics.setColor( 255, 255, 255, 100 )
    love.graphics.circle( "fill", x, y, 150, 150 )


    love.graphics.setBlendMode("multiplicative")
    love.graphics.setColor(255, 255, 255, 20)

    if gameState == "start" then
        love.graphics.draw(coffin, 0, 0)
    elseif gameState == "lockbox" then
        love.graphics.draw(CoffinLockbox1, 0, 0)
    elseif gameState == "openlockbox" then
        love.graphics.draw(CoffinLockbox2, 0, 0)
    elseif gameState == "lockboxkeytaken" then
        love.graphics.draw(CoffinLockbox3, 0, 0)
    elseif gameState == "lockexposed" then
        love.graphics.draw(CoffinPadlock, 0, 0)
    end

    -- Show the picture if it hasn't been picked up
    if not inventory.picture then
        love.graphics.draw(picturefront, 870, 300, -0.7, 0.1, 0.1)
    end

    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 255, 255)

    -- Draw the inventory items
    if inventory.picture then
        love.graphics.draw(picturefront, 10, 646, 0, 0.1, 0.1)
    end

    if inventory.key then
        love.graphics.draw(key, 70, 646, 0, 0.5, 0.5)
    end

    -- Draw the toggle audio button
    if musicPaused then
        love.graphics.draw(soundOn, love.window.getWidth() - 160, love.window.getHeight() - 140)
    else
        love.graphics.draw(soundOff, love.window.getWidth() - 160, love.window.getHeight() - 140)
    end

    if overlay == "picturefront" then
        love.graphics.draw(picturefront, 474, 35)
    elseif overlay == "pictureback" then
        love.graphics.draw(pictureback, 474, 35)
    elseif overlay == "numberpuzzle" then
        love.graphics.rectangle("fill", 565, 335, 40, 50)
        love.graphics.rectangle("fill", 615, 335, 40, 50)
        love.graphics.rectangle("fill", 665, 335, 40, 50)

        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.print(numberpuzzleNumbers["1"], 575, 335)
        love.graphics.print(numberpuzzleNumbers["2"], 625, 335)
        love.graphics.print(numberpuzzleNumbers["3"], 675, 335)
    end

    love.graphics.setColor(overlayColor)
    love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())
end

return game
