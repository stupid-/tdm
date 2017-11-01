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
-- Thank you TTT
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

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) && ( ply:GetPData( "Player_Class", "noclass" ) != "noclass") ) then
	
		ply:Spawn()
		
	end

	-- Forced Player Respawn, Can't afk dead
	if ( !ply:Alive() && (ply.NextSpawnTime + TDM_ForceRespawnDelay) < CurTime() && (ply:GetPData( "Player_Class", "noclass" ) != "noclass")) then

		ply:Spawn()

	end
	
end

util.AddNetworkString("PlayerKilledSelf")
util.AddNetworkString("PlayerKilledByPlayer")
util.AddNetworkString("PlayerKilled")

function GM:PlayerDeath( ply, inflictor, attacker )

	local roundState = GetGlobalInt( "TDM_RoundState" )

	ply.NextSpawnTime = CurTime() + TDM_RespawnDelay -- Default 3 Seconds to respawn
	ply.DeathTime = CurTime()

	if ( roundState == ROUND_IN_PROGRESS ) then
		ply:SetPData( "tdm_stats_deaths", ( ply:GetPData( "tdm_stats_deaths", 0 ) + 1 ) )
		MsgN( ply:Nick() .. "s deaths: " .. ply:GetPData( "tdm_stats_deaths", 0 ) )
	end

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

		if (ply.SuicideCount >= 4) then

			ply:Ban( 10, false)
			ply:Kick( "Banned for 10 minutes. Reason: Forcing team loss." )

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

		if ( roundState == ROUND_IN_PROGRESS ) then
			attacker:SetPData( "tdm_stats_kills", ( attacker:GetPData( "tdm_stats_kills", 0 ) + 1 ) )
			MsgN( attacker:Nick() .. "s kills: " .. attacker:GetPData( "tdm_stats_kills", 0 ) )

			if ply.was_headshot then
				attacker:AddXP( 150 )
				attacker:SetPData( "tdm_stats_headshot", ( attacker:GetPData( "tdm_stats_headshot", 0 ) + 1 ) )
				MsgN( attacker:Nick() .. "s headshots: " .. attacker:GetPData( "tdm_stats_headshot", 0 ) )
			else
				attacker:AddXP( 100 )
			end

			local deathPos = ply:GetPos()
			local deathAng = ply:GetAngles()
			CreateAmmoOnDeath( deathPos, deathAng )
			CreateOtherEntsOnDeath( deathPos, deathAng )
			
		end

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

function CreateAmmoOnDeath( pos, ang )

	local ammo_types = {
		"item_ammo_357_ttt",
		"item_ammo_pistol_ttt",
		"item_ammo_pistol_ttt",
		"item_ammo_pistol_ttt",
		"item_ammo_smg1_ttt",
		"item_ammo_smg1_ttt",
		"item_ammo_smg1_ttt",
		"item_box_buckshot_ttt",
		"item_ammo_revolver_ttt"
	}

	pos = pos + Vector( 0, 0, 30 )

	local ent = ents.Create( table.Random( ammo_types ) )
	if not IsValid( ent ) then return end
	ent:SetPos( pos )
	ent:SetAngles( ang )

	ent:Spawn()
	ent:PhysWake()

	timer.Simple( 55, function()

		if ent:IsValid() then ent:Remove() end

	end )

end

function CreateOtherEntsOnDeath( pos, ang )

	local checkRandom = math.random( 0, 10 )

	if ( checkRandom < 7 ) then return end

	local randomEnts = {
		"item_armor_25",
		"item_armor_33",
		"item_health_25"
	}

	local randomPos = math.random( 0, 10 )

	pos = pos + Vector( 0 + randomPos, 0 + randomPos, 32 )

	local ent = ents.Create( table.Random( randomEnts ) )
	if not IsValid( ent ) then return end
	ent:SetPos( pos )
	ent:SetAngles( ang )

	ent:Spawn()
	ent:PhysWake()

	timer.Simple( 55, function()

		if ent:IsValid() then ent:Remove() end

	end )

end

--Stop the pickup of props
function GM:AllowPlayerPickup( ply, object )

	return false
		
end

hook.Add( "PlayerDisconnected", "HealthRegenDestruction", function( ply ) 

	timer.Remove( ply.RegenDelay )
	timer.Remove( ply.RegenActive )
	timer.Remove( ply.ResetValues )

end )

--Health Regen
hook.Add( "PlayerHurt", "WhenHurtHealthRegen", function( ply, attacker ) 

	if ( ply:SteamID64() == nil ) then

		--Create unique id's for players who are hurt
		ply.RegenDelay = "Delay_" .. ply:Nick()
		ply.RegenActive = "Active_" .. ply:Nick()
		ply.ResetValues = "Values_" .. ply:Nick()

	else

		--Create unique id's for players who are hurt
		ply.RegenDelay = "Delay_" .. ply:SteamID64()
		ply.RegenActive = "Active_" .. ply:SteamID64()
		ply.ResetValues = "Values_" .. ply:SteamID64()

	end

	--Stop Healing if Hurt
	timer.Remove( ply.RegenDelay )
	timer.Remove( ply.RegenActive )
	timer.Remove( ply.ResetValues )

	timer.Create( ply.ResetValues, 6, 1, function() 

		--Reset Damage Table / Assists if no damage taken after 6 seconds.
		ply.EnemyAttackers = {}
		ply.DamageTable = nil

	end )

	--After 7 seconds of not being hurt
	timer.Create( ply.RegenDelay, 7, 1, function() 

		--Start the healing over this interval
		timer.Create( ply.RegenActive, 0.10, 0, function()

			if ( ply:Alive() and ply:Health() < 100 ) then
				ply:SetHealth( ply:Health() + 1 )
			end

			if ( !ply:Alive() or ply:Health() == 100 ) then
				timer.Remove( ply.RegenDelay )
				timer.Remove( ply.RegenActive )
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

			v:SetPData( "tdm_stats_assists", ( v:GetPData( "tdm_stats_assists", 0 ) + 1 ) )

			MsgN( v:Nick() .. "s assists: " .. v:GetPData( "tdm_stats_assists", 0 ) )

			v:AddXP( 25 )
		end

	end

	--Death Message Incoming
	if attacker == inflictor and attacker == victim then

		victim.DamageTable = nil

	end

	if roundState == ROUND_IN_PROGRESS then
		/*

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

		*/

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

end )

---- Weapon switching
local function ForceWeaponSwitch(ply, cmd, args)
   if not ply:IsPlayer() or not args[1] then return end
   -- Turns out even SelectWeapon refuses to switch to empty guns, gah.
   -- Worked around it by giving every weapon a single Clip2 round.
   -- Works because no weapon uses those.
   local wepname = args[1]
   local wep = ply:GetWeapon(wepname)
   if IsValid(wep) then
      -- Weapons apparently not guaranteed to have this
      if wep.SetClip2 then
         wep:SetClip2(1)
      end
      ply:SelectWeapon(wepname)
   end
end
concommand.Add("wepswitch", ForceWeaponSwitch)

--Add Minimap Detection

--Hook Key Press SHOOT

--Hook Key Press Talk