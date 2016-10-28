--[[-------------------------------------------------------------------------
Menu for changing teams mid-game
---------------------------------------------------------------------------]]
surface.CreateFont("stupidButton", {
    font = "Marlett",
    size = 13,
    weight = 600,
    antialias = true,
    blursize = 0.2,
    symbol = true,
    shadow = false
})

surface.CreateFont("stupidButton2", {
    font = "Marlett",
    size = 11,
    weight = 600,
    antialias = true,
    blursize = 0.2,
    symbol = true,
    shadow = false
})

surface.CreateFont("Close", {
    font = "CloseCaption_Bold",
    size = 13,
    weight = 700,
    antialias = true,
    blursize = 0.2,
    shadow = false
})

surface.CreateFont("Button", {
    font = "Triomphe",
    size = 16,
    weight = 700,
    antialias = true,
    blursize = 0.3,
    shadow = false
})

surface.CreateFont("WelcomeMSG", {
    font = "Triomphe",
    size = 62,
    weight = 400,
    antialias = true,
    blursize = 0.2,
    shadow = false
})

surface.CreateFont("WelcomeMSGShadow", {
    font = "Triomphe",
    size = 62,
    weight = 400,
    antialias = true,
    blursize = 2,
    shadow = false
})

surface.CreateFont("TeamMSG", {
    font = "Triomphe",
    size = 32,
    weight = 400,
    antialias = true,
    blursize = 0.2,
    shadow = false
})

surface.CreateFont("TeamMSGShadow", {
    font = "Triomphe",
    size = 32,
    weight = 400,
    antialias = true,
    blursize = 1.5,
    shadow = false
})

