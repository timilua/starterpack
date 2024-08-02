StartPack = {
    ['Pack Illegal'] = {
        { item = 'weapon_bat', amount = 1 },
        { item = 'black_money', amount = 50000 },
        { item = 'money', amount = 70000 },
        { item = 'phone', amount = 1 },
        { item = 'radio', amount = 1 }
    },

    ['Pack Legal'] = {
        { item = 'Bread', amount = 2 },
        { item = 'money', amount = 70000 },
        { item = 'phone', amount = 1 },
        { item = 'radio', amount = 1 }
    }
}

RegisterNetEvent('openbymystic')
AddEventHandler('openbymystic', function()
    local startpack = {}
    
    for k, v in pairs(StartPack) do
        startpack[#startpack + 1] = {
            title = k,
            description = 'Open ' .. k .. ' Starter Pack',
            onSelect = function()
                local items = ""
                for _, pack in pairs(v) do
                    items = items .. ' | Item: ' .. pack.item .. ' | Quantité: ' .. pack.amount
                end
            
                local alert = lib.alertDialog({
                    header = 'Vous avez ouvert un Starter Pack ' .. k,
                    content = items,
                    centered = true,
                    cancel = true
                })
            
                if alert == 'confirm' then
                    TriggerServerEvent('bymystic', v, k)
                elseif alert == 'cancel' then
                    ESX.ShowNotification('Vous avez annulé l\'ouverture du Starter Pack ' .. k)
                end
            end
        }
    end

    lib.registerContext({
        id = 'starterpack',
        title = 'Starter Pack',
        options = startpack
    })

    lib.showContext('starterpack')
end)

exports.qtarget:AddBoxZone('starterpack', vector3(406.92, -349.24, 46.86), 1.5, 1.5, {
    name = 'starterpack',
    heading = 0,
    debugPoly = false
}, {
    options = {
        {
            event = 'openbymystic',
            icon = 'fas fa-box-open',
            label = 'Récupérer mon Starter-Pack'
        }
    },
    distance = 1.5
})


---- PNJ ---


Citizen.CreateThread(function()
    local hash = GetHashKey("cs_movpremmale")
    while not HasModelLoaded(hash) do
       RequestModel(hash)
       Wait(20)
    end
       ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_movpremmale", 406.92, -349.24, 45.86, 131.88, false, true)
       SetBlockingOfNonTemporaryEvents(ped, true)
       FreezeEntityPosition(ped, true)
  end)


--- BLIPS ---

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(406.92, -349.24, 45.86) -- remplacer les coordonnés

    SetBlipSprite (blip, 456) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7) -- Taille du blip
    SetBlipColour (blip, 5) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('~g~Pack D\'arrivé') -- Nom du blips
    EndTextCommandSetBlipName(blip)
end)