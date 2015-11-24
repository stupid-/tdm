include( "shared.lua" )
include( "player.lua" )
include( "sv_rounds.lua" )
include( "sv_stamina.lua" )
include( "sv_levels.lua" )
include( "sv_classselection.lua" )
include( "ent_import.lua" )
include( "config/config.lua" )
include( "weaponry_shd.lua" )
include( "resources.lua" )

--Class Config
include( "config/loadout_config.lua" )

--Map Voting (Not My Code), By https://github.com/wiox/gmod-mapvote
include( "mapvote/mapvote.lua" )
include( "mapvote/sv_mapvote.lua" )

--Includes for Client
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_menus.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_welcome.lua" )
AddCSLuaFile( "cl_welcome2.lua" )
AddCSLuaFile( "cl_pickclass.lua" )
AddCSLuaFile( "cl_voice.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )
AddCSLuaFile( "cl_targetid.lua" )
AddCSLuaFile( "cl_deathnotice.lua" )
AddCSLuaFile( "cl_deathscreen.lua" )
AddCSLuaFile( "cl_levels.lua" )
AddCSLuaFile( "mapvote/cl_mapvote.lua" )
AddCSLuaFile( "weaponry_shd.lua" )

AddCSLuaFile( "config/loadout_config.lua" )

--Network Strings
util.AddNetworkString( "PlayerDeathMessage" )
util.AddNetworkString( "PlayerLevelUp" )
util.AddNetworkString( "PickLoadout" )

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

function GM:ShowSpare1( ply ) -- F3

	-- Coming soon --cl_help.lua
	-- Help Menu

end

function GM:ShowSpare2( ply ) -- F4

	-- Coming soon --cl_stats.lua
	-- Statistics / Leaderboards

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

	local roundState = GetGlobalInt( "TDM_RoundState" )

	if ( roundState == 2 && ply:Team() != TEAM_SPEC ) then 

		ply:SetPData( "tdm_stats_losses", ( ply:GetPData( "tdm_stats_losses", 0 ) + 1 ) )


		ply:SetPData( "tdm_stats_games_played", ( ply:GetPData( "tdm_stats_games_played", 0 ) + 1 ) )
		MsgN( ply:Nick() .. " left during the round and it counts as a loss." )

	end

end

------------------------------------------
--			Initializing Convars		--
------------------------------------------

function GM:Initialize()

	SetGlobalInt( "TDM_RoundsLeft", round_limit:GetInt() )

	SetGlobalInt( "TDM_ScoreLimit", round_scorelimit:GetInt() )

	if ( TDM_TeamAutoBalance == true ) then 
		timer.Create( "CheckTeamBalance", TDM_TeamBalanceCheckTime, 0, function() 
			if ( GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS ) then
				GAMEMODE:CheckTeamBalance() 
			end
		end )
	end

end

------------------------------------------
--				Spawning				--
------------------------------------------

function GM:PlayerInitialSpawn ( ply )

	--Initialize some player stuff
	ply.EnemyAttackers = {}
	ply:SetNWInt( "Assists", 0 )
	ply.SuicideCount = 0
	ply.NextSwitchTime = 0
	ply.Stamina = 100
	ply:GetLevel()
	ply:GetXP()
	ply:GetReqXP()

	classReset( ply )

	--Bots for private gamemode testing
	if ( ply:IsBot() ) then
		-- Randomly Set Bot Team
		ply:SetTeam( math.random( TEAM_RED, TEAM_BLUE ) )

		ply:SetPData("Player_Class", "infantry" )
		ply:SetPData("Player_PickedClass", "infantry" )

		hook.Call( "PlayerLoadout", GAMEMODE, ply )
		hook.Call( "PlayerSetModel", GAMEMODE, ply )
		ply:KillSilent()
		ply:Spawn()
	else
		ply:StripWeapons()
		ply:SetTeam( TEAM_SPEC )
		ply:Spectate( OBS_MODE_ROAMING )

		--hook.Call( "PlayerLoadout", GAMEMODE, ply )
		--hook.Call( "PlayerSetModel", GAMEMODE, ply )

		timer.Simple( 3, function() ply:ConCommand( "welcomePlayer" ) end )
	end
end

function GM:PlayerSpawn ( ply )

	if ( ply:GetPData( "Player_Class", "noclass" ) != ply:GetPData( "Player_PickedClass", "noclass" ) ) then

		ply:SetPData( "Player_Class", ply:GetPData( "Player_PickedClass", "noclass" ) )

	end

	if ply:Team() == TEAM_SPEC then 

		ply:Spectate( OBS_MODE_ROAMING )

	--Make sure the player has a class before spawned
	elseif ( ply:Team() == TEAM_RED && ply:GetPData( "Player_Class", "noclass" ) != "noclass" || ply:Team() == TEAM_BLUE && ply:GetPData( "Player_Class", "noclass" ) != "noclass" ) then

		local color = team.GetColor( ply:Team() )

		if TDM_PlayerModelColors == true then 
			ply:SetPlayerColor( Vector( color.r/255, color.g/255, color.b/255 ) )
		end

		ply:SetupHands()

        if ( ply:GetPData("Player_Class") != ply:GetPData("Player_PickedClass") ) then
        	classUpdate( ply, ply:GetPData("Player_PickedClass") )
        end

        hook.Call( "PlayerLoadout", GAMEMODE, ply )
        hook.Call( "PlayerSetModel", GAMEMODE, ply )

        --Most Basic Spawn Protection, 2 Seconds of God Mode.
        ply:GodEnable()

        local function unprotect( player )

        	if IsValid( player ) then

        		player:GodDisable()

        	end

        end
        timer.Simple( TDM_SpawnProtectionTime, function() unprotect( ply ) end )

        hook.Add( "KeyPress", "RemoveSpawnProtection", function( ply, key ) 

        	if ( key == IN_ATTACK && ply:HasGodMode() && ply:Alive() ) then

        		unprotect( ply )

        	end

        end )
        
    -- If no class, force class selection or else no spawn
	elseif ( ply:GetPData( "Player_Class", "noclass" ) == "noclass" ) then

		ply:KillSilent()

		--ply:ConCommand("pickClass")

	end

	local ang = ply:GetAngles()
	ang.r = 0
	ply:SetEyeAngles( ang )
	
end

function GM:PlayerSetModel( ply )

	currentClass = ply:GetPData( "Player_Class" )

	if currentClass == "noclass" then return end 

	if TDM_TeamBasedPlayerModels == true then

		if ply:Team() == TEAM_RED then

			ply:SetModel( table.Random( TDM_PlayerModelsRed ) )

		elseif ply:Team() == TEAM_BLUE then

			ply:SetModel( table.Random( TDM_PlayerModelsBlue ) )

		end

	else

		for k, class in pairs( PlayerClasses ) do

			if class.name == currentClass then

				ply:SetModel( table.Random( class.playerModels ) )

			end

		end

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

    	if ( playerTeam == TEAM_RED ) then opposingTeam = TEAM_BLUE else opposingTeam = TEAM_RED end

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

	if ply:GetPData( "Player_PickedClass", "noclass" ) == "noclass" then return false end

	pPrimary = ply:GetPData( "Player_Primary", "weapon_ttt_m16" )
	pPrimaryAmmo = ply:GetPData( "Player_Primary_Ammo", 120)
	pPrimaryAmmoType = ply:GetPData( "Player_Primary_Ammo_Type", "item_ammo_pistol_ttt" )
	pSecondary = ply:GetPData( "Player_Secondary", "weapon_zm_pistol" )
	pSecondaryAmmo = ply:GetPData( "Player_Secondary_Ammo", 60)
	pSecondaryAmmoType = ply:GetPData( "Player_Secondary_Ammo_Type", "item_ammo_pistol_ttt")
	pGrenade = ply:GetPData( "Player_Grenade", "weapon_ttt_smokegrenade" )

	ply:GiveAmmo( pPrimaryAmmo,	pPrimaryAmmoType, 		true )
	ply:GiveAmmo( pSecondaryAmmo,	pSecondaryAmmoType, 		true )

	ply:Give( pPrimary )
	ply:Give( "weapon_zm_improvised" )
	ply:Give( pSecondary )
	ply:Give( pGrenade )
	
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

	if ( TDM_EnableSuicide == true ) then return true end

	return false

end

--Fall damage taken by players, has been many complaints about this
function GM:GetFallDamage( ply, flFallSpeed )
	
	return flFallSpeed / 14
	
end

--Player takes damage only if hurt by a member of the opposite team
function GM:PlayerShouldTakeDamage( ply, attacker )
	if ( IsValid( attacker ) ) then
		if ( attacker.Team && ply:Team() == attacker:Team() && ply != attacker && TDM_FriendlyFire == false ) then 
			return false
		elseif ( attacker.Team && ply:Team() == attacker:Team() && ply != attacker && TDM_FriendlyFire == true ) then
			return true
		end 
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

	ply.NextSwitchTime = CurTime() + (TDM_SwitchTeamCooldown)

	ply:KillSilent()
	classReset( ply )
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

	--Players will not be screwed over in the last 45 seconds of the game
	if ( GAMEMODE:GetRoundTime() < 45 and GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS and ply:Team() == TEAM_BLUE ) then return end

	--Players will not be switched if a team is close to winning
	if ( GAMEMODE:GetRedKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5) and ply:Team() == TEAM_RED ) then return end

	--Players will not be switched if a team is close to winning
	if ( GAMEMODE:GetBlueKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5) and ply:Team() == TEAM_RED ) then return end

	ply.NextSwitchTime = CurTime() + TDM_SwitchTeamCooldown

	classReset( ply )
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

	--Players will not be screwed over in the last 45 seconds of the game
	if ( GAMEMODE:GetRoundTime() < 45 and GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS and ply:Team() == TEAM_RED ) then return end

	--Players will not be switched if a team is close to winning
	if ( GAMEMODE:GetRedKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5) and ply:Team() == TEAM_RED ) then return end

	--Players will not be switched if a team is close to winning
	if ( GAMEMODE:GetBlueKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5) and ply:Team() == TEAM_RED ) then return end

	ply.NextSwitchTime = CurTime() + TDM_SwitchTeamCooldown

	classReset( ply )
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

