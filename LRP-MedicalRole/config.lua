
Config                            = {}
local second = 1000
local minute = 60 * second
Config.Locale = 'en'

Config.DrawDistance               = 100.0
Config.Marker                     = { type = 1, x = 1.3, y = 1.3, z = 0.5, r = 230, g = 5, b = 10, a = 100, rotate = true }
Config.ReviveReward               = 80  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.EarlyRespawnTimer          = 8 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 6 * minute 
Config.EnablePlayerManagement     = true
Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(361.55, -591.92, 43.32), heading = 62.41 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(374.68, -595.63, 28.82),
			sprite = 61,
			scale  = 1.0,
			color  = 2
		},

		AmbulanceActions = {
			vector3(298.63, -598.16, 42.28)
		},

-- DECOMENT THIS IF YOU WILL USE THE DEFAULT PHARMACY.
-- DESCOMENTAR ESTO SI USARAS LA FARMACIA POR DEFECTO. 
		Pharmacies = {
			--vector3(319.4, -593.6,  43.29) 
		},

		Vehicles = {
			{
				Spawner = vector3(295.33, -601.87,43.26),
				InsideShop = vector3(292.16, -611.73, 43.39),
				
				Marker = { type = 36, x = 1.5, y = 1.5, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(274.15, -608.16, 42.9), heading = 275.91, radius = 5.0 },
					{ coords = vector3(287.9, -602.79,42.9), heading = 334.5, radius = 5.0 },
					{ coords = vector3(292.3, -590.69, 42.9), heading = 335.43, radius = 6.0 }
				}
			}
		},



		Helicopters = {
			{
				Spawner = vector3(351.51, -575.81, 74.17),
				InsideShop = vector3(352.0, -587.9, 74.17),
				Marker = { type = 34, x = 2.5, y = 2.5, z = 2.0, r = 230, g = 5, b = 10, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(352.0, -587.9, 74.17), heading = 275.66, radius = 10.0 }
					--{ coords = vector3(352.0, -587.9, 74.17), heading = 142.7, radius = 10.0 }
				}
			}
		},



		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

--------------------- Enfermero --------------------
	ambulance = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}
	},
---------------------------------------------------------------	

--------------------- Residente --------------------
	doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}	
	},
	
---------------------------------------------------------------	
	
	
--------------------- Medico --------------------
	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}

	},
	
-----------------------------------------------------------------------


--------------------- Medico de Cabezera --------------------
	medicodecabezera = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}

	},
	
-----------------------------------------------------------------------

--------------------- Sub Director (es) --------------------
	subdirector = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}

	},
-----------------------------------------------------------------------


--------------------- Director SEM --------------------


	boss = {
		{ model = 'ambulance', label = 'Ambulancia', price = 5000},
		{ model = 'policeb', label = 'Moto Medic', price = 5000}

	}

}
---------------------------------------------------------------	

Config.AuthorizedHelicopters = {

	ambulance = {
		{ model = 'POLMAV', label = 'HELI EMS', price = 1500000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'POLMAV', label = 'HELI EMS', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	medicodecabezera = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
			{ model = 'POLMAV', label = 'HELI EMS', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	subdirector = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
			{ model = 'POLMAV', label = 'HELI EMS', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
			{ model = 'POLMAV', label = 'HELI EMS', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}
