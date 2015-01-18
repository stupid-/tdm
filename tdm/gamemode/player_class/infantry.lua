AddCSLuaFile()

DEFINE_BASECLASS( "player_default" )

local PLAYER = {} 

PLAYER.DisplayName			= "Infantry"
PLAYER.WalkSpeed 			= 210
PLAYER.RunSpeed				= 315
PLAYER.CrouchedWalkSpeed 	= 0.32		-- Multiply move speed by this when crouching
PLAYER.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
PLAYER.JumpPower			= 210		-- How powerful our jump should be
PLAYER.CanUseFlashlight     = true		-- Can we use the flashlight
PLAYER.MaxHealth			= 100		-- Max health we can have
PLAYER.StartHealth			= 100		-- How much health we start with
PLAYER.StartArmor			= 0			-- How much armour we start with
PLAYER.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide 	= true		-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers			= true		-- Automatically swerves around other players
PLAYER.UseVMHands			= true		-- Uses viewmodel hands

function PLAYER:Loadout()

	self.Player:GiveAmmo( 80,	"pistol", 		true )
	self.Player:GiveAmmo( 90,	"smg1", 		true )
	self.Player:Give( "weapon_ttt_glock" )
	self.Player:Give( "weapon_zm_mac10" )
	self.Player:Give( "weapon_crowbar" )

end

function PLAYER:SetModel()

	self.Player:SetModel( "models/player/leet.mdl" )

end

player_manager.RegisterClass( "infantry", PLAYER, "player_default" )