-- Inspired by Fretta13
function GM:CheckTeamBalance()
	local CurrentRedPlayers = GetGlobalInt( "TDM_RedTeamNum" )
	local CurrentBluePlayers = GetGlobalInt( "TDM_BlueTeamNum" )

	--Players will not be screwed over in the last minute of the game
	if ( GAMEMODE:GetRoundTime() < 60 and GetGlobalInt( "TDM_RoundState" ) == ROUND_IN_PROGRESS ) then return end

	--Players will not be switched if a team is close to winning
	if ( GAMEMODE:GetRedKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5) or GAMEMODE:GetBlueKills() > ( GetGlobalInt( "TDM_ScoreLimit", 50 ) - 5)) then return end

	if ( CurrentRedPlayers > ( CurrentBluePlayers + 1) ) then
		local ply, reason = GAMEMODE:FindLeastCommittedPlayerOnTeam( TEAM_RED )

		classReset( ply )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( TEAM_BLUE )
		ply:KillSilent()
		
		if (ply:IsBot()) then

			ply:SetPData("Player_Class", "infantry" )
			ply:SetPData("Player_PickedClass", "infantry" )
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

		classReset( ply )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( TEAM_RED )
		ply:KillSilent()

		if (ply:IsBot()) then

			ply:SetPData("Player_Class", "infantry" )
			ply:SetPData("Player_PickedClass", "infantry" )
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

	local randomPlayer

	local teamPlaters = team.GetPlayers( teamid )

	randomPlayer = table.Random( teamPlaters )

	return randomPlayer

end