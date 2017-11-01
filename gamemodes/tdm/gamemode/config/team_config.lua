------------------------------------------
--			TEAM CONFIGURATION 			--
------------------------------------------
--
--	Note for server owners:
--	To create a class follow the basic class examples below.
--
--	Be careful of lua table formatting, and use the correct use of commas.
--
--	If you want classes to have more than one player model, see the below example for table formatting:
--
--
--		playerModels = {
--
--			"models/player/bill.mdl",
--			"models/player/ted.mdl",
--			"models/player/johnny.mdl"
--
--		},
--
--
--	Notice how the last entry does not have a comma at the end, and if there is only a single entry there is no comma.
--
--	Good luck!


--Make this true if you want player models chosen by team rather than by class. Default is false.
TDM_TeamBasedPlayerModels = false 

--Team based colors on Player Models. Default is true.
TDM_PlayerModelColors = true 

--Teams have different classes
TDM_TeamBasedClasses = false

--Red Team Player Models ( If TDM_TeamBasedPlayerModels = true )
TDM_PlayerModelsRed = {

	"models/player/arctic.mdl",
	"models/player/guerilla.mdl",
	"models/player/leet.mdl",
	"models/player/phoenix.mdl"

}

--Blue Team Player Models ( If TDM_TeamBasedPlayerModels = true )
TDM_PlayerModelsBlue = {
	
	"models/player/gasmask.mdl",
	"models/player/riot.mdl",
	"models/player/swat.mdl",
	"models/player/urban.mdl"

}

--In Testing
TDM_TeamRedName = "Red Team"
TDM_TeamBlueName = "Blue Team"
TDM_TeamSpecName = "Spectator"
 
TDM_TeamRedColor = Color( 255, 60, 60, 255 )
TDM_TeamBlueColor = Color( 60, 60, 255, 255 )
TDM_TeamSpecColor = Color( 60, 60, 60, 255 )