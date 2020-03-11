local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false
Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
	
		end
	end, function(data, menu)
		menu.close()
	end)
end



function OpenAmbulanceActionsMenuBoss()
	local elements = {
	
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = 'Menu de Jefe',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

	
		if data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()


			end, {wash = false})
	
		end
	end, function(data, menu)
		menu.close()
	end)
end

local bloqtecla = false

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
		if bloqtecla then

         DisableAllControlActions(0)
		 EnableControlAction(0, 1, true)
		 EnableControlAction(0, 2, true)
		 EnableControlAction(0, Keys["T"], true)
		 EnableControlAction(0, Keys["N"], true)
 		 EnableControlAction(0,Keys["CAPS"], true)
		 EnableControlAction(0,Keys["N+"], true)
		 EnableControlAction(0,Keys["F6"], true)
		 DisableControlAction(0,Keys ["LEFTALT"], true)


	    else
	    	Citizen.Wait(1000)
        end
    end
end)

RegisterNetEvent('anim:revivirfast')
AddEventHandler('anim:revivirfast', function(playerheading, playercoords, playerlocation)
		 local deathCoords			 
		 local coords = GetEntityCoords(playerPed)
		 local playerPed = GetPlayerPed(-1)
		 local test1, test2 = ESX.Game.GetClosestPlayer()
		 local test1_id = GetPlayerServerId(target)

        bloqtecla = true
        ClampGameplayCamPitch(0.0, -90.0)
        SetEntityVisible(playerPed, false)
		loadanimdict('mini@cpr@char_b@cpr_str')
		TriggerEvent('animrevive:loopfalse')
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false) 
		TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
		SetEntityInvincible(playerPed, false)
		StopScreenEffect('DeathFailOut')

	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(test1_id, x, y, z-0.50)
	SetEntityHeading(GetPlayerPed(-1), playerheading - 270.0) 

   	    	Citizen.Wait(1500)
         SetEntityCoords(test1_id, x, y, z-0.50)
   		 SetEntityVisible(playerPed, true)

		    for i=1, 15, 1 do
		        Citizen.Wait(900)
		        TaskPlayAnim(playerPed, 'mini@cpr@char_b@cpr_str', 'cpr_pumpchest', 8.0, 8.0, -1, 0, 0, false, false, false)
	       end	
      bloqtecla = false
end)

RegisterNetEvent('anim:medicorevivirfast')
AddEventHandler('anim:medicorevivirfast', function(playerheading, playercoords, playerlocation)
	bloqtecla = true
	local playerPed = GetPlayerPed(-1)

	loadanimdict('mini@cpr@char_a@cpr_str')
		Citizen.Wait(1500)
		 ClampGameplayCamPitch(0.0, -90.0)	
		for i=1, 15, 1 do
			Citizen.Wait(900)
				TaskPlayAnim(playerPed, 'mini@cpr@char_a@cpr_str','cpr_pumpchest', 8.0, 8.0, -1, 0, 0, false, false, false)
		end
     bloqtecla = false

end) 

------------------------------
---NUEVA ANIMACION REVIVIR ---
------------------------------
function entidadvisible()
SetEntityVisible(GetPlayerPed(-1), false)
Wait(250)
SetEntityVisible(GetPlayerPed(-1), true)
end

RegisterNetEvent('anim:herido')
AddEventHandler('anim:herido', function(playerheading, playercoords, playerlocation)
	bloqtecla = true
    local coords = GetEntityCoords(playerPed)
	playerPed = GetPlayerPed(-1)
    loadanimdict('mini@cpr@char_b@cpr_str')
    loadanimdict('mini@cpr@char_b@cpr_def')
	entidadvisible()
	TriggerEvent('animrevive:loopfalse')
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false) 
	SetEntityInvincible(playerPed, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	StopScreenEffect('DeathFailOut')
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z-0.50)
	SetEntityHeading(GetPlayerPed(-1), playerheading - 270.0) 

   			 TaskPlayAnim(playerPed, 'mini@cpr@char_b@cpr_def',  'cpr_intro', 8.0, 8.0, -1, 0, 0, false, false, false)
   			    Citizen.Wait(15800 - 900)
		    for i=1, 15, 1 do
		        Citizen.Wait(900)
		        TaskPlayAnim(playerPed, 'mini@cpr@char_b@cpr_str', 'cpr_pumpchest', 8.0, 8.0, -1, 0, 0, false, false, false)
		    end	
    		  TaskPlayAnim(playerPed, 'mini@cpr@char_b@cpr_str', 'cpr_success', 8.0, 8.0, 30590, 0, 0, false, false, false)	
    		  Citizen.Wait(30590)
    		  bloqtecla = false
end) 
RegisterNetEvent('anim:medico')
AddEventHandler('anim:medico', function()
	bloqtecla = true
    playerPed = GetPlayerPed(-1)
	loadanimdict('mini@cpr@char_a@cpr_def')
	loadanimdict('mini@cpr@char_a@cpr_str')
     TaskPlayAnim(playerPed, 'mini@cpr@char_a@cpr_def', 'cpr_intro', 8.0, 8.0, -1, 0, 0, false, false, false)                      	
     	 Citizen.Wait(15800 - 900)
		for i=1, 15, 1 do
			Citizen.Wait(900)
				TaskPlayAnim(playerPed, 'mini@cpr@char_a@cpr_str','cpr_pumpchest', 8.0, 8.0, -1, 0, 0, false, false, false)
		end
	  TaskPlayAnim(playerPed,'mini@cpr@char_a@cpr_str', 'cpr_success', 8.0, 8.0, 30590, 0, 0, false, false, false)
            Citizen.Wait(33590 - 3000)
            bloqtecla = false
end) 
---------------------------------
---FIN NUEVA ANIMACION REVIVIR --
---------------------------------
-----------------------------
---  LEVANTAR HERIDO       ---
------------------------------
RegisterNetEvent('commando:levantarherido')
AddEventHandler('commando:levantarherido', function()
  		 local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 1.1 then
				exports['mythic_notify']:DoCustomHudText('nohayjugadorescerca', 'no_players',3500)
				else	
                local dict,base = "anim@heists@box_carry@","idle"
			        loadanimdict(dict)
					TriggerServerEvent('esx_cargarherido:levantar', GetPlayerServerId(closestPlayer))
                    TriggerServerEvent("cargarherido:mensaje", GetPlayerServerId(closestPlayer))
				 	TaskPlayAnim(GetPlayerPed(-1), dict,"idle", 8.0, 8.0, -1, 50, 0, false, false, false)
	end
end)

local estadoherido = false

RegisterNetEvent('esx_cargarherido:anim')
AddEventHandler('esx_cargarherido:anim', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local lPed = GetPlayerPed(-1)	

	if isCarry == false then
		estadoherido = true
		LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
  	Citizen.CreateThread(function()
		 while estadoherido do
		 Citizen.Wait(0)
		TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
		 end
	 end)
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
	Citizen.CreateThread(function()
        while estadoherido do
          Citizen.Wait(0)
           if not IsEntityPlayingAnim(GetPlayerPed(-1),"amb@code_human_in_car_idles@generic@ps@base", "base", 3) then
              TaskPlayAnim(GetPlayerPed(-1),"amb@code_human_in_car_idles@generic@ps@base", "base", 1.0, -1, -1, 10, 0, 0, 0, 0)
             end
        end
      end)

		isCarry = true
	else
	  DetachEntity(GetPlayerPed(-1), true, false)
	  estadoherido = false
	  ClearPedTasks(GetPlayerPed(-1))
      ClearPedSecondaryTask(GetPlayerPed(-1))
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ClearPedTasksImmediately(targetPed)
		isCarry = false
	Citizen.Wait(250)			
	TriggerEvent("random:animacion")
	end

end)
------------------------------
---  LEVANTAR HERIDO       ---
------------------------------

function  OpenMobileAmbulanceActionsMenu2()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'EMS Menu',
		align    = 'top-right',
		elements = {
			{label = 'Interaccion Cuidadana', value = 'citizen_interaction'},
			{label = 'Asistencia Medica', value = 'vehicle_interaction'},
			
	}}, function(data, menu)

		if data.current.value == 'citizen_interaction' then

			local elements = {
			    {label = 'Poner en el Vehiculo', value = 'vehiculo'},
			    {label = 'Sacar del Vehiculo', value = 'vehiculo2'},

				--{label = 'Revisar Pertenencias', value = 'catearems'},
				{label = 'Factura', value = 'factura'}
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = 'Interaccion Cuidadana',
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
               	if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 2.0 then
					local action = data2.current.value

					if action == 'vehiculo' then

							TriggerServerEvent('esx_sem:putInVehicle', GetPlayerServerId(closestPlayer))

					elseif action == 'vehiculo2' then

							TriggerServerEvent('esx_sem:OutVehicle', GetPlayerServerId(closestPlayer))

					elseif action == 'catearems' then

							TriggerServerEvent('esx_emsrevision:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
	                 		OpenBodySearchMenu(closestPlayer)					
							ESX.UI.Menu.CloseAll() 

					elseif action == 'factura' then 
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
							title = _U('ems_menu')
						}, function(data, menu)
							local amount = tonumber(data.value)

							if amount == nil or amount < 0 then
								exports['mythic_notify']:DoCustomHudText('cajaroja',U('invalid_amount'),7000)				
								--ESX.ShowNotification(_U('invalid_amount'))
							else
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer == -1 or closestDistance > 3.0 then
								exports['mythic_notify']:DoCustomHudText('cajamostaza',_U('no_players'),7000)					
									--ESX.ShowNotification(_U('no_players'))
								else
									menu.close()
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', _U('ambulance'), amount)
								end
							end
									end, function(data, menu)
										menu.close()
									end)
						
					end
			
				else
				exports['mythic_notify']:DoCustomHudText('cajamostaza', _U('no_players_nearby'),7000)
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()	
				table.insert(elements, {label = 'Estabilizando', value = 'rev1'})
				table.insert(elements, {label = '[RCP]', value = 'rev2'})
				table.insert(elements, {label = 'Tratar Heridas', value = 'curar1'})
		      	table.insert(elements, {label = 'Tratar Heridas graves', value = 'curar2'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = 'Asistencia Medica',
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				local action  = data2.current.value
				if action == 'rev1' then
				IsBusy = true

			ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
				local target, distance = ESX.Game.GetClosestPlayer()
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
							--	if IsPedDeadOrDying(closestPlayerPed, 1) then

				                   local target, distance = ESX.Game.GetClosestPlayer()
								   playerheading = GetEntityHeading(GetPlayerPed(-1))
								   playerlocation = GetEntityForwardVector(PlayerPedId())
								   playerCoords = GetEntityCoords(GetPlayerPed(-1))						
								   local target_id = GetPlayerServerId(target)
			                       local searchPlayerPed = GetPlayerPed(target)
								   local closestPlayerPed = GetPlayerPed(closestPlayer)
                      			   local health = GetEntityHealth(closestPlayerPed)

                  				 if health > 0 or IsEntityDead(searchPlayerPed)  then

									   local playerPed = PlayerPedId()

				             ClampGameplayCamPitch(0.0, -90.0)
					         TriggerServerEvent("anim:revivirfastsv",target_id, playerheading, playerCoords, playerlocation)
                                                                        Citizen.Wait(15000)
									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
									-- Show revive award?
                           if Config.ReviveReward > 0 then
						   exports['mythic_notify']:DoCustomHudText('success',_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward),4500)
							--ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else									
							 exports['mythic_notify']:DoCustomHudText('success',_U('revive_complete', GetPlayerName(closestPlayer)),5500)				
							--ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end															
								else
								exports['mythic_notify']:DoCustomHudText('nohayjugadorescerca', ' El Sujeto no esta en estado critico. ',2500)
									--ESX.ShowNotification(_U('player_not_unconscious'))
								end						
							else
							 exports['mythic_notify']:DoCustomHudText('error', _U('not_enough_medikit') ,3000)	
								--ESX.ShowNotification(_U('not_enough_medikit'))
				     		end
							IsBusy = false
						end, 'medikit')
				elseif action == 'rev2' then

			ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
				local target, distance = ESX.Game.GetClosestPlayer()

				if quantity > 0 then
							local closestPlayerPed = GetPlayerPed(closestPlayer)
							--	if IsPedDeadOrDying(closestPlayerPed, 1) then
				                   local target, distance = ESX.Game.GetClosestPlayer()
								   playerheading = GetEntityHeading(GetPlayerPed(-1))
								   playerlocation = GetEntityForwardVector(PlayerPedId())
								   playerCoords = GetEntityCoords(GetPlayerPed(-1))						
								   local target_id = GetPlayerServerId(target)
			                       local searchPlayerPed = GetPlayerPed(target)
								   local closestPlayerPed = GetPlayerPed(closestPlayer)
                      			   local health = GetEntityHealth(closestPlayerPed)


					if health > 0 or IsEntityDead(searchPlayerPed)  then

					    TriggerServerEvent('ems:nuevobb',target_id, playerheading, playerCoords, playerlocation)
                                                                        Citizen.Wait(60000)
									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                           if Config.ReviveReward > 0 then							   
						   exports['mythic_notify']:DoCustomHudText('success',_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward),4500)
									else								
							 exports['mythic_notify']:DoCustomHudText('success',_U('revive_complete', GetPlayerName(closestPlayer)),5500)
									end
																
								else
								exports['mythic_notify']:DoCustomHudText('nohayjugadorescerca', ' El Sujeto no esta en estado critico. ',2500)
								end						
							else
							 exports['mythic_notify']:DoCustomHudText('error', _U('not_enough_medikit') ,3000)	
							end

							IsBusy = false


						end, 'medikit')		
				elseif action == 'curar1' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)
								if health > 0 then
									local playerPed = PlayerPedId()
									IsBusy = true
										exports['mythic_notify']:DoCustomHudText('cajaverde',_U('heal_inprogress'),8000)							
									--ESX.ShowNotification(_U('heal_inprogress'))								
								TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
								 exports['progressBars']:startUI(5000, "Aplicande Vendajes")
									Citizen.Wait(5000)
									ClearPedTasks(playerPed)
									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')															
			 						exports['mythic_notify']:DoCustomHudText('cajaverde',_U('heal_complete', GetPlayerName(closestPlayer)),5500)						
									--ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false

								else
								 exports['mythic_notify']:DoCustomHudText('cajamostaza',_U('player_not_conscious'),7000)					
								--ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								exports['mythic_notify']:DoCustomHudText('cajaroja',_U('not_enough_bandage'),7000)
								--ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')
				elseif action == 'curar2' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true					
							exports['mythic_notify']:DoCustomHudText('cajaverde',_U('heal_inprogresse'),8000)
								
									--ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									 exports['progressBars']:startUI(7000, "Aplicando medkits")
									Citizen.Wait(7000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
								          exports['mythic_notify']:DoCustomHudText('cajaverde',_U('heal_complete', GetPlayerName(closestPlayer)),8000)								
									--ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
							exports['mythic_notify']:DoCustomHudText('cajamostaza',_U('player_not_conscious'),8000)
									--ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
							exports['mythic_notify']:DoCustomHudText('cajaroja',_U('not_enough_medikit'),8000)
								--ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

				end

						else
							exports['mythic_notify']:DoCustomHudText('cajamostaza', _U('no_players_nearby'),7000)
						end
			end, function(data2, menu2)
				menu2.close()
			end)
			
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()
	DoScreenFadeOut(800)
	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end
	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)
		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end


DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 400
	DrawRect(_x, _y + 0.0115, 0.035 + factor, 0.035, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum
		local coords      = GetEntityCoords(PlayerPedId())

		for hospitalNum,hospital in pairs(Config.Hospitals) do
			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

         	if GetDistanceBetweenCoords(coords, 313.69, -590.63,28.95, true) < 3.0 then
                DrawText3Ds(vector3(313.69, -590.63,28.95), "Presiona [E] para entrar al menu de medicos", 0.37)
			end	

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				end
			end
			-- Pharmacies
			for k,v in ipairs(hospital.Pharmacies) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

         	if GetDistanceBetweenCoords(coords, 355.30, -577.43,  28.85, true) < 2.0 then
                DrawText3Ds(vector3(355.30, -577.43,  28.85), "Presiona [E] para entrar al menu la farmacia", 0.37)
			end	

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
				end
			end
			-- Vehicle Spawners
			for k,v in ipairs(hospital.Vehicles) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
				end
			end

			-- Helicopter Spawners
			for k,v in ipairs(hospital.Helicopters) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
				end
			end

			-- Fast Travels
			for k,v in ipairs(hospital.FastTravels) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end


				if distance < v.Marker.x then
					FastTravel(v.To.coords, v.To.heading)
				end
			end

			-- Fast Travels (Prompt)
			for k,v in ipairs(hospital.FastTravelsPrompt) do
				local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
				end
			end

		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls

bosscords = {x=339.35 , y= -595.21 , z=42.33 }
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)


local pedcoords = GetEntityCoords(GetPlayerPed(-1))

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
	
if GetDistanceBetweenCoords(pedcoords,  bosscords.x, bosscords.y,bosscords.z, true) < 10.0 then
DrawMarker(1, bosscords.x, bosscords.y,bosscords.z-0.30, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.8, 204, 204, 0, 100, false, false, 2, false, nil, nil, false)
	 if IsControlJustReleased(0, Keys['E']) then
    OpenAmbulanceActionsMenuBoss()
    end

end

end

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end
				CurrentAction = nil
			end
		--elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
		elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu2()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-right',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
						name  = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						type  = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'top-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									
exports['mythic_notify']:DoCustomHudText('cajaverde', _U('garage_released'),7500)
		--ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
	exports['mythic_notify']:DoCustomHudText('cajaroja', _U('garage_notavailable'),7500)
					
							--ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
		exports['mythic_notify']:DoCustomHudText('cajaroja', _U('garage_empty'),7500)
		   --ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'car')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else	
exports['mythic_notify']:DoCustomHudText('cajamostaza', _U('garage_store_nearby'),7500)
	
		--ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end
	ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				while IsBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)
			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end
			IsBusy = false
			exports['mythic_notify']:DoCustomHudText('cajaverde', _U('garage_has_stored'),7500)		
			--ESX.ShowNotification(_U('garage_has_stored'))
		else
			exports['mythic_notify']:DoCustomHudText('cajaroja', _U('garage_has_notstored'),7500)	
			--ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end
	if found then
		return true, foundSpawnPoint
	else
exports['mythic_notify']:DoCustomHudText('cajaroja', _U('garage_blocked'),7500)
	
		--ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('helicopter_garage'), action = 'garage'},
		{label = _U('helicopter_store'), action = 'store_garage'},
		{label = _U('helicopter_buy'), action = 'buy_helicopter'}
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title    = _U('helicopter_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k,helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name  = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						type  = 'helicopter'
					})
				end
			else
	exports['mythic_notify']:DoCustomHudText('cajaroja', _U('helicopter_notauthorized'),7500)
		
				--ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end
			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}
			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
						title    = _U('helicopter_garage_title'),
						align    = 'top-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									
		exports['mythic_notify']:DoCustomHudText('cajaverde', _U('garage_released'),7500)
								
									--ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
				exports['mythic_notify']:DoCustomHudText('cajamostaza', _U('garage_notavailable'),7500)
				
							--ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
				
	exports['mythic_notify']:DoCustomHudText('cajaroja', _U('garage_empty'),7500)
				--ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'helicopter')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('esx_ambulancejob:buyJobVehicle', function (bought)
					if bought then
					
	exports['mythic_notify']:DoCustomHudText('cajaverde', _U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)),7500)
					
				--ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
				
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
				
						ESX.Game.Teleport(playerPed, restoreCoords)
					else
					
		exports['mythic_notify']:DoCustomHudText('cajaroja', _U('vehicleshop_money'),7500)
				
						--ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
		end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)
function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)
			drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)

		end
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-right',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
			{label = _U('pharmacy_take', _U('pildora')), value = 'pildora'},
			{label = _U('pharmacy_take', _U('recetamed')), value = 'recetamed'},
			
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end
function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end
		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		exports['mythic_notify']:DoCustomHudText('cajamostaza', _U('no_vehicles'),7500)
		--ESX.ShowNotification(_U('no_vehicles'))
	end
end
RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)

	elseif healType == 'verysmall' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
		SetEntityHealth(playerPed, newHealth)
	end
	if not quiet then
	exports['mythic_notify']:DoCustomHudText('cajaverde', _U('healed'),7500)
		--ESX.ShowNotification(_U('healed'))
	end
end)




-------animacion cpr----------
function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName,8.0, -8.0, -1, 0, 0, false, false, false)
	RemoveAnimDict(animDict)
end
-------animacion cpr----------

RegisterNetEvent('esx_sem:putInVehicle')
AddEventHandler('esx_sem:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	--if not IsHandcuffed then
		--return
--end
	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)
RegisterNetEvent('esx_sem:OutVehicle')
AddEventHandler('esx_sem:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
	return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)
RegisterCommand('sacardelcarro',function()
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		local sem  = ESX.PlayerData.job.name == 'ambulance'	
   if sem then
       if closestPlayer ~= -1 and closestDistance <= 2.0 then 
		TriggerServerEvent('esx_sem:OutVehicle', GetPlayerServerId(closestPlayer))			
		     else
			--ESX.ShowNotification(_U('no_players_nearby'))
			exports['mythic_notify']:DoCustomHudText('nohayjugadorescerca', 'No hay ningun jugador cerca',2200)
             end
	else
	exports['mythic_notify']:DoCustomHudText('noereseljobquenecesita', 'No eres sem para usar este comando',3000)
       	--ESX.ShowNotification('NO ERES UN POLICIA PARA USAR ESTE COMANDO.')
   end 
end, false)	
TriggerEvent('chat:addSuggestion', '/sacardelcarro', 'Este comando es para sacar del vehiculo solo para sem.', {})

--##########################-------------############---------------###--

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

