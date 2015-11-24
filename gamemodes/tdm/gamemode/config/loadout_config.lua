------------------------------------------
--			PLAYER CLASSES  			--
------------------------------------------
--
--	Note for server owners:
--	To create a class follow the basic class examples below.
--
--	Be careful of lua table formatting, and use the correct use of commas.
--
--	If you want classes to have more than one player model, see the below example for table formatting:
--
--
--		playerModels = {
--
--			"models/player/bill.mdl",
--			"models/player/ted.mdl",
--			"models/player/johnny.mdl"
--
--		},
--
--
--	Notice how the last entry does not have a comma at the end, and if there is only a single entry there is no comma.
--
--	Good luck!

PlayerClasses = {

	{
		name = "assault",
		displayName = "Assault",
		playerModels = {

			"models/player/barney.mdl"

		},
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 200,
		runSpeed = 285
	},

	{
		name = "commando",
		displayName = "Commando",
		playerModels = {

			"models/player/alyx.mdl"

		},
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 200,
		runSpeed = 290
	},

	{
		name = "heavy",
		displayName = "Heavy",
		playerModels = {

			"models/player/police.mdl"

		},
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 190,
		runSpeed = 280
	},

	{
		name = "infantry",
		displayName = "Infantry",
		playerModels = {

			"models/player/leet.mdl"

		},
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 210,
		runSpeed = 290
	},

	{
		name = "sniper",
		displayName = "Sniper",
		playerModels = {

			"models/player/odessa.mdl"

		},
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 195,
		runSpeed = 280
	}

};

--If you want to disable ranks.
PlayerRanksEnabled = true

PlayerRanks = {
	
	{
		level = 0,
		rank = "Private First Class"
	},

	{
		level = 2,
		rank = "Private First Class II"
	},

	{
		level = 3,
		rank = "Private First Class III"
	},

	{
		level = 4,
		rank = "Lance Corporal"
	},

	{
		level = 5,
		rank = "Lance Corporal II"
	},

	{
		level = 6,
		rank = "Lance Corporal III"
	},

	{
		level = 7,
		rank = "Corporal"
	},

	{
		level = 8,
		rank = "Corporal II"
	},

	{
		level = 9,
		rank = "Corporal III"
	},

	{
		level = 10,
		rank = "Sergeant"
	},

	{
		level = 11,
		rank = "Sergeant II"
	},

	{
		level = 12,
		rank = "Sergeant III"
	},

	{
		level = 13,
		rank = "Staff Sergeant"
	},

	{
		level = 14,
		rank = "Staff Sergeant II"
	},

	{
		level = 15,
		rank = "Staff Sergeant III"
	},

	{
		level = 16,
		rank = "Gunnery Sergeant"
	},

	{
		level = 17,
		rank = "Gunnery Sergeant II"
	},

	{
		level = 18,
		rank = "Gunnery Sergeant III"
	},

	{
		level = 19,
		rank = "Master Sergeant"
	},

	{
		level = 20,
		rank = "Master Sergeant II"
	},

	{
		level = 21,
		rank = "Master Sergeant III"
	},

	{
		level = 22,
		rank = "Master Gunnery Sergeant"
	},

	{
		level = 23,
		rank = "Master Gunnery Sergeant II"
	},

	{
		level = 24,
		rank = "Master Gunnery Sergeant III"
	},

	{
		level = 25,
		rank = "Second Lieutenant"
	},

	{
		level = 26,
		rank = "Second Lieutenant II"
	},

	{
		level = 27,
		rank = "Second Lieutenant III"
	},

	{
		level = 28,
		rank = "Lieutenant"
	},

	{
		level = 29,
		rank = "Lieutenant II"
	},

	{
		level = 30,
		rank = "Lieutenant III"
	}

};

