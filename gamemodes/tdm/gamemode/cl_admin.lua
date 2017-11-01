function adminMenu( ply )

	if ply:IsAdmin() == false then return end

	local AdminFrame = vgui.Create( "DFrame" )
	AdminFrame:SetSize( 800, 600 )
	AdminFrame:SetTitle("Administration")
	AdminFrame:Center()
	AdminFrame:SetVisible( true )
	AdminFrame:SetDraggable( false )
	AdminFrame:ShowCloseButton( true )
	AdminFrame:MakePopup()
	/*
	AdminFrame.Paint = function()
	end
	*/

	local PlayerList = vgui.Create( "DListView" )
	PlayerList:SetParent( AdminFrame )
	PlayerList:SetPos( 200, 50 )
	PlayerList:SetSize( 375, 525)
	PlayerList:SetMultiSelect( false )
	PlayerList:AddColumn( "Player" )
	PlayerList:AddColumn( "SteamID" )
	PlayerList:AddColumn( "Team" )
	PlayerList:SortByColumn( 2 )

	for k, plyr in pairs( player.GetAll() ) do

		if plyr:Team() == TEAM_RED then

			PlayerList:AddLine( plyr:Nick(), plyr:SteamID(), "Red Team" )

		elseif plyr:Team() == TEAM_BLUE then

			PlayerList:AddLine( plyr:Nick(), plyr:SteamID(), "Blue Team" )

		else

			PlayerList:AddLine( plyr:Nick(), plyr:SteamID(), "Spectator" )

		end

	end

	local AdminCategories = vgui.Create( "DCategoryList" )
	AdminCategories:SetParent( AdminFrame )
	AdminCategories:SetPos( 25, 50 )
	AdminCategories:SetSize( 150, 525 )

	local AdminPlayers = AdminCategories:Add( "Player Options" )

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminPlayers )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 25 )
	testButton:SetText( "Kick" )
	/*
	testButton:DoClick = function()
	end
	*/

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminPlayers )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 50 )
	testButton:SetText( "Ban" )
	/*
	testButton:DoClick = function()
	end
	*/

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminPlayers )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 85 )
	testButton:SetText( "Mute" )
	/*
	testButton:DoClick = function()
	end
	*/

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminPlayers )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 110 )
	testButton:SetText( "Gag" )
	/*
	testButton:DoClick = function()
	end
	*/

	local AdminTeams = AdminCategories:Add( "Team Options" )

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminTeams )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 25 )
	testButton:SetText( "Force Red" )
	/*
	testButton:DoClick = function()
	end
	*/

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminTeams )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 50 )
	testButton:SetText( "Force Blue" )
	/*
	testButton:DoClick = function()
	end
	*/

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminTeams )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 75 )
	testButton:SetText( "Force Spectate" )
	/*
	testButton:DoClick = function()
	end
	*/

	local AdminRounds = AdminCategories:Add( "Round Options" )

	local testButton = vgui.Create( "DButton" )
	testButton:SetParent( AdminRounds )
	testButton:SetSize( 146, 25 )
	testButton:SetPos( 0, 25 )
	testButton:SetText( "Round Restart" )
	/*
	testButton:DoClick = function()
	end
	*/

end

concommand.Add( "adminMenu", adminMenu )