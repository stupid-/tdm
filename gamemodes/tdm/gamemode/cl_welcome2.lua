-- Fonts
surface.CreateFont( "TDM_Title", { font = "Software Tester 7", size = 32, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "TDM_ServerTitle", { font = "Triomphe", size = 20, weight = 600, antialias = true, blursize = 0.4, shadow = false })
surface.CreateFont( "TDM_FooterText", { font = "Triomphe", size = 18, weight = 600, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "TDM_MenuOptions", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 0, shadow = false })
surface.CreateFont( "WelcomeMenu", { font = "CloseCaption_Normal", size = 32, weight = 200, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "WelcomeMenu2", { font = "CloseCaption_Normal", size = 18, weight = 600, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "WelcomeMenu3", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 0.2, shadow = false })

local blur = Material("pp/blurscreen")
local gradient = surface.GetTextureID("gui/gradient_up")
local gradient2 = surface.GetTextureID("gui/gradient_down")
local gradient3 = surface.GetTextureID("gui/gradient")
local gradient4 = surface.GetTextureID("vgui/gradient-r")

local border_opac = 10

local buttonXPos = ScrW() / 12
local buttonYPos = 100 + ScrH() / 12
local buttonHeight = 55
local buttonWidth = 80 + ScrW() / 6.5

local margin = 60
local panelWidth = ScrW() - buttonWidth - buttonXPos*2 - margin
local panelHeight = ScrH() - 200 - margin - buttonYPos/2

local function DrawBlur(panel, amount)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)

	for i = 1, 3 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

function welcomePlayer2( ply )
	local PlayerName = LocalPlayer():Nick()
	local MapName = game.GetMap()
	local SpecPlayers = GetGlobalInt( "TDM_SpecTeamNum" )
	local RedPlayers = GetGlobalInt( "TDM_RedTeamNum" )
	local BluePlayers = GetGlobalInt( "TDM_BlueTeamNum" )

	--Force update of information
	timer.Create( "NumberCheckTimer", 1, 0, function() 

		PlayerName = LocalPlayer():Nick()
		SpecPlayers = GetGlobalInt( "TDM_SpecTeamNum" )
		RedPlayers = GetGlobalInt( "TDM_RedTeamNum" )
		BluePlayers = GetGlobalInt( "TDM_BlueTeamNum" )

	end )

	local MenuFrame = vgui.Create( "DFrame" )
	MenuFrame:SetSize(ScrW(), ScrH())
	MenuFrame:SetTitle("")
	MenuFrame:SetPos( 0, 0 )
	MenuFrame:SetVisible( true )
	MenuFrame:SetDraggable( false )
	MenuFrame:ShowCloseButton( false )
	MenuFrame:MakePopup()
	function MenuFrame:Paint( w, h, ply )
		DrawBlur( MenuFrame, 2 )

		draw.RoundedBox( 0, 0, 0, w, 100, Color( 10, 10, 10, 251 ) )
		draw.RoundedBox( 0, 0, 100, w, h - 200, Color( 20, 30, 30, 235 ) )
		draw.RoundedBox( 0, 0, h - 100, w, 100, Color( 10, 10, 10, 251 ) )

		surface.SetDrawColor( 10, 10, 10, 100 )
		surface.SetTexture( gradient2 )
		surface.DrawTexturedRect(0, 100, w, 15)

		surface.SetDrawColor( 10, 10, 10, 100 )
		surface.SetTexture( gradient )
		surface.DrawTexturedRect(0, h - 100 - 15, w, 15)

		surface.SetDrawColor(225, 225, 225, 20)
		surface.DrawRect(0, 100, w, 2)
		surface.DrawRect(0, h - 100, w, 2)

		surface.SetDrawColor(230, 200, 24, 255)
		surface.DrawRect(120, 100 - 28, 7, 18)

		draw.DrawText( "[Stupid's TDM] - Custom", "TDM_ServerTitle", 120, 100 - 60, Color( 230, 200, 24, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Version 1.0.0", "TDM_ServerTitle", 498, 100 - 27, Color( 180, 180, 180, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		draw.DrawText( "TEAM DEATHMATCH", "TDM_Title", 135, 100 - 35, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

		draw.DrawText( "[F1]", "TDM_FooterText", 120, h - 100 + 10, Color( 230, 200, 24, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Home Menu", "TDM_FooterText", 156, h - 100 + 10, Color( 210, 210, 210, 255 ), TEXT_ALIGN_LEFT )

		draw.DrawText( "[F2]", "TDM_FooterText", 260, h - 100 + 10, Color( 230, 200, 24, 255 ), TEXT_ALIGN_LEFT )
		draw.DrawText( "Change Classes", "TDM_FooterText", 296, h - 100 + 10, Color( 210, 210, 210, 255 ), TEXT_ALIGN_LEFT )

		surface.SetDrawColor( 10, 10, 10, 80 )
		surface.SetTexture( gradient2 )
		surface.DrawTexturedRect( buttonXPos, buttonYPos + buttonHeight*4, buttonWidth, 200)

		surface.SetDrawColor( 225, 225, 225, 10 )
		surface.SetTexture( gradient2 )
		surface.DrawTexturedRect( buttonXPos, buttonYPos + buttonHeight*4, 2, 200)

		surface.SetDrawColor( 225, 225, 225, 10 )
		surface.SetTexture( gradient2 )
		surface.DrawTexturedRect( buttonXPos + buttonWidth - 2, buttonYPos + buttonHeight*4, 2, 200)

		surface.SetDrawColor( 10, 10, 10, 60 )
		surface.SetTexture( gradient3 )
		surface.DrawTexturedRect( buttonXPos + buttonWidth, buttonYPos, 8, buttonHeight*4 + 180)
	end

	local WelcomePanel = vgui.Create("DPanel", MenuFrame)
	WelcomePanel:SetSize( panelWidth, panelHeight )
	WelcomePanel:SetPos( buttonXPos + buttonWidth + margin, buttonYPos)
	WelcomePanel:SetDrawBackground( false )
	function WelcomePanel:Paint(w, h)

		if WelcomePanel:GetDisabled() == false then
			draw.RoundedBoxEx( 0, 0, 0, w, h, Color(10,10,10,80), false, false, false, false)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(2, h - 2, w - 4, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)

			local lineXPos = 20
			local textStartPos = h/2
			local lineHeight = h/14
			local lineMargin = 5
			local lineTextSpacingXPos = w/3

			draw.DrawText( "Welcome, Stupid!", "WelcomeMenu",  lineXPos, lineMargin, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )
			draw.DrawText( "To add: Level, XP required, other jazz here.", "WelcomeMenu3",  lineXPos, lineHeight + lineMargin*2, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)



            for i = 0, 10 do
            
                draw.RoundedBox( 0, 60 + ( ( w - 120 ) /10 * i ) , h/2 - 40, 2, 10, Color( 255, 255, 255, 60) )
            
            end     

            local reqXP = ply:GetNWInt( "Level_xp", 0 )
            local maxXP = ply:GetNWInt("Level_xp_max", 100)
            local playerLevel = ply:GetNWInt("Level", 1)

			draw.DrawText( "( " .. reqXP .. " / " .. maxXP .. " )", "WelcomeMenu3",  w/2, h/2 - 70, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.DrawText( playerLevel, "WelcomeMenu3", 32, h/2 - 47, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			draw.DrawText( (tonumber(playerLevel) + 1 ), "WelcomeMenu3", w - 32, h/2 - 47, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            local prec = ply:GetNWInt( "Level_xp", 0 ) / ply:GetNWInt("Level_xp_max", 100)
            prec = math.Clamp( prec, 0, 1 )
            
            self.Gradient = surface.GetTextureID("vgui/gradient-r")
            surface.SetDrawColor( 255, 225, 75, 140 );
            surface.SetTexture( self.Gradient );
            surface.DrawTexturedRect( 60, h/2 - 39, (w - 120 ) * prec, 8);
             
            self.Gradient = surface.GetTextureID("gui/gradient_up")
            surface.SetDrawColor( 255, 255, 255, 4 );
            surface.SetTexture( self.Gradient );
            surface.DrawTexturedRect( 60, h/2 - 40, w - 120, 10);
             
            self.Gradient = surface.GetTextureID("gui/gradient_down")
            surface.SetDrawColor( 0, 0, 0, 40 );
            surface.SetTexture( self.Gradient );
            surface.DrawTexturedRect( 60, h/2 - 40, w - 120, 10 );

			draw.DrawText( "Your Statistics", "WelcomeMenu",  lineXPos, textStartPos - lineMargin, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )
			draw.DrawText( "Total Kills:", "WelcomeMenu3",  lineXPos, textStartPos + lineHeight + lineMargin, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Assists:", "WelcomeMenu3",  lineXPos, textStartPos + (lineHeight)*2 + lineMargin, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Deaths:", "WelcomeMenu3",  lineXPos, textStartPos + (lineHeight*3 + lineMargin), Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Headshots:", "WelcomeMenu3",  lineXPos, textStartPos + (lineHeight*4 + lineMargin), Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			local kills = 23
			local deaths = 4
			local headshots = 6
			local assists = 5

			draw.DrawText( kills, "WelcomeMenu3",  lineTextSpacingXPos,  textStartPos + lineHeight + lineMargin, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( assists, "WelcomeMenu3",  lineTextSpacingXPos,  textStartPos + (lineHeight)*2 + lineMargin, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( deaths, "WelcomeMenu3",  lineTextSpacingXPos, textStartPos + (lineHeight*3 + lineMargin), Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( headshots, "WelcomeMenu3",  lineTextSpacingXPos, textStartPos + (lineHeight*4 + lineMargin), Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		end
		
	end

	WelcomePanel:SetDisabled( false )


	local TeamSelectionPanel = vgui.Create("DPanel", MenuFrame)
	TeamSelectionPanel:SetSize( panelWidth, panelHeight )
	TeamSelectionPanel:SetPos( buttonXPos + buttonWidth + margin, buttonYPos)
	TeamSelectionPanel:SetDrawBackground( false )
	function TeamSelectionPanel:Paint(w, h)

		if TeamSelectionPanel:GetDisabled() == false then
			draw.RoundedBoxEx( 0, 0, 0, w, h, Color(10,10,10,80), false, false, false, false)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(2, h - 2, w - 4, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)

			local lineXPos = 20
			local lineMargin = 5

			draw.DrawText( "Coming Soon.", "WelcomeMenu",  lineXPos, lineMargin, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )

		end
		
	end

	TeamSelectionPanel:SetDisabled( true )

	local GameplayOptionsPanel = vgui.Create("DPanel", MenuFrame)
	GameplayOptionsPanel:SetSize( panelWidth, panelHeight )
	GameplayOptionsPanel:SetPos( buttonXPos + buttonWidth + margin, buttonYPos)
	GameplayOptionsPanel:SetDrawBackground( false )
	function GameplayOptionsPanel:Paint(w, h)

		if GameplayOptionsPanel:GetDisabled() == false then
			draw.RoundedBoxEx( 0, 0, 0, w, h, Color(10,10,10,80), false, false, false, false)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(2, h - 2, w - 4, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)

			local lineXPos = 20
			local lineMargin = 5

			draw.DrawText( "Gameplay options are coming soon.", "WelcomeMenu",  lineXPos, lineMargin, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )

		end
		
	end

	GameplayOptionsPanel:SetDisabled( true )

	local LeaderboardsPanel = vgui.Create("DPanel", MenuFrame)
	LeaderboardsPanel:SetSize( panelWidth, panelHeight )
	LeaderboardsPanel:SetPos( buttonXPos + buttonWidth + margin, buttonYPos)
	LeaderboardsPanel:SetDrawBackground( false )
	function LeaderboardsPanel:Paint(w, h)

		if LeaderboardsPanel:GetDisabled() == false then
			draw.RoundedBoxEx( 0, 0, 0, w, h, Color(10,10,10,80), false, false, false, false)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(2, h - 2, w - 4, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)

			local lineXPos = 20
			local lineMargin = 5

			draw.DrawText( "Leaderboards are coming soon.", "WelcomeMenu",  lineXPos, lineMargin, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )

		end
		
	end

	LeaderboardsPanel:SetDisabled( true )

	local tabHover = false
	local TeamButton = vgui.Create('DButton')
	TeamButton:SetParent(MenuFrame)
	TeamButton:SetSize( buttonWidth, buttonHeight )
	TeamButton:SetPos( buttonXPos, buttonYPos )
	TeamButton:SetText("")
	TeamButton:SetFont("Button")
	TeamButton:SetDrawBackground(true)
	function TeamButton:OnCursorEntered()
		tabHover = true
	end
	function TeamButton:OnCursorExited()
		tabHover = false
	end
	function TeamButton:Paint(w, h)
		if tabHover then
			surface.SetDrawColor( 230, 200, 24, 255 )
			surface.DrawRect(0, 0, w, h)

			draw.DrawText( "Team Selection", "TDM_MenuOptions", 25, 15, Color( 10, 10, 10, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)
			--surface.DrawRect(0, h - 2, w, 2)

			draw.DrawText( "Team Selection", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end
	function TeamButton:DoClick()
		if TeamSelectionPanel:GetDisabled() == false then
			TeamSelectionPanel:SetDisabled( true )
			WelcomePanel:SetDisabled( false )
		else
			WelcomePanel:SetDisabled( true )
			GameplayOptionsPanel:SetDisabled( true )
			LeaderboardsPanel:SetDisabled( true )
			TeamSelectionPanel:SetDisabled( false )
		end
	end

	local tabHover = false
	local OptionsButton = vgui.Create('DButton')
	OptionsButton:SetParent(MenuFrame)
	OptionsButton:SetSize( buttonWidth, buttonHeight )
	OptionsButton:SetPos( buttonXPos, buttonYPos + buttonHeight )
	OptionsButton:SetText("")
	OptionsButton:SetFont("Button")
	OptionsButton:SetDrawBackground(true)
	function OptionsButton:OnCursorEntered()
		tabHover = true
	end
	function OptionsButton:OnCursorExited()
		tabHover = false
	end
	function OptionsButton:Paint(w, h)
		if tabHover then
			surface.SetDrawColor( 230, 200, 24, 255 )
			surface.DrawRect(0, 0, w, h)
			
			draw.DrawText( "Gameplay Options", "TDM_MenuOptions", 25, 15, Color( 10, 10, 10, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)
			--surface.DrawRect(0, h - 2, w, 2)

			draw.DrawText( "Gameplay Options", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end
	function OptionsButton:DoClick()
		if GameplayOptionsPanel:GetDisabled() == false then
			GameplayOptionsPanel:SetDisabled( true )
			WelcomePanel:SetDisabled( false )
		else
			WelcomePanel:SetDisabled( true )
			TeamSelectionPanel:SetDisabled( true )
			LeaderboardsPanel:SetDisabled( true )
			GameplayOptionsPanel:SetDisabled( false )
		end
	end


	local tabHover = false
	local StatsButton = vgui.Create('DButton')
	StatsButton:SetParent(MenuFrame)
	StatsButton:SetSize( buttonWidth, buttonHeight )
	StatsButton:SetPos( buttonXPos, buttonYPos + buttonHeight*2 )
	StatsButton:SetText("")
	StatsButton:SetFont("Button")
	StatsButton:SetDrawBackground(true)
	function StatsButton:OnCursorEntered()
		tabHover = true
	end
	function StatsButton:OnCursorExited()
		tabHover = false
	end
	function StatsButton:Paint(w, h)
		if tabHover then
			surface.SetDrawColor( 230, 200, 24, 255 )
			surface.DrawRect(0, 0, w, h)
			
			draw.DrawText( "Leaderboards", "TDM_MenuOptions", 25, 15, Color( 10, 10, 10, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 2)
			surface.DrawRect(w - 2, 2, 2, h - 2)
			--surface.DrawRect(0, h - 2, w, 2)

			draw.DrawText( "Leaderboards", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end
	function StatsButton:DoClick()
		if LeaderboardsPanel:GetDisabled() == false then
			LeaderboardsPanel:SetDisabled( true )
			WelcomePanel:SetDisabled( false )
		else
			WelcomePanel:SetDisabled( true )
			TeamSelectionPanel:SetDisabled( true )
			GameplayOptionsPanel:SetDisabled( true )
			LeaderboardsPanel:SetDisabled( false )
		end
	end

	local tabHover = false
	local CloseButton = vgui.Create('DButton')
	CloseButton:SetParent(MenuFrame)
	CloseButton:SetSize( buttonWidth, buttonHeight )
	CloseButton:SetPos( buttonXPos, buttonYPos + buttonHeight*3 )
	CloseButton:SetText("")
	CloseButton:SetFont("Button")
	CloseButton:SetDrawBackground( true )
	function CloseButton:OnCursorEntered()
		tabHover = true
	end
	function CloseButton:OnCursorExited()
		tabHover = false
	end
	function CloseButton:Paint(w, h)
		if tabHover then
			surface.SetDrawColor( 230, 200, 24, 255 )
			surface.DrawRect(0, 0, w, h)
			
			draw.DrawText( "Close", "TDM_MenuOptions", 25, 15, Color( 10, 10, 10, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 4)
			surface.DrawRect(w - 2, 2, 2, h - 4)
			surface.DrawRect(0, h - 2, w, 2)

			draw.DrawText( "Close", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end
	function CloseButton:DoClick()
		MenuFrame:Close()
		timer.Stop( "NumberCheckTimer" )
	end

/*

	local tabHover = false
	local WelcomeHover = vgui.Create('DButton')
	WelcomeHover:SetParent(MenuFrame)
	WelcomeHover:SetSize( 600, 90 )
	WelcomeHover:SetPos( 540, 155 )
	WelcomeHover:SetText("")
	WelcomeHover:SetFont("Button")
	WelcomeHover:SetDrawBackground(true)
	function WelcomeHover:OnCursorEntered()
		tabHover = true
	end
	function WelcomeHover:OnCursorExited()
		tabHover = false
	end
	function WelcomeHover:Paint(w, h)
		if tabHover then
			
			--draw.DrawText( "Close", "TDM_MenuOptions", 25, 15, Color( 10, 10, 10, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)


			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 4)
			surface.DrawRect(w - 2, 2, 2, h - 4)
			surface.DrawRect(0, h - 2, w, 2)

			surface.DrawRect(2, h/2 - 1, w - 4, 2)

			draw.DrawText( "Welcome, " .. PlayerName .. ".", "WelcomeMenu",  20, 6, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )
			draw.DrawText( "Welcome and such.", "WelcomeMenu2",  20, 56, Color(190, 190, 190, 235), TEXT_ALIGN_LEFT )

			--surface.DrawLine(1, 33, 41, 1)
			--surface.DrawLine(0, h/2, w, h/2)
			--surface.DrawLine(0, h, w, h)

			--draw.DrawText( "Close", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end

	local tabHover = false
	local WelcomeHover = vgui.Create('DButton')
	WelcomeHover:SetParent(MenuFrame)
	WelcomeHover:SetSize( 600, 225 )
	WelcomeHover:SetPos( 540, 285 )
	WelcomeHover:SetText("")
	WelcomeHover:SetFont("Button")
	WelcomeHover:SetDrawBackground(true)
	function WelcomeHover:OnCursorEntered()
		tabHover = true
	end
	function WelcomeHover:OnCursorExited()
		tabHover = false
	end

	function WelcomeHover:Paint(w, h)
		if tabHover then
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)


			surface.SetDrawColor(225, 225, 225, 20)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 4)
			surface.DrawRect(w - 2, 2, 2, h - 4)
			surface.DrawRect(0, h - 2, w, 2)

			surface.DrawRect(2, h - (h/5)*3 - 1, w - 4, 2)
			surface.DrawRect(2, h - (h/5)*2 - 1, w - 4, 2)
			surface.DrawRect(2, h/5 - 1, w - 4, 2)
			surface.DrawRect(2, h - h/5 - 1, w - 4, 2)


			
			draw.DrawText( "Your Statistics", "WelcomeMenu",  20, 6, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )
			draw.DrawText( "Total Kills:", "WelcomeMenu3",  20, 55, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Assists:", "WelcomeMenu3",  20, 100, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Deaths:", "WelcomeMenu3",  20, 145, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Headshots:", "WelcomeMenu3",  20, 190, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			local kills = 23
			local deaths = 4
			local headshots = 6
			local assists = 5


			draw.DrawText( kills, "WelcomeMenu3",  500, 55, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( assists, "WelcomeMenu3",  500, 100, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( deaths, "WelcomeMenu3",  500, 145, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( headshots, "WelcomeMenu3",  500, 190, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			surface.SetDrawColor( 10, 10, 10, 80 )
			surface.DrawRect(0, 0, w, h)


			surface.SetDrawColor(225, 225, 225, 10)
			surface.DrawRect(0, 0, w, 2)
			surface.DrawRect(0, 2, 2, h - 4)
			surface.DrawRect(w - 2, 2, 2, h - 4)
			surface.DrawRect(0, h - 2, w, 2)

			surface.DrawRect(2, h - (h/5)*3 - 1, w - 4, 2)
			surface.DrawRect(2, h - (h/5)*2 - 1, w - 4, 2)
			surface.DrawRect(2, h/5 - 1, w - 4, 2)
			surface.DrawRect(2, h - h/5 - 1, w - 4, 2)
			
			draw.DrawText( "Your Statistics", "WelcomeMenu",  20, 6, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT )
			draw.DrawText( "Total Kills:", "WelcomeMenu3",  20, 55, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Assists:", "WelcomeMenu3",  20, 100, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Deaths:", "WelcomeMenu3",  20, 145, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.DrawText( "Total Headshots:", "WelcomeMenu3",  20, 190, Color(170, 170, 170, 235), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			draw.DrawText( kills, "WelcomeMenu3",  500, 55, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( assists, "WelcomeMenu3",  500, 100, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( deaths, "WelcomeMenu3",  500, 145, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawText( headshots, "WelcomeMenu3",  500, 190, Color(170, 170, 170, 235), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			--draw.DrawText( "Close", "TDM_MenuOptions", 25, 15, Color( 230, 230, 230, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		end
	end

	local ModelPlayer = vgui.Create('DModelPanel', MenuFrame)
	ModelPlayer:SetPos( ScrW() - 512/2 - 300, 100 )
	ModelPlayer:SetSize( ScrH()/1.5, ScrH()/1.5 )
	ModelPlayer:SetModel( "models/player/phoenix.mdl" )
	function ModelPlayer:LayoutEntity( Entity ) return end
*/

end
concommand.Add("welcomePlayer2", welcomePlayer2)