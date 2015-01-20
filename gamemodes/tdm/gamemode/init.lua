include("shared.lua")
include("player.lua")
include("sv_rounds.lua")

--Classes  
include("player_class/noclass.lua")
include("player_class/assault.lua")
include("player_class/infantry.lua")
include("player_class/heavy.lua")
include("player_class/sniper.lua")

--Map Voting (Not My Code), By https://github.com/wiox/gmod-mapvote
include("mapvote/mapvote.lua")
include("mapvote/sv_mapvote.lua")

--Includes for Client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_menus.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_welcome.lua")
AddCSLuaFile("cl_pickclass.lua")
AddCSLuaFile("cl_voice.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("cl_targetid.lua")
AddCSLuaFile("mapvote/cl_mapvote.lua")

--Classes For Client
AddCSLuaFile("player_class/noclass.lua")
AddCSLuaFile("player_class/assault.lua")
AddCSLuaFile("player_class/infantry.lua")
AddCSLuaFile("player_class/heavy.lua")
AddCSLuaFile("player_class/sniper.lua")
AddCSLuaFile("player_class/commando.lua")

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

	ply:ConCommand("chooseTeam") --cl_menus.lua

end

function GM:ShowTeam( ply ) -- F2 

	ply:ConCommand("pickClass") --cl_picklass.lua

end

function GM:ShowSpare2( ply ) -- F4

	-- Coming soon --cl_help.lua
	-- Help Menu

end

------------------------------------------
--		Connecting/Disconnecting		--
------------------------------------------

function GM:PlayerConnect ( name, ip )

	print("Player: " .. name .. " has connected.")

end


function GM:PlayerAuthed ( ply, steamid, uniqueid )

	print ("Player: " .. ply:Nick() .. " ( " .. steamid .. " ) has authenticated.")

end

function GM:PlayerDisconnected( ply )

	print("Player: " .. ply:Nick() .. " has disconnected.")

end

------------------------------------------
--			Initializing Convars		--
------------------------------------------

function GM:Initialize()

	SetGlobalInt( "TDM_RoundsLeft", round_limit:GetInt() )

	SetGlobalInt( "TDM_ScoreLimit", round_scorelimit:GetInt() )

	timer.Create( "CheckTeamBalance", 15, 0, function() 

		if ( GetGlobalInt( "TDM_RoundState" ) == 0 or GetGlobalInt( "TDM_RoundState" ) == 1 or GetGlobalInt( "TDM_RoundState" ) == 3 ) then 

			--Do Nothing, annoying when team balancing happens preround. 

		else

			GAMEMODE:CheckTeamBalance() 

		end 

	end )

end

------------------------------------------
--				Spawning				--
------------------------------------------

function GM:PlayerInitialSpawn ( ply )
	--print("Player: " .. ply:Nick() .. " has joined.")

	ply.NextSwitchTime = 0

	-- IsBot() Is for testing gamemode features in private.
	if (ply:IsBot()) then
		-- Randomly Set Bot Team
		ply:SetTeam( math.random(0, 1) )

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

		timer.Simple( 3, function() ply:ConCommand("welcomePlayer") end )
	end
end

function GM:PlayerSpawn ( ply )
	if ply:Team() == TEAM_SPEC then 

		ply:Spectate( OBS_MODE_ROAMING )

	--Make sure the player has a class before spawned
	elseif (ply:Team() == TEAM_RED && player_manager.GetPlayerClass( ply ) != "noclass" || ply:Team() == TEAM_BLUE && player_manager.GetPlayerClass( ply ) != "noclass" ) then

		local color = team.GetColor( ply:Team() )

		ply:SetPlayerColor( Vector( color.r/255, color.g/255, color.b/255 ) )

		ply:SetupHands()
		player_manager.OnPlayerSpawn( ply )
        player_manager.RunClass( ply, "Spawn" )
        hook.Call( "PlayerLoadout", GAMEMODE, ply )
        hook.Call( "PlayerSetModel", GAMEMODE, ply )


        --Most Basic Spawn Protection, 4 Seconds of God Mode.
        ply:GodEnable()

        local function unprotect()

        	if IsValid(ply) then

        		ply:GodDisable()

        	end

        end
        timer.Simple( 4, unprotect)

    -- If no class, force class selection or else no spawn
	elseif (player_manager.GetPlayerClass( ply ) == "noclass") then

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

function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )

	local Pos = spawnpointent:GetPos()

	local Ents = ents.FindInBox( Pos + Vector( -16, -16, 0 ), Pos + Vector( 16, 16, 72 ) )

	if ( ply:Team() == TEAM_SPEC ) then return true end

	local Blockers = 0

	for k, v in pairs( Ents ) do

		if ( IsValid( v ) && v:GetClass() == "player" && v:Alive() ) then

			Blockers = Blockers + 1

		end
		
	end

	if ( Blockers > 0 ) then return false end
	
	return true

