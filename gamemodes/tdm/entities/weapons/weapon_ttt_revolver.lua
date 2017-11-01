AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = ".357 Magnum"
end

SWEP.Slot        = 1
--SWEP.SlotPos     = 1

-- Always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"

-- Standard GMod values
SWEP.HoldType = "pistol"

SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Delay = 0.8
SWEP.Primary.Recoil = 8
SWEP.Primary.Cone = 0.0325
SWEP.Primary.Damage = 42
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 7
SWEP.Primary.ClipMax = 35
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Sound = Sound( "Weapon_DetRev.Single" )

-- Model settings
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel	= "models/weapons/w_357.mdl"

SWEP.IronSightsPos = Vector ( -4.64, -3.96, 0.68 )
SWEP.IronSightsAng = Vector ( 0.214, -0.1767, 0 )

--- TTT config values

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP1

SWEP.AutoSpawnable      = true
SWEP.AmmoEnt = "item_ammo_revolver_ttt"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = { ROLE_DETECTIVE }

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

-- Precache custom sounds
function SWEP:Precache()
   util.PrecacheSound( "weapons/det_revolver/revolver-fire.wav" )
end

-- Give the primary sound an alias
sound.Add({
   name = "Weapon_DetRev.Single",
   channel = CHAN_USER_BASE+10,
   volume = 1.0,
   sound = "weapons/det_revolver/revolver-fire.wav"
})

-- Equipment menu information is only needed on the client
if CLIENT then
   -- Text shown in the equip menu
   SWEP.EquipMenuData = {
      type = "Weapon",
      desc = "One shot, one kill. Will kill ANY ROLE."
   }
end
