include( "shared.lua" )
include( "player.lua" )
include( "sv_rounds.lua" )
include( "ent_import.lua" )
include( "config/config.lua" )

--Classes  
include( "player_class/noclass.lua" )
include( "player_class/assault.lua" )
include( "player_class/infantry.lua" )
include( "player_class/heavy.lua" )
include( "player_class/sniper.lua" )
include( "player_class/commando.lua" )

--Map Voting (Not My Code), By https://github.com/wiox/gmod-mapvote
include( "mapvote/mapvote.lua" )
include( "mapvote/sv_mapvote.lua" )

--Includes for Client
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_menus.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_welcome.lua" )
AddCSLuaFile( "cl_pickclass.lua" )
AddCSLuaFile( "cl_voice.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_targetid.lua" )
AddCSLuaFile( "cl_deathnotice.lua" )
AddCSLuaFile( "cl_deathscreen.lua" )
AddCSLuaFile( "mapvote/cl_mapvote.lua" )

--Classes For Client
AddCSLuaFile( "player_class/noclass.lua" )
AddCSLuaFile( "player_class/assault.lua" )
AddCSLuaFile( "player_class/infantry.lua" )
AddCSLuaFile( "player_class/heavy.lua" )
AddCSLuaFile( "player_class/sniper.lua" )
AddCSLuaFile( "player_class/commando.lua" )

--Network Strings
util.AddNetworkString( "PlayerDeathMessage" )

------------------------------------------
--				ConVars					--
------------------------------------------

local round_preparetime = CreateConVar( "tdm_preparetime", "60", FCVAR_ARCHIVE )
local round_time = CreateConVar( "tdm_roundtime", "600", FCVAR_ARCHIVE )
local round_endtime = CreateConVar( "tdm_endtime", "30", FCVAR_ARCHIVE )
local round_limit = CreateConVar( "tdm_roundlimit", "1", FCVAR_ARCHIVE )
local round_scorelimit = CreateConVar( "tdm_scorelimit", "50", FCVAR_ARCHIVE )

------------------------------------------
--			Opening VGUI				--
------------------------------------------

function GM:ShowHelp( ply ) -- F1

	ply:ConCommand( "chooseTeam" ) --cl_menus.lua

end

function GM:ShowTeam( ply ) -- F2 

	--Just down show class menu unless you're not a spectator
	if ply:Team() == TEAM_SPEC then return end

	ply:ConCommand( "pickClass" ) --cl_picklass.lua

end

function GM:ShowSpare2( ply ) -- F4

	-- Coming soon --cl_help.lua
	-- Help Menu

end

------------------------------------------
--		Connecting/Disconnecting		--
------------------------------------------

function GM:PlayerConnect ( name, ip )

	print( "Player: " .. name .. " has connected." )

end


function GM:PlayerAuthed ( ply, steamid, uniqueid )

	print ( "Player: " .. ply:Nick() .. " ( " .. steamid .. " ) has authenticated." )

	PrintMessage( HUD_PRINTTALK, Format( "Player %s has joined the game.", ply:Nick() ) )

end

function GM:PlayerDisconnected( ply )

	print( "Player: " .. ply:Nick() .. " has disconnected." )

	PrintMessage( HUD_PRINTTALK, Format( "Player %s has disconnected.", ply:Nick() ) )

end

------------------------------------------
--			Initializing Convars		--
------------------------------------------

function GM:Initialize()

	SetGlobalInt( "TDM_RoundsLeft", round_limit:GetInt() )

	SetGlobalInt( "TDM_ScoreLimit", round_scorelimit:GetInt() )

	timer.Create( "CheckTeamBalance", 30, 0, function() 

		if ( GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS ) then

			GAMEMODE:CheckTeamBalance() 

		end

	end )

end

------------------------------------------
--				Spawning				--
------------------------------------------