ClassLoadouts = {

------------------------------------------
--		ASSAULT CLASS LOADOUT  			--
------------------------------------------

-- .357 Magnum  --all
-- 9mm Pistol   --all
-- mp7  -- infantry
-- AR2 Pulse-Rifle -- assault
-- Shotgun? -- heavy
-- Crossbow -- commando

	["assault"] = {

		PrimaryWeapons_tbl = {
			{
				name = "AK47",
				weapon_tag = "weapon_ttt_ak47",
				starting_ammo = 140,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{	
				name = "M16",
				weapon_tag = "weapon_ttt_m16",
				starting_ammo = 120,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{	
				name = "Famas",
				weapon_tag = "weapon_ttt_famas",
				starting_ammo = 120,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{	
				name = "Galil",
				weapon_tag = "weapon_ttt_galil",
				starting_ammo = 120,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 6,
				desc = "Soon"
			},

			{	
				name = "Silenced M4A1",
				weapon_tag = "weapon_ttt_silm4a1",
				starting_ammo = 130,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 9,
				desc = "Soon"
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 8,
				desc = "Soon"
			}
		};

		TertiaryWeapons_tbl = {
			{
				name = "Smoke Grenade",
				weapon_tag = "weapon_ttt_smokegrenade",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Flashbang Grenade",
				weapon_tag = "weapon_ttt_flashbang",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "Frag Grenade",
				weapon_tag = "weapon_ttt_frag",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			}
		};

	};



------------------------------------------
--		INFANTRY CLASS LOADOUT  		--
------------------------------------------

	["infantry"] = {

		PrimaryWeapons_tbl = {
			{
				name = "MAC10",
				weapon_tag = "weapon_zm_mac10",
				starting_ammo = 150,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "MP5",
				weapon_tag = "weapon_ttt_mp5",
				starting_ammo = 150,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "P90",
				weapon_tag = "weapon_ttt_p90",
				starting_ammo = 200,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 9,
				desc = "Soon"
			},

			{
				name = "Silenced TMP",
				weapon_tag = "",
				starting_ammo = 150,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "UMP",
				weapon_tag = "",
				starting_ammo = 150,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 8,
				desc = "Soon"
			}
		};

		TertiaryWeapons_tbl = {
			{
				name = "Smoke Grenade",
				weapon_tag = "weapon_ttt_smokegrenade",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Flashbang Grenade",
				weapon_tag = "weapon_ttt_flashbang",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "Frag Grenade",
				weapon_tag = "weapon_ttt_frag",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			}
		};

	};

------------------------------------------
--		HEAVY CLASS LOADOUT  			--
------------------------------------------

	["heavy"] = {

		PrimaryWeapons_tbl = {
			{
				name = "Shotgun",
				weapon_tag = "weapon_zm_shotgun",
				starting_ammo = 32,
				starting_ammo_type = "buckshot",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Pump Shotgun",
				weapon_tag = "weapon_ttt_pump",
				starting_ammo = 18,
				starting_ammo_type = "buckshot",
				material = "Soon",
				required_level = 3,
				desc = "Soon"
			}

		};
		SecondaryWeapons_tbl = {
			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 8,
				desc = "Soon"
			}
		};

		TertiaryWeapons_tbl = {
			{
				name = "Smoke Grenade",
				weapon_tag = "weapon_ttt_smokegrenade",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Flashbang Grenade",
				weapon_tag = "weapon_ttt_flashbang",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "Frag Grenade",
				weapon_tag = "weapon_ttt_frag",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			}
		};

	};


------------------------------------------
--		COMMANDO CLASS LOADOUT  		--
------------------------------------------

	["commando"] = {

		PrimaryWeapons_tbl = {
			{
				name = "SG552",
				weapon_tag = "weapon_ttt_sg552",
				starting_ammo = 130,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "AUG",
				weapon_tag = "weapon_ttt_aug",
				starting_ammo = 130,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 6,
				desc = "Soon"
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 8,
				desc = "Soon"
			}
		};

		TertiaryWeapons_tbl = {
			{
				name = "Smoke Grenade",
				weapon_tag = "weapon_ttt_smokegrenade",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Flashbang Grenade",
				weapon_tag = "weapon_ttt_flashbang",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "Frag Grenade",
				weapon_tag = "weapon_ttt_frag",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			}
		};

	};


------------------------------------------
--		SNIPER CLASS CONFIG   			--
------------------------------------------

	["sniper"] = {

		PrimaryWeapons_tbl = {
			{
				name = "Scout Rifle",
				weapon_tag = "weapon_zm_rifle",
				starting_ammo = 20,
				starting_ammo_type = "357",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{	
				name = "SIG SG 550",
				weapon_tag = "weapon_ttt_sg550",
				starting_ammo = 15,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{	
				name = "G3SG1",
				weapon_tag = "weapon_ttt_g3",
				starting_ammo = 20,
				starting_ammo_type = "357",
				material = "Soon",
				required_level = 12,
				desc = "Soon"
			},

			{	
				name = "Magnum Sniper Rifle",
				weapon_tag = "weapon_ttt_awp",
				starting_ammo = 10,
				starting_ammo_type = "tbd",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			}


		};
		
		SecondaryWeapons_tbl = {
			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 2,
				desc = "Soon"
			},

			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 4,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 8,
				desc = "Soon"
			}
		};

		TertiaryWeapons_tbl = {
			{
				name = "Smoke Grenade",
				weapon_tag = "weapon_ttt_smokegrenade",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Flashbang Grenade",
				weapon_tag = "weapon_ttt_flashbang",
				material = "Soon",
				required_level = 55,
				desc = "Soon"
			},

			{
				name = "Frag Grenade",
				weapon_tag = "weapon_ttt_frag",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			}
		};

	};

};