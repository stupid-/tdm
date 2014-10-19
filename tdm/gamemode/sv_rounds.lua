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

local mapSettings = {
	Length = 15, -- How long does the vote last?
	AllowCurrent = true, -- Allow voting for map that was just played
	Limit = 12, -- Limit of maps able to vote between
	Prefix = {"tdm_", "cs_", "de_"}, -- Map Prefix, chooses all maps with set presets
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

		for k,v in pairs(player.GetAll()) do
			v:KillSilent()
			v:Spawn()
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
				v:ChatPrint( "The map will change after this round." )
			end

		end

	end,

	[ROUND_IN_PROGRESS] = function( gm ) 

		gm:SetRoundTime( GetConVarNumber( "tdm_roundtime" ) or 600 ) -- 10 minutes default

		game.CleanUpMap()

		for k,v in pairs(player.GetAll()) do
			v:KillSilent()
			v:Spawn()
		end

		SetGlobalInt( "TDM_RedKills", 0)
		SetGlobalInt( "TDM_BlueKills", 0 )

		local sound = "surface.PlaySound( \"ttt/thump01e.mp3\" )"

		BroadcastLua( sound )

	end,

	[ROUND_OVER] = function( gm, winner) 

		gm:SetRoundTime( GetConVarNumber( "tdm_endtime" ) or 20 ) 

		local sound = "surface.PlaySound( \"ttt/thump02e.mp3\" )"

		BroadcastLua( sound )

		for k,v in pairs(player.GetAll()) do
			v:ChatPrint( team.GetName(winner).." Team wins." )
		end

		if winner == 0 then

			for k,v in pairs(player.GetAll()) do
				v:ConCommand("redWins")
			end

		else

			for k,v in pairs(player.GetAll()) do
				v:ConCommand("blueWins")
			end

		end

		local rounds_left = math.max(GetGlobalInt( "TDM_RoundsLeft", 1) - 1, 0)
		SetGlobalInt( "TDM_RoundsLeft", rounds_left )

		if rounds_left < 1 then
		    
	        MapVote.Start(mapSettings.Length, mapSettings.AllowCurrent, mapSettings.Limit, mapSettings.Prefix)  
	        
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

GM.ThinkRoundFunctions = {

	[ROUND_WAITING] = function( gm )

		if #player.GetAll() < 2 then return end

		gm:SetRound( ROUND_PREPARING )

	end,

	[ROUND_PREPARING] = function( gm )

		if gm:GetRoundTime() <= 0 then

			gm:SetRound( ROUND_IN_PROGRESS )

		end

	end,

	[ROUND_IN_PROGRESS] = function( gm )

		if gm:GetScoreLimit() <= gm.GetRedKills() then

			gm:SetRound( ROUND_OVER, 0 )

		elseif gm:GetScoreLimit() <= gm.GetBlueKills() then

			gm:SetRound( ROUND_OVER, 1 )

		elseif gm:GetRoundTime() <= 0 then

			if gm.GetRedKills() > gm.GetBlueKills() then

				gm:SetRound( ROUND_OVER, 0 )

			else

				gm:SetRound( ROUND_OVER, 1 )

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