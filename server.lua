local saveVehicles = function()
    local information = {}
    local i = 0
    for k,v in pairs(GetAllVehicles()) do
        i = i + 1
        table.insert(information,{
        GetEntityModel(v),
        GetEntityCoords(v),
        GetEntityHeading(v),
        GetVehicleNumberPlateText(v),
        GetVehicleCustomPrimaryColour(v),
        GetVehicleCustomSecondaryColour(v),
        GetVehicleBodyHealth(v),
        GetVehicleDirtLevel(v),
        GetVehicleColours(v),
        })
    end
    SaveResourceFile(GetCurrentResourceName(), "vehicles.json", json.encode(information), -1)
    print("^2 Saved " .. i .. " Vehicles^7")
end

local loadVehicles = function()
    local file = LoadResourceFile(GetCurrentResourceName(), "./vehicles.json")
    local data = {}
    data = json.decode(file)
    local i = 0
    for k,v in pairs(data) do
        i = i + 1
        local tempVeh = Citizen.InvokeNative(GetHashKey("CREATE_AUTOMOBILE"), v[1], v[2].x, v[2].y, v[2].z)
        SetEntityHeading(tempVeh, v[3])
        SetVehicleNumberPlateText(tempVeh, v[4])
        SetVehicleCustomPrimaryColour(tempVeh, v[5])
        SetVehicleCustomSecondaryColour(tempVeh, v[6])
        SetVehicleBodyHealth(tempVeh, v[7])
        SetVehicleDirtLevel(tempVeh, v[8])
        SetVehicleColours(tempVeh, v[9], v[10])
    end
    print("^2 Loaded " .. i .. " Vehicles^7")
end

RegisterCommand("saveVehicles", saveVehicles, true)

RegisterCommand("loadVehicles", loadVehicles, true)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        saveVehicles()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        loadVehicles()
    end
end)