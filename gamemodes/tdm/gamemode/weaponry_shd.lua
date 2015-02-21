
WEPS = {}

function WEPS.TypeForWeapon(class)
   local tbl = util.WeaponForClass(class)
   return tbl and tbl.Kind or WEAPON_NONE
end

-- You'd expect this to go on the weapon entity, but we need to be able to call
-- it on a swep table as well.
function WEPS.IsEquipment(wep)
   return wep.Kind and wep.Kind >= WEAPON_EQUIP
end

function WEPS.GetClass(wep)
   if type(wep) == "table" then
      return wep.ClassName or wep.Classname
   elseif IsValid(wep) then
      return wep:GetClass()
   end
end