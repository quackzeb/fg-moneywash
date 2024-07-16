local QBCore = exports['qb-core']:GetCoreObject()

local function failedebug(src, donedebug)
print("^5Moneywash Warn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to wash without being in suitable range. It is recommended this person gets kicked.")
end

RegisterNetEvent("fg:moneywash:server:failedebug")
AddEventHandler("fg:moneywash:server:failedebug", function(src, donedebug)
	if donedebug == false then
		failedebug(src, donedebug)
	end
end)


RegisterNetEvent("fg:moneywash:server:clean")
AddEventHandler("fg:moneywash:server:clean", function(count, donedebug)
if donedebug == true then
	local src = source
	local newcount = count * Config.moneywash.tax
	count = count - newcount
	exports.ox_inventory:AddItem(src, "money", count)
end
end)

RegisterNetEvent("fg:moneywash:server:removedirty")
AddEventHandler("fg:moneywash:server:removedirty", function(count)
	local src = source
	exports.ox_inventory:RemoveItem(src, "black_money", count)
end)