function chooseTeam(ply)
    local SpecPlayers = GetGlobalInt("TDM_SpecTeamNum")
    local RedPlayers = GetGlobalInt("TDM_RedTeamNum")
    local BluePlayers = GetGlobalInt("TDM_BlueTeamNum")

    --Force update of information
    timer.Create("NumberMenuCheckTimer", 1, 0, function()
        SpecPlayers = GetGlobalInt("TDM_SpecTeamNum")
        RedPlayers = GetGlobalInt("TDM_RedTeamNum")
        BluePlayers = GetGlobalInt("TDM_BlueTeamNum")
    end)

    local ChooseTeamFrame = vgui.Create("DFrame")
    ChooseTeamFrame:SetSize(ScrW(), ScrH() * 0.3)
    ChooseTeamFrame:SetTitle("")
    ChooseTeamFrame:SetPos(0, ScrH() / 4)
    ChooseTeamFrame:SetVisible(true)
    ChooseTeamFrame:SetDraggable(false)
    ChooseTeamFrame:ShowCloseButton(false)
    ChooseTeamFrame:MakePopup()

    function ChooseTeamFrame:Paint(w, h, ply)
        draw.RoundedBox(0, 0, 0 + h / (1.5), w, h * (1 / 3), Color(250, 250, 250, 25))
        draw.RoundedBox(0, 0, 0, w, h / (1.5), Color(40, 40, 40, 205))
        draw.DrawText("Changing teams?", "TeamMSGShadow", 0 + w / 2 + 1, 0 + (h / 1.5) / 3 + 16 + 1, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
        draw.DrawText("Changing teams?", "TeamMSG", 0 + w / 2, 0 + (h / 1.5) / 3 + 16, Color(255, 255, 255, 235), TEXT_ALIGN_CENTER)
    end

    local tabHover = false
    local HelpButton = vgui.Create('DButton')
    HelpButton:SetParent(ChooseTeamFrame)
    HelpButton:SetSize(45, 22)
    HelpButton:SetPos(ScrW() - 90, 0)
    HelpButton:SetFont("Close")
    HelpButton:SetText("")
    HelpButton:SetTextColor(Color(255, 255, 255, 255))

    function HelpButton:OnCursorEntered()
        tabHover = true
    end

    function HelpButton:OnCursorExited()
        tabHover = false
    end

    function HelpButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(0, 0, 0, w, h, Color(80, 80, 80, 210))
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(120, 120, 120, 210))
        end

        draw.SimpleText("s", "stupidButton2", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function HelpButton:DoClick()
        --ChooseTeamFrame:Close()
    end

    local tabHover = false
    local CloseButton = vgui.Create('DButton')
    CloseButton:SetParent(ChooseTeamFrame)
    CloseButton:SetSize(45, 22)
    CloseButton:SetPos(ScrW() - 45, 0)
    CloseButton:SetFont("Close")
    CloseButton:SetText("")
    CloseButton:SetTextColor(Color(255, 255, 255, 255))

    function CloseButton:OnCursorEntered()
        tabHover = true
    end

    function CloseButton:OnCursorExited()
        tabHover = false
    end

    function CloseButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(0, 0, 0, w, h, Color(240, 30, 30, 210))
        else
            draw.RoundedBox(0, 0, 0, w, h, Color(250, 120, 120, 210))
        end

        draw.SimpleText("r", "stupidButton", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function CloseButton:DoClick()
        ChooseTeamFrame:Close()
        timer.Stop("NumberMenuCheckTimer")
    end

    local tabHover = false
    local SpectatorButton = vgui.Create('DButton')
    SpectatorButton:SetParent(ChooseTeamFrame)
    SpectatorButton:SetSize(ScrW() / 10, ScrH() / 20)
    SpectatorButton:SetPos(ScrW() / 2 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    SpectatorButton:SetText("")
    SpectatorButton:SetTextColor(Color(255, 255, 255, 255))
    SpectatorButton:SetFont("Button")
    SpectatorButton:SetDrawBackground(true)

    function SpectatorButton:OnCursorEntered()
        tabHover = true
    end

    function SpectatorButton:OnCursorExited()
        tabHover = false
    end

    function SpectatorButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(65, 65, 65, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(65, 65, 65, 255))
        end

        draw.SimpleText("SPECTATE (" .. SpecPlayers .. ")", "Button", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function SpectatorButton:DoClick()
        if ply:Team() == TEAM_SPEC then
            ply:ChatPrint("You are already spectating")
        else
            RunConsoleCommand("stTeamSpec")
            ChooseTeamFrame:Close()
            timer.Stop("NumberMenuCheckTimer")
        end
    end

    local tabHover = false
    local RedButton = vgui.Create('DButton')
    RedButton:SetParent(ChooseTeamFrame)
    RedButton:SetSize(ScrW() / 10, ScrH() / 20)
    RedButton:SetPos(ScrW() / 3 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    RedButton:SetText("")
    RedButton:SetTextColor(Color(255, 255, 255, 255))
    RedButton:SetFont("Button")
    RedButton:SetDrawBackground(true)

    function RedButton:OnCursorEntered()
        tabHover = true
    end

    function RedButton:OnCursorExited()
        tabHover = false
    end

    function RedButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(180, 40, 40, 250))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(180, 30, 30, 250))
        end

        draw.SimpleText("TEAM RED (" .. RedPlayers .. ")", "Button", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function RedButton:DoClick()
        if ply:Team() == TEAM_RED then
            ply:ChatPrint("You are already on the Red Team.")
        else
            if RedPlayers > BluePlayers then
                ply:ChatPrint("There are too many players on the Red Team.")
            else
                RunConsoleCommand("stTeamT")
                ChooseTeamFrame:Close()
                timer.Stop("NumberMenuCheckTimer")
            end
        end
    end

    local tabHover = false
    local BlueButton = vgui.Create('DButton')
    BlueButton:SetParent(ChooseTeamFrame)
    BlueButton:SetSize(ScrW() / 10, ScrH() / 20)
    BlueButton:SetPos(ScrW() / 2 + ScrW() / 6 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    BlueButton:SetText("")
    BlueButton:SetTextColor(Color(255, 255, 255, 255))
    BlueButton:SetFont("Button")
    BlueButton:SetDrawBackground(true)

    function BlueButton:OnCursorEntered()
        tabHover = true
    end

    function BlueButton:OnCursorExited()
        tabHover = false
    end

    function BlueButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(40, 40, 180, 250))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(30, 30, 180, 250))
        end

        draw.SimpleText("TEAM BLUE (" .. BluePlayers .. ")", "Button", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    function BlueButton:DoClick()
        if ply:Team() == TEAM_BLUE then
            ply:ChatPrint("You are already on Team Blue.")
        else
            if BluePlayers > RedPlayers then
                ply:ChatPrint("There are too many players on the Blue Team.")
            else
                RunConsoleCommand("stTeamCT")
                ChooseTeamFrame:Close()
                timer.Stop("NumberMenuCheckTimer")
            end
        end
    end
end

concommand.Add("chooseTeam", chooseTeam)

function redWins(ply)
    local RedWinsFrame = vgui.Create("DFrame")
    RedWinsFrame:SetSize(ScrW(), ScrH() * 0.3)
    RedWinsFrame:SetTitle("")
    RedWinsFrame:SetPos(0, ScrH() / 4)
    RedWinsFrame:SetVisible(true)
    RedWinsFrame:SetDraggable(false)
    RedWinsFrame:ShowCloseButton(false)
    RedWinsFrame:MakePopup()

    function RedWinsFrame:Paint(w, h, ply)
        draw.RoundedBox(0, 0, 0 + h / (1.5), w, h * (1 / 3), Color(250, 250, 250, 25))
        draw.RoundedBox(0, 0, 0, w, h / (1.5), Color(180, 30, 30, 225))
        draw.DrawText("Red Team Wins!", "WelcomeMSGShadow", 0 + w / 2 + 1, 0 + (h / 1.5) / 3 + 1, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
        draw.DrawText("Red Team Wins!", "WelcomeMSG", 0 + w / 2, 0 + (h / 1.5) / 3, Color(255, 255, 255, 235), TEXT_ALIGN_CENTER)
    end

    local tabHover = false
    local RedButton = vgui.Create('DButton')
    RedButton:SetParent(RedWinsFrame)
    RedButton:SetSize(ScrW() / 10, ScrH() / 20)
    RedButton:SetPos(ScrW() / 2 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    RedButton:SetText("Close")
    RedButton:SetTextColor(Color(255, 255, 255, 255))
    RedButton:SetFont("Button")
    RedButton:SetDrawBackground(true)

    function RedButton:OnCursorEntered()
        tabHover = true
    end

    function RedButton:OnCursorExited()
        tabHover = false
    end

    function RedButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(180, 40, 40, 250))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(180, 30, 30, 250))
        end
    end

    function RedButton:DoClick()
        RedWinsFrame:Close()
    end
end

concommand.Add("redWins", redWins)

function blueWins(ply)
    local BlueWinsFrame = vgui.Create("DFrame")
    BlueWinsFrame:SetSize(ScrW(), ScrH() * 0.3)
    BlueWinsFrame:SetTitle("")
    BlueWinsFrame:SetPos(0, ScrH() / 4)
    BlueWinsFrame:SetVisible(true)
    BlueWinsFrame:SetDraggable(false)
    BlueWinsFrame:ShowCloseButton(false)
    BlueWinsFrame:MakePopup()

    function BlueWinsFrame:Paint(w, h, ply)
        draw.RoundedBox(0, 0, 0 + h / (1.5), w, h * (1 / 3), Color(250, 250, 250, 25))
        draw.RoundedBox(0, 0, 0, w, h / (1.5), Color(30, 30, 180, 225))
        draw.DrawText("Blue Team Wins!", "WelcomeMSGShadow", 0 + w / 2 + 1, 0 + (h / 1.5) / 3 + 1, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
        draw.DrawText("Blue Team Wins!", "WelcomeMSG", 0 + w / 2, 0 + (h / 1.5) / 3, Color(255, 255, 255, 235), TEXT_ALIGN_CENTER)
    end

    local tabHover = false
    local BlueButton = vgui.Create('DButton')
    BlueButton:SetParent(BlueWinsFrame)
    BlueButton:SetSize(ScrW() / 10, ScrH() / 20)
    BlueButton:SetPos(ScrW() / 2 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    BlueButton:SetText("Close")
    BlueButton:SetTextColor(Color(255, 255, 255, 255))
    BlueButton:SetFont("Button")
    BlueButton:SetDrawBackground(true)

    function BlueButton:OnCursorEntered()
        tabHover = true
    end

    function BlueButton:OnCursorExited()
        tabHover = false
    end

    function BlueButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(40, 40, 180, 250))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(30, 30, 180, 250))
        end
    end

    function BlueButton:DoClick()
        BlueWinsFrame:Close()
    end
end

concommand.Add("blueWins", blueWins)

function nobodyWins(ply)
    local NobodyWinsFrame = vgui.Create("DFrame")
    NobodyWinsFrame:SetSize(ScrW(), ScrH() * 0.3)
    NobodyWinsFrame:SetTitle("")
    NobodyWinsFrame:SetPos(0, ScrH() / 4)
    NobodyWinsFrame:SetVisible(true)
    NobodyWinsFrame:SetDraggable(false)
    NobodyWinsFrame:ShowCloseButton(false)
    NobodyWinsFrame:MakePopup()

    function NobodyWinsFrame:Paint(w, h, ply)
        draw.RoundedBox(0, 0, 0 + h / (1.5), w, h * (1 / 3), Color(250, 250, 250, 25))
        draw.RoundedBox(0, 0, 0, w, h / (1.5), Color(80, 80, 80, 225))
        draw.DrawText("This was a Draw!", "WelcomeMSGShadow", 0 + w / 2 + 1, 0 + (h / 1.5) / 3 + 1, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
        draw.DrawText("This was a Draw!", "WelcomeMSG", 0 + w / 2, 0 + (h / 1.5) / 3, Color(255, 255, 255, 235), TEXT_ALIGN_CENTER)
    end

    local tabHover = false
    local GrayButton = vgui.Create('DButton')
    GrayButton:SetParent(NobodyWinsFrame)
    GrayButton:SetSize(ScrW() / 10, ScrH() / 20)
    GrayButton:SetPos(ScrW() / 2 - (ScrW() / 10) / 2, 0 + (ScrH() / 4) / 1.5 + ScrH() / 20 + (ScrH() / 20) / 6)
    GrayButton:SetText("Close")
    GrayButton:SetTextColor(Color(255, 255, 255, 255))
    GrayButton:SetFont("Button")
    GrayButton:SetDrawBackground(true)

    function GrayButton:OnCursorEntered()
        tabHover = true
    end

    function GrayButton:OnCursorExited()
        tabHover = false
    end

    function GrayButton:Paint(w, h)
        if tabHover then
            draw.RoundedBox(2, 0, 0, w, h, Color(220, 220, 220, 255))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(60, 60, 60, 250))
        else
            draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 0))
            draw.RoundedBox(2, 1, 1, w - 2, h - 2, Color(40, 40, 40, 250))
        end
    end

    function GrayButton:DoClick()
        NobodyWinsFrame:Close()
    end
end

concommand.Add("nobodyWins", nobodyWins)

function endgameMenu(ply)
end