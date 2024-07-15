local QBCore = exports['qb-core']:GetCoreObject()
local ox_target = exports.ox_target

local function cooldown()
	WashCooldown = true
	Wait(Config.moneywash.cooldown * 600)
	WashCooldown = false
end

function WashMoney(count)
	iswashing = true
	lib.notify({
		description = "You have started washing",
		type = "inform",
	})
	local key = exports.ox_inventory:Search("count", "laundrymat_keycard")
	if
		lib.progressBar({
			duration = Config.moneywash.washtime * 600,
			label = "Washing Money",
			useWhileDead = false,
			canCancel = false,
			disable = {
				car = true,
				move = false,
				combat = false,
			},
		})
		then
			iswashing = false
			TriggerServerEvent("fg:moneywash:server:addclean", "money", count)
			cooldown()
	end
end

function enterlaundry() 
		local key = exports.ox_inventory:Search("count", "laundrymat_keycard")
		if key >= 1 then
			inside = true
			DoScreenFadeOut(100)
			Wait(500)
			SetEntityCoords(PlayerPedId(), 1138.1279, -3199.1963, -39.6657)
			SetEntityHeading(PlayerPedId(), 6)
			Wait(1000)
			DoScreenFadeIn(100)
	else
		lib.notify({
			title = "Access Denied",
			description = "You are need a keycard to enter",
			type = "error",
		})
	end
end

function exitlaundry() 
	if iswashing then
		lib.notify({
			description = "You are already washing",
			type = "error",
		})
	else
		inside = false
		DoScreenFadeOut(100)
		Wait(500)
	    SetEntityCoords(PlayerPedId(), 51.3, -2571.37, 6.0)
		SetEntityHeading(PlayerPedId(), 4.22)
		Wait(1000)
		DoScreenFadeIn(100)
	end
end

RegisterNetEvent("fg:moneywash:client:startwash")
AddEventHandler("fg:moneywash:client:startwash", function()
	local p_dirtymoney = exports.ox_inventory:Search("count", "black_money")
	local input = lib.inputDialog('Washing Amount', {
		{type = 'number', label = 'How much would you like to wash?'},
	})
if not WashCooldown then
	if not iswashing then
		SetEntityHeading(PlayerPedId(), 349.9048)
		lib.requestAnimDict('anim@gangops@facility@servers@bodysearch@', 10)
		TaskPlayAnim(PlayerPedId(), 'anim@gangops@facility@servers@bodysearch@', 'player_search', 8.0, -8.0, -1, 48, 0)
		if input[1] > Config.moneywash.maxwash then
			lib.notify({
				description = "You can't do that much at a time",
				type = "error",
			})
		elseif input[1] == Config.moneywash.maxwash then
			lib.notify({
				description = "You can't do that much at a time",
				type = "error",
			})
		elseif input[1] > p_dirtymoney then
			lib.notify({
				description = "You don't have enough dirty money!",
				type = "error",
			})
		elseif input[1] < p_dirtymoney then
			lib.notify({
				description = "Successfully washing",
				type = "success",
			})
			TriggerServerEvent("fg:moneywash:server:removedirty", "black_money" , input[1])
			WashMoney(input[1])
		else 
			lib.notify({
				description = "Successfully washing",
				type = "success",
			})
			TriggerServerEvent("fg:moneywash:server:removedirty", "black_money" , input[1])
			WashMoney(input[1])
		end
	elseif iswashing then
			lib.notify({
				description = "You are already washing",
				type = "error",
			})
		end
	else
		lib.notify({
			description = "You are must wait for the cooldown",
			type = "error",
		})
	end
end)


Citizen.CreateThread(function()
	ox_target:addSphereZone({
		coords = vec3(1122.25, -3194.48, -40.4),
		radius = 0.5,
		debug = drawZones,
		drawSprite = true,
		options = {{
			name = "Money Wash",
			event = "fg:moneywash:client:startwash",
			icon = "fa-solid fa-money-bill",
			label = "Wash Money"
			}}
		})
	ox_target:addSphereZone({
		coords = vec(51.3, -2571.37, 6.0),
		radius = 1,
		debug = drawZones,
		options = {{
			name = "Enter Wash",
			icon = "fa-solid fa-door-open",
			label = "Enter Laundrymat",
			onSelect = function()
					enterlaundry()
			end
			}}
		})	
	ox_target:addSphereZone({
		coords = vec(1138.1279, -3199.1963, -39.6657),
		radius = 1,
		debug = drawZones,
		options = {{
			name = "Exit Wash",
			icon = "fa-solid fa-door-open",
			label = "Exit Laundrymat",
			onSelect = function()
					exitlaundry()
			end
			}}
		})	
 end)