DeriveGamemode( "base" )

GM.Name = "Team Deathmatch"
GM.Author = "Stupid"
GM.Email = "stupid@stupids-servers.com"
GM.Website = "www.stupids-servers.com"
GM.TeamBased = true

--Classes
include("mapvote/mapvote.lua")
include("player_class/noclass.lua")
include("player_class/assault.lua")
include("player_class/infantry.lua")

TEAM_RED = 0
TEAM_BLUE = 1
TEAM_SPEC = 2

--Future Convars
--[[
GM.RoundLimit = 
GM.RoundLength = 
GM.RoundPostEndTime =
GM.RoundPrepStartTime =
GM.RoundWarmupTime =
]]--

function GM:CreateTeams()
	team.SetUp(TEAM_RED, "Red", Color(255, 0, 0, 255), true)
	team.SetUp(TEAM_BLUE, "Blue", Color(0, 0, 255, 255), true)
	team.SetUp(TEAM_SPEC, "Spectator", Color(0, 0, 0 , 255), true)

	--Set Spawn Points
	team.SetSpawnPoint( TEAM_RED, {"info_player_terrorist"} )
	team.SetSpawnPoint( TEAM_BLUE, {"info_player_counterterrorist"} )
	--team.SetSpawnPoint( TEAM_SPEC, {"info_player_start"} )

	--Precaching Playermodels
	util.PrecacheModel( 'models/player/leet.mdl' )
	util.PrecacheModel( 'models/player/barney.mdl' )
end

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

function GM:GetRound()

	return GetGlobalInt( "TDM_RoundState" )

end

function GM:GetRoundTime()

	return math.Round(math.max( GetGlobalInt( "TDM_RoundTime") - CurTime(), 0) )

end

function GM:GetScoreLimit()

	return GetGlobalInt( "TDM_ScoreLimit" )

end

function GM:GetRoundsLeft()

	return GetGlobalInt( "TDM_RoundsLeft" )

end

function GM:GetRedKills()

	return GetGlobalInt( "TDM_RedKills" )

end

function GM:GetBlueKills()

	return GetGlobalInt( "TDM_BlueKills" )

end

if CLIENT then
	hit = false
	W = ScrW()/2
	H = ScrH()/2
	usermessage.Hook("HIT_MARK", function()
		hit = true
		opac = 150
		timer.Simple(0.2, function()   
			hook.Add("Think", "hit_fade", function()
				opac = opac - 5
				if opac <= 0 then
					hook.Remove("Think", "hit_fade")
					hit = false
				end
			end)
		end)
	end)
	hook.Add("HUDPaint", "HITMARKER", function()
		if hit then
			surface.SetDrawColor(255,255,255,opac)
			surface.DrawLine(W-2,H-2,W-8,H-8)
			surface.DrawLine(W+2,H-2,W+8,H-8)
			surface.DrawLine(W+2,H+2,W+8,H+8)
			surface.DrawLine(W-2,H+2,W-8,H+8)
		end
	end)
end

if SERVER then
	hook.Add("PlayerHurt", "Hit", function(ply, attacker)
		if IsValid(attacker) and attacker:IsPlayer() then
			umsg.Start( "HIT_MARK", attacker )
			umsg.End()
		end
	end)
end