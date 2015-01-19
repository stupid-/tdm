AddCSLuaFile()

DEFINE_BASECLASS( "player_default" )

local PLAYER = {} 

PLAYER.DisplayName			= "Commando"
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 280
PLAYER.CrouchedWalkSpeed 	= 0.34		-- Multiply move speed by this when crouching
PLAYER.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
PLAYER.JumpPower			= 205		-- How powerful our jump should be
PLAYER.CanUseFlashlight     = true		-- Can we use the flashlight
PLAYER.MaxHealth			= 100		-- Max health we can have
PLAYER.StartHealth			= 100		-- How much health we start with
PLAYER.StartArmor			= 0			-- How much armour we start with
PLAYER.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide 	= true		-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers			= false		-- Automatically swerves around other players
PLAYER.UseVMHands			= true		-- Uses viewmodel hands

function PLAYER:Loadout()

	if self.Player:Team() == TEAM_RED then

		self.Player:GiveAmmo( 60,	"Pistol", 		true )
		self.Player:GiveAmmo( 90,	"smg1", 		true )
		self.Player:Give( "weapon_ttt_galil" )
		self.Player:Give( "weapon_zm_improvised" )
		self.Player:Give( "weapon_zm_pistol" )

	elseif self.Player:Team() == TEAM_BLUE then

		self.Player:GiveAmmo( 60,	"Pistol", 		true )
		self.Player:GiveAmmo( 90,	"smg1", 		true )
		self.Player:Give( "weapon_ttt_famas" )
		self.Player:Give( "weapon_crowbar" )
		self.Player:Give( "weapon_ttt_glock" )

	end

end

function PLAYER:SetModel()

	self.Player:SetModel( "models/player/alyx.mdl" )

end

player_manager.RegisterClass( "commando", PLAYER, "player_default" )