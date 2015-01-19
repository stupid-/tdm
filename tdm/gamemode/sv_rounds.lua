--[[  Round State  ]]--

ROUND_WAITING = 0
ROUND_PREPARING = 1
ROUND_IN_PROGRESS = 2 
ROUND_OVER = 3

SetGlobalInt( "TDM_RoundState", ROUND_WAITING)
SetGlobalInt( "TDM_RoundTime", 0 )
SetGlobalInt( "TDM_RedKills", 0)
SetGlobalInt( "TDM_BlueKills", 0 )

local red_music = {
	
	"inno/africa.mp3",
	"inno/brother.mp3",
	"inno/hero.mp3",
	"inno/lotr.mp3",
	"inno/finalf.mp3",
	"inno/joy.mp3",
	"inno/oblivion.mp3",
	"inno/park.mp3",
	"inno/90s_v2.mp3",
	"inno/gay_v2.mp3",
	"inno/pirate.mp3",
	"inno/victory_v2.mp3",
	"inno/aot.mp3",
	"inno/bf4.mp3",
	"inno/rebel.mp3",
	"inno/ru.mp3",
	"inno/mother.mp3",
	"inno/jack.mp3",
	"inno/harder.mp3",
	"inno/stepup.mp3",
	"inno/careless.mp3",
	"inno/men.mp3"

}

local blue_music = {
	
	"traitor/german.mp3",
	"traitor/lotr2.mp3",
	"traitor/march.mp3",
	"traitor/septh.mp3",
	"traitor/sad.mp3",
	"traitor/mass.mp3",
	"traitor/call.mp3",
	"traitor/soviet.mp3",
	"traitor/danger_v2.mp3",
	"traitor/dropit_v2.mp3",
	"traitor/jungle.mp3",
	"traitor/saw_v2.mp3",
	"traitor/died.mp3",
	"traitor/kebab.mp3",
	"traitor/lies.mp3",
	"traitor/yns2.mp3",
	"traitor/someone.mp3",
	"traitor/sex.mp3",
	"traitor/monster.mp3",
	"traitor/shia.mp3",
	"traitor/club.mp3",
	"traitor/ussr.mp3"

}

--[[  Map Vote Code is by https://github.com/wiox/gmod-mapvote  ]]--

mapSettings = {
	Length = 15, -- How long does the vote last?
	AllowCurrent = true, -- Allow voting for map that was just played
	Limit = 18, -- Limit of maps able to vote between
	Prefix = {"de_dust_go", "de_dust2_go", "de_nuke_go", "de_inferno_go", "de_train_go", "de_lake_go"}, -- Map Prefix, chooses all maps with set presets
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

		for k,v in pairs(player.GetAll()) do

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

	[ROUND_OVER] = function( gm, winner) 

		gm:SetRoundTime( GetConVarNumber( "tdm_endtime" ) or 20 ) 

		local sound = "surface.PlaySound( \"ttt/thump02e.mp3\" )"

		BroadcastLua( sound )

		for k,v in pairs(player.GetAll()) do
			v:ChatPrint( team.GetName(winner).." Team wins." )
		end

		if winner == 0 then

			--Display RED WINS
			for k,v in pairs(player.GetAll()) do
				v:ConCommand("redWins")
			end

			--Play RED MUSIC
			local song = table.Random( red_music )
			song = "surface.PlaySound(\""..song.."\")"

			BroadcastLua( song )

		else

			--Display BLUE WINS
			for k,v in pairs(player.GetAll()) do
				v:ConCommand("blueWins")
			end

			--Play BLUE MUSIC
			local song = table.Random( blue_music )
			song = "surface.PlaySound(\""..song.."\")"

			BroadcastLua( song )

		end

		local rounds_left = math.max(GetGlobalInt( "TDM_RoundsLeft", 1) - 1, 0)
		SetGlobalInt( "TDM_RoundsLeft", rounds_left )

		if rounds_left < 1 then

			timer.Simple(6, function()

				MapVote.Start(mapSettings.Length, mapSettings.AllowCurrent, mapSettings.Limit, mapSettings.Prefix)  

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