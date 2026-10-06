local balltze = Balltze
local engine = Engine
local getObject = Engine.object.getObject
local getPlayer = Engine.player.getPlayer
local const = require "alpha_halo.systems.core.constants"

local extendedHud = {}

function extendedHud.hideMetersOnZoom()
    local player = getPlayer()
    if not player then
        return
    end
    local biped = getObject(player.unitHandle, "biped")
    if not biped then
        return
    end

    local levelZoom1 = biped.desiredZoomLevel == 0
    local levelZoom2 = biped.desiredZoomLevel == 1

    -------------------------------------------------------
    -- Beam Rifle
    -------------------------------------------------------

    if not const.hud.extBeamRifle then
        logger.warninging("{} not found", const.hud.extBeamRifle and const.hud.extBeamRifle.path or "unknown")
        return
    end

    local hudMetersBeamRifle = const.hud.extBeamRifle.data or const.hud.extBeamRifle

    for i = 1, #hudMetersBeamRifle.meterElements do
        local meterElement = hudMetersBeamRifle.meterElements[i]
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
        logger.warninging("{} not found", const.hud.extSniperRifle and const.hud.extSniperRifle.path or "unknown")
        return
    end

    local hudMetersSniperRifle = const.hud.extSniperRifle.data or const.hud.extSniperRifle

    for i = 1, #hudMetersSniperRifle.meterElements do
        local meterElement = hudMetersSniperRifle.meterElements[i]
        if levelZoom1 or levelZoom2 then
            meterElement.anchorOffset.y = 100
        else
            meterElement.anchorOffset.y = 1000
        end
    end
end

return extendedHud
