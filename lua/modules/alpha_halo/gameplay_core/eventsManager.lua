local eventsManager = {}
local blam = require "blam"
local engine = Engine
local balltze = Balltze
local scriptBlock = require "script".block

-- VARIABLES DE LA FUNCIÓN eventManager.onMapLoad
local gameIsOn = false

function eventsManager.onMapLoad()
    gameIsOn = true
    eventsManager.debugFunction()
end

function eventsManager.EachTick()
    if gameIsOn == true then
        --eventsManager.debugFunction()
    end
end

function eventsManager.debugFunction()
    console_out("Currently testing eventManager")
end

return eventsManager