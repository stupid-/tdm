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
AddCSLuaFile("mapvote/cl_mapvote.lua")

--Classes For Client
AddCSLuaFile("player_class/noclass.lua")
AddCSLuaFile("player_class/assault.lua")
AddCSLuaFile("player_class/infantry.lua")
AddCSLuaFile("player_class/heavy.lua")
AddCSLuaFile("player_class/sniper.lua")

------------------------------------------
--				ConVars					--
------------------------------------------
-- Need to fix the setting of some of the ConVars, not entirely working.
local round_preparetime = CreateConVar( "tdm_preparetime", "20", FCVAR_ARCHIVE )
local round_time = CreateConVar( "tdm_roundtime", "600", FCVAR_ARCHIVE )
local round_endtime = CreateConVar( "tdm_endtime", "20", FCVAR_ARCHIVE )
local round_limit = CreateConVar( "tdm_roundlimit", "2", FCVAR_ARCHIVE )
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

	-- Coming soon

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

	timer.Create( "CheckTeamBalance", 30, 0, function() GAMEMODE:CheckTeamBalance() end )

end

------------------------------------------
--				Spawning				--
------------------------------------------

function GM:PlayerInitialSpawn ( ply )
	print("Player: " .. ply:Nick() .. " has joined.")

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

		ply:ConCommand("welcomePlayer")
	end
end

function GM:PlayerSpawn ( ply )
	if ply:Team() == TEAM_SPEC then 
		ply:Spectate( OBS_MODE_ROAMING )

	elseif (ply:Team() == TEAM_RED || ply:Team() == TEAM_BLUE ) then

		local color = team.GetColor( ply:Team() )

		ply:SetPlayerColor( Vector( color.r/255, color.g/255, color.b/255 ) )

		ply:SetupHands()
		player_manager.OnPlayerSpawn( ply )
        player_manager.RunClass( ply, "Spawn" )
        hook.Call( "PlayerLoadout", GAMEMODE, ply )
        hook.Call( "PlayerSetModel", GAMEMODE, ply )

    -- Incase someone spawns with no class picked, they will be silently killed and asked to pick a class.
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

--Doing this just in case, team.SetSpawnPoint wasn't working. Works now. Leaving both in.
function GM:PlayerSelectSpawn( ply ) 
 
    local spawns = ents.FindByClass( "info_player_terrorist" ) 
    local truespawn = table.Random(spawns)

    if (ply:Team() == TEAM_RED || ply:Team() == TEAM_SPEC) then

        return truespawn

    end 


    local spawns = ents.FindByClass( "info_player_counterterrorist" ) 
    local truespawn = table.Random(spawns)

    if (ply:Team() == TEAM_BLUE) then

        return truespawn

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

	if ply:Team() == TEAM_SPEC then return false end

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
------------------------------------------
--			Team Switching				--
------------------------------------------

function stTeamSpec( ply )
	if ( ply:Team() == 2 || ply.NextSwitchTime > CurTime() ) then return end

	ply.NextSwitchTime = CurTime() + 30

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
	if ( ply:Team() == 0 || ply.NextSwitchTime > CurTime() ) then return end

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
	if ( ply:Team() == 1 || ply.NextSwitchTime > CurTime() ) then return end

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

-- I need to rewrite this, inspired by Fretta13, just need something that works atm. 
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