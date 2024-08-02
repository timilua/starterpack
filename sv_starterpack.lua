RegisterNetEvent('bymystic')

AddEventHandler('bymystic', function(v, k)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    MySQL.Async.fetchScalar('SELECT identifier FROM starterpack WHERE identifier = @identifier',
        { ['identifier'] = xPlayer.getIdentifier() }, function(result)
        if result then
            TriggerClientEvent('esx:showNotification', source, 'Vous avez déjà prit votre Starter-Pack')
        else
            MySQL.Async.execute('INSERT INTO starterpack (identifier, pack) VALUES (@identifier, @pack)',
                { ['@identifier'] = xPlayer.getIdentifier(), ['@pack'] = k })

            for _, pack in pairs(v) do
                xPlayer.addInventoryItem(pack.item, pack.amount)
            end

            TriggerClientEvent('esx:showNotification', source, 'Vous venez de prendre votre Starter-Pack' .. k)
        end
    end)
end)
