AddCSLuaFile()

SWEP.HoldType			= "grenade"

if CLIENT then
   SWEP.PrintName = "Smoke Grenade"
end

SWEP.Slot        = 3
--SWEP.SlotPos     = 1

SWEP.Weight     = 6
SWEP.AutoSwitchTo   = false
SWEP.AutoSwitchFrom   = true

SWEP.Base				= "weapon_tttbasegrenade"

SWEP.Spawnable = true

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel			= "models/weapons/cstrike/c_eq_smokegrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_smokegrenade.mdl"
SWEP.Weight			= 5
SWEP.AutoSpawnable      = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt_smokegrenade_proj"
end