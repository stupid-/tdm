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
surface.CreateFont( "AmmoSmall", { font = "Gotham HTF Book", size = 24, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AmmoSmallShadow", { font = "Gotham HTF Book", size = 24, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "AmmoLarge", { font = "Gotham HTF Book", size = 46, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "AmmoLargeShadow", { font = "Gotham HTF Book", size = 46, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "Weapon", { font = "CloseCaption_Normal", size = 25, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "WeaponShadow", { font = "CloseCaption_Normal", size = 25, weight  = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "CommandsBlur", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 3.75, shadow = false })
surface.CreateFont( "CommandsShadow", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 1.5, shadow = false })
surface.CreateFont( "Commands", { font = "CloseCaption_Bold", size = 13, weight = 600, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "HeadTextShadow2", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 12, shadow = false })
surface.CreateFont( "HeadTextShadow", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 6, shadow = false })
surface.CreateFont( "HeadText", { font = "CloseCaption_Bold", size = 124, weight = 600, antialias = true, blursize = 0, shadow = false })
surface.CreateFont( "AlphaFontShadow2", { font = "Gotham HTF", size = 18, weight = 800, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "AlphaFont2", { font = "Gotham HTF", size = 18, weight = 800, antialias = true, blursize = 0.2, shadow = false })

surface.CreateFont( "TimerFontShadow", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "TimerFont", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 0.2, shadow = false })

