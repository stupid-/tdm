-- Pistol ammo override

AddCSLuaFile()

ENT.Type = "anim"
ENT.Model = Model("models/Items/HealthKit.mdl")

function ENT:Initialize()

	self:SetModel( self.Model )
	self:SetColor(Color(100, 100, 255, 255))

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_BBOX )

	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	local b = 26
	self:SetCollisionBounds(Vector(-b, -b, -b), Vector(b,b,b))

	if SERVER then
	  self:SetTrigger(true)
	end

	self.taken = false


end

function ENT:PlayerCanPickup(ply)
	if ply == self:GetOwner() then return false end

	local ent = self
	local phys = ent:GetPhysicsObject()
	local spos = phys:IsValid() and phys:GetPos() or ent:OBBCenter()
	local epos = ply:GetShootPos() -- equiv to EyePos in SDK

	local tr = util.TraceLine({start=spos, endpos=epos, filter={ply, ent}, mask=MASK_SOLID})

	-- can pickup if trace was not stopped
	return tr.Fraction == 1.0
end

function ENT:Touch(ent)
   if SERVER and self.taken != true then
      if (ent:IsValid() and ent:IsPlayer() and self:PlayerCanPickup(ent) and (ent:Armor() != 100) ) then

      	local curNum = ent:Armor()
      	local aNum = 25

      	if ( (curNum + aNum) >= 100 ) then

      		ent:SetArmor( 100 )

      	else 

      		ent:SetArmor( curNum + aNum )

      	end

      	self:Remove()
      	self.taken = true
      end
   end
end

-- Hack to force ammo to physwake
if SERVER then
   function ENT:Think()
      if not self.first_think then
         self:PhysWake()
         self.first_think = true

         -- Immediately unhook the Think, save cycles. The first_think thing is
         -- just there in case it still Thinks somehow in the future.
         self.Think = nil
      end
   end
end