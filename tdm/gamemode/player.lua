local ply = FindMetaTable("Player")

-- I will be changing how this is done
-- Already Changed how it was done, depreciating soon.
local teams = {}

teams[0] = {name = "Red", color = Vector( 1.0, .2, .2), weapons = {} }
teams[1] = {name = "Blue", color = Vector( .2, .2, 1.0), weapons = {} }
teams[2] = {name = "Spectator", color = Vector ( 0, 0 , 0 ), weapons = {} }

function ply:SetGamemodeTeam ( n )

	if not teams[n] then return false end

	self:SetTeam( n )

	--self:SetPlayerColor( teams[n].color )

	return true

end

------------------------------------------
--	How much DMG is Taken		--
------------------------------------------
-- Feel Free to Modify based on gameplay needs
function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	-- Headshot Damage multiplyer
	if ( hitgroup == HITGROUP_HEAD ) then
	 
		dmginfo:ScaleDamage( 2.75 )
	 
	end
	 
	-- Damage Taken To Centre of Mass
	if ( hitgroup == HITGROUP_CHEST ||
		hitgroup == HITGROUP_STOMACH ) then

		dmginfo:ScaleDamage( 1.5 )

	end

	-- Tamage taken if hit in limbs
	if ( hitgroup == HITGROUP_LEFTARM ||
		hitgroup == HITGROUP_RIGHTARM || 
		hitgroup == HITGROUP_LEFTLEG ||
		hitgroup == HITGROUP_RIGHTLEG ||
		hitgroup == HITGROUP_GEAR ) then
	 
		dmginfo:ScaleDamage( 1 )
	 
	end

end

------------------------------------------
--	When the player dies		--
------------------------------------------
function GM:PlayerDeathThink( ply )

	if (  ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
	
		ply:Spawn()
		
	end
	
end

util.AddNetworkString("PlayerKilledSelf")
util.AddNetworkString("PlayerKilledByPlayer")
util.AddNetworkString("PlayerKilled")

function GM:PlayerDeath( ply, inflictor, attacker )

	ply.NextSpawnTime = CurTime() + 3 -- 3 Seconds to respawn
	
	ply.DeathTime = CurTime()
	
	if ( IsValid( attacker ) && attacker:GetClass() == "trigger_hurt" ) then attacker = ply end
	
	if ( IsValid( attacker ) && attacker:IsVehicle() && IsValid( attacker:GetDriver() ) ) then
		attacker = attacker:GetDriver()
	end

	if ( !IsValid( inflictor ) && IsValid( attacker ) ) then
		inflictor = attacker
	end

	if ( IsValid( inflictor ) && inflictor == attacker && ( inflictor:IsPlayer() || inflictor:IsNPC() ) ) then
	
		inflictor = inflictor:GetActiveWeapon()
		if ( !IsValid( inflictor ) ) then inflictor = attacker end

	end

	if ( attacker == ply ) then
	
		net.Start( "PlayerKilledSelf" )
			net.WriteEntity( ply )
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " suicided!\n" )
		
	return end

	if ( attacker:IsPlayer() ) then
	
		net.Start( "PlayerKilledByPlayer" )
		
			net.WriteEntity( ply )
			net.WriteString( inflictor:GetClass() )
			net.WriteEntity( attacker )
		
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )
		
	return end
	
	net.Start( "PlayerKilled" )
	
		net.WriteEntity( ply )
		net.WriteString( inflictor:GetClass() )
		net.WriteString( attacker:GetClass() )

	net.Broadcast()
	
	MsgAll( ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n" )
	
end