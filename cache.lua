local cachestate = {}
cachestate.firstcds = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if not inPaintball and state_ready then
            local coords = GetEntityCoords(PlayerPedId(),true)
            if cachestate.firstcds then 
            cachestate.cds = coords
            cachestate.firstcds = false
            end
            if ( #(coords - cachestate.cds) >= 3 ) then
            vRPserver._updatePos(coords.x, coords.y, coords.z)
            cachestate.cds = coords
            end
            local health = tvRP.getHealth()
            if health ~= cachestate.health then
            vRPserver._updateHealth(health)
            cachestate.health = health
            end
            local armour = tvRP.getArmour()
            if armour ~= cachestate.armour then
            vRPserver._updateArmor(armour)
            cachestate.armour = armour
            end
            local clothes = tvRP.getCustomization()
            if json.encode(clothes) ~= json.encode(cachestate.clothes) then
                vRPserver._updateCustomization(clothes)
                cachestate.clothes = clothes
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if not inPaintball and state_ready and canUpdateWeapons then
            local weapons = tvRP.getWeapons()
            if json.encode(weapons) ~= json.encode(cachestate.weapons) then
            vRPserver._updateWeapons(weapons)
            cachestate.weapons = weapons
            end
        end
    end
end)
