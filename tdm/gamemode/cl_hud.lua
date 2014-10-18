--[[

Heads up display. 

]]--

    surface.CreateFont( "DebugFont",
    {
                    font    = "DefaultBold",
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    shadow = true
    })

    surface.CreateFont( "Team",
    {
                    font    = "CloseCaption_Bold", 
                    size    = 20,
                    weight  = 700,
                    antialias = true,
                    blursize = 0.2,
                    shadow = true
    })

    surface.CreateFont( "AlphaFont",
    {
                    font    = "Triomphe",
                    size    = 44,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "AlphaFontShadow",
    {
                    font    = "Triomphe", 
                    size    = 44,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

    surface.CreateFont( "AlphaFontSmall",
    {
                    font    = "Triomphe", 
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "AlphaFontShadowSmall",
    {
                    font    = "Triomphe", 
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

    surface.CreateFont( "TimeLeftShadow",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 26,
                    weight  = 400,
                    antialias = true,
                    blursize = 1.5,
                    shadow = false
    })

    surface.CreateFont( "TimeLeft",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 26,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "MapShadow",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 22,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

    surface.CreateFont( "Map",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 22,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = true
    })

    surface.CreateFont( "Score",
    {
                    font    = "CloseCaption_Normal",
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "ScoreShadow",
    {
                    font    = "CloseCaption_Normal",
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 1.5,
                    shadow = false
    })

    surface.CreateFont( "AmmoSmall",
    {
                    font    = "CloseCaption_Normal",
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "AmmoSmallShadow",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 24,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

    surface.CreateFont( "AmmoLarge",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 48,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "AmmoLargeShadow",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 48,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

    surface.CreateFont( "Weapon",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 30,
                    weight  = 400,
                    antialias = true,
                    blursize = 0.2,
                    shadow = false
    })

    surface.CreateFont( "WeaponShadow",
    {
                    font    = "CloseCaption_Normal", 
                    size    = 30,
                    weight  = 400,
                    antialias = true,
                    blursize = 2,
                    shadow = false
    })

function GM:HUDPaint()

	hook.Run( "HUDDrawTargetID" )
	hook.Run( "HUDDrawPickupHistory" )
	hook.Run( "DrawDeathNotice", 0.85, 0.04 )

	local ply = LocalPlayer()
	local x, y = ScrW(), ScrH()
	local MapName = game.GetMap()
	local round = self:GetRound()

	if round == 0 then round = "Waiting"
	elseif round == 1 then round = "Preparing"
	elseif round == 2 then round = "In Progress"
	elseif round == 3 then round = "Round Over"
	end

	local time = string.ToMinutesSeconds(self:GetRoundTime())
	local rk = self:GetRedKills()
	local bk = self:GetBlueKills()
	local sl = self:GetScoreLimit()
	local left = self:GetRoundsLeft()

	local team1_deaths = bk * 10

	local team2_deaths = rk * 10

	local team1 = bk / sl
	team1 = math.Clamp( team1, 0, 1 )

	local team2 = rk / sl
	team2 = math.Clamp( team2, 0, 1 )

	draw.RoundedBox( 0 , ScrW()-292, ScrH() - 90, 30, 30, Color(20,20,175,250) )
	draw.RoundedBox( 0 , ScrW()-292, ScrH()-125, 30, 30, Color(175,20,20,250) )

	draw.DrawText( "B", "TimeLeft", ScrW()-279, ScrH() - 89 , Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
	draw.DrawText( "R", "TimeLeft", ScrW()-279, ScrH() - 124 , Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

	draw.RoundedBox( 0 , ScrW()-260, ScrH() - 90, 200*team1, 30, Color(20,20,175,250) )
	draw.RoundedBox( 0 , ScrW()-260, ScrH()-125, 200*team2, 30, Color(175,20,20,250) )

	self.Gradient = surface.GetTextureID("gui/gradient_down")
	surface.SetDrawColor( 0, 0, 0, 90 );
	surface.SetTexture( self.Gradient );
	surface.DrawTexturedRect( ScrW()-292, ScrH() - 90, 232, 30 );

	self.Gradient = surface.GetTextureID("gui/gradient_down")
	surface.SetDrawColor( 0, 0, 0, 90 );
	surface.SetTexture( self.Gradient );
	surface.DrawTexturedRect( ScrW()-292, ScrH() - 125, 232, 30 );

	self.Gradient = surface.GetTextureID("gui/gradient_up")
	surface.SetDrawColor(  255, 255, 255, 1  );
	surface.SetTexture( self.Gradient );
	surface.DrawTexturedRect( ScrW()-292, ScrH() - 75, 232, 15 );

	self.Gradient = surface.GetTextureID("gui/gradient_up")
	surface.SetDrawColor(  255, 255, 255, 1  );
	surface.SetTexture( self.Gradient );
	surface.DrawTexturedRect( ScrW()-292, ScrH() - 110, 200, 15 );	

	draw.DrawText( team1_deaths, "ScoreShadow", ScrW()-65 + 1, ScrH() - 87 + 1 , Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( team2_deaths, "ScoreShadow", ScrW()-65 + 1, ScrH() - 122 + 1 , Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( team1_deaths, "Score", ScrW()-65, ScrH() - 87 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( team2_deaths, "Score", ScrW()-65, ScrH() - 122 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

	draw.DrawText( time, "TimeLeftShadow", ScrW()-290 + 1, ScrH() - 155 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
	draw.DrawText( time, "TimeLeft", ScrW()-290, ScrH() - 155 , Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

	draw.DrawText( round, "TimeLeftShadow", ScrW()-60 + 1, ScrH() - 155 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( round, "TimeLeft", ScrW()-60, ScrH() - 155 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

	draw.DrawText( "Alpha 0.00.1", "AlphaFontShadow", x - x/8 + 1, y/6 - 40 + 1, Color(10, 10, 10, 210), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( "Alpha 0.00.1", "AlphaFont", x - x/8, y/6 - 40, Color(255, 255, 255, 235), TEXT_ALIGN_RIGHT ) 

	draw.DrawText( "Team Deathmatch", "AlphaFontShadowSmall", x - x/8 + 1, y/6 + 1, Color(10, 10, 10, 210), TEXT_ALIGN_RIGHT ) 
	draw.DrawText( "Team Deathmatch", "AlphaFontSmall", x - x/8, y/6, Color(255, 255, 255, 235), TEXT_ALIGN_RIGHT ) 

	draw.RoundedBox( 0 , x - x/8 + 10 + 1, y/6 - 40+2 + 1, x/500, y/14, Color(10,10,10,160) )
	draw.RoundedBox( 0 , x - x/8 + 10, y/6 - 40+2, x/500, y/14, Color(255,255,255,180) )

	--local material2 = Material ("materials/tdm/DM.png", "noclamp")
	--surface.SetMaterial( material2 )
	--surface.DrawTexturedRect(  x - x/8 + 24, y/6 - 30 + 2, 77, 46)

	if team.GetName( LocalPlayer():Team() ) == "Spectator" then 
        -- Was testing the hud here.

	else
		--[[ Debug display for admins.
		if (ply:Alive() && team.GetName( LocalPlayer():Team() ) != "Spectator"  && ply:IsAdmin()) then
			local playerClass = player_manager.GetPlayerClass( ply )
			local playerTeam = team.GetName( LocalPlayer():Team() )
			local round = self:GetRound()
			local time = self:GetRoundTime()
			local sl = self:GetScoreLimit()
			local left = self:GetRoundsLeft()

		    draw.DrawText( "Team: "..playerTeam, "DebugFont", 10,5, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		    draw.DrawText( "Class: "..playerClass, "DebugFont", 10,35, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		    draw.DrawText( round, "DebugFont", 10,65, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		    draw.DrawText( time, "DebugFont", 10,95, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		    draw.DrawText( sl, "DebugFont", 10,125, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		    draw.DrawText( left, "DebugFont", 10,155, Color(255, 255, 255, 235), TEXT_ALIGN_LEFT ) 
		end
		]]--

		if (ply:Alive()) then
	    	local playerTeam = team.GetName( ply:Team() )
	    	local playerClass = player_manager.GetPlayerClass( ply )


	    	local prec = ply:Health() / ply:GetMaxHealth()
	    	prec = math.Clamp( prec, 0, 1 )
	    	draw.RoundedBox( 0, 57, ScrH() - 150, 306 * prec, 15, Color(210,50,50,240) )

			self.Gradient = surface.GetTextureID("gui/gradient_up")
			surface.SetDrawColor( 255, 255, 255, 2 );
			surface.SetTexture( self.Gradient );
			surface.DrawTexturedRect( 57, ScrH() - 145, 306, 10);

			self.Gradient = surface.GetTextureID("gui/gradient_down")
			surface.SetDrawColor( 0, 0, 0, 90 );
			surface.SetTexture( self.Gradient );
			surface.DrawTexturedRect( 57, ScrH() - 150, 306, 15 );


			if ply:GetActiveWeapon() != NULL then

				self.Gradient = surface.GetTextureID("gui/gradient_up")
				surface.SetDrawColor( 255, 255, 255, 2 );
				surface.SetTexture( self.Gradient );
				surface.DrawTexturedRect( 60, ScrH() - 95, 300, 35 );

				self.Gradient = surface.GetTextureID("gui/gradient_down")
				surface.SetDrawColor( 0, 0, 0, 65 );
				surface.SetTexture( self.Gradient );
				surface.DrawTexturedRect( 60, ScrH() - 125, 300, 65 );

				draw.RoundedBox( 0 , 60, ScrH() - 125, 3, 65, Color(255,255,255,25) )
				draw.RoundedBox( 0 , 360, ScrH() - 125, 3, 65, Color(255,255,255,25) )

				local weaponName = ply:GetActiveWeapon():GetPrintName()
				draw.DrawText( weaponName, "WeaponShadow", 72 + 1, ScrH() - 122 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
				draw.DrawText( weaponName, "Weapon", 72, ScrH() - 122, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 


			end

			if ( IsValid( LocalPlayer():GetActiveWeapon() ) ) then
				local ammoLeft = LocalPlayer():GetActiveWeapon():Clip1()
			    local ammoTotal = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
			    draw.RoundedBox( 0 , 295, ScrH() - 120, 2, 55, Color(255,255,255,10) )

			    draw.DrawText( ammoTotal, "AmmoSmallShadow", 326 + 1, ScrH() - 121 + 1, Color(0, 0, 0, 250), TEXT_ALIGN_CENTER ) 
				draw.DrawText( ammoTotal, "AmmoSmall", 326, ScrH() - 121, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

				draw.DrawText( ammoLeft, "AmmoLargeShadow", 260 + 1, ScrH() - 126 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
				draw.DrawText( ammoLeft, "AmmoLarge", 260, ScrH() - 126, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
			end
		end

	end
end

function GM:HUDShouldDraw( name )
    if ( name == "CHudHealth" or name == "CHudAmmo" or name == "CHudSecondaryAmmo") then
        return false
    end
    return true
end