function GM:PlayerInitialSpawn ( ply )

	ply.EnemyAttackers = {}

	ply:SetNWInt( "Assists", 0 )

	ply.SuicideCount = 0

	ply.NextSwitchTime = 0

	ply.Stamina = 100

	-- IsBot() Is for testing gamemode features in private.
	if ( ply:IsBot() ) then
		-- Randomly Set Bot Team
		ply:SetTeam( math.random( TEAM_RED, TEAM_BLUE) )

		player_manager.OnPlayerSpawn( ply )
		player_manager.SetPlayerClass( ply, "infantry" )
		player_manager.RunClass( ply, "Spawn" )
		hook.Call( "PlayerLoadout", GAMEMODE, ply )
		hook.Call( "PlayerSetModel", GAMEMODE, ply )
		ply:KillSilent()
		ply:Spawn()
	else
		ply:StripWeapons()
		ply:SetTeam( TEAM_SPEC )
		ply:Spectate( OBS_MODE_ROAMING )

		player_manager.OnPlayerSpawn( ply )
		player_manager.SetPlayerClass( ply, "noclass" )
		player_manager.RunClass( ply, "Spawn" )
		hook.Call( "PlayerLoadout", GAMEMODE, ply )
		hook.Call( "PlayerSetModel", GAMEMODE, ply )

		timer.Simple( 2, function() ply:ConCommand( "welcomePlayer" ) end )
	end
end

function GM:PlayerSpawn ( ply )
	if ply:Team() == TEAM_SPEC then 

		ply:Spectate( OBS_MODE_ROAMING )

	--Make sure the player has a class before spawned
	elseif ( ply:Team() == TEAM_RED && player_manager.GetPlayerClass( ply ) != "noclass" || ply:Team() == TEAM_BLUE && player_manager.GetPlayerClass( ply ) != "noclass" ) then

		local color = team.GetColor( ply:Team() )

		ply:SetPlayerColor( Vector( color.r/255, color.g/255, color.b/255 ) )

		ply:SetupHands()
		player_manager.OnPlayerSpawn( ply )
        player_manager.RunClass( ply, "Spawn" )
        hook.Call( "PlayerLoadout", GAMEMODE, ply )
        hook.Call( "PlayerSetModel", GAMEMODE, ply )


        --Most Basic Spawn Protection, 2 Seconds of God Mode.
        ply:GodEnable()

        local function unprotect()

        	if IsValid(ply) then

        		ply:GodDisable()

        	end

        end
        timer.Simple( 2.5, unprotect )

        hook.Add( "KeyPress", "RemoveSpawnProtection", function( ply, key ) 

        	if ( key == IN_ATTACK && ply:HasGodMode() && ply:Alive() ) then

        		unprotect()

        	end

        end )
        
    -- If no class, force class selection or else no spawn
	elseif ( player_manager.GetPlayerClass( ply ) == "noclass" ) then

		ply:KillSilent()

		ply:ConCommand("pickClass")

	end

end

function GM:Think()

	self:RoundThink()

	SetGlobalInt( "TDM_SpecTeamNum", team.NumPlayers( TEAM_SPEC ) )

	SetGlobalInt( "TDM_RedTeamNum", team.NumPlayers( TEAM_RED ) )

	SetGlobalInt( "TDM_BlueTeamNum", team.NumPlayers( TEAM_BLUE ) )


end

------------------------------------------
--		Create extra spawn entities		--
------------------------------------------

function SpawnEntities()

	local import = ents.TDM.CanImportEntities( game.GetMap() )

	if import then

		ents.TDM.ProcessImportScript( game.GetMap() )

	end

end

