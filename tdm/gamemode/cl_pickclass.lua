--[[

This is an extremely bad example of what I want it to look like. To prevent redesigning the gui multiple times, it will look like this until classes have been finalized. 

Feel free to modify this yourself.

]]--

function pickClass( ply )
	local ChooseClassFrame = vgui.Create( "DFrame" )
	ChooseClassFrame:SetSize(ScrW()*0.6, ScrH()*0.6)
	ChooseClassFrame:SetTitle("Welcome. Please Choose a Class.")
	ChooseClassFrame:Center()
	ChooseClassFrame:SetVisible( true )
	ChooseClassFrame:SetDraggable( false )
	ChooseClassFrame:ShowCloseButton( true )
	ChooseClassFrame:MakePopup()
	--ChooseClassFrame.startTime = SysTime()
	ChooseClassFrame.Paint = function()
		--Derma_DrawBackgroundBlur(ChooseClassFrame, ChooseClassFrame.startTime)
	end

	local ChooseTeamSheet = vgui.Create( "DPropertySheet", ChooseClassFrame)
	ChooseTeamSheet:SetPos( 0, 25)
	ChooseTeamSheet:SetSize(ScrW()*0.6, ScrH()*0.6)
	ChooseTeamSheet.Paint = function()
		draw.RoundedBox( 8, 0, 0, ChooseTeamSheet:GetWide(), ChooseTeamSheet:GetTall(), Color(0,0,0,55))
	end

	local SpectatorButton = vgui.Create('DButton')
	SpectatorButton:SetParent(ChooseTeamSheet)
	SpectatorButton:SetSize(100, 30)
	SpectatorButton:SetPos(0, 30)
	SpectatorButton:SetText('Assault')
	SpectatorButton:SetDrawBackground(true)
	SpectatorButton.DoClick = function() 
		if player_manager.GetPlayerClass( ply ) == "assault" then
			ply:ChatPrint( "You are already Assault." )
		else
			RunConsoleCommand( "assaultClass" )
			ChooseClassFrame:Close()
		end
	end

	local SpectatorButton = vgui.Create('DButton')
	SpectatorButton:SetParent(ChooseTeamSheet)
	SpectatorButton:SetSize(100, 30)
	SpectatorButton:SetPos(0, 60)
	SpectatorButton:SetText('Infantry')
	SpectatorButton:SetDrawBackground(true)
	SpectatorButton.DoClick = function() 
		if player_manager.GetPlayerClass( ply ) == "infantry" then
			ply:ChatPrint( "You are already Infantry." )
		else
			RunConsoleCommand( "infantryClass" )
			ChooseClassFrame:Close()
		end
	end

	local SpectatorButton = vgui.Create('DButton')
	SpectatorButton:SetParent(ChooseTeamSheet)
	SpectatorButton:SetSize(100, 30)
	SpectatorButton:SetPos(0, 90)
	SpectatorButton:SetText('Heavy')
	SpectatorButton:SetDrawBackground(true)
	SpectatorButton.DoClick = function() 
		if player_manager.GetPlayerClass( ply ) == "heavy" then
			ply:ChatPrint( "You are already Heavy." )
		else
			RunConsoleCommand( "heavyClass" )
			ChooseClassFrame:Close()
		end
	end

	local SpectatorButton = vgui.Create('DButton')
	SpectatorButton:SetParent(ChooseTeamSheet)
	SpectatorButton:SetSize(100, 30)
	SpectatorButton:SetPos(0, 120)
	SpectatorButton:SetText('Sniper')
	SpectatorButton:SetDrawBackground(true)
	SpectatorButton.DoClick = function() 
		if player_manager.GetPlayerClass( ply ) == "sniper" then
			ply:ChatPrint( "You are already Sniper." )
		else
			RunConsoleCommand( "sniperClass" )
			ChooseClassFrame:Close()
		end
	end
end
concommand.Add("pickClass", pickClass)