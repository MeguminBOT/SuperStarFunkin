local customCamZoom = true
local zoomValue = 0.7 -- Default zoom value, should be the same as the stage.json.

function onCreate()
	if not customCamZoom then
        return
    end
end

function onUpdate()
    setProperty('defaultCamZoom', zoomValue)
end

function onStepHit()
    if curStep >= 1024 and curStep <= 1151 then
        zoomValue = 1

    elseif curStep >= 1152 then
        zoomValue = 1.4
    end
end

-- function onSectionHit()
-- 	zoomDebug = getProperty('defaultCamZoom')
-- 	sectionDebug = tostring(mustHitSection)
-- 	debugPrint(" Camera zoom: " .. zoomDebug .. " | Must hit section: " .. sectionDebug)
-- end