function PlayerAdvancedSpawnSelection( ply, spawnpointent, enemy_team )
	
	local Pos = spawnpointent:GetPos()

	--This is within the size of 48 players between you and an enemy
	local EnemyEnts = ents.FindInBox( Pos + Vector( -1536, -1536, -144 ), Pos + Vector( 1536, 1536, 216 ) )

	local FriendlyEnts = ents.FindInBox( Pos + Vector( -16, -16, 0 ), Pos + Vector( 16, 16, 72 ) )

	local Blockers = 0

	for k, v in pairs( EnemyEnts ) do

		if ( IsValid( v ) && v:GetClass() == "player" && v:Alive() && v:Team() == enemy_team ) then

			Blockers = Blockers + 1

		end

	end

	for k, v in pairs( FriendlyEnts ) do

		if ( IsValid( v ) && v:GetClass() == "player" && v:Alive() ) then

			Blockers = Blockers + 1

		end

	end

	if ( Blockers > 0 ) then return false end

	return true

end

local function GetThreeRandomTeammates( playerTeam )

	--Find Random Alive Players on team
	local teamAlivePlayers = team.GetPlayers( playerTeam )

	--Weed out the dead players
	for k, v in pairs( teamAlivePlayers ) do

		if ( !v:Alive() ) then

			table.RemoveByValue( teamAlivePlayers, v:Nick() )

		end

	end

	p1 = table.Random( teamAlivePlayers )

	table.RemoveByValue( teamAlivePlayers, p1:Nick() )

	p2 = table.Random( teamAlivePlayers )

	table.RemoveByValue( teamAlivePlayers, p2:Nick() )

	p3 = table.Random( teamAlivePlayers )

	return p1, p2, p3

end