surface.CreateFont( "cIconsShadow", { font = "csd", size = 42, weight = 400, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "cIcons", { font = "csd", size = 42, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "HudTxtShadow", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "HudTxt", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 0.2, shadow = false })

surface.CreateFont( "SmallTxt", { font = "Trebuchet MS", size = 18, weight = 900, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "SmallTxtShadow", { font = "Trebuchet MS", size = 18, weight = 900, antialias = true, blursize = 2, shadow = false })

surface.CreateFont( "WpnIcon", { font = "csd", size = 50, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "WpnIconShadow", { font = "csd", size = 50, weight = 400, antialias = true, blursize = 2, shadow = false })

surface.CreateFont( "Wpn2Icon", { font = "HL2MP", size = 50, weight = 400, antialias = true, blursize = 0.2, shadow = false })
surface.CreateFont( "Wpn2IconShadow", { font = "HL2MP", size = 50, weight = 400, antialias = true, blursize = 2, shadow = false })

local name_colors = {
    mainText = {
        [TEAM_RED] = Color( 255, 255, 255, 255 ),
        [TEAM_BLUE] = Color( 255, 255, 255, 255 )
    },

    shadowText1 = {
        [TEAM_RED] = Color( 0, 0, 0, 245 ),
        [TEAM_BLUE] = Color( 0, 0, 0, 245 )
    },

    shadowText2 = {
        [TEAM_RED] = Color( 0, 0, 0, 145 ),
        [TEAM_BLUE] = Color( 0, 0, 0, 145 )
    },

    shadowText3 = {
        [TEAM_RED] = Color( 210, 60, 60, 185 ),
        [TEAM_BLUE] = Color( 60, 60, 210, 185 )
    }
}

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

-- Initialize Variables
local currentHealth = 0
local currentStamina = 0

local function DrawNewTeams( ply, roundState, roundTime, redKills, blueKills, scoreLimit, roundsLeft )
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

    if round == "In Progress" then
        NewRedColor = TDM_TeamRedColor
        NewRedColor.a = 50 
        NewBlueColor = TDM_TeamBlueColor
        NewBlueColor.a = 50

        --DrawBlur( 4, ScrW()/2 - 175 - 50, 30, 175, 25 )
        surface.SetDrawColor( 20, 20, 20, 100 )
        surface.DrawRect( ScrW()/2 - 175 - 50, 30, 175, 25 )

        --DrawBlur( 4, ScrW()/2 + 50, 30, 175, 25 )
        surface.SetDrawColor( 20, 20, 20, 100 )
        surface.DrawRect( ScrW()/2 + 50, 30, 175, 25 )

        --draw.RoundedBox( 1 , ScrW()/2 - 175*team2 - 50, 30, 175*team2, 25, NewRedColor )
        surface.SetDrawColor( NewRedColor.r, NewRedColor.g, NewRedColor.b, NewRedColor.a )
        surface.DrawRect( ScrW()/2 - 175*team2 - 50, 30, 175*team2, 25 )

        RedGrad = TDM_TeamRedColor
        RedGrad.a = 140 
        surface.SetDrawColor( RedGrad );
        surface.SetTexture( gradient3 );
        surface.DrawTexturedRect( ScrW()/2 - 175*team2 - 50, 30, 175*team2, 25);

        draw.DrawText( team2_deaths, "AlphaFontShadow2",  ScrW()/2 - 55 + 1, 34 + 1, Color(0, 0, 0, 200), TEXT_ALIGN_RIGHT ) 
        draw.DrawText( team2_deaths, "AlphaFont2",  ScrW()/2 - 55, 34, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

        --draw.RoundedBox( 1 , ScrW()/2 + 50, 30, 175*team1, 25, NewBlueColor )
        surface.SetDrawColor( NewBlueColor.r, NewBlueColor.g, NewBlueColor.b, NewBlueColor.a )
        surface.DrawRect( ScrW()/2 + 50, 30, 175*team1, 25 )

        BlueGrad = TDM_TeamBlueColor
        BlueGrad.a = 140
        surface.SetDrawColor( BlueGrad );
        surface.SetTexture( gradient4 );
        surface.DrawTexturedRect( ScrW()/2 + 50, 30, 175*team1, 25);

        draw.DrawText( team1_deaths, "AlphaFontShadow2",  ScrW()/2 + 55 + 1, 34 + 1, Color(0, 0, 0, 200), TEXT_ALIGN_LEFT ) 
        draw.DrawText( team1_deaths, "AlphaFont2",  ScrW()/2 + 55, 34, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

        draw.DrawText( time, "TimerFontShadow", ScrW()/2 + 1, 30 + 1, Color(0, 0, 0, 240), TEXT_ALIGN_CENTER ) 
        draw.DrawText( time, "TimerFont", ScrW()/2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

    elseif round == "Preparing" then

        draw.DrawText( "Preparing", "TimerFontShadow", ScrW()/2 + 1, 10 + 1, Color(0, 0, 0, 240), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Preparing", "TimerFont", ScrW()/2, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        draw.DrawText( time, "TimerFontShadow", ScrW()/2 + 1, 30 + 1, Color(0, 0, 0, 240), TEXT_ALIGN_CENTER ) 
        draw.DrawText( time, "TimerFont", ScrW()/2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

    elseif round == "Waiting" then

        draw.DrawText( "Waiting", "TimerFontShadow", ScrW()/2 + 1, 30 + 1, Color(0, 0, 0, 240), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "Waiting", "TimerFont", ScrW()/2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

    end

end

-- Draw XP Bar on the bottom of screen
local function DrawXP( ply )

    local c = team.GetColor( LocalPlayer():Team() )
    c.a = 180

    for i = 0, 10 do
        draw.RoundedBox( 0, 30 + ( (ScrW() - 60) /10 * i ) , ScrH() - 22, 1, 10, Color( 255, 255, 255, 180) )
    end     
    
    for i = 0,40 do

        if ( i != 0 && i != 4 && i != 8 && i!= 12 && i != 16 && i != 20 && i != 24 && i != 28 && i != 32 && i != 36 && i != 40) then
            draw.RoundedBox( 0, 30 + ( (ScrW() - 60) /40 * i ) , ScrH() - 19, 1, 5, Color( 0, 0, 0, 180) )
        end
    
    end     

    local prec = ply:GetNWInt( "Level_xp", 0 ) / ply:GetNWInt("Level_xp_max", 100)
    prec = math.Clamp( prec, 0, 1 )

    local otherC = Color( 255, 225, 75, 80 )
    otherC.a = 80*prec

    surface.SetDrawColor( otherC );
    surface.SetTexture( gradient3 );
    surface.DrawTexturedRect( 30, ScrH() - 19, (ScrW() - 60) * prec, 5);

    surface.SetDrawColor( c );
    surface.SetTexture( gradient4 );
    surface.DrawTexturedRect( 30, ScrH() - 19, (ScrW() - 60) * prec, 5);

    surface.SetDrawColor( 255, 255, 255, 4 );
    surface.SetTexture( gradient );
    surface.DrawTexturedRect( 30, ScrH() - 19, ScrW() - 60, 8 );
     
    surface.SetDrawColor( 0, 0, 0, 40 );
    surface.SetTexture( gradient2 );
    surface.DrawTexturedRect( 30, ScrH() - 22, ScrW() - 60, 11 );

end

local function DrawBetaInfo( ply )

    DrawBlur( 4, 25, 25, 150, 35 )
    surface.SetDrawColor( 0, 0, 0, 15 )
    surface.DrawRect( 25, 25, 150, 35 )
    draw.DrawText( "TDM ALPHA", "AlphaFontShadow2",  76 + 25 + 1, 45 - 12 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
    draw.DrawText( "TDM ALPHA", "AlphaFont2", 76 + 25, 45 - 12, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

end

local function DrawSpectatorInfo()

    DrawBlur( 4, 25, 25 + 35, 150, 25 )
    surface.SetDrawColor( 255*0.7, 225*0.7, 75*0.7, 200 )
    surface.DrawRect( 25, 25 + 35, 150, 25 )
    draw.DrawText( "SPECTATING", "AlphaFontShadow2", 76 + 25 + 1, 45 - 12 + 1 + 30, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
    draw.DrawText( "SPECTATING", "AlphaFont2",  76 + 25, 45 - 12 + 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

end

local function DrawTooltip()

    DrawBlur( 4, ScrW()/2 - 500/2, ScrH()-60-25, 500, 25 )
    draw.DrawText( "Press [F1] to switch teams. Press [F2] to change classes.", "AlphaFontShadow2", ScrW()/2 + 1, ScrH()-60-25 + 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER ) 
    draw.DrawText( "Press [F1] to switch teams. Press [F2] to change classes.", "AlphaFont2",  ScrW()/2, ScrH()-60-25 + 3, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

end

local function DrawTeamInfo( ply )

    local playerTeam = team.GetName( ply:Team() )
    local teamColor = team.GetColor( ply:Team() )

    teamColor.a = 80

    DrawBlur( 4, 25, 25 + 35, 150, 25 )
    surface.SetDrawColor( teamColor )
    surface.DrawRect( 25, 25 + 35, 150, 25 )
    draw.DrawText( playerTeam, "AlphaFontShadow2", 76 + 25 + 1, 45 - 12 + 1 + 30, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
    draw.DrawText( playerTeam, "AlphaFont2",  76 + 25, 45 - 12 + 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

end

local function DrawEffects( ply )

    local plyHealth = ply:Health()-- / ply:GetMaxHealth()
    plyHealth = math.Clamp( plyHealth, 0, 100 )
    plyHealth = math.Round( plyHealth, 0 )

    --Near Death Effect
    plyHealthEffect = plyHealth * 4
    plyHealthEffect = math.Clamp( plyHealthEffect, 0, 255 )
    plyHealthEffect = math.abs( plyHealthEffect - 255 )
    surface.SetMaterial( Material( "vgui/tdm/death-fx.png" ) );
    surface.SetDrawColor( 255, 255, 255, plyHealthEffect );
    surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );

end

-- New Test HUD
local function DrawNewHud( ply )
    local hudPadding = 30
    local playerTeam = team.GetName( ply:Team() )
    
    --Main Hud
    local plyHealth = ply:Health()-- / ply:GetMaxHealth()
    plyHealth = math.Clamp( plyHealth, 0, 100 )
    plyHealth = math.Round( plyHealth, 0 )

    --Blur BG
    --DrawBlur( 4, hudPadding, ScrH() - 30 - hudPadding, 90, 30 )

    --Low Health
    surface.SetDrawColor( 195, 32, 32, plyHealthEffect )
    surface.DrawRect( hudPadding, ScrH() - 30 - hudPadding, 90, 30 )

    --BG
    surface.SetDrawColor( 20, 20, 20, 100 )
    surface.DrawRect( hudPadding, ScrH() - 30 - hudPadding, 90, 30 )

    --Colored Tip
    surface.SetDrawColor( 160*0.7, 30*0.7, 30*0.7, 230 )
    surface.DrawRect( hudPadding, ScrH() - 30 - hudPadding, 3, 30 )

    --Colored Tip
    surface.SetDrawColor( 160, 30, 30, 230 )
    surface.DrawRect( hudPadding + 3, ScrH() - 30 - hudPadding, 30, 30 )

    --CROSS
    draw.DrawText( "K", "cIconsShadow",  hudPadding + 20 + 1, ScrH() - 30 - hudPadding + 5 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
    draw.DrawText( "K", "cIcons",  hudPadding + 20, ScrH() - 30 - hudPadding + 5, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER ) 

    --HELTH TEXT
    draw.DrawText( plyHealth, "HudTxtShadow",  hudPadding + 61 + 1, ScrH() - 30 - hudPadding + 3 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
    draw.DrawText( plyHealth, "HudTxt",  hudPadding + 61, ScrH() - 30 - hudPadding + 3, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER ) 

    local ArmorValue = ply:Armor()

    --Armor Bar
    if ArmorValue >= 1 then

        --Blur BG
        --DrawBlur( 4, hudPadding + hudPadding/2 + 90, ScrH() - 30 - hudPadding, 90, 30 )

        --BG
        surface.SetDrawColor( 20, 20, 20, 100 )
        surface.DrawRect( hudPadding + hudPadding/2 + 90, ScrH() - 30 - hudPadding, 90, 30 )

        --Colored Tip
        surface.SetDrawColor( 30*0.7, 30*0.7, 160*0.7, 230 )
        surface.DrawRect( hudPadding + hudPadding/2 + 90, ScrH() - 30 - hudPadding, 3, 30 )

        --Colored Tip
        surface.SetDrawColor( 30, 30, 160, 230 )
        surface.DrawRect( hudPadding + hudPadding/2 + 90 + 3, ScrH() - 30 - hudPadding, 30, 30 )

        --SHIELD
        draw.DrawText( "p", "cIconsShadow",  hudPadding + hudPadding/2 + 90 + 22 + 1, ScrH() - 30 - hudPadding + 4 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
        draw.DrawText( "p", "cIcons",  hudPadding + hudPadding/2 + 90 + 22, ScrH() - 30 - hudPadding + 4, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER ) 

        --ARMOR TEXT
        draw.DrawText( ArmorValue, "HudTxtShadow",  hudPadding + hudPadding/2 + 90 + 61 + 1, ScrH() - 30 - hudPadding + 3 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
        draw.DrawText( ArmorValue, "HudTxt",  hudPadding + hudPadding/2 + 90 + 61, ScrH() - 30 - hudPadding + 3, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER ) 

    end

    --Stamina Bar
    local prec = currentStamina / 100 
    prec = math.Clamp( prec, 0, 1 )

    --DrawBlur( 4,  ScrW() - 150 - hudPadding, ScrH() - 5 - hudPadding, 150, 5 )

    surface.SetDrawColor( 20, 20, 20, 100 )
    surface.DrawRect( ScrW() - 150 - hudPadding, ScrH() - 5 - hudPadding, 150, 5 )

    surface.SetDrawColor( 255, 230, 55, 240 ) --Color(255,255,255,130)
    surface.DrawRect( ScrW() - 150 - hudPadding, ScrH() - 5 - hudPadding, (150 * prec), 5 )

    --Ammo Box
    DrawBlur( 4,  ScrW() - 150 - hudPadding, ScrH() - 10 - hudPadding - 50, 150, 50 )
    surface.SetDrawColor( 20, 20, 20, 100 )
    surface.DrawRect( ScrW() - 150 - hudPadding, ScrH() - 10 - hudPadding - 50, 150, 50 )

    -- Display Ammo
    if ( IsValid( LocalPlayer():GetActiveWeapon() ) ) then
        local ammoLeft = LocalPlayer():GetActiveWeapon():Clip1()
        local ammoTotal = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
        local weaponName = ply:GetActiveWeapon():GetPrintName()

            draw.DrawText( weaponName, "SmallTxtShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 15 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( weaponName, "SmallTxt", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        if ammoLeft != -1 then

            --draw.RoundedBox( 0 , 295, ScrH() - 120, 2, 35, Color(255,255,255,10) )

            draw.DrawText( ammoTotal, "AmmoSmallShadow", ScrW() - 57 - hudPadding + 1, ScrH() - 11 - hudPadding - 50 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_LEFT ) 
            draw.DrawText( ammoTotal, "AmmoSmall", ScrW() - 57 - hudPadding, ScrH() - 11 - hudPadding - 50, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT ) 

            draw.DrawText( "/", "AmmoSmallShadow", ScrW() - 67 - hudPadding + 1, ScrH() - 11 - hudPadding - 50 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "/", "AmmoSmall", ScrW() - 67 - hudPadding, ScrH() - 11 - hudPadding - 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

            draw.DrawText( ammoLeft, "AmmoLargeShadow", ScrW() - 77 - hudPadding + 1, ScrH() - 16 - hudPadding - 50 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_RIGHT ) 
            draw.DrawText( ammoLeft, "AmmoLarge", ScrW() - 77 - hudPadding, ScrH() - 16 - hudPadding - 50, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT ) 

        end

        if weaponName == "Incendiary Grenade" then

            draw.DrawText( "P", "WpnIconShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 45 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "P", "WpnIcon", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 45, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        elseif weaponName == "Frag Grenade" then

            draw.DrawText( "h", "WpnIconShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 40 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "h", "WpnIcon", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 40, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        elseif weaponName == "Smoke Grenade" then

            draw.DrawText( "Q", "WpnIconShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 45 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "Q", "WpnIcon", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 45, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        elseif weaponName == "Discombobulator" then

            draw.DrawText( "O", "WpnIconShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 40 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "O", "WpnIcon", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 40, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        elseif weaponName == "Crowbar" then

            draw.DrawText( "6", "Wpn2IconShadow", ScrW() - 150/2 - hudPadding + 1, ScrH() - 11 - hudPadding - 40 + 1, Color(0, 0, 0, 230), TEXT_ALIGN_CENTER ) 
            draw.DrawText( "6", "Wpn2Icon", ScrW() - 150/2 - hudPadding, ScrH() - 11 - hudPadding - 40, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER ) 

        end
    end
end

local function NamesOverPlayers()
    for k, v in pairs(player.GetAll()) do
        if v:IsValid() && v:Alive() && v:Team() != TEAM_SPEC then
            local pos = (v:GetPos() + Vector(0,0,80)):ToScreen()

            draw.SimpleText( v:Nick(), "CommandsBlur", pos.x + 1, pos.y + 1, team.GetColor(v:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.SimpleText( v:Nick(), "CommandsShadow", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.SimpleText( v:Nick(), "Commands", pos.x, pos.y, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )              
        end
    end
end

hook.Add( "PostDrawOpaqueRenderables", "PlayerNamesOverHeadsYeah", function()
    local playerTeam = LocalPlayer():Team()

    if playerTeam != TEAM_SPEC then

        local opposingTeam = nil
        if ( playerTeam == TEAM_RED ) then opposingTeam = TEAM_BLUE else opposingTeam = TEAM_RED end

        -- Display Teammates Names over their heads
        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() != TEAM_SPEC ) && ( v:Team() != opposingTeam ) && (v != LocalPlayer()) ) then
                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, name_colors.shadowText3[ playerTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, name_colors.shadowText2[ playerTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, name_colors.shadowText1[ playerTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )    
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0 , name_colors.mainText[ playerTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()   
            end

        end

        -- Display enemies names over their head if you are looking at them
        local tr = util.GetPlayerTrace( LocalPlayer() )
        local trace = util.TraceLine( tr )
        if (!trace.Hit) then return end
        if (!trace.HitNonWorld) then return end

        for k, v in pairs(player.GetAll()) do

            if (v:IsValid() && v:Alive() && ( v:Team() == opposingTeam ) && ( trace.Entity:IsPlayer() ) && (v:Nick() == trace.Entity:Nick()) ) then
                local Pos = v:GetPos()+Vector(0,0,78)
                local Ang = (Pos - (LocalPlayer():EyePos())):Angle()

                cam.Start3D2D(Pos, Angle(0, Ang.y-90, 90), 0.065) 
                    draw.SimpleText( v:Nick(), "HeadTextShadow2", 3, 3, name_colors.shadowText3[ opposingTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )   
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 6, 6, name_colors.shadowText2[ opposingTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )      
                    draw.SimpleText( v:Nick(), "HeadTextShadow", 3, 3, name_colors.shadowText1[ opposingTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                    draw.SimpleText( v:Nick(), "HeadText", 0, 0, name_colors.mainText[ opposingTeam ], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )     
                cam.End3D2D()
            end

        end
    end
end )

hook.Add( "Initialize", "Interp", function() 

    hook.Add( "Think", "InterpThink", function() 

        if LocalPlayer():Health() != currentHealth then
            currentHealth = Lerp( 0.10, currentHealth, LocalPlayer():Health() )
        end

        if LocalPlayer():GetNWInt( "Stamina", 0 ) != currentStamina then
            currentStamina = Lerp( 0.10, currentStamina, LocalPlayer():GetNWInt( "Stamina", 0 ) )
        end

    end )

end )

--Radar

local function metersToSource( m )
    return ( 64 / 1.22 ) * m 
end

local function sourceToMeters( s )
    return ( 1.22 / 64 ) * s 
end

local radar_x = 100
local radar_y = 100

local radar_opacity = 1

local angle = 180
local drawScale = 100

local radarQuality = 4
local radarRingEvery = 250
local radarRingWidth = 3
local radarBlipSize = drawScale/14
local radarBlipHeightColorMult = 0.65
local radarPingTime = 3

local scanFor = {
    {
        class   = "headcrab",
        color   = Color( 255, 26, 22, 255 ),
        size    = 0.5,
    },
    
    { 
        class   = "antlionguard",
        color   = Color( 255, 26, 22, 255 ),
        size    = 1.5,
    },
    
    { 
        class   = "npc_",
        color   = Color( 255, 26, 22, 255 ),
        size    = 1,
    },
    
    {
        class   = "player",
        color   = Color( 250, 215, 37, 255 ),
        size    = 1,
    },
}

--Draws a circle
local function drawCircle( x, y, radius, res )
    local tbl = {}
    processedRes = math.floor( 360 * res )
    for I = 1, processedRes do
    
        local curX = x + math.cos( math.rad( I * ( 360 / processedRes ) ) ) * radius
        local curY = y + math.sin( math.rad( I * ( 360 / processedRes ) ) ) * radius
        
        table.insert( tbl, { x = curX, y = curY } )
    end
    
    return tbl

end

--Draws a wedge of a circle.  It's used to draw the forward FOV indicator
function drawWedge( x, y, radius, angle, direction, res )
    local tbl = { }
    table.insert( tbl, { x = x, y = y } )
    processedRes = math.ceil( angle * res )
    for I = 0, processedRes do
        
        local curX = x + math.cos( math.rad( I * ( angle / processedRes ) + ( direction ) ) ) * radius
        local curY = y + math.sin( math.rad( I * ( angle / processedRes ) + ( direction ) ) ) * radius
        
        table.insert( tbl, { x = curX, y = curY } )
    end
    return tbl
end

function DrawRadar( ply )
    local radarTeamColor = team.GetColor( ply:Team() )

    local opacityMult = radar_opacity
    
    --Radar position
    local radarX = drawScale + (radar_x/100 * ((ScrW()-drawScale) - drawScale)) - 20
    local radarY = drawScale + (radar_y/100) + 20
    
    local radarRange = metersToSource( 20 )
    
    --Creating polygons where applicable
    local radarCircle = drawCircle( radarX, radarY, drawScale, radarQuality )
    local localPlayerCircle = drawCircle( radarX, radarY, radarBlipSize, 0.025 )
    
    --Prep the stencil
    render.ClearStencil()
    render.SetStencilEnable( true )
    
    --If we draw on a pixel, set its value to 15
    render.SetStencilFailOperation( STENCILOPERATION_KEEP )
    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
    render.SetStencilZFailOperation( STENCILOPERATION_KEEP )
        render.SetStencilReferenceValue(15)
        render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS )
    
    --Draw the radar circle to define it as the area we want to clip to
    surface.SetDrawColor( Color( 255, 255, 255, 1 ) )
    surface.DrawPoly( radarCircle )
    
    --If the pixels we draw next match the reference value (15) that we set on the radar pixels, draw that.
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
    
    --Background
    surface.SetDrawColor( Color( radarTeamColor.r, radarTeamColor.g, radarTeamColor.b, 255 ) )
    surface.DrawPoly( radarCircle )
    
    --Wedge
    surface.SetDrawColor( Color( 255, 255, 255, 50 * opacityMult ) )
    local fov = LocalPlayer():GetFOV()
    local ang = -90
    local wedge = drawWedge( radarX, radarY, drawScale, fov, ang - fov/2, radarQuality )
    surface.DrawPoly( wedge )
    
    --Radar ping
    surface.SetDrawColor( Color( 255, 255, 255, (75 * opacityMult) - (75 * opacityMult) * ( CurTime() % radarPingTime )/radarPingTime ) )
    local ping = drawCircle( radarX, radarY, drawScale * ( CurTime() % radarPingTime )/radarPingTime, radarQuality )
    surface.DrawPoly( ping )
    
    --Draw client
    surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
    surface.DrawPoly( localPlayerCircle )
    
    --Entities within the radar's range
    local search = ents.FindInBox( LocalPlayer():GetPos() - Vector( radarRange, radarRange, 4 * radarRange ), LocalPlayer():GetPos() + Vector( radarRange, radarRange, 4 * radarRange ) )

    --For every entity in range
    for _, ent in pairs( search ) do
        --If they're not the player
        if ent != LocalPlayer() then
            --And they're alive
            if ( ent:Health() > 0 ) and ( ent:IsPlayer() ) and ( ent:IsValid() ) then
                --Used to stop drawing if we've already found something. So we don't draw an npc from a filter of both "npc_antlion" and "npc_"
                local found = false

                local entTeamColor = team.GetColor( ent:Team() )

                if ent:Team() == LocalPlayer():Team() then 

                    entTeamColor = Color( 255, 255, 255, 255 )

                end
                
                for _, scanOption in pairs( scanFor ) do
                    if not found then
                        local plyPos = LocalPlayer():GetPos()
                        local entPos = ent:GetPos() + ent:OBBCenter()
                        
                        local dist = ( plyPos - Vector( 0, 0, plyPos.z ) ):Distance( entPos - Vector( 0, 0, entPos.z ) )
                        if dist <= radarRange then
                        
                            if ( string.find( ent:GetClass(), scanOption.class ) ) then
                                
                                found = true
                                
                                local dx = entPos.x - plyPos.x
                                local dy = entPos.y - plyPos.y
                                local dz = entPos.z - plyPos.z
                                
                                local ang = math.atan2( dx, dy )
                                
                                local fixedAng = ang + math.rad( LocalPlayer():EyeAngles().y ) + math.rad( 180 )
                                
                                local color = table.Copy( scanOption.color )
                                color.a = color.a * opacityMult
                                
                                if ( dz < 0 and math.abs( dz ) > 100 ) then
                                    color = Color( scanOption.color.r * radarBlipHeightColorMult, scanOption.color.g * radarBlipHeightColorMult, scanOption.color.b * radarBlipHeightColorMult, 255 )
                                end
                                
                                surface.SetDrawColor( entTeamColor )
                                local blipX = radarX + math.cos( fixedAng ) * ( ( dist/radarRange ) * ( drawScale + radarBlipSize ) )
                                local blipY = radarY + math.sin( fixedAng ) * ( ( dist/radarRange ) * ( drawScale + radarBlipSize ) )
                                
                                local ply = drawCircle( blipX, blipY, radarBlipSize * scanOption.size , 0.025 )
                                surface.DrawPoly( ply )
                            end
                            
                        end
                    end
                end
            end
        end
        
    end
    
    render.SetStencilEnable( false )
    
end


function GM:HUDPaint()
    hook.Run( "HUDDrawTargetID" )
    hook.Run( "HUDDrawPickupHistory" )
    hook.Run( "DrawDeathNotice", 0.75, 0.04 )

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

    if LocalPlayer():Team() == TEAM_SPEC then 

        --Alpha Text Top Left
        DrawBetaInfo( ply )

        --Spectator Text Top Left
        DrawSpectatorInfo()

        --Names over all players (Spectator Only)
        NamesOverPlayers()

        --Tooltip for Spectators
        DrawTooltip()

    else

        if (ply:Alive()) then

            --Low Health Effects first so under rest of Hud
            DrawEffects( ply )

            --New Simple Hud
            DrawNewHud( ply )

            --Bottom XP Bar
            DrawXP( ply )

            --Radar Top Right
            DrawRadar( ply )

            --Weapon Switching Menu
            WSWITCH:Draw( ply )

        end

        --DrawBetaInfo( ply )
        --DrawTeamInfo( ply )

    end

    --Team Score and Counter - Top Middle
    DrawNewTeams( ply, round, time, rk, bk, sl, left )

end

-- Hide the standard HUD stuff
local hud = {["CHudHealth"] = true, ["CHudBattery"] = true, ["CHudAmmo"] = true, ["CHudSecondaryAmmo"] = true, ["CHudWeaponSelection"] = true }
function GM:HUDShouldDraw(name)
   if hud[name] then return false end

   return self.BaseClass.HUDShouldDraw(self, name)
end