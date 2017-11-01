--Based on the base scorebaord, with modifications.
surface.CreateFont( "ScoreboardDefault", { font	= "Helvetica", size	= 18, weight = 800, antialias = true, blursize = 0.1 })
surface.CreateFont( "ScoreboardDefaultRank", { font = "Helvetica", size = 14, weight = 800, antialias = true, blursize = 0.1 })
surface.CreateFont( "ScoreboardHeading", { font = "Helvetica", size = 18, weight = 800, antialias = true, blursize = 0.1, shadow = false })
surface.CreateFont( "ScoreboardHeadingShadow", { font = "Helvetica", size = 18, weight = 800, antialias = true,blursize = 1.5,shadow = false })
surface.CreateFont( "ScoreboardDefaultTitleShadow", { font = "Coolvetica", size = 32, weight = 400, antialias = true, blursize = 1.5 })
surface.CreateFont( "ScoreboardDefaultTitle", { font = "Coolvetica", size = 32, weight = 400, antialias = true, blursize = 0.2 })

surface.CreateFont( "ElementTxt", { font = "Trebuchet MS", size = 24, weight = 900, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "ElementTxtShadow", { font = "Trebuchet MS", size = 24, weight = 900, antialias = true, blursize = 2, shadow = false })

surface.CreateFont( "ElementTxt20", { font = "Trebuchet MS", size = 22, weight = 900, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "ElementTxtShadow20", { font = "Trebuchet MS", size = 22, weight = 900, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "ElementTxt23", { font = "Trebuchet MS", size = 23, weight = 900, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "ElementTxtShadow23", { font = "Trebuchet MS", size = 23, weight = 900, antialias = true, blursize = 2, shadow = false })

local PLAYER_LINE = {
	Init = function( self )

		self.Level = self:Add( "DLabel" )
		self.Level:Dock( LEFT )
		self.Level:SetWidth( 20 )
		self.Level:SetFont( "ScoreboardDefault" )
		self.Level:SetDark( false )
		self.Level:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Level:DockMargin( 8, 0, 12, 0 )
		self.Level:SetContentAlignment( 5 )

		self.AvatarButton = self:Add( "DButton" )
		self.AvatarButton:Dock( LEFT )
		self.AvatarButton:SetSize( 22, 22 )
		self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

		self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton )
		self.Avatar:SetSize( 22, 22 )
		self.Avatar:SetMouseInputEnabled( false )

		self.Name = self:Add( "DLabel" )
		self.Name:Dock( LEFT )
		self.Name:SetWidth( 120 )
		self.Name:SetFont( "ScoreboardDefault" )
		self.Name:SetDark( false )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Name:DockMargin( 8, 0, 0, 0 )

		self.Rank = self:Add( "DLabel" )
		self.Rank:Dock( LEFT )
		self.Rank:SetWidth( 120 )
		self.Rank:SetFont( "ScoreboardDefaultRank" )
		self.Rank:SetDark( false )
		self.Rank:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Rank:DockMargin( 8, 0, 0, 0 )

		self.Mute = self:Add( "DImageButton" )
		self.Mute:SetSize( 22, 22 )
		self.Mute:Dock( RIGHT )

		self.Ping = self:Add( "DLabel" )
		self.Ping:Dock( RIGHT )
		self.Ping:SetWidth( 80 )
		self.Ping:SetFont( "ScoreboardDefault" )
		self.Ping:SetDark( false )
		self.Ping:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Ping:SetContentAlignment( 5 )

		self.Deaths = self:Add( "DLabel" )
		self.Deaths:Dock( RIGHT )
		self.Deaths:SetWidth( 80 )
		self.Deaths:SetFont( "ScoreboardDefault" )
		self.Deaths:SetDark( false )
		self.Deaths:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Deaths:SetContentAlignment( 5 )

		self.ScoreAssists = self:Add( "DLabel" )
		self.ScoreAssists:Dock( RIGHT )
		self.ScoreAssists:SetWidth( 80 )
		self.ScoreAssists:SetFont( "ScoreboardDefault" )
		self.ScoreAssists:SetDark( false )
		self.ScoreAssists:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.ScoreAssists:SetContentAlignment( 5 )

		self.Kills = self:Add( "DLabel" )
		self.Kills:Dock( RIGHT )
		self.Kills:SetWidth( 80 )
		self.Kills:SetFont( "ScoreboardDefault" )
		self.Kills:SetDark( false )
		self.Kills:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Kills:SetContentAlignment( 5 )

		self:Dock( TOP )
		self:DockPadding( 3, 3, 3, 3 )
		self:SetHeight( 22 + 3*2 )
		self:DockMargin( 2, 0, 2, 2 )

	end,

	Setup = function( self, pl )

		self.Player = pl

		self.Avatar:SetPlayer( pl )

		self:Think( self )

	end,

	Think = function( self )

		if ( !IsValid( self.Player ) ) then
			self:Remove()
			return
		end

		if ( self.NumLevel == nil || self.NumLevel != self.Player:GetNWInt( "Level", 1 ) ) then
			self.NumLevel = self.Player:GetNWInt( "Level", 1 )
			self.Level:SetText( self.NumLevel )
		end

		if ( self.PName == nil || self.PName != self.Player:Nick() ) then
			self.PName = self.Player:Nick()
			self.Name:SetText( self.PName )
		end

		if PlayerRanksEnabled == true then 

			self.findRank = nil
			self.findRankLevel = nil

			for k, v in pairs( PlayerRanks ) do
				if ( !self.findRank || ( tonumber(v.level) >= tonumber(self.findRankLevel)) && (tonumber(v.level) <= tonumber(self.NumLevel)) ) then
					self.findRankLevel = v.level
					self.findRank = v.rank
				end
			end

		else 

			self.findRank = ""

		end

		if ( self.PRank == nil || self.PRank != self.findRank ) then
			self.PRank = self.findRank
			self.Rank:SetText( self.PRank )
		end
		
		if ( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then
			self.NumKills = self.Player:Frags()
			self.Kills:SetText( self.NumKills )
		end

		if ( self.NumAssists == nil || self.NumAssists != self.Player:GetNWInt( "Assists", 0 ) ) then
			self.NumAssists = self.Player:GetNWInt( "Assists", 0 )
			self.ScoreAssists:SetText( self.NumAssists )
		end

		if ( self.NumDeaths == nil || self.NumDeaths != self.Player:Deaths() ) then
			self.NumDeaths = self.Player:Deaths()
			self.Deaths:SetText( self.NumDeaths )
		end

		if ( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then
			self.NumPing = self.Player:Ping()
			self.Ping:SetText( self.NumPing )
		end

		--
		-- Change the icon of the mute button based on state
		--
		if ( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then

			self.Muted = self.Player:IsMuted()
			if ( self.Muted ) then
				self.Mute:SetImage( "vgui/tdm/muted.png" )
			else
				self.Mute:SetImage( "vgui/tdm/unmuted.png" )
			end

			self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end

		end

		-- Spectating players go at the very bottom
		if ( self.Player:Team() == TEAM_SPEC ) then
			self:SetZPos( 5000 )
		end

		--
		-- This is what sorts the list. The panels are docked in the z order,
		-- so if we set the z order according to kills they'll be ordered that way!
		-- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
		--
		-- Put team with most frags on top.
		local redTeamFrags = team.TotalFrags( TEAM_RED )
		local blueTeamFrags = team.TotalFrags( TEAM_BLUE )

		if redTeamFrags >= blueTeamFrags then
			if ( self.Player:Team() == TEAM_RED) then
				self:SetZPos( (self.NumKills * -10) )
			elseif ( self.Player:Team() == TEAM_BLUE) then
				self:SetZPos( (self.NumKills * -10) + 2000 )
			end
		else
			if ( self.Player:Team() == TEAM_BLUE) then
				self:SetZPos( (self.NumKills * -10) )
			elseif ( self.Player:Team() == TEAM_RED) then
				self:SetZPos( (self.NumKills * -10) + 2000 )
			end
		end

	end,

	Paint = function( self, w, h )

		if ( !IsValid( self.Player ) ) then
			return
		end

		--
		-- We draw our background a different colour based on the status of the player
		--

		if ( self.Player:Team() == TEAM_SPEC) then
			draw.RoundedBox( 2, 0, 0, w, h, Color( 150, 150, 150, 150 ) )
			return
		end

		if ( self.Player:Team() == TEAM_RED ) then
			--draw.RoundedBox( 2, 0, 0, w, h, Color( 235, 60, 60, 220 ) )
			if self.Player:Alive() then
				draw.RoundedBox( 2, 0, 0, w, h, Color( 40, 40, 40, 100 ) )
				draw.RoundedBox( 2, 0, 0, w, h, Color( 235, 60, 60, 150 ) )
			else
				draw.RoundedBox( 2, 0, 0, w, h, Color( 40, 40, 40, 100 ) )
				draw.RoundedBox( 2, 0, 0, w, h, Color( 235, 60, 60, 60 ) )
			end

			return
		end

		if ( self.Player:Team() == TEAM_BLUE ) then
			--draw.RoundedBox( 2, 0, 0, w, h, Color( 60, 60, 235, 220 ) )
			if self.Player:Alive() then
				draw.RoundedBox( 2, 0, 0, w, h, Color( 40, 40, 40, 100 ) )
				draw.RoundedBox( 2, 0, 0, w, h, Color( 60, 60, 235, 150 ) )
			else
				draw.RoundedBox( 2, 0, 0, w, h, Color( 40, 40, 40, 100 ) )
				draw.RoundedBox( 2, 0, 0, w, h, Color( 60, 60, 235, 60 ) )
			end
			return
		end

	end
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
PLAYER_LINE = vgui.RegisterTable( PLAYER_LINE, "DPanel" )

--
-- Here we define a new panel table for the scoreboard. It basically consists
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = {
	Init = function( self )

		self.Header = self:Add( "Panel" )
		self.Header:Dock( TOP )
		self.Header:SetHeight( 80 )

		self.Name = self.Header:Add( "DLabel" )
		self.Name:SetFont( "ScoreboardDefaultTitle" )
		self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Name:Dock( TOP )
		self.Name:SetHeight( 40 )
		self.Name:SetContentAlignment( 5 )
		self.Name:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
		function self.Name:Paint( w, h, ply )
			--draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

			draw.SimpleText( GetHostName(), "ScoreboardDefaultTitleShadow", 351, 21, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			draw.SimpleText( GetHostName(), "ScoreboardDefaultTitle", 350, 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		end

		self.Other = self.Header:Add( "DLabel" )
		self.Other:SetFont( "ScoreboardDefaultTitle" )
		self.Other:SetTextColor( Color( 255, 255, 255, 255 ) )
		self.Other:Dock( BOTTOM )
		self.Other:SetContentAlignment( 5 )
		self.Other:SetHeight( 40 )
		function self.Other:Paint( w, h, ply )
			--draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 250, 0, 200 ) )

			local scoreName = "Player"
			local scoreKills = "Kills"
			local scoreAssists = "Assists"
			local scoreDeaths = "Deaths"
			local scorePing = "Ping"

			--DropShadows
			draw.DrawText( scoreName, "ScoreboardHeadingShadow", 44 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_LEFT ) 
			draw.DrawText( scoreKills, "ScoreboardHeadingShadow", 393 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scoreAssists, "ScoreboardHeadingShadow", 473 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scoreDeaths, "ScoreboardHeadingShadow", 552 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scorePing, "ScoreboardHeadingShadow", 632 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER ) 

			draw.DrawText( scoreName, "ScoreboardHeading", 44, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 
			draw.DrawText( scoreKills, "ScoreboardHeading", 393, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scoreAssists, "ScoreboardHeading", 473, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scoreDeaths, "ScoreboardHeading", 552, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
			draw.DrawText( scorePing, "ScoreboardHeading", 632, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		end

		self.Scores = self:Add( "DScrollPanel" )
		self.Scores:Dock( FILL )

	end,

	PerformLayout = function( self )

		self:SetSize( 700, ScrH() - 200 )
		self:SetPos( ScrW() / 2 - 350, 100 )

	end,

	Paint = function( self, w, h )

		--draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )

	end,

	Think = function( self, w, h )

		

		self.Name:SetText( "" )

		self.Other:SetText( "" )
		--
		-- Loop through each player, and if one doesn't have a score entry - create it.
		--
		local plyrs = player.GetAll()
		for id, pl in pairs( plyrs ) do

			if ( IsValid( pl.ScoreEntry ) ) then continue end

			pl.ScoreEntry = vgui.CreateFromTable( PLAYER_LINE, pl.ScoreEntry )
			pl.ScoreEntry:Setup( pl )

			self.Scores:AddItem( pl.ScoreEntry )

		end

	end
}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()

	--[[	

	if ( !IsValid( g_Scoreboard ) ) then
		g_Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
	end

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Show()
		g_Scoreboard:MakePopup()
		g_Scoreboard:SetKeyboardInputEnabled( false )
	end

	]]--	

	drawscoreboard = true

end

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()

	--[[	

	if ( IsValid( g_Scoreboard ) ) then
		g_Scoreboard:Hide()
	end

	
	]]--

	if drawscoreboard then

		drawscoreboard = false

	end

end

-- Blur Function for BG Blurs
local blur = Material("pp/blurscreen")
local function DrawBlur( amount, x, y, w, h )
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()

        render.UpdateScreenEffectTexture()
        render.SetScissorRect( x, y, x + w, y + h, true )
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
        render.SetScissorRect( 0, 0, 0, 0, false )
    end
end

local function sbThink()
	local client = LocalPlayer()
	local redTeamPlayers = team.GetPlayers( TEAM_RED )
	local redTeamCount = team.NumPlayers( TEAM_RED )
	local blueTeamPlayers = team.GetPlayers( TEAM_BLUE )
	local blueTeamCount = team.NumPlayers( TEAM_BLUE )
	local specPlayers = team.GetPlayers( TEAM_SPEC )
	local players = player.GetAll()

	redTable = {}
	tempTable = {}
	for k, v in pairs( redTeamPlayers ) do

		tempTable = {

			{ Player = v:UserID(), Name = v:Nick(), Rank = v:GetNWInt( "Level", 1 ), Kills = v:Frags(), Assists = v:GetNWInt( "Assists", 0 ), Deaths = v:Deaths(), Ping = v:Ping(), Alive = v:Alive() }

		}

		table.Add( redTable, tempTable )

	end

	table.SortByMember( redTable, "Kills" )

	blueTable = {}
	temp2Table = {}
	for k, v in pairs( blueTeamPlayers ) do

		temp2Table = {

			{ Player = v:UserID(), Name = v:Nick(), Rank = v:GetNWInt( "Level", 1 ), Kills = v:Frags(), Assists = v:GetNWInt( "Assists", 0 ), Deaths = v:Deaths(), Ping = v:Ping(), Alive = v:Alive() }

		}

		table.Add( blueTable, temp2Table )

	end

	table.SortByMember( blueTable, "Kills" )

end

-- Different Gradients
local gradient = surface.GetTextureID("gui/gradient_up") 
local gradient2 = surface.GetTextureID("gui/gradient_down")
local gradient3 = surface.GetTextureID("gui/gradient")
local gradient4 = surface.GetTextureID("vgui/gradient-r")

function NewScoreboard()
	local client = LocalPlayer()

	--Entire Scoreboard W/H
	local w = 800
	local h = ScrH() - 200

	--Entire Scoreboard Master Position
	local x = ScrW() / 2 - w/2
	local y = 125

	local padding = 5

	--Heading Size
	hh = 20

	--Element Size
	ew = 800
	eh = 35
	ep = 5

	--local winningTeam
	local redTeamFrags = team.TotalFrags( TEAM_RED )
	local blueTeamFrags = team.TotalFrags( TEAM_BLUE )

	if ( redTeamFrags >= blueTeamFrags ) then 

		winningTeam = TEAM_RED

	else

		winningTeam = TEAM_RED

	end

	local redTeamPlayers = team.GetPlayers( TEAM_RED )
	local redTeamCount = team.NumPlayers( TEAM_RED )
	local blueTeamPlayers = team.GetPlayers( TEAM_BLUE )
	local blueTeamCount = team.NumPlayers( TEAM_BLUE )
	local specPlayers = team.GetPlayers( TEAM_SPEC )
	local players = player.GetAll()

	local redC = team.GetColor( TEAM_RED )
	local blueC = team.GetColor( TEAM_BLUE )
	local specC = team.GetColor( TEAM_SPEC )

	if ( winningTeam == TEAM_RED ) then

		-- **Team Logo
		-- TEAM NAME
		-- Kills
		-- Assists
		-- Deaths
		-- Ping

		--DrawBlur( 4, x, y + eh - eh, ew, eh )

		surface.SetDrawColor( 40, 40, 40, 100 )
    	surface.DrawRect( x, y, ew, eh )

		surface.SetDrawColor( 40, 40, 40, 120 )
    	surface.DrawRect( x, y + 5, ew, eh - 5 )

        draw.DrawText( TDM_TeamRedName, "ElementTxtShadow", x + ep*3 + 1, y + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
        draw.DrawText( TDM_TeamRedName, "ElementTxt", x + ep*3, y + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

        draw.DrawText( "Kills", "ElementTxtShadow", x + (w/9)*5 + ep*3 + 1, y + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Kills", "ElementTxt", x + (w/9)*5 + ep*3, y + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Assists", "ElementTxtShadow", x + (w/9)*6 + ep*3 + 1, y + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Assists", "ElementTxt", x + (w/9)*6 + ep*3, y + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Deaths", "ElementTxtShadow", x + (w/9)*7 + ep*3 + 1, y + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Deaths", "ElementTxt", x + (w/9)*7 + ep*3, y + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Ping", "ElementTxtShadow", x + (w/9)*8 + ep*3 + 1, y + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Ping", "ElementTxt", x + (w/9)*8 + ep*3, y + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		for k, v in pairs( redTable ) do

			--DrawBlur( 4, x + 25, y + eh*k + padding*k, ew, eh )

			surface.SetDrawColor( redC.r*0.7, redC.g*0.7, redC.b*0.7, 255 )
    		surface.DrawRect( x, y + eh*k + padding*k, 4, eh )

    		if ( v.Alive ) then

				surface.SetDrawColor( redC.r, redC.g, redC.b, 180 )
	    		surface.DrawRect( x + 4, y + eh*k + padding*k, ew - 4, eh )

    		else

				surface.SetDrawColor( redC.r*0.5, redC.g*0.5, redC.b*0.5, 180 )
				surface.DrawRect( x + 4, y + eh*k + padding*k, ew - 4, eh )

    		end

    		if (v.Player == client:UserID() ) then

				surface.SetDrawColor( redC.r*0.5, redC.g*0.5, redC.b*0.5, 220 );
				surface.SetTexture( gradient3 );
				surface.DrawTexturedRect( x, y + eh*k + padding*k + 2, ew, eh - 4 );

    		end

	        draw.DrawText( v.Rank, "ElementTxtShadow20", x + ep*7 + 1, y + eh*k + padding*k + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
	        draw.DrawText( v.Rank, "ElementTxt20", x + ep*7, y + eh*k + padding*k + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 
			
			surface.SetMaterial( Material( PlayerRanks[tonumber(v.Rank)]["rankMaterialSm"] ) );
		    surface.SetDrawColor( 255, 255, 255, 255 );
		    surface.DrawTexturedRect( x + ep*7 - 1 + ep*3, y + eh*k + padding*k + 1, 32, 32 );  

	        draw.DrawText( v.Name, "ElementTxtShadow", x + ep*16 + ep*3 + 1, y + eh*k + padding*k + ep + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
	        draw.DrawText( v.Name, "ElementTxt", x + ep*16 + ep*3, y + eh*k + padding*k + ep, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

		    draw.DrawText( v.Kills, "ElementTxtShadow23", x + (w/9)*5 + ep*3 + 1, y + eh*k + padding*k + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Kills, "ElementTxt23", x + (w/9)*5 + ep*3, y + eh*k + padding*k + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Assists, "ElementTxtShadow23", x + (w/9)*6 + ep*3 + 1, y + eh*k + padding*k + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Assists, "ElementTxt23", x + (w/9)*6 + ep*3, y + eh*k + padding*k + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Deaths, "ElementTxtShadow23", x + (w/9)*7 + ep*3 + 1, y + eh*k + padding*k + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Deaths, "ElementTxt23", x + (w/9)*7 + ep*3, y + eh*k + padding*k + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Ping, "ElementTxtShadow23", x + (w/9)*8 + ep*3 + 1, y + eh*k + padding*k + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Ping, "ElementTxt23", x + (w/9)*8 + ep*3, y + eh*k + padding*k + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		end

		local offset = redTeamCount*eh + redTeamCount*padding + eh + padding

		--DrawBlur( 4, x, y + offset, ew, eh )

		surface.SetDrawColor( 40, 40, 40, 100 )
    	surface.DrawRect( x, y + offset, ew, eh )

		surface.SetDrawColor( 40, 40, 40, 120 )
    	surface.DrawRect( x, y + offset + 5, ew, eh - 5 )

        draw.DrawText( TDM_TeamBlueName, "ElementTxtShadow", x + ep*3 + 1, y + offset + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
        draw.DrawText( TDM_TeamBlueName, "ElementTxt", x + ep*3, y + offset + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

        draw.DrawText( "Kills", "ElementTxtShadow", x + (w/9)*5 + ep*3 + 1, y + offset + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Kills", "ElementTxt", x + (w/9)*5 + ep*3, y + offset + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Assists", "ElementTxtShadow", x + (w/9)*6 + ep*3 + 1, y + offset + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Assists", "ElementTxt", x + (w/9)*6 + ep*3, y + offset + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Deaths", "ElementTxtShadow", x + (w/9)*7 + ep*3 + 1, y + offset + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Deaths", "ElementTxt", x + (w/9)*7 + ep*3, y + offset + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( "Ping", "ElementTxtShadow", x + (w/9)*8 + ep*3 + 1, y + offset + ep + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Ping", "ElementTxt", x + (w/9)*8 + ep*3, y + offset + ep + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		for k, v in pairs( blueTable ) do

			--DrawBlur( 4, x, y + eh*k + padding*k + offset, ew, eh )

			surface.SetDrawColor( blueC.r*0.7, blueC.g*0.7, blueC.b*0.7, 255 )
    		surface.DrawRect( x, y + eh*k + padding*k + offset, 4, eh )

    		if ( v.Alive ) then

				surface.SetDrawColor( blueC.r, blueC.g, blueC.b, 180 )
	    		surface.DrawRect( x + 4, y + eh*k + padding*k + offset, ew - 4, eh )

    		else

				surface.SetDrawColor( blueC.r*0.5, blueC.g*0.5, blueC.b*0.5, 180 )
				surface.DrawRect( x + 4, y + eh*k + padding*k + offset, ew - 4, eh )

    		end

    		if (v.Player == client:UserID() ) then

				surface.SetDrawColor( blueC.r*0.5, blueC.g*0.5, blueC.b*0.5, 220 );
				surface.SetTexture( gradient3 );
				surface.DrawTexturedRect( x, y + eh*k + padding*k + offset + 2, ew, eh - 4 );

    		end

	        draw.DrawText( v.Rank, "ElementTxtShadow20", x + ep*7 + 1, y + eh*k + padding*k + offset + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
	        draw.DrawText( v.Rank, "ElementTxt20", x + ep*7, y + eh*k + padding*k + offset + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 
			
			surface.SetMaterial( Material( PlayerRanks[tonumber(v.Rank)]["rankMaterialSm"] ) );
		    surface.SetDrawColor( 255, 255, 255, 255 );
		    surface.DrawTexturedRect( x + ep*7 - 1 + ep*3, y + eh*k + padding*k + offset + 2, 32, 32 );  

	        draw.DrawText( v.Name, "ElementTxtShadow", x + ep*16 + ep*3 + 1, y + eh*k + padding*k + offset + ep + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
	        draw.DrawText( v.Name, "ElementTxt", x + ep*16 + ep*3, y + eh*k + padding*k + offset + ep, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

		    draw.DrawText( v.Kills, "ElementTxtShadow23", x + (w/9)*5 + ep*3 + 1, y + eh*k + padding*k + offset + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Kills, "ElementTxt23", x + (w/9)*5 + ep*3, y + eh*k + padding*k + offset + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Assists, "ElementTxtShadow23", x + (w/9)*6 + ep*3 + 1, y + eh*k + padding*k + offset + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Assists, "ElementTxt23", x + (w/9)*6 + ep*3, y + eh*k + padding*k + offset + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Deaths, "ElementTxtShadow23", x + (w/9)*7 + ep*3 + 1, y + eh*k + padding*k + offset + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Deaths, "ElementTxt23", x + (w/9)*7 + ep*3, y + eh*k + padding*k + offset + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		    draw.DrawText( v.Ping, "ElementTxtShadow23", x + (w/9)*8 + ep*3 + 1, y + eh*k + padding*k + offset + ep + 2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
		    draw.DrawText( v.Ping, "ElementTxt23", x + (w/9)*8 + ep*3, y + eh*k + padding*k + offset + ep + 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

		end

	end

end

--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
	Heres the stupid way
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()

	if not drawscoreboard then return end

	sbThink()

	NewScoreboard()

end