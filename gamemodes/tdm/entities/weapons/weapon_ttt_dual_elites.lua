AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "Dual Elites"
end

SWEP.Slot        = 1
--SWEP.SlotPos     = 1

SWEP.UseHands = true -- should the hands be displayed
SWEP.ViewModelFlip = false -- should the weapon be hold with the left or the right hand
SWEP.ViewModelFOV = 55

-- always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"

--[[Default GMod values]]--
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Delay = 0.15
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Cone = 0.025
SWEP.Primary.Damage = 17
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Sound = Sound("Weapon_Elite.Single")

--[[Model settings]]--
SWEP.HoldType = "duel"
SWEP.ViewModel  = Model("models/weapons/cstrike/c_pist_elite.mdl")
SWEP.WorldModel = Model("models/weapons/w_pist_elite.mdl")

--[[TTT config values]]--

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_PISTOL

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2,
-- then this gun can be spawned as a random weapon.
SWEP.AutoSpawnable = true

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true
