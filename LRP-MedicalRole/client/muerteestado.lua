

local Keys = {
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


local isDead = false
local deathCoords
ESX = nil
Citizen.CreateThread(function()
  while true do
    Wait(5)
    if ESX ~= nil then
    else
      ESX = nil
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
  end
end)

RegisterNetEvent('anim:animloop')
AddEventHandler('anim:animloop', function()
       if not IsEntityPlayingAnim(GetPlayerPed(-1), "mp_arresting", "idle", 3) then
            ClearPedTasksImmediately(GetPlayerPed(-1))
       end
end)

RegisterNetEvent('random:animacion')
AddEventHandler('random:animacion', function()

  local ped = PlayerPedId()
  local animacionrandom  = math.random(1,50)
  local playerPed  = GetPlayerPed(-1)

	  loadanimdict('combat@damage@writhe')
	  loadanimdict('combat@damage@writheidle_a')
	  loadanimdict('combat@damage@writheidle_b')
	  loadanimdict('combat@damage@writheidle_c')
	  loadanimdict('combat@damage@rb_writhe')

  local lib1,anim1 ='combat@damage@writhe','writhe_loop'           --2500
  local lib2,anim2 ='combat@damage@writheidle_a','writhe_idle_a'   --13000
  local lib3,anim3 ='combat@damage@writheidle_b','writhe_idle_e'   --11166
  local lib4,anim4 ='combat@damage@writheidle_c','writhe_idle_g'   --8666
  local lib5,anim5 ='combat@damage@rb_writhe' ,'rb_writhe_loop'    --6500

		if animacionrandom  <= 10 then
		     TaskPlayAnim(playerPed,lib1,anim1, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 10 and  animacionrandom <= 20 then
			    TaskPlayAnim(playerPed,lib2,anim2, 8.0, 8.0, -1, 33, 0, 0, 0, 0)   

			elseif animacionrandom > 20 and  animacionrandom <= 30 then
			    TaskPlayAnim(playerPed,lib3,anim3, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 30 and  animacionrandom <= 40 then
			    TaskPlayAnim(playerPed,lib4,anim4, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    

			elseif animacionrandom > 40 and  animacionrandom <= 50 then
			    TaskPlayAnim(playerPed,lib5,anim5, 8.0, 8.0, -1, 33, 0, 0, 0, 0)    
		end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)     
   		local playerPed = PlayerPedId()

		   if isDead or GetEntityHealth(playerPed) <= 0 then

				  local lib, anim = 'combat@damage@rb_writhe'  , 'rb_writhe_loop' 
				  local lib1,anim1 ='combat@damage@writhe','writhe_loop'           --2500
				  local lib2,anim2 ='combat@damage@writheidle_a','writhe_idle_a'   --13000
				  local lib3,anim3 ='combat@damage@writheidle_b','writhe_idle_e'   --11166
				  local lib4,anim4 ='combat@damage@writheidle_c','writhe_idle_g'   --8666
				  local lib5,anim5 ='combat@damage@rb_writhe' ,'rb_writhe_loop'    --6500
				  local animm,libb = 'combat@damage@rb_writhe' , 'rb_writhe_loop' 

						  loadanimdict('combat@damage@writhe')
						  loadanimdict('combat@damage@writheidle_a')
						  loadanimdict('combat@damage@writheidle_b')
						  loadanimdict('combat@damage@writheidle_c')
						  loadanimdict('combat@damage@rb_writhe')

		      ClearPedTasks(GetPlayerPed(-1))
		      ClearPedSecondaryTask(GetPlayerPed(-1))
		      ClearPedTasksImmediately(GetPlayerPed(-1))
		      Citizen.Wait(750)
		      deathCoords = GetEntityCoords(playerPed)
		      SetEntityInvincible(GetPlayerPed(-1),true)
		      SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
		      TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
		      TriggerEvent('esx_basicneeds:resetStatus')
		      SetEntityHealth(playerPed, GetPedMaxHealth(playerPed))
		      SetEntityCoords(playerPed, deathCoords)
		      Citizen.Wait(500)
		      TriggerEvent("random:animacion")
		      Citizen.Wait(500)
				 if not IsEntityPlayingAnim(GetPlayerPed(-1),lib5,anim5, 3) and  not IsEntityPlayingAnim(GetPlayerPed(-1),lib1,anim1, 3) and  not IsEntityPlayingAnim(GetPlayerPed(-1),lib2,anim2, 3) and  not IsEntityPlayingAnim(GetPlayerPed(-1),lib3,anim3, 3) and  not IsEntityPlayingAnim(GetPlayerPed(-1),lib4,anim4, 3) then                 
				        TriggerEvent("random:animacion")
				     else
				         Citizen.Wait(1000)
				 end

		  end
   end
 end)

function loadanimdict(dictname)
  if not HasAnimDictLoaded(dictname) then
    RequestAnimDict(dictname) 
    while not HasAnimDictLoaded(dictname) do 
      Citizen.Wait(1)
    end
  end
end

----#### CODIGO CREADO Y MODIFICADO POR LATAMMRP
----#### Karenciita❤ y ShinxD