if SERVER then
	AddCSLuaFile( "shared.lua" )
	resource.AddFile("tflppy/vgui/ttt/icon_elites.vmt")
	resource.AddFile("tflppy/vgui/ttt/icon_elites.vtf")
end

if CLIENT then
	SWEP.PrintName = "Dual Elites"
	SWEP.Author = "TFlippy"
	
	SWEP.Slot		= 1 -- add 1 to get the slot number key
	SWEP.Icon = "tflippy/vgui/ttt/icon_elites"
	
	SWEP.ViewModelFOV  = 60
	SWEP.ViewModelFlip = false
end

SWEP.Base				= "weapon_tttbase_tflippy"

SWEP.HoldType			= "duel"
SWEP.AutoSpawnable		= true
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = true
SWEP.Kind = WEAPON_PISTOL

SWEP.Primary.Delay		 = 0.115
SWEP.Primary.Recoil		= 2.75
SWEP.Primary.Automatic	= false
SWEP.Primary.SoundLevel = 105

SWEP.Primary.ClipSize	 = 24
SWEP.Primary.ClipMax	  = 60
SWEP.Primary.DefaultClip = 24
SWEP.Primary.Ammo		  = "pistol"
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.HeadshotMultiplier = 1.90

SWEP.Primary.Damage		= 16.7
SWEP.Primary.Cone		  = 0.065
SWEP.Primary.NumShots 	 = 0

--SWEP.IronSightsPos = Vector(-7.70, -12, 3.30 )
--SWEP.IronSightsAng = Vector( 2.00, 0.0, -13 )

SWEP.IronSightsPos = Vector(-5.565, -4.00, 3.00)
SWEP.IronSightsAng = Vector(0.00, 0.00, 0.00)

SWEP.UseHands	= true
SWEP.ViewModel	= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel	= "models/weapons/w_pist_elite.mdl"
SWEP.Primary.Sound = Sound("Weapon_Elite.Single")
SWEP.Secondary.Sound = Sound("Default.Zoom")