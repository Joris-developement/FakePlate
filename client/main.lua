Citizen.CreateThread(function()
    while true do
        Wait(3)
        local ped = PlayerPedId()
        local wait = true

        local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Pos.x, Config.Pos.y, Config.Pos.z, true)

        if distance < 1.5 then
            wait = false
            local veh = GetVehiclePedIsIn(ped)
            if veh ~= 0 then
                AddTextEntry("HELP", 'Appuyer sur ~INPUT_TALK~ pour installer la fausse plaque et payer ~r~'..Config.Price..'~s~$')
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('FakePalte:AddFakePlate', string.upper(GetVehicleNumberPlateText(veh)), veh)
                end
            elseif veh == 0 then
                AddTextEntry("HELP", 'Vous devez ~r~être dans un véhicule~s~')
                DisplayHelpTextThisFrame("HELP", false)
            end
        end
        if wait then
            Wait(500)
        end
    end
end)

RegisterNetEvent('FakePlate:SetPlate')
AddEventHandler('FakePlate:SetPlate', function(veh, plate)
    SetVehicleNumberPlateText(veh, plate)
end)
