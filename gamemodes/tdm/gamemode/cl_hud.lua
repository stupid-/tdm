-- Fonts
surface.CreateFont( "DebugFont", { font = "DefaultBold", size = 24, weight = 400, antialias = true, shadow = true })
surface.CreateFont( "Team", { font = "CloseCaption_Bold", size = 20, weight = 700, antialias = true, blursize = 0.2, shadow = true })
surface.CreateFont( "AlphaFont", { font = "Triomphe", size = 34, weight  = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AlphaFontShadow", { font = "Triomphe", size = 34, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "AlphaFontSmall", { font = "Triomphe", size = 24, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AlphaFontShadowSmall", { font = "Triomphe", size = 24, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "TimeLeftShadow", { font = "CloseCaption_Normal", size = 26, weight = 400, antialias = true, blursize = 1.5, shadow = false })
surface.CreateFont( "TimeLeft", { font = "CloseCaption_Normal", size = 26, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "MapShadow", { font = "CloseCaption_Normal", size = 22, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "Map", { font = "CloseCaption_Normal", size = 22, weight = 400, antialias = true, blursize = 0.2, shadow = true })
surface.CreateFont( "Score", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "ScoreShadow", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 1.5, shadow = false })
surface.CreateFont( "AmmoSmall", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AmmoSmallShadow", { font = "CloseCaption_Normal", size = 24, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "AmmoLarge", { font = "CloseCaption_Normal", size = 48, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AmmoLargeShadow", { font = "CloseCaption_Normal", size = 48, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "Weapon", { font = "CloseCaption_Normal", size = 30, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "WeaponShadow", { font = "CloseCaption_Normal", size = 30, weight  = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "CommandsBlur", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 3.75, shadow = false })
surface.CreateFont( "CommandsShadow", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 1.5, shadow = false })
surface.CreateFont( "Commands", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "HeadTextShadow2", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 12, shadow = false })
surface.CreateFont( "HeadTextShadow", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 6, shadow = false })
surface.CreateFont( "HeadText", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 0, shadow = false })

/*
local health_colors = {
    
}

local team_colors = {
    
}
*/

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

-- Different Gradients
local gradient = surface.GetTextureID("gui/gradient_up") 
local gradient2 = surface.GetTextureID("gui/gradient_down")
local gradient3 = surface.GetTextureID("gui/gradient")
local gradient4 = surface.GetTextureID("vgui/gradient-r")

-- Draw Teams and Scores on Bottom Right
local function DrawTeams( ply, roundState, roundTime, redKills, blueKills, scoreLimit, roundsLeft )
    local round = roundState

    if round == 0 then round = "Waiting"
    elseif round == 1 then round = "Preparing"
    elseif round == 2 then round = "In Progress"
    elseif round == 3 then round = "Round Over"
    end

    local time = roundTime
    local rk = redKills
    local bk = blueKills
    local sl = scoreLimit
    local left = roundsLeft

    local team1_deaths = bk * 10
    local team2_deaths = rk * 10

    local team1 = bk / sl
    team1 = math.Clamp( team1, 0, 1 )

    local team2 = rk / sl
    team2 = math.Clamp( team2, 0, 1 )

    if round == "Waiting" or round == "Preparing" then
        --Make it gray
        draw.RoundedBox( 0 , ScrW()-292, ScrH() - 90, 30, 30, Color(60,60,60,220) )
        draw.RoundedBox( 0 , ScrW()-292, ScrH()-125, 30, 30, Color(60,60,60,220) )

        draw.RoundedBox( 0 , ScrW()-260, ScrH() - 90, 200*team1, 30, Color(60,60,60,220) )
        draw.RoundedBox( 0 , ScrW()-260, ScrH()-125, 200*team2, 30, Color(60,60,60,220) )

    else 
        draw.RoundedBox( 0 , ScrW()-292, ScrH() - 90, 30, 30, Color(20,20,175,250) )
        draw.RoundedBox( 0 , ScrW()-292, ScrH()-125, 30, 30, Color(175,20,20,250) )

        draw.RoundedBox( 0 , ScrW()-260, ScrH() - 90, 200*team1, 30, Color(20,20,175,250) )
        draw.RoundedBox( 0 , ScrW()-260, ScrH()-125, 200*team2, 30, Color(175,20,20,250) )
    end

    draw.DrawText( "B", "TimeLeft", ScrW()-279, ScrH() - 89 , Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 
    draw.DrawText( "R", "TimeLeft", ScrW()-279, ScrH() - 124 , Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

    surface.SetDrawColor( 0, 0, 0, 90 );
    surface.SetTexture( gradient2 );
    surface.DrawTexturedRect( ScrW()-292, ScrH() - 90, 232, 30 );

    surface.SetDrawColor( 0, 0, 0, 90 );
    surface.SetTexture( gradient2 );
    surface.DrawTexturedRect( ScrW()-292, ScrH() - 125, 232, 30 );

    surface.SetDrawColor(  255, 255, 255, 1  );
    surface.SetTexture( gradient );
    surface.DrawTexturedRect( ScrW()-292, ScrH() - 75, 232, 15 );

    surface.SetDrawColor(  255, 255, 255, 1  );
    surface.SetTexture( gradient );
    surface.DrawTexturedRect( ScrW()-292, ScrH() - 110, 232, 15 );  

    draw.DrawText( team1_deaths, "ScoreShadow", ScrW()-65 + 1, ScrH() - 87 + 1 , Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
    draw.DrawText( team2_deaths, "ScoreShadow", ScrW()-65 + 1, ScrH() - 122 + 1 , Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
    draw.DrawText( team1_deaths, "Score", ScrW()-65, ScrH() - 87 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 
    draw.DrawText( team2_deaths, "Score", ScrW()-65, ScrH() - 122 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

    draw.DrawText( time, "TimeLeftShadow", ScrW()-290 + 1, ScrH() - 155 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
    draw.DrawText( time, "TimeLeft", ScrW()-290, ScrH() - 155 , Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

    draw.DrawText( round, "TimeLeftShadow", ScrW()-60 + 1, ScrH() - 155 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT ) 
    draw.DrawText( round, "TimeLeft", ScrW()-60, ScrH() - 155 , Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

end

-- Draw XP Bar on the bottom of screen
local function DrawXP( ply )

    for i = 0, 10 do
        draw.RoundedBox( 0, 57 + ( (ScrW() - 117) /10 * i ) , ScrH() - 45, 2, 13, Color( 255, 255, 255, 60) )
    end     
    
    for i = 0,40 do

        if ( i != 0 && i != 4 && i != 8 && i!= 12 && i != 16 && i != 20 && i != 24 && i != 28 && i != 32 && i != 36 && i != 40) then
            draw.RoundedBox( 0, 57 + ( (ScrW() - 117) /40 * i ) , ScrH() - 41, 2, 6, Color( 255, 255, 255, 20) )
        end
    
    end     

    local prec = ply:GetNWInt( "Level_xp", 0 ) / ply:GetNWInt("Level_xp_max", 100)
    prec = math.Clamp( prec, 0, 1 )

    surface.SetDrawColor( 255, 225, 75, 140 );
    surface.SetTexture( gradient4 );
    surface.DrawTexturedRect( 57, ScrH() - 43, (ScrW() - 117) * prec, 9);

    surface.SetDrawColor( 255, 255, 255, 4 );
    surface.SetTexture( gradient );
    surface.DrawTexturedRect( 57, ScrH() - 40, ScrW() - 117, 8);
     
    surface.SetDrawColor( 0, 0, 0, 40 );
    surface.SetTexture( gradient2 );
    surface.DrawTexturedRect( 57, ScrH() - 45, ScrW() - 117, 13 );

end

-- Draw HUD health, stamina and ammo/weapon
local function DrawHUD( ply )
    local playerTeam = team.GetName( ply:Team() )
    local playerClass = player_manager.GetPlayerClass( ply )

    local prec = ply:Health() / ply:GetMaxHealth()
    prec = math.Clamp( prec, 0, 1 )
    draw.RoundedBox( 0, 57, ScrH() - 150, 306 * prec, 15, Color(210,50,50,240) )

    surface.SetDrawColor( 255, 255, 255, 2 );
    surface.SetTexture( gradient );
    surface.DrawTexturedRect( 57, ScrH() - 145, 306, 10);

    surface.SetDrawColor( 0, 0, 0, 90 );
    surface.SetTexture( gradient2 );
    surface.DrawTexturedRect( 57, ScrH() - 150, 306, 15 );

    --Stamina Bar
    local prec = ply:GetNWInt( "Stamina", 0 ) / 100 
    prec = math.Clamp( prec, 0, 1 )
    draw.RoundedBox( 0, 57, ScrH() - 135, 306 * prec, 3, Color( 255, 225, 75, 240) )

    --If weapon equipped, display box and weapon name
    if ply:GetActiveWeapon() != NULL then

        DrawBlur( 0, 57, ScrH() - 125, 306, 65 )

        if playerTeam == "Red" then

            surface.SetDrawColor(175,20,20, 10 );
            surface.SetTexture( gradient );
            surface.DrawTexturedRect(0, ScrH()-100, ScrW(), 200);

            surface.SetDrawColor(175,20,20, 10 );
            surface.SetTexture( gradient2 );
            surface.DrawTexturedRect(0, -100, ScrW(), 200);

            surface.SetDrawColor( 175,20,20, 90 );
            surface.SetTexture( gradient2 );
            surface.DrawTexturedRect( 60, ScrH() - 125, 300, 65 );
            draw.RoundedBox( 0 , 57, ScrH() - 125, 3, 65, Color(255,255,255,35) )
            draw.RoundedBox( 0 , 360, ScrH() - 125, 3, 65, Color(255,255,255,35) )     
            
            surface.SetDrawColor( 255, 170, 170, 8 );
            surface.SetTexture( gradient );
            surface.DrawTexturedRect( 60, ScrH() - 95, 300, 35 );

        elseif playerTeam == "Blue" then

            surface.SetDrawColor(20,20,175, 10 );
            surface.SetTexture( gradient );
            surface.DrawTexturedRect(0, ScrH()-100, ScrW(), 200);

            surface.SetDrawColor(20,20,175, 10 );
            surface.SetTexture( gradient2 );
            surface.DrawTexturedRect(0, -100, ScrW(), 200);

            surface.SetDrawColor( 20,20,175, 90 );
            surface.SetTexture( gradient2 );
            surface.DrawTexturedRect( 60, ScrH() - 125, 300, 65 );
            draw.RoundedBox( 0 , 60, ScrH() - 125, 3, 65, Color(255,255,255,35) )
            draw.RoundedBox( 0 , 360, ScrH() - 125, 3, 65, Color(255,255,255,35) )
            
            surface.SetDrawColor( 170, 170, 255, 8 );
            surface.SetTexture( gradient );
            surface.DrawTexturedRect( 60, ScrH() - 95, 300, 35 );

        end

        local weaponName = ply:GetActiveWeapon():GetPrintName()
        draw.DrawText( weaponName, "WeaponShadow", 72 + 1, ScrH() - 122 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
        draw.DrawText( weaponName, "Weapon", 72, ScrH() - 122, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

        local commandText = "[F1] Switch Teams - [F2] Change Classes"
        draw.DrawText( commandText, "CommandsShadow", 60 + 11, ScrH()-78 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
        draw.DrawText( commandText, "Commands", 60 + 10, ScrH()-78 , Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

    end

    -- Display Ammo
    if ( IsValid( LocalPlayer():GetActiveWeapon() ) ) then
        local ammoLeft = LocalPlayer():GetActiveWeapon():Clip1()
        local ammoTotal = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())

        if ammoLeft != -1 then

            draw.RoundedBox( 0 , 295, ScrH() - 120, 2, 35, Color(255,255,255,10) )

            draw.DrawText( ammoTotal, "AmmoSmallShadow", 326 + 1, ScrH() - 121 + 1, Color(0, 0, 0, 250), TEXT_ALIGN_CENTER ) 
            draw.DrawText( ammoTotal, "AmmoSmall", 326, ScrH() - 121, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

            draw.DrawText( ammoLeft, "AmmoLargeShadow", 260 + 1, ScrH() - 126 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
            draw.DrawText( ammoLeft, "AmmoLarge", 260, ScrH() - 126, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        end
    end

end

function NamesOverPlayers()
    if LocalPlayer():Team() == TEAM_SPEC then 
        for k, v in pairs(player.GetAll()) do
            if v:IsValid() && v:Alive() && v:Team() != TEAM_SPEC then
                local pos = (v:GetPos() + Vector(0,0,80)):ToScreen()

                draw.SimpleText( v:Nick(), "CommandsBlur", pos.x + 1, pos.y + 1, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.SimpleText( v:Nick(), "CommandsShadow", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.SimpleText( v:Nick(), "Commands", pos.x, pos.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )              
            end
        end
    end
end

function GM:HUDPaint()

	hook.Run( "HUDDrawTargetID" )
	hook.Run( "HUDDrawPickupHistory" )
	hook.Run( "DrawDeathNotice", 0.85, 0.04 )

	local ply = LocalPlayer()
	local x, y = ScrW(), ScrH()
	local MapName = game.GetMap()

    local version = GAMEMODE.Version

    local round = self:GetRound()
    local time = string.ToMinutesSeconds(self:GetRoundTime())
    local rk = self:GetRedKills()
    local bk = self:GetBlueKills()
    local sl = self:GetScoreLimit()
    local left = self:GetRoundsLeft()

    NamesOverPlayers()

    DrawTeams( ply, round, time, rk, bk, sl, left )

	--draw.DrawText( "Alpha " .. version, "AlphaFontShadow", x - 65 + 1, y/6 - 40 + 1, Color(10, 10, 10, 210), TEXT_ALIGN_RIGHT ) 
	--draw.DrawText( "Alpha " .. version, "AlphaFont", x - 65, y/6 - 40, Color(255, 255, 255, 235), TEXT_ALIGN_RIGHT ) 

	--draw.DrawText( "Team Deathmatch", "AlphaFontShadowSmall", x - 65 + 1, y/6 + 1, Color(10, 10, 10, 210), TEXT_ALIGN_RIGHT ) 
	--draw.DrawText( "Team Deathmatch", "AlphaFontSmall", x - 65, y/6, Color(255, 255, 255, 235), TEXT_ALIGN_RIGHT ) 

	if LocalPlayer():Team() == TEAM_SPEC then 

        --Hud for Spectators

        --local commandText = "[F1] Switch Teams"
        --draw.DrawText( commandText, "CommandsShadow", 60 + 11, ScrH()-78 + 1, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT ) 
        --draw.DrawText( commandText, "Commands", 60 + 10, ScrH()-78 , Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

	else

        DrawXP( ply )

        --No Hud if dead
		if (ply:Alive()) then

            DrawHUD( ply )

		end

	end
end

function GM:HUDShouldDraw( name )

    if ( name == "CHudHealth" or name == "CHudAmmo" or name == "CHudSecondaryAmmo") then
        return false
    end

    return true

end

hook.Add( "PostDrawOpaqueRenderables", "PlayerNamesOverHeadsYeah", function()

    if LocalPlayer():Team() == TEAM_RED then

        --Display Teammates Names over their heads
        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() != TEAM_SPEC ) && ( v:Team() != TEAM_BLUE ) && (v != LocalPlayer()) ) then

                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, Color( 210, 60, 60, 185 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, Color( 0, 0, 0, 145 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, Color( 0, 0, 0, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )    
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0 , Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()
                
            end

        end

        --Display enemies names over their head if you are looking at them
        local tr = util.GetPlayerTrace( LocalPlayer() )
        local trace = util.TraceLine( tr )
        if (!trace.Hit) then return end
        if (!trace.HitNonWorld) then return end

        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() == TEAM_BLUE ) && ( trace.Entity:IsPlayer() ) && (v:Nick() == trace.Entity:Nick()) ) then

                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, Color( 60, 60, 210, 185 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, Color( 0, 0, 0, 145 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, Color( 0, 0, 0, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()

            end

        end

    end

    if LocalPlayer():Team() == TEAM_BLUE then
        
        --Display Teammates Names over their heads
        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() != TEAM_SPEC ) && ( v:Team() != TEAM_RED ) && (v != LocalPlayer()) ) then

                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, Color( 60, 60, 210, 185 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, Color( 0, 0, 0, 145 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, Color( 0, 0, 0, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )    
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()
                
            end

        end

        --Display enemies names over their head if you are looking at them
        local tr = util.GetPlayerTrace( LocalPlayer() )
        local trace = util.TraceLine( tr )
        if (!trace.Hit) then return end
        if (!trace.HitNonWorld) then return end

        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() == TEAM_RED ) && ( trace.Entity:IsPlayer() ) && (v:Nick() == trace.Entity:Nick()) ) then

                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, Color( 210, 60, 60, 185 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, Color( 0, 0, 0, 145 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, Color( 0, 0, 0, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )    
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()
                
            end

        end

    end

end )