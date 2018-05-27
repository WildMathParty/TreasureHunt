local composer = require( "composer" )
local widget = require("widget")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local currentQuestion
local questionsAnswers = {
    {"test1", "testA"},
    {"test2", "testB"},
    {"test3", "testC"}
}
local questionText
local answerInput

local function createQuestion(sceneGroup)
    questionText = display.newText({
        text = "no text displayed",
        x = display.contentCenterX,
        y = display.contentCenterY - 200,
        width = display.actualContentWidth - 100,
        font = native.systemFont,   
        fontSize = 18,
        align = "center"        
    })
    sceneGroup:insert(questionText)
end

local function askQuestion()
    questionText.text = questionsAnswers[currentQuestion][1]
end 

local function createTextField()
    local function textListener(event)
        if(event.phase == "ended" or event.phase == "submitted") then
            if(event.target.text == questionsAnswers[currentQuestion][2]) then
                currentQuestion = currentQuestion + 1
                if(currentQuestion > #questionsAnswers) then
                    composer.gotoScene("s_Menu", {params={state=2}})
                else
                    askQuestion()
                end
            else
                print("failure")
            end
        end
    end

    answerInput = native.newTextField(display.contentCenterX, display.contentCenterY + 200, 256, 64)
    answerInput:addEventListener("userInput", textListener)
end
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    createQuestion(sceneGroup)
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        currentQuestion = 1
        askQuestion()
        createTextField()
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    if answerInput then
        answerInput:removeSelf()
        answerInput = nil
    end
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
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