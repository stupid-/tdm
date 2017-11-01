--[[  Round State  ]]--

ROUND_WAITING = 0
ROUND_PREPARING = 1
ROUND_IN_PROGRESS = 2 
ROUND_OVER = 3

SetGlobalInt( "TDM_RoundState", ROUND_WAITING)
SetGlobalInt( "TDM_RoundTime", 0 )
SetGlobalInt( "TDM_RedKills", 0)
SetGlobalInt( "TDM_BlueKills", 0 )

--[[  Map Vote Code is by https://github.com/wiox/gmod-mapvote  ]]--

mapSettings = {
	Length = 10, -- How long does the vote last?
	AllowCurrent = true, -- Allow voting for map that was just played
	Limit = 18, -- Limit of maps able to vote between
}

--[[  The way rounds were setup is inspired by Mr-Gash's Deathrun https://github.com/Mr-Gash/GMod-Deathrun  ]]--

function GM:SetRoundTime( time )

	return SetGlobalInt( "TDM_RoundTime", CurTime() + (tonumber(time or 5) or 5) )

end

GM.RoundFunctions = {
	
	[ROUND_WAITING] = function( gm )

		gm:SetRoundTime( 0 ) 

	end,

	[ROUND_PREPARING] = function( gm ) 

		game.CleanUpMap()

		gm:SetRoundTime( GetConVarNumber( "tdm_preparetime" ) or 15 )

		--Ticking sound, round about to begin
		timer.Simple ( (GetConVarNumber( "tdm_preparetime" ) - 11.25), function()

			local soundCountdown = "surface.PlaySound( \"ui/ui_menu_flip_single_02.wav\" )"

			for i =0,9 do

				timer.Simple(1+i, function() BroadcastLua( soundCountdown ) end )

			end 

		end )

		for k,v in pairs(player.GetAll()) do

			if (v:Team() != TEAM_SPEC) then

				v:KillSilent()

				v:Spawn()

			end

		end

		SetGlobalInt( "TDM_RedKills", 0)
		SetGlobalInt( "TDM_BlueKills", 0 )

		local rounds_left = math.max(GetGlobalInt( "TDM_RoundsLeft", 1), 0)
		if rounds_left > 1 then

			for k,v in pairs(player.GetAll()) do
				v:ChatPrint( "The map will change in "..rounds_left.." rounds." )
			end

		elseif rounds_left == 1 then

			for k,v in pairs(player.GetAll()) do
				--v:ChatPrint( "The map will change after this round." )
			end

		end

	end,

	[ROUND_IN_PROGRESS] = function( gm ) 

		gm:SetRoundTime( GetConVarNumber( "tdm_roundtime" ) or 600 ) -- 10 minutes default

		game.CleanUpMap()

		timer.Simple(5, SpawnEntities)

		for k,v in pairs(player.GetAll()) do

			v:SetPData( "Level_xp_round", 0 )

			if (v:Team() != TEAM_SPEC) then
				v:KillSilent()
				v:Spawn()
			end

		end

		SetGlobalInt( "TDM_RedKills", 0)
		SetGlobalInt( "TDM_BlueKills", 0 )

		local sound = "surface.PlaySound( \"ttt/thump01e.mp3\" )"

		BroadcastLua( sound )

	end,

	[ROUND_OVER] = function( gm, winner ) 

		gm:SetRoundTime( GetConVarNumber( "tdm_endtime" ) or 20 ) 

		local sound = "surface.PlaySound( \"ttt/thump02e.mp3\" )"

		BroadcastLua( sound )

		if winner == TEAM_RED then

			--Award Red Players
			for k,v in pairs(team.GetPlayers( TEAM_RED )) do
				local vLevel = v:GetPData( "tdm_player_level", 1 )
				local xpToGive = ( 100 + ((vLevel/2)*10) - vLevel )
				v:AddXP( xpToGive )

				v:SetPData( "tdm_stats_wins", ( v:GetPData( "tdm_stats_wins", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s wins: " .. v:GetPData( "tdm_stats_wins", 0 ) )
				MsgN( v:Nick() .. "s losses: " .. v:GetPData( "tdm_stats_losses", 0 ) )
				MsgN( v:Nick() .. "s kills: " .. v:GetPData( "tdm_stats_kills", 0 ) )
				MsgN( v:Nick() .. "s deaths: " .. v:GetPData( "tdm_stats_deaths", 0 ) )

				v:SetPData( "tdm_stats_games_played", ( v:GetPData( "tdm_stats_games_played", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s Games Played: " .. v:GetPData( "tdm_stats_games_played", 0 ) )
			end

			--Blue Players Loss Statistics
			for k,v in pairs(team.GetPlayers( TEAM_BLUE )) do
				v:SetPData( "tdm_stats_losses", ( v:GetPData( "tdm_stats_losses", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s wins: " .. v:GetPData( "tdm_stats_wins", 0 ) )
				MsgN( v:Nick() .. "s losses: " .. v:GetPData( "tdm_stats_losses", 0 ) )
				MsgN( v:Nick() .. "s kills: " .. v:GetPData( "tdm_stats_kills", 0 ) )
				MsgN( v:Nick() .. "s deaths: " .. v:GetPData( "tdm_stats_deaths", 0 ) )

				v:SetPData( "tdm_stats_games_played", ( v:GetPData( "tdm_stats_games_played", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s Games Played: " .. v:GetPData( "tdm_stats_games_played", 0 ) )
			end

			--Play RED MUSIC
			local song = table.Random( TDM_RedTeamMusic )
			song = "surface.PlaySound(\""..song.."\")"

			BroadcastLua( song )

			--Display RED WINS
			for k,v in pairs(player.GetAll()) do

				local tbl = {}
				tbl.winner = TEAM_RED
				tbl.team = v:Team()
				tbl.kills = v:Frags()
				tbl.assists = v:GetNWInt( "Assists", 0)
				tbl.deaths = v:Deaths()
				tbl.headshots = v:GetPData( "tdm_stats_headshot", 0 )
				tbl.killsTotal = v:GetPData( "tdm_stats_kills", 0 )
				tbl.assistsTotal = v:GetPData( "tdm_stats_assists", 0 )
				tbl.deathsTotal = v:GetPData( "tdm_stats_deaths", 0 )
				tbl.wins = v:GetPData( "tdm_stats_wins", 0 )
				tbl.losses = v:GetPData( "tdm_stats_losses", 0 )
				tbl.gamesTotal = v:GetPData( "tdm_stats_games_played", 0 )
				tbl.level = v:GetPData( "tdm_player_level", 1 )
				tbl.savedXP = v:GetPData( "tdm_player_xp", 1 )
				tbl.reqXP = v:GetPData( "tdm_player_xp_req", 1 )
				tbl.earnedXP = v:GetPData( "Level_xp_round", 0 )

				net.Start( "EndGame" )
					net.WriteTable( tbl )
				net.Send( v )

				--v:ConCommand("redWins")
				v:ChatPrint( team.GetName(winner).." Team wins." )

			end

		elseif winner == TEAM_BLUE then

			--Award Blue Players
			for k,v in pairs(team.GetPlayers( TEAM_BLUE )) do
				local vLevel = v:GetPData( "tdm_player_level", 1 )
				local xpToGive = ( 100 + ((vLevel/2)*10) - vLevel )
				v:AddXP( xpToGive )

				v:SetPData( "tdm_stats_wins", ( v:GetPData( "tdm_stats_wins", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s wins: " .. v:GetPData( "tdm_stats_wins", 0 ) )
				MsgN( v:Nick() .. "s losses: " .. v:GetPData( "tdm_stats_losses", 0 ) )
				v:SetPData( "tdm_stats_games_played", ( v:GetPData( "tdm_stats_games_played", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s Games Played: " .. v:GetPData( "tdm_stats_games_played", 0 ) )
			end

			--Red Players Loss Statistics
			for k,v in pairs(team.GetPlayers( TEAM_RED )) do
				v:SetPData( "tdm_stats_losses", ( v:GetPData( "tdm_stats_losses", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s wins: " .. v:GetPData( "tdm_stats_wins", 0 ) )
				MsgN( v:Nick() .. "s losses: " .. v:GetPData( "tdm_stats_losses", 0 ) )

				v:SetPData( "tdm_stats_games_played", ( v:GetPData( "tdm_stats_games_played", 0 ) + 1 ) )
				MsgN( v:Nick() .. "s Games Played: " .. v:GetPData( "tdm_stats_games_played", 0 ) )
			end

			--Play BLUE MUSIC
			local song = table.Random( TDM_BlueTeamMusic )
			song = "surface.PlaySound(\""..song.."\")"

			BroadcastLua( song )

			--Display BLUE WINS
			for k,v in pairs(player.GetAll()) do

				local tbl = {}
				tbl.winner = TEAM_BLUE
				tbl.team = v:Team()
				tbl.kills = v:Frags()
				tbl.assists = v:GetNWInt( "Assists", 0)
				tbl.deaths = v:Deaths()
				tbl.headshots = v:GetPData( "tdm_stats_headshot", 0 )
				tbl.killsTotal = v:GetPData( "tdm_stats_kills", 0 )
				tbl.assistsTotal = v:GetPData( "tdm_stats_assists", 0 )
				tbl.deathsTotal = v:GetPData( "tdm_stats_deaths", 0 )
				tbl.wins = v:GetPData( "tdm_stats_wins", 0 )
				tbl.losses = v:GetPData( "tdm_stats_losses", 0 )
				tbl.gamesTotal = v:GetPData( "tdm_stats_games_played", 0 )
				tbl.level = v:GetPData( "tdm_player_level", 1 )
				tbl.savedXP = v:GetPData( "tdm_player_xp", 1 )
				tbl.reqXP = v:GetPData( "tdm_player_xp_req", 1 )
				tbl.earnedXP = v:GetPData( "Level_xp_round", 0 )

				net.Start( "EndGame" )
					net.WriteTable( tbl )
				net.Send( v )

				--v:ConCommand("blueWins")
				v:ChatPrint( team.GetName(winner).." Team wins." )
			end

		elseif winner == TEAM_SPEC then

			--Display DRAW
			for k,v in pairs(player.GetAll()) do
				v:ConCommand("nobodyWins")
				v:ChatPrint( "Congratulations, nobody wins!" )
			end

			local song = table.Random( TDM_DrawMusic )
			song = "surface.PlaySound(\""..song.."\")"

			BroadcastLua( song )

		end

		local rounds_left = math.max(GetGlobalInt( "TDM_RoundsLeft", 1) - 1, 0)
		SetGlobalInt( "TDM_RoundsLeft", rounds_left )

		if rounds_left < 1 then

			timer.Simple( 20, function()

				MapVote.Start( mapSettings.Length, mapSettings.AllowCurrent, mapSettings.Limit, TDM_PlayableMaps )  

			end )
	        
		end

	end,

}

function GM:SetRound( round, ... )

	if not self.RoundFunctions[round] then return end

	local args = {...}

	SetGlobalInt( "TDM_RoundState", round)

	self.RoundFunctions[round]( self, unpack(args) )

	hook.Call( "OnRoundSet", self, round, unpack(args) )

end

function GM:GetRoundState()

	return GetGlobalInt( "TDM_RoundState" )

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

function GM:GetTeamPlayers()
	local redPlayers = team.GetPlayers( TEAM_RED )
	local bluePlayers = team.GetPlayers( TEAM_BLUE )

	if #redPlayers > 0 and #bluePlayers > 0 then
		return true
	else
		return false
	end
end

GM.ThinkRoundFunctions = {

	[ROUND_WAITING] = function( gm )

		if not gm:GetTeamPlayers() then return end

		gm:SetRound( ROUND_PREPARING )

	end,

	[ROUND_PREPARING] = function( gm )

		if gm:GetRoundTime() <= 0 then

			gm:SetRound( ROUND_IN_PROGRESS )

		end

	end,

	[ROUND_IN_PROGRESS] = function( gm )

		if gm:GetScoreLimit() <= gm.GetRedKills() then

			gm:SetRound( ROUND_OVER, TEAM_RED )

		elseif gm:GetScoreLimit() <= gm.GetBlueKills() then

			gm:SetRound( ROUND_OVER, TEAM_BLUE )

		elseif gm:GetRoundTime() <= 0 then

			if gm.GetRedKills() > gm.GetBlueKills() then

				gm:SetRound( ROUND_OVER, TEAM_RED )

			elseif gm.GetBlueKills() > gm.GetRedKills() then

				gm:SetRound( ROUND_OVER, TEAM_BLUE )

			else

				gm:SetRound( ROUND_OVER, TEAM_SPEC )

			end

		end

	end,

	[ROUND_OVER] = function( gm )

		if gm:GetRoundTime() <= 0 then

			gm:SetRound( ROUND_PREPARING )

		end

	end,

}

function GM:RoundThink()

	local cur = self:GetRound()

	if cur != ROUND_WAITING then

		if #player.GetAll() < 2 then

			self:SetRound(ROUND_WAITING)

			return

		end

	end

	if self.ThinkRoundFunctions[cur] then

		self.ThinkRoundFunctions[cur]( self )

	end

end