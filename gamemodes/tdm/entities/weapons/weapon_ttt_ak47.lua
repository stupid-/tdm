AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "AK47"
end

SWEP.Slot        = 2
--SWEP.SlotPos     = 1

SWEP.Weight     = 5
SWEP.AutoSwitchTo   = false
SWEP.AutoSwitchFrom   = false

-- Always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"

-- Standard GMod values
SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Delay = 0.095
SWEP.Primary.Recoil = 1.75
SWEP.Primary.Cone = 0.02
SWEP.Primary.Damage = 16
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 70
SWEP.Primary.DefaultClip = 35
SWEP.Primary.Sound = Sound( "Weapon_AK47.Single" )
SWEP.HeadshotMultiplier = 3

-- Model settings
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.IronSightsPos = Vector( -6.518, -4.646, 2.134 )
SWEP.IronSightsAng = Vector( 2.737, 0.158, 0 )

--- TTT config values

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_HEAVY

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2, then this gun can
-- be spawned as a random weapon.
SWEP.AutoSpawnable = true

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = { nil }

-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.
SWEP.InLoadoutFor = { nil }

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = false

-- Equipment menu information is only needed on the client
if CLIENT then
   -- Text shown in the equip menu
   SWEP.EquipMenuData = {
      type = "Weapon",
      desc = "Very high damage assault rifle.\n\nHas very high recoil."
   }
end