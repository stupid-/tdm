------------------------------------------
--			PLAYER CLASSES  			--
------------------------------------------

PlayerClasses = {

	{
		name = "assault",
		displayName = "Assault",
		playerModel = "models/player/barney.mdl",
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 200,
		runSpeed = 285
	},

	{
		name = "commando",
		displayName = "Commando",
		playerModel = "models/player/alyx.mdl",
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 200,
		runSpeed = 290
	},

	{
		name = "heavy",
		displayName = "Heavy",
		playerModel = "models/player/police.mdl",
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 190,
		runSpeed = 280
	},

	{
		name = "infantry",
		displayName = "Infantry",
		playerModel = "models/player/leet.mdl",
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 210,
		runSpeed = 290
	},

	{
		name = "sniper",
		displayName = "Sniper",
		playerModel = "models/player/odessa.mdl",
		defaultPrimary = "weapon_ttt_ak47",
		defaultSecondary = "weapon_ttt_sipistol",
		defaultTertiary = "weapon_ttt_smokegrenade",
		walkSpeed = 195,
		runSpeed = 280
	}

};

ClassLoadouts = {

------------------------------------------
--		ASSAULT CLASS LOADOUT  			--
------------------------------------------

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
				required_level =12,
				desc = "Soon"
			},

			{	
				name = "Famas",
				weapon_tag = "weapon_ttt_famas",
				starting_ammo = 120,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 24,
				desc = "Soon"
			},

			{	
				name = "Galil",
				weapon_tag = "weapon_ttt_galil",
				starting_ammo = 120,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 31,
				desc = "Soon"
			},

			{	
				name = "Silenced M4A1",
				weapon_tag = "weapon_ttt_silm4a1",
				starting_ammo = 130,
				starting_ammo_type = "SMG1",
				material = "Soon",
				required_level = 54,
				desc = "Soon"
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 15,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 51,
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
			}
		};

	};



------------------------------------------
--		INFANTRY CLASS LOADOUT  		--
------------------------------------------

	--p90
	--mp5

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
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 15,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 51,
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
				required_level = 18,
				desc = "Soon"
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 15,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 51,
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
			}

		};

		SecondaryWeapons_tbl = {
			{
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 15,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 51,
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
				required_level = 35,
				desc = "Soon"
			},

			{	
				name = "G3SG1",
				weapon_tag = "weapon_ttt_g3",
				starting_ammo = 20,
				starting_ammo_type = "357",
				material = "Soon",
				required_level = 50,
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
				name = "Silenced Pistol",
				weapon_tag = "weapon_ttt_sipistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 0,
				desc = "Soon"
			},

			{
				name = "Five-Seven",
				weapon_tag = "weapon_zm_pistol",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 5,
				desc = "Soon"
			},

			{
				name = "Glock-18",
				weapon_tag = "weapon_ttt_glock",
				starting_ammo = 60,
				starting_ammo_type = "Pistol",
				material = "Soon",
				required_level = 15,
				desc = "Soon"
			},

			{
				name = "Desert Eagle",
				weapon_tag = "weapon_zm_revolver",
				starting_ammo = 24,
				starting_ammo_type = "AlyxGun",
				material = "Soon",
				required_level = 51,
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
			}
		};

	};

};