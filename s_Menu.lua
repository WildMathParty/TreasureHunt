local composer = require("composer")
local widget = require("widget")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local greetingText
local startButton
local textStates = {
    [[
Welcome
This is my first treasure hunt using this program]],
    [[
Congrats!
Thanks for playing, kiddo]]
}
local buttonStates = {
    "Begin Treasure Hunt",
    "Replay Treasure Hunt"
}

local function createScreen(sceneGroup)
    greetingText = display.newText({
        text = "",
        x = display.contentCenterX,
        y = display.contentCenterY - 200,
        width = 256,
        font = native.systemFont,   
        fontSize = 18,
        align = "center"
    })
    sceneGroup:insert(greetingText)

    local function handleButtonEvent(event)
        if(event.phase == "ended") then
            composer.gotoScene("s_Hunt")
        end
    end

    startButton = widget.newButton({        
        label = "",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        x = display.contentCenterX,
        y = display.contentCenterY + 80,
        width = 200,
        height = 40,
        cornerRadius = 2,
        fillColor = { default={0.5,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    })
    sceneGroup:insert(startButton)
end
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create(event)
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    createScreen(sceneGroup)
 
end
 
 
-- show()
function scene:show(event)
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        greetingText.text = textStates[event.params.state]
        startButton:setLabel(buttonStates[event.params.state])
        --startButton.label = "ee"--buttonStates[event.params.state]

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide(event)
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy(event)
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene