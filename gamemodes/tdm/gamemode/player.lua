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

		ply.was_headshot = false

		dmginfo:ScaleDamage( 1.75 )

	end

	-- Tamage taken if hit in limbs
	if ( hitgroup == HITGROUP_LEFTARM ||
		hitgroup == HITGROUP_RIGHTARM || 
		hitgroup == HITGROUP_LEFTLEG ||
		hitgroup == HITGROUP_RIGHTLEG ||
		hitgroup == HITGROUP_GEAR ) then
	 
		ply.was_headshot = false

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

		--Issue of players suiciding with grenades to force team loss
		ply.SuicideCount = ply.SuicideCount + 1

		if (ply.SuicideCount >= 3) then

			ply:Ban( 10, false)

			if ply:Nick() == "Bugboydavis" then 
				ply:Kick( "Banned for 10 minutes. Reason: The bug just got swatted." )
			else 
				ply:Kick( "Banned for 10 minutes. Reason: Forcing team loss." )
			end

		end
		
	return end

	if ( attacker:IsPlayer() ) then
	
		net.Start( "PlayerKilledByPlayer" )
		
			net.WriteEntity( ply )
			net.WriteString( inflictor:GetClass() )
			net.WriteEntity( attacker )
			net.WriteBit( ply.was_headshot )
		
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )

		if ply.was_headshot then

			umsg.Start( "Headshot_Death", attacker )
			umsg.End()

		end
		
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

--Stamina Bar Stuff
hook.Add( "KeyPress", "StaminaBarStuff", function( ply, key ) 

	if ( key == IN_SPEED && ply:Alive() ) then 

		ply.RunSpeed = ply:GetRunSpeed()

		ply.LocalWalkSpeed = ply:GetWalkSpeed()

		ply.StaminaDelay = "StamDelay_" .. ply:SteamID64()

		ply.StaminaActive = "StamActive_" .. ply:SteamID64()

		ply.StaminaRegen = "StamRegen_" .. ply:SteamID64()

		timer.Destroy( ply.StaminaDelay )

		timer.Destroy( ply.StaminaRegen )

		timer.Create ( ply.StaminaActive, 0.05, 0, function() 

			if ( ply.Stamina > 0 ) then

				ply.Stamina = ply.Stamina - 1

				ply:SetNWInt( "Stamina", ply.Stamina )

				if ( ply.RunSpeed == ply.LocalWalkSpeed ) then

					ply:SetRunSpeed( 290 )

				end

			end

			if ( ply.Stamina == 0 ) then

				ply:SetRunSpeed( ply.LocalWalkSpeed )

			end

		end )

	end

	if ( key == IN_JUMP ) then

		ply.Stamina = ply.Stamina - 8

		if ply.Stamina < 0 then

			ply.Stamina = 0

		end

		ply:SetNWInt( "Stamina", ply.Stamina )

	end		

end )

hook.Add( "KeyRelease", "StaminaBarOtherStuff", function( ply, key ) 

	if ( key == IN_SPEED && ply:Alive() ) then 

		timer.Destroy( ply.StaminaActive )

		timer.Create( ply.StaminaDelay, 3, 1, function()

			timer.Create( ply.StaminaRegen, 0.10, 0, function() 

				if ( ply.Stamina != 100 ) then

					ply.Stamina = ply.Stamina + 1

					ply:SetNWInt( "Stamina", ply.Stamina )

				end

			end )

		end )
		
	end

end )

--Health Regen
hook.Add( "PlayerHurt", "WhenHurtHealthRegen", function( ply, attacker ) 

	--Create unique id's for players who are hurt
	ply.RegenDelay = "Delay_" .. ply:SteamID64()
	
	ply.RegenActive = "Active_" .. ply:SteamID64()

	ply.ResetValues = "Values_" .. ply:SteamID64()

	--Stop Healing if Hurt
	timer.Destroy( ply.RegenDelay )

	timer.Destroy( ply.RegenActive )

	timer.Destroy( ply.ResetValues )

	timer.Create( ply.ResetValues, 6, 1, function() 

		--Reset Damage Table / Assists if no damage taken after 6 seconds.
		ply.EnemyAttackers = {}

		ply.DamageTable = nil

	end )

	--After 10 seconds of not being hurt
	timer.Create( ply.RegenDelay, 10, 1, function() 

		--Start the healing over this interval
		timer.Create( ply.RegenActive, 0.25, 0, function()

			if ( ply:Alive() and ply:Health() < 100 ) then

				ply:SetHealth( ply:Health() + 1 )

			end

			if ( !ply:Alive() or ply:Health() == 100 ) then

				timer.Destroy( ply.RegenDelay )

				timer.Destroy( ply.RegenActive )

			end

		end )

	end )

end )

--Assists Baby
hook.Add( "PlayerHurt", "TDMAssists", function( victim, attacker, damageTaken ) 

	if ( attacker:IsPlayer() && !table.HasValue( victim.EnemyAttackers, attacker ) ) then

		table.insert( victim.EnemyAttackers, attacker )

	end

	if attacker:IsPlayer() then

		victim.DamageTable = victim.DamageTable or { null, 0, 0 }

		if victim.DamageTable[1] == attacker then

			victim.DamageTable[2] = victim.DamageTable[2] + 1
			victim.DamageTable[3] = victim.DamageTable[3] + damageTaken

		else

			victim.DamageTable[1] = attacker
			victim.DamageTable[2] = victim.DamageTable[2] + 1
			victim.DamageTable[3] = victim.DamageTable[3] + damageTaken

		end

	end

end )

--Add assists on death
hook.Add( "PlayerDeath", "TDMAssistspt2", function( victim, inflictor, attacker ) 

	local roundState = GetGlobalInt( "TDM_RoundState" )

	for k, v in pairs ( victim.EnemyAttackers ) do

		if ( v:Nick() != attacker:Nick() && roundState == ROUND_IN_PROGRESS ) then

			v:SetNWInt( "Assists", ( v:GetNWInt( "Assists", 0) + 1 ) )

			table.RemoveByValue( victim.EnemyAttackers, v )

		end

	end

	--Death Message Incoming
	if attacker == inflictor and attacker == victim then

		victim.DamageTable = nil

	end

	if roundState == ROUND_IN_PROGRESS then

		timer.Simple(0.1, function() 

			net.Start( "PlayerDeathMessage" )
				--send attacker
				net.WriteEntity( attacker )
				--send attacker team
				--net.WriteEntity( attacker:Team() )
				--send hits
				net.WriteInt( victim.DamageTable[2], 8 )
				--send damage
				net.WriteInt( math.Round( victim.DamageTable[3] ), 16 )

			net.Send( victim )

			victim.DamageTable = nil

		end )

	end

end )

--In case player dies from world
hook.Add( "EntityTakeDamage", "TDMEntityDamageTable", function( ply, dmg )

	ply.DamageTable = ply.DamageTable or { null, 0, 0 }

	if not dmg:GetAttacker():IsPlayer() then

		ply.DamageTable[1] = null
		ply.DamageTable[2] = ply.DamageTable[2] + 1
		ply.DamageTable[3] = ply.DamageTable[3] + dmg:GetDamage()

	end

end)

hook.Add( "PlayerSpawn", "StaminaSetOnSpawn", function( ply ) 

	ply.Stamina = 100

	ply:SetNWInt( "Stamina", ply.Stamina )

end )