function GM:PlayerSelectSpawn( ply ) 

    playerTeam = ply:Team()

	if ( playerTeam == TEAM_SPEC ) then

	    local spawns = ents.FindByClass( "info_player_terrorist" ) 

	    spawns = table.Add(spawns, ents.FindByClass( "info_player_counterterrorist" ) )

	    spawns = table.Add(spawns, ents.FindByClass( "info_mobile_spawn" ) )

	    local truespawn = table.Random(spawns)

	    return truespawn

	else

    	local roundState = GetGlobalInt( "TDM_RoundState" )

    	local opposingTeam = nil

    	if ( playerTeam == TEAM_RED ) then

    		opposingTeam = TEAM_BLUE 

    	else 

    		opposingTeam = TEAM_RED 

    	end

		local teamAlivePlayers = team.GetPlayers( playerTeam )

		--Weed out the dead players
		for k, v in pairs( teamAlivePlayers ) do

			if ( !v:Alive() ) then

				table.RemoveByValue( teamAlivePlayers, v:Nick() )

			end

		end

		Spawnpoints = {}
		Spawnpoints[ TEAM_RED ] = {}
		Spawnpoints[ TEAM_BLUE ] = {}

		table.Add( Spawnpoints[ TEAM_RED ], ents.FindByClass( "info_player_terrorist" ) )
		table.Add( Spawnpoints[ TEAM_BLUE ], ents.FindByClass( "info_player_counterterrorist" ) )
		table.Add( Spawnpoints[ TEAM_RED ], ents.FindByClass( "info_mobile_spawn" ) )
		table.Add( Spawnpoints[ TEAM_BLUE ], ents.FindByClass( "info_mobile_spawn" ) )

		local SpawnPointCount = table.Count( Spawnpoints[ playerTeam ] )

		local PlayerAliveCount = table.Count( teamAlivePlayers )

		local randomTeamSpawnPoint = nil

		--if Less than 3 teammates are alive, choose random spawn
		if PlayerAliveCount <= 3 then

			--Check and see if any spawn is X Distance away from enemy
			for i=0, SpawnPointCount do

				randomTeamSpawnPoint = table.Random( Spawnpoints[ playerTeam ] )
				
				if ( randomTeamSpawnPoint && 
					randomTeamSpawnPoint:IsValid() && 
					randomTeamSpawnPoint:IsInWorld() &&
					randomTeamSpawnPoint != ply:GetVar( "LastSpawnpoint" ) &&
					randomTeamSpawnPoint != self.LastSpawnPoint ) then

					if PlayerAdvancedSpawnSelection( ply, randomTeamSpawnPoint, opposingTeam ) then

						self.LastSpawnPoint = randomTeamSpawnPoint
						ply:SetVar( "LastSpawnpoint", randomTeamSpawnPoint )
						return randomTeamSpawnPoint

					end

				end

			end

			return randomTeamSpawnPoint

		--if 4 or more teammates are alive, find nearby spawn points
		else

			local PossibleSpawnPoint = table.Copy( Spawnpoints[ playerTeam ] )
			local num = #PossibleSpawnPoint
			local closest = nil
			for i=1, num do

				local p1,p2,p3 = GetThreeRandomTeammates( playerTeam )
				local v1,v2,v3 = p1:GetPos(), p2:GetPos(), p3:GetPos()
				local x1,x2,x3,y1,y2,y3 = v1.x, v2.x, v3.x, v1.y, v2.y, v3.y
				local xAvg = ( x1 + x2 + x3 )/3
				local yAvg = ( y1 + y2 + y3 )/3
				local centroid = Vector( xAvg, yAvg, 0 )

				--Find Closest Possible Spawn point
				local closestDist = ( PossibleSpawnPoint[ table.maxn( PossibleSpawnPoint ) ]:GetPos() - centroid):Length2D() 
				closest = PossibleSpawnPoint[ table.maxn( PossibleSpawnPoint ) ]

				local closestKey = table.maxn( PossibleSpawnPoint )
				for k, v in pairs( PossibleSpawnPoint ) do

					if v then
						local dist = ( v:GetPos() - centroid ):Length2D()
						if dist < closestDist then 

							closest = v
							closestDist = dist
							closestKey = k

						end
					end
				end

				if not PlayerAdvancedSpawnSelection( ply, closest, opposingTeam ) then

					PossibleSpawnPoint[ closestKey ] = nil

				else

					break -- Found what we want, stop the loop

				end

			end

			if ( closest &&
				closest:IsValid() &&
				closest:IsInWorld() ) then 

				return closest

			else 

				for i=0, SpawnPointCount do

					randomTeamSpawnPoint = table.Random( Spawnpoints[ playerTeam ] )

					
					if ( randomTeamSpawnPoint && 
						randomTeamSpawnPoint:IsValid() && 
						randomTeamSpawnPoint:IsInWorld() &&
						randomTeamSpawnPoint != ply:GetVar( "LastSpawnpoint" ) &&
						randomTeamSpawnPoint != self.LastSpawnPoint ) then

						if PlayerAdvancedSpawnSelection( ply, randomTeamSpawnPoint, opposingTeam ) then

							self.LastSpawnPoint = randomTeamSpawnPoint
							ply:SetVar( "LastSpawnpoint", randomTeamSpawnPoint )
							return randomTeamSpawnPoint

						end

					end

				end

				return randomTeamSpawnPoint

			end

		end

	end

end


------------------------------------------
--	Player Loadout (Just in case)		--
------------------------------------------

function GM:PlayerLoadout( ply )

	if ply:Team() == TEAM_SPEC then return false end

	player_manager.RunClass( ply, "Loadout" )
	
	return true

end

------------------------------------------
--			Taking Damage				--
------------------------------------------
--Suiciding in TDM can be used to force a team to lose.
--However suiciding is useful when a player is stuck,
--May add the possibility of suiciding with a cooldown.

function GM:CanPlayerSuicide( ply )

	if ply:IsAdmin() then return true end

	return false

end

--Fall damage taken by players, has been many complaints about this
function GM:GetFallDamage( ply, flFallSpeed )
	
	return flFallSpeed / 14
	
end

--Player takes damage only if hurt by a member of the opposite team
function GM:PlayerShouldTakeDamage( ply, attacker )

	if ( IsValid( attacker ) ) then

		if ( attacker.Team && ply:Team() == attacker:Team() && ply != attacker ) then return false end

	end
	
	return true

