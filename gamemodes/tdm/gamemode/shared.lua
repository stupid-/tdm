DeriveGamemode( "base" )

GM.Name = "Team Deathmatch"
GM.Author = "Stupid"
GM.Email = "stupid@stupids-servers.com"
GM.Website = "www.stupids-servers.com"
GM.TeamBased = true
GM.Version = "01-29-15"

include( "mapvote/mapvote.lua" )

--Classes
include( "player_class/noclass.lua" )
include( "player_class/assault.lua" )
include( "player_class/infantry.lua" )
include( "player_class/heavy.lua" )
include( "player_class/sniper.lua" )
include( "player_class/commando.lua" )

TEAM_RED = 1
TEAM_BLUE = 2
TEAM_SPEC = 3

function GM:CreateTeams()
	team.SetUp( TEAM_RED, "Red", Color( 255, 60, 60, 255 ), true )
	team.SetUp( TEAM_BLUE, "Blue", Color( 60, 60, 255, 255 ), true )
	team.SetUp( TEAM_SPEC, "Spectator", Color( 60, 60, 60 , 255 ), true )

	--Set Spawn Points
	team.SetSpawnPoint( TEAM_RED, {"info_player_terrorist"} )
	team.SetSpawnPoint( TEAM_BLUE, {"info_player_counterterrorist"} )
	team.SetSpawnPoint( TEAM_SPEC, {"info_player_terrorist"} )

	--Precaching Playermodels
	util.PrecacheModel( 'models/player/leet.mdl' )
	util.PrecacheModel( 'models/player/phoenix.mdl' )
	util.PrecacheModel( 'models/player/barney.mdl' )
end

function GetAssists( ply )

	local PlayerAssists = ply.Assists 

	return PlayerAssists

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

--Not my code, temp hitmarker.
--Game sucks without hitmarkers.
if CLIENT then
	hit = false
	W = ScrW()/2
	H = ScrH()/2
	usermessage.Hook("HIT_MARK", function()
		hit = true
		opac = 150
		--hitmarker sound
		surface.PlaySound( "tdm/hitmarker.wav" )

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

	usermessage.Hook( "Headshot_Death", function() 

		surface.PlaySound( "tdm/headshot.mp3" )

	end )
end

if SERVER then
	hook.Add("PlayerHurt", "Hit", function(ply, attacker)
		if IsValid(attacker) and attacker:IsPlayer() then
			umsg.Start( "HIT_MARK", attacker )
			umsg.End()
		end
	end)
end