end

function GM:PlayerSelectSpawn( ply ) 

	if (ply:Team() == TEAM_SPEC) then

	    local spawns = ents.FindByClass( "info_player_terrorist" ) 

	    spawns = table.Add(spawns, ents.FindByClass( "info_player_counterterrorist" ) )

	    local truespawn = table.Random(spawns)

	    return truespawn

	end

    if (ply:Team() == TEAM_RED) then

	    local spawns = ents.FindByClass( "info_player_terrorist" )

	    local Count = table.Count(spawns)

		local ChosenSpawnPoint = nil
		
		for i=0, Count do
		
			ChosenSpawnPoint = table.Random(spawns)

			if ( ChosenSpawnPoint &&
				ChosenSpawnPoint:IsValid() &&
				ChosenSpawnPoint:IsInWorld() &&
				ChosenSpawnPoint != ply:GetVar( "LastSpawnpoint" ) &&
				ChosenSpawnPoint != self.LastSpawnPoint ) then
				
				if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, ply, ChosenSpawnPoint, i == Count ) ) then
				
					self.LastSpawnPoint = ChosenSpawnPoint
					ply:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
					return ChosenSpawnPoint
				
				end
				
			end
				
		end
		
		return ChosenSpawnPoint

    end 

    if (ply:Team() == TEAM_BLUE) then

	    local spawns = ents.FindByClass( "info_player_counterterrorist" ) 

	    local Count = table.Count(spawns)

		local ChosenSpawnPoint = nil
		
		for i=0, Count do
		
			ChosenSpawnPoint = table.Random(spawns)

			if ( ChosenSpawnPoint &&
				ChosenSpawnPoint:IsValid() &&
				ChosenSpawnPoint:IsInWorld() &&
				ChosenSpawnPoint != ply:GetVar( "LastSpawnpoint" ) &&
				ChosenSpawnPoint != self.LastSpawnPoint ) then
				
				if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, ply, ChosenSpawnPoint, i == Count ) ) then
				
					self.LastSpawnPoint = ChosenSpawnPoint
					ply:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
					return ChosenSpawnPoint
				
				end
				
			end
				
		end
		
		return ChosenSpawnPoint

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
	if ( ply:Team() == 2 || ply.NextSwitchTime > CurTime() ) then return end

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

	if (player_manager.GetPlayerClass( ply ) == "assault" || (ply:Team() == 2) ) then return end

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

	if (player_manager.GetPlayerClass( ply ) == "infantry" || (ply:Team() == 2) ) then return end

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

	if (player_manager.GetPlayerClass( ply ) == "heavy" || (ply:Team() == 2) ) then return end

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

	if (player_manager.GetPlayerClass( ply ) == "sniper" || (ply:Team() == 2) ) then return end

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

	if (player_manager.GetPlayerClass( ply ) == "commando" || (ply:Team() == 2) ) then return end

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

		local ply, reason = GAMEMODE:FindLeastCommittedPlayerOnTeam( 0 )

		player_manager.SetPlayerClass( ply, "noclass" )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( 1 )
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

		local ply, reason = GAMEMODE:FindLeastCommittedPlayerOnTeam( 1 )

		player_manager.SetPlayerClass( ply, "noclass" )
		ply:UnSpectate()
		ply:StripWeapons()
		ply:SetTeam( 0 )
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

	return worst, "Least points on their team"

end