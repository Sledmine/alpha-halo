local balltze = Balltze
local engine = Engine
local objectTypes = Engine.tag.objectType
local getObject = Engine.gameState.getObject
local getPlayer = Engine.gameState.getPlayer
local const = require "alpha_halo.systems.core.constants"

local extendedHud = {}

function extendedHud.hideMetersOnZoom()

    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.objectHandle, objectTypes.biped)
    if not biped then
        return
    end

    local levelZoom1 = biped.desiredZoomLevel == 0
    local levelZoom2 = biped.desiredZoomLevel == 1

    -------------------------------------------------------
    -- Beam Rifle
    -------------------------------------------------------

    if not const.hud.extBeamRifle then
        logger:warning("{} not found", const.hud.extBeamRifle.path)
        return
    end

    local hudMetersBeamRifle = const.hud.extBeamRifle.data

    for i = 1, hudMetersBeamRifle.meterElements.count do
        local meterElement = hudMetersBeamRifle.meterElements.elements[i]
        if levelZoom1 or levelZoom2 then
            meterElement.anchorOffset.y = 0
        else
            meterElement.anchorOffset.y = 1000
        end
    end

    -------------------------------------------------------
    -- Sniper rifle 
    -------------------------------------------------------

    if not const.hud.extSniperRifle then
        logger:warning("{} not found", const.hud.extSniperRifle.path)
        return
    end

    local hudMetersSniperRifle = const.hud.extSniperRifle.data

    for i = 1, hudMetersSniperRifle.meterElements.count do
        local meterElement = hudMetersSniperRifle.meterElements.elements[i]
        if levelZoom1 or levelZoom2 then
            meterElement.anchorOffset.y = 100
        else
            meterElement.anchorOffset.y = 1000
        end
    end

end

return extendedHud
