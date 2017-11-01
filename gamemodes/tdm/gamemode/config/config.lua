--Configuation

--CVars not in this config file. Set these in your server.cfg file.
-- tdm_preparetime (Default 60, time in seconds before match starts)
-- tdm_roundtime (Default 600, time in seconds, how long the match is)
-- tdm_endtime (Default 30, time in seconds at the end of the round)
-- tdm_roundlimit (Default 1, you can play more than 1 round per map)
-- tdm_scorelimit (Default 50, kills required for a team to win)

--Enable Friendly Fire.
TDM_FriendlyFire = false

--Seconds of Godmode when players Spawn.
--Godmode is also disabled when the player discharges their firearm. Default is 2.5 Seconds.
TDM_SpawnProtectionTime = 2.5

--Delay in seconds until a player can "click" to respawn. Default is 3.
TDM_RespawnDelay = 3

--Delay in seconds until a player is forcebly respawned. Default is 5. 
TDM_ForceRespawnDelay = 5

--Not Recommended, teams lose score when they die. Default is false. 
TDM_EnableSuicide = false

--How often to check if teams are unbalanced. Default is 30 Seconds.
TDM_TeamBalanceCheckTime = 30

--Should we auto balance the teams? Default is true.
TDM_TeamAutoBalance = true

--How long should the cooldown be on switching teams? Default is 20 Seconds.
TDM_SwitchTeamCooldown = 15

--For adding spawns on maps, make sure the spawn text file has the map name and ends with the _tdm suffix, e.g. cs_office_tdm.txt
--See content/maps/cs_office_tdm.txt as an example
------------------------------------------
--			MAP LIST CONFIG  			--
------------------------------------------
TDM_PlayableMaps = {
	
	"cs_office",
	"stdm_dust",
	"stdm_dust2",
	"stdm_inferno",
	"stdm_nuke",
	"tdm_cod4_vacant",
	"tdm_nuketown_b0"

}

--When adding to the music table, make sure entrys are separated by commas, excluding the last entry (e.g. look at the map list table)
------------------------------------------
--			RED WINS MUSIC  			--
------------------------------------------
TDM_RedTeamMusic = {
	
	"tdm/red/red01.mp3"

}

--When adding to the music table, make sure entrys are separated by commas, excluding the last entry (e.g. look at the map list table)
------------------------------------------
--			BLUE WINS MUSIC  			--
------------------------------------------
TDM_BlueTeamMusic = {
	
	"tdm/blue/blue01.mp3"

}

--When adding to the music table, make sure entrys are separated by commas, excluding the last entry (e.g. look at the map list table)
------------------------------------------
--				DRAW MUSIC  			--
------------------------------------------
TDM_DrawMusic = {
	
	"tdm/draw/draw01.mp3"

}