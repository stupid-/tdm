local ply = FindMetaTable("Player")

------------------------------------------
--	How much DMG is Taken		--
------------------------------------------
-- Feel Free to Modify based on gameplay needs
function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	-- Headshot Damage multiplyer
	ply.was_headshot = false

	if ( hitgroup == HITGROUP_HEAD ) then

		ply.was_headshot = true
	 
		dmginfo:ScaleDamage( 3.25 )
	 
	end
	 
	-- Damage Taken To Centre of Mass
	if ( hitgroup == HITGROUP_CHEST ||
		hitgroup == HITGROUP_STOMACH ) then

		dmginfo:ScaleDamage( 1.75 )

	end

	-- Tamage taken if hit in limbs
	if ( hitgroup == HITGROUP_LEFTARM ||
		hitgroup == HITGROUP_RIGHTARM || 
		hitgroup == HITGROUP_LEFTLEG ||
		hitgroup == HITGROUP_RIGHTLEG ||
		hitgroup == HITGROUP_GEAR ) then
	 
		dmginfo:ScaleDamage( 1.25 )
	 
	end

end

------------------------------------------
--	Death Sounds						--
------------------------------------------

local deathsounds = {
   Sound("player/death1.wav"),
   Sound("player/death2.wav"),
   Sound("player/death3.wav"),
   Sound("player/death4.wav"),
   Sound("player/death5.wav"),
   Sound("player/death6.wav"),
   Sound("vo/npc/male01/pain07.wav"),
   Sound("vo/npc/male01/pain08.wav"),
   Sound("vo/npc/male01/pain09.wav"),
   Sound("vo/npc/male01/pain04.wav"),
   Sound("vo/npc/Barney/ba_pain06.wav"),
   Sound("vo/npc/Barney/ba_pain07.wav"),
   Sound("vo/npc/Barney/ba_pain09.wav"),
   Sound("vo/npc/Barney/ba_ohshit03.wav"),
   Sound("vo/npc/Barney/ba_no01.wav"),
   Sound("vo/npc/male01/no02.wav"),
   Sound("hostage/hpain/hpain1.wav"),
   Sound("hostage/hpain/hpain2.wav"),
   Sound("hostage/hpain/hpain3.wav"),
   Sound("hostage/hpain/hpain4.wav"),
   Sound("hostage/hpain/hpain5.wav"),
   Sound("hostage/hpain/hpain6.wav")
};

local function PlayDeathSound(victim)

   if not IsValid(victim) then return end

   sound.Play(table.Random(deathsounds), victim:GetShootPos(), 90, 100)

end

--Don't play shitty hl2 beep when death occurs
function GM:PlayerDeathSound()

	return true
	
end

------------------------------------------
--	When the player dies				--
------------------------------------------
function GM:PlayerDeathThink( ply )

	if ( ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) && (player_manager.GetPlayerClass( ply ) == "noclass") ) then
	
		ply:Spawn()
		
	end

	if ( !ply:Alive() && (ply.NextSpawnTime + 4) < CurTime() && (player_manager.GetPlayerClass( ply ) != "noclass")) then

		ply:Spawn()

	end
	
end

util.AddNetworkString("PlayerKilledSelf")
util.AddNetworkString("PlayerKilledByPlayer")
util.AddNetworkString("PlayerKilled")

function GM:PlayerDeath( ply, inflictor, attacker )

	ply.NextSpawnTime = CurTime() + 3 -- 3 Seconds to respawn
	
	ply.DeathTime = CurTime()

   if ( !ply.was_headshot && attacker:IsPlayer() ) then
      PlayDeathSound(ply)
   end
	
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

--Stop the pickup of props
function GM:AllowPlayerPickup( ply, object )

	return false
		
end

--Health Regen
hook.Add( "PlayerHurt", "WhenHurtHealthRegen", function( ply ) 

	--Stop Healing if Hurt
	timer.Stop( "PlayerHealthRegenDelayTimer" )
	timer.Stop( "PlayerActiveHealthRegen" )

	--After 10 seconds of not being hurt
	timer.Create( "PlayerHealthRegenDelayTimer", 10, 1, function() 

		--Start the healing over this interval
		timer.Create( "PlayerActiveHealthRegen", 0.25, 0, function()

			if ( ply:Alive() and ply:Health() < 100 ) then

				ply:SetHealth( ply:Health() + 1 )

			end

			if ( !ply:Alive() or ply:Health() == 100 ) then

				timer.Stop( "PlayerHealthRegenDelayTimer" )

				timer.Stop( "PlayerActiveHealthRegen" )

			end

		end )

	end )

end )