end

function GM:DoPlayerDeath( victim, attacker, dmginfo )

	victim:CreateRagdoll()

	if ( GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS or GetGlobalInt( "TDM_RoundState" ) == ROUND_OVER ) then

		victim:AddDeaths( 1 )

		if ( attacker:IsValid() && attacker:IsPlayer() ) then
		
			if ( attacker == victim ) then

				attacker:AddFrags( -1 )

			else

				attacker:AddFrags( 1 )

			end
			
		end

		if victim:Team() == TEAM_RED then

			local blueKills = GetGlobalInt( "TDM_BlueKills" )

			SetGlobalInt( "TDM_BlueKills", blueKills + 1 )

		elseif victim:Team() == TEAM_BLUE then

			local redKills = GetGlobalInt( "TDM_RedKills" )

			SetGlobalInt( "TDM_RedKills", redKills + 1 )

		end

	end

end
------------------------------------------
--			Team Switching				--
------------------------------------------

function stTeamSpec( ply )
	if ( ply:Team() == TEAM_SPEC || ply.NextSwitchTime > CurTime() ) then return end

	ply.NextSwitchTime = CurTime() + 15

	ply:KillSilent()
	player_manager.SetPlayerClass( ply, "noclass" )
	ply:UnSpectate()
	ply:SetTeam( TEAM_SPEC )
	ply:StripWeapons()
	ply:Spectate( OBS_MODE_ROAMING )
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint( "Player "..ply:GetName().." has become a " .. team.GetName( ply:Team() ) .. "." )
	end
end
concommand.Add( "stTeamSpec", stTeamSpec )

function stTeamT( ply )

	local RedPlayers = GetGlobalInt( "TDM_RedTeamNum" )
	local BluePlayers = GetGlobalInt( "TDM_BlueTeamNum" )

	if ( ply:Team() == TEAM_RED || ply.NextSwitchTime > CurTime() ) then return end

	--Protection against swapping and forcing an autobalance
	if ( ply:Team() == TEAM_BLUE && RedPlayers == BluePlayers) then return end

	ply.NextSwitchTime = CurTime() + 30

	player_manager.SetPlayerClass( ply, "noclass" )
	ply:UnSpectate()
	ply:StripWeapons()
	ply:SetTeam( TEAM_RED )
	ply:KillSilent()
	ply:ConCommand("pickClass")
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint( "Player "..ply:GetName().." has joined the " .. team.GetName( ply:Team() ) .. " Team.")
	end
end
concommand.Add( "stTeamT", stTeamT )

function stTeamCT( ply )
	if ( ply:Team() == TEAM_BLUE || ply.NextSwitchTime > CurTime() ) then return end

	--Protection against swapping and forcing an autobalance
	if ( ply:Team() == TEAM_RED && RedPlayers == BluePlayers) then return end

	ply.NextSwitchTime = CurTime() + 30

	player_manager.SetPlayerClass( ply, "noclass" )
	ply:UnSpectate()
	ply:StripWeapons()
	ply:SetTeam( TEAM_BLUE )
	ply:KillSilent()
	ply:ConCommand("pickClass")
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint( "Player "..ply:GetName().." has joined the " .. team.GetName( ply:Team() ) .. " Team." )
	end
end
concommand.Add( "stTeamCT", stTeamCT )

------------------------------------------
--			Class Switching				--
------------------------------------------
--Class system will be overhauled.

function assaultClass( ply )

	if (player_manager.GetPlayerClass( ply ) == "assault" || (ply:Team() == TEAM_SPEC) ) then return end

	player_manager.SetPlayerClass( ply, "assault" )

	if (player_manager.GetPlayerClass( ply ) == "noclass" ) then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end
concommand.Add( "assaultClass", assaultClass )

