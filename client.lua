local ESX = exports['es_extended']:getSharedObject()

local doorList = Config.DoorList

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, door in ipairs(doorList) do
            local distance = #(playerCoords - door.doorCoords)

            if distance < 2.0 then
                DrawText3D(door.doorCoords.x, door.doorCoords.y, door.doorCoords.z + 0.5, 'Press E to interact with ' .. door.doorName)

                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('rival_keyless_system:interactDoor', door.doorID)
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent('rival_keyless_system:openDoor')
AddEventHandler('rival_keyless_system:openDoor', function(doorID)
    local door = doorList[doorID]
    if door then
        local doorObject = GetClosestObjectOfType(door.doorCoords.x, door.doorCoords.y, door.doorCoords.z, 2.0, GetHashKey(door.doorModel), false, false, false)
        if doorObject then
            FreezeEntityPosition(doorObject, false)
        end
    end
end)

RegisterNetEvent('rival_keyless_system:closeDoor')
AddEventHandler('rival_keyless_system:closeDoor', function(doorID)
    local door = doorList[doorID]
    if door then
        local doorObject = GetClosestObjectOfType(door.doorCoords.x, door.doorCoords.y, door.doorCoords.z, 2.0, GetHashKey(door.doorModel), false, false, false)
        if doorObject then
            FreezeEntityPosition(doorObject, true)
        end
    end
end)