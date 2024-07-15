local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("fg:moneywash:server:addclean")
AddEventHandler("fg:moneywash:server:addclean", function(itemname, count)
	local src = source
	local newcount = count * Config.moneywash.tax
	count = count - newcount
	exports.ox_inventory:AddItem(src, itemname, count)
	print("added")
end)

RegisterNetEvent("fg:moneywash:server:removedirty")
AddEventHandler("fg:moneywash:server:removedirty", function(itemname, count)
	local src = source
	exports.ox_inventory:RemoveItem(src, itemname, count)
	print("removed")
end)