function infantryClass( ply )

	if (player_manager.GetPlayerClass( ply ) == "infantry" || (ply:Team() == TEAM_SPEC) ) then return end

	player_manager.SetPlayerClass( ply, "infantry" )

	if (player_manager.GetPlayerClass( ply ) == "noclass") then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end
concommand.Add( "infantryClass", infantryClass )

function heavyClass( ply )

	if (player_manager.GetPlayerClass( ply ) == "heavy" || (ply:Team() == TEAM_SPEC) ) then return end

	player_manager.SetPlayerClass( ply, "heavy" )

	if (player_manager.GetPlayerClass( ply ) == "noclass") then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end
concommand.Add( "heavyClass", heavyClass )

function sniperClass( ply )

	if (player_manager.GetPlayerClass( ply ) == "sniper" || (ply:Team() == TEAM_SPEC) ) then return end

	player_manager.SetPlayerClass( ply, "sniper" )

	if (player_manager.GetPlayerClass( ply ) == "noclass") then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end
concommand.Add( "sniperClass", sniperClass )

function commandoClass( ply )

	if (player_manager.GetPlayerClass( ply ) == "commando" || (ply:Team() == TEAM_SPEC) ) then return end

	player_manager.SetPlayerClass( ply, "commando" )

	if (player_manager.GetPlayerClass( ply ) == "noclass") then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end
concommand.Add( "commandoClass", commandoClass )

-- Inspired by Fretta13
function GM:CheckTeamBalance()
	local CurrentRedPlayers = GetGlobalInt( "TDM_RedTeamNum" ) -- Team 0
	local CurrentBluePlayers = GetGlobalInt( "TDM_BlueTeamNum" ) -- Team 1

	if ( CurrentRedPlayers > ( CurrentBluePlayers + 1) ) then

		local ply, reason = GAMEMODE:FindLeastCommittedPlayerOnTeam( TEAM_RED )

		player_manager.SetPlayerClass( ply, "noclass" )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( TEAM_BLUE )
		ply:KillSilent()
		
		if (ply:IsBot()) then

			player_manager.OnPlayerSpawn( ply )
			player_manager.SetPlayerClass( ply, "infantry" )
	        player_manager.RunClass( ply, "Spawn" )
	        hook.Call( "PlayerLoadout", GAMEMODE, ply )
	        hook.Call( "PlayerSetModel", GAMEMODE, ply )

	    else

			ply:ConCommand("pickClass")

		end

		for k,v in pairs(player.GetAll()) do

			v:ChatPrint( "Player "..ply:GetName().." has been automatically switched to the " .. team.GetName( ply:Team() ) .. " Team." )

		end

	elseif ( CurrentBluePlayers > ( CurrentRedPlayers + 1) ) then

		local ply, reason = GAMEMODE:FindLeastCommittedPlayerOnTeam( TEAM_BLUE )

		player_manager.SetPlayerClass( ply, "noclass" )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( TEAM_RED )
		ply:KillSilent()

		if (ply:IsBot()) then

			player_manager.OnPlayerSpawn( ply )
			player_manager.SetPlayerClass( ply, "infantry" )
	        player_manager.RunClass( ply, "Spawn" )
	        hook.Call( "PlayerLoadout", GAMEMODE, ply )
	        hook.Call( "PlayerSetModel", GAMEMODE, ply )

	    else

			ply:ConCommand("pickClass")

		end

		for k,v in pairs(player.GetAll()) do

			v:ChatPrint( "Player "..ply:GetName().." has been automatically switched to the " .. team.GetName( ply:Team() ) .. " Team." )

		end

	end
	
end

function GM:FindLeastCommittedPlayerOnTeam( teamid )

	local worst

	for k,v in pairs( team.GetPlayers( teamid ) ) do

		if ( !worst || v:Frags() < worst:Frags() ) then

			worst = v

		end

	end

	return worst

end