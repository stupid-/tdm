surface.CreateFont( "HudTxtShadow", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 2, shadow = false })
surface.CreateFont( "HudTxt", { font = "Gotham HTF", size = 22, weight = 800, antialias = true, blursize = 0.2, shadow = false })

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

net.Receive( "NotifyPlayer", function( len, ply )

    received_tbl = net.ReadTable()

    PrintTable( received_tbl )

    gWinner = received_tbl.winner
    gTeam = received_tbl.team
    gKills = received_tbl.kills
    gAssists = received_tbl.assists
    gDeaths = received_tbl.deaths
    gHeadshots = received_tbl.headshots
    gKillsTotal = received_tbl.killsTotal
    gAssistsTotal = received_tbl.assistsTotal
    gDeathsTotal = received_tbl.deathsTotal
    gWins = received_tbl.wins
    gLosses = received_tbl.losses
    gGamesTotal = received_tbl.gamesTotal
    gLevel = received_tbl.level
    gSavedXP = received_tbl.savedXP
    gReqXP = received_tbl.reqXP
    gEarnedXP = received_tbl.earnedXP

    notifyMsg( ply )

end )


function notifyMsg( ply, color, img, msg )
        nAlpha = 255

        --DrawBlur( 4, 0, 0, 225, 50 )

        surface.SetDrawColor( 255, 225, 75, nAlpha )
        surface.DrawRect( ScrW()/2 - 255/2, ScrH()/4, 225, 50 )

end
concommand.Add("notifyMsgCmd", notifyMsg)