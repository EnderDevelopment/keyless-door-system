local ESX = exports['es_extended']:getSharedObject()

local doorList = Config.DoorList

ESX.RegisterServerCallback('rival_keyless_system:getDoorInfo', function(source, cb, doorID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local doorInfo = doorList[doorID]

    if doorInfo then
        MySQL.Async.fetchScalar('SELECT owner FROM doors WHERE door_id = @door_id', {['@door_id'] = doorID}, function(result)
            if result then
                doorInfo.owner = result
            else
                doorInfo.owner = nil
            end
            cb(doorInfo)
        end)
    else
        cb(nil)
    end
end)

RegisterServerEvent('rival_keyless_system:interactDoor')
AddEventHandler('rival_keyless_system:interactDoor', function(doorID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local doorInfo = doorList[doorID]

    if doorInfo then
        MySQL.Async.fetchScalar('SELECT owner FROM doors WHERE door_id = @door_id', {['@door_id'] = doorID}, function(result)
            if result then
                if result == xPlayer.identifier then
                    TriggerClientEvent('rival_keyless_system:openDoor', source, doorID)
                else
                    MySQL.Async.fetchScalar('SELECT id FROM keys WHERE owner = @owner AND door_id = @door_id', {['@owner'] = xPlayer.identifier, ['@door_id'] = doorID}, function(keyResult)
                        if keyResult then
                            TriggerClientEvent('rival_keyless_system:openDoor', source, doorID)
                        else
                            xPlayer.showNotification('You do not have access to this door.')
                        end
                    end)
                end
            else
                xPlayer.showNotification('This door is not owned by anyone.')
            end
        end)
    else
        xPlayer.showNotification('Invalid door.')
    end
end)

ESX.RegisterServerCallback('rival_keyless_system:buyDoor', function(source, cb, doorID)
    local xPlayer = ESX.GetPlayerFromId(source)
    local doorInfo = doorList[doorID]

    if doorInfo then
        if xPlayer.getMoney() >= doorInfo.doorPrice then
            xPlayer.removeMoney(doorInfo.doorPrice)
            MySQL.Async.execute('INSERT INTO doors (owner, door_id) VALUES (@owner, @door_id)', {['@owner'] = xPlayer.identifier, ['@door_id'] = doorID}, function()
                cb(true)
            end)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('rival_keyless_system:buyKey', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= Config.KeyPrice then
        xPlayer.removeMoney(Config.KeyPrice)
        xPlayer.addInventoryItem(Config.KeyItem, 1)
        cb(true)
    else
        cb(false)
    end
end)