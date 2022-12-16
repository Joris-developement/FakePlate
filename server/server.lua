ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local alphabet = {'A', 'Z', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'Q', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'W', 'X', 'C', 'V', 'B', 'N'}
local number = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
RegisterNetEvent('FakePalte:AddFakePlate')
AddEventHandler('FakePalte:AddFakePlate', function(oldPlate, veh)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if xPlayer.getAccount(Config.Money).money >= Config.Price then
        xPlayer.removeAccountMoney(Config.Money, Config.Price)
        local newPlate = alphabet[math.random(1, 26)]..alphabet[math.random(1, 26)]..alphabet[math.random(1, 26)].. " " .. number[math.random(1, 10)]..number[math.random(1, 10)]..number[math.random(1, 10)]

        MySQL.Async.fetchAll('SELECT `plate`, `realPlate`, `vehicle` FROM `owned_vehicles` WHERE `plate` = @plate', {
            ['@plate'] = oldPlate
        }, function(r)
            if r[1] then
                if r[1].realPlate == nil then
                    MySQL.Async.execute('UPDATE owned_vehicles SET `realPlate`=@realPlate WHERE plate=@realPlate', {
                        ['@realPlate'] = oldPlate
                    })
                end
                local vehicle = json.decode(r[1].vehicle)
                vehicle.plate = newPlate
                MySQL.Async.execute('UPDATE owned_vehicles SET `plate`=@newPlate, `vehicle`=@veh WHERE plate=@oldPlate', {
                    ['@oldPlate'] = oldPlate,
                    ['@veh'] = json.encode(vehicle),
                    ['@newPlate'] = newPlate
                })
            end
            TriggerClientEvent('FakePlate:SetPlate', _src, veh, newPlate)
        end)
    else
        TriggerClientEvent('esx:showNotification', _src, 'Vous n\'avez ~r~pas assez d\'argent~s~')
    end

end)