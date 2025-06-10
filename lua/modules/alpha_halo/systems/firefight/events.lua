-- 📁 modules/project_modules/systems/firefight/eventsManager.lua
local balltze = Balltze
local engine = Engine
local hsc = require "hsc"
local script = require "script"

local events = {}

-- Eventos configurables por set, ronda y oleada
local setEvents = {
    [1] = function()
        logger:info("🏁 Inicio del Set 1: Preparación total")
        execute_script("object_create_anew base_shield")
    end
}

local roundEvents = {
    [1] = function()
        logger:info("📣 Evento especial de la Ronda 1: ¡Invasión rápida!")
        execute_script("object_create_anew rally_flag")
    end,
    [3] = function()
        logger:info("📣 Evento especial de la Ronda 3: ¡Enemigos invisibles!")
        execute_script("ai_allegiance player elite")
    end
}

local waveEvents = {
    [2] = function(call, sleep)
        sleep(60)
        logger:info("🌊 Oleada 2: Lluvia de granadas")
        --execute_script("object_create_anew grenade_storm")
    end
}



-- Funciones para disparar eventos
---@param setNumber integer
function events.triggerSetEvent(setNumber)
    local eventFunc = setEvents[setNumber]
    if eventFunc then
        eventFunc()
    end
end

---@param roundNumber integer
function events.triggerRoundEvent(roundNumber)
    local eventFunc = roundEvents[roundNumber]
    if eventFunc then
        eventFunc()
    end
end

---@param waveNumber integer
function events.triggerWaveEvent(waveNumber)
    local eventFunc = waveEvents[waveNumber]
    if eventFunc then
        script.wake(eventFunc)
    end
end

-- Verificación por tick si se quiere extender lógica reactiva
function events.eachTick()
    -- Espacio reservado para lógica reactiva por tick
end


return events
