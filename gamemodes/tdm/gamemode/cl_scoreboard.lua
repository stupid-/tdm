--Based on the base scorebaord, with modifications.
surface.CreateFont("ScoreboardDefault", {
    font = "Helvetica",
    size = 18,
    weight = 800,
    antialias = true,
    blursize = 0.1
})

surface.CreateFont("ScoreboardDefaultRank", {
    font = "Helvetica",
    size = 14,
    weight = 800,
    antialias = true,
    blursize = 0.1
})

surface.CreateFont("ScoreboardHeading", {
    font = "Helvetica",
    size = 18,
    weight = 800,
    antialias = true,
    blursize = 0.1,
    shadow = false
})

surface.CreateFont("ScoreboardHeadingShadow", {
    font = "Helvetica",
    size = 18,
    weight = 800,
    antialias = true,
    blursize = 1.5,
    shadow = false
})

surface.CreateFont("ScoreboardDefaultTitleShadow", {
    font = "Coolvetica",
    size = 32,
    weight = 400,
    antialias = true,
    blursize = 1.5
})

surface.CreateFont("ScoreboardDefaultTitle", {
    font = "Coolvetica",
    size = 32,
    weight = 400,
    antialias = true,
    blursize = 0.2
})

local PLAYER_LINE = {
    Init = function(self)
        self.Level = self:Add("DLabel")
        self.Level:Dock(LEFT)
        self.Level:SetWidth(20)
        self.Level:SetFont("ScoreboardDefault")
        self.Level:SetDark(false)
        self.Level:SetTextColor(Color(255, 255, 255, 255))
        self.Level:DockMargin(8, 0, 12, 0)
        self.Level:SetContentAlignment(5)
        self.AvatarButton = self:Add("DButton")
        self.AvatarButton:Dock(LEFT)
        self.AvatarButton:SetSize(22, 22)

        self.AvatarButton.DoClick = function()
            self.Player:ShowProfile()
        end

        self.Avatar = vgui.Create("AvatarImage", self.AvatarButton)
        self.Avatar:SetSize(22, 22)
        self.Avatar:SetMouseInputEnabled(false)
        self.Name = self:Add("DLabel")
        self.Name:Dock(LEFT)
        self.Name:SetWidth(120)
        self.Name:SetFont("ScoreboardDefault")
        self.Name:SetDark(false)
        self.Name:SetTextColor(Color(255, 255, 255, 255))
        self.Name:DockMargin(8, 0, 0, 0)
        self.Rank = self:Add("DLabel")
        self.Rank:Dock(LEFT)
        self.Rank:SetWidth(120)
        self.Rank:SetFont("ScoreboardDefaultRank")
        self.Rank:SetDark(false)
        self.Rank:SetTextColor(Color(255, 255, 255, 255))
        self.Rank:DockMargin(8, 0, 0, 0)
        self.Mute = self:Add("DImageButton")
        self.Mute:SetSize(22, 22)
        self.Mute:Dock(RIGHT)
        self.Ping = self:Add("DLabel")
        self.Ping:Dock(RIGHT)
        self.Ping:SetWidth(80)
        self.Ping:SetFont("ScoreboardDefault")
        self.Ping:SetDark(false)
        self.Ping:SetTextColor(Color(255, 255, 255, 255))
        self.Ping:SetContentAlignment(5)
        self.Deaths = self:Add("DLabel")
        self.Deaths:Dock(RIGHT)
        self.Deaths:SetWidth(80)
        self.Deaths:SetFont("ScoreboardDefault")
        self.Deaths:SetDark(false)
        self.Deaths:SetTextColor(Color(255, 255, 255, 255))
        self.Deaths:SetContentAlignment(5)
        self.ScoreAssists = self:Add("DLabel")
        self.ScoreAssists:Dock(RIGHT)
        self.ScoreAssists:SetWidth(80)
        self.ScoreAssists:SetFont("ScoreboardDefault")
        self.ScoreAssists:SetDark(false)
        self.ScoreAssists:SetTextColor(Color(255, 255, 255, 255))
        self.ScoreAssists:SetContentAlignment(5)
        self.Kills = self:Add("DLabel")
        self.Kills:Dock(RIGHT)
        self.Kills:SetWidth(80)
        self.Kills:SetFont("ScoreboardDefault")
        self.Kills:SetDark(false)
        self.Kills:SetTextColor(Color(255, 255, 255, 255))
        self.Kills:SetContentAlignment(5)
        self:Dock(TOP)
        self:DockPadding(3, 3, 3, 3)
        self:SetHeight(22 + 3 * 2)
        self:DockMargin(2, 0, 2, 2)
    end,
    Setup = function(self, pl)
        self.Player = pl
        self.Avatar:SetPlayer(pl)
        self:Think(self)
    end,
    Think = function(self)
        if (not IsValid(self.Player)) then
            self:Remove()

            return
        end

        if (self.NumLevel == nil or self.NumLevel ~= self.Player:GetNWInt("Level", 1)) then
            self.NumLevel = self.Player:GetNWInt("Level", 1)
            self.Level:SetText(self.NumLevel)
        end

        if (self.PName == nil or self.PName ~= self.Player:Nick()) then
            self.PName = self.Player:Nick()
            self.Name:SetText(self.PName)
        end

        self.findRank = nil
        self.findRankLevel = nil

        for k, v in pairs(PlayerRanks) do
            if (not self.findRank or (tonumber(v.level) >= tonumber(self.findRankLevel)) and (tonumber(v.level) <= tonumber(self.NumLevel))) then
                self.findRankLevel = v.level
                self.findRank = v.rank
            end
        end

        if (self.PRank == nil or self.PRank ~= self.findRank) then
            self.PRank = self.findRank
            self.Rank:SetText(self.PRank)
        end

        if (self.NumKills == nil or self.NumKills ~= self.Player:Frags()) then
            self.NumKills = self.Player:Frags()
            self.Kills:SetText(self.NumKills)
        end

        if (self.NumAssists == nil or self.NumAssists ~= self.Player:GetNWInt("Assists", 0)) then
            self.NumAssists = self.Player:GetNWInt("Assists", 0)
            self.ScoreAssists:SetText(self.NumAssists)
        end

        if (self.NumDeaths == nil or self.NumDeaths ~= self.Player:Deaths()) then
            self.NumDeaths = self.Player:Deaths()
            self.Deaths:SetText(self.NumDeaths)
        end

        if (self.NumPing == nil or self.NumPing ~= self.Player:Ping()) then
            self.NumPing = self.Player:Ping()
            self.Ping:SetText(self.NumPing)
        end

        --
        -- Change the icon of the mute button based on state
        --
        if (self.Muted == nil or self.Muted ~= self.Player:IsMuted()) then
            self.Muted = self.Player:IsMuted()

            if (self.Muted) then
                self.Mute:SetImage("vgui/tdm/muted.png")
            else
                self.Mute:SetImage("vgui/tdm/unmuted.png")
            end

            self.Mute.DoClick = function()
                self.Player:SetMuted(not self.Muted)
            end
        end

        -- Spectating players go at the very bottom
        if (self.Player:Team() == TEAM_SPEC) then
            self:SetZPos(5000)
        end

        --
        -- This is what sorts the list. The panels are docked in the z order,
        -- so if we set the z order according to kills they'll be ordered that way!
        -- Careful though, it's a signed short internally, so needs to range between -32,768k and +32,767
        --
        -- Put team with most frags on top.
        local redTeamFrags = team.TotalFrags(TEAM_RED)
        local blueTeamFrags = team.TotalFrags(TEAM_BLUE)

        if redTeamFrags >= blueTeamFrags then
            if (self.Player:Team() == TEAM_RED) then
                self:SetZPos((self.NumKills * -10))
            elseif (self.Player:Team() == TEAM_BLUE) then
                self:SetZPos((self.NumKills * -10) + 2000)
            end
        else
            if (self.Player:Team() == TEAM_BLUE) then
                self:SetZPos((self.NumKills * -10))
            elseif (self.Player:Team() == TEAM_RED) then
                self:SetZPos((self.NumKills * -10) + 2000)
            end
        end
    end,
    Paint = function(self, w, h)
        if (not IsValid(self.Player)) then return end

        --
        -- We draw our background a different colour based on the status of the player
        --
        if (self.Player:Team() == TEAM_SPEC) then
            draw.RoundedBox(2, 0, 0, w, h, Color(150, 150, 150, 150))

            return
        end

        if (self.Player:Team() == TEAM_RED) then
            --draw.RoundedBox( 2, 0, 0, w, h, Color( 235, 60, 60, 220 ) )
            if self.Player:Alive() then
                draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 100))
                draw.RoundedBox(2, 0, 0, w, h, Color(235, 60, 60, 150))
            else
                draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 100))
                draw.RoundedBox(2, 0, 0, w, h, Color(235, 60, 60, 60))
            end

            return
        end

        if (self.Player:Team() == TEAM_BLUE) then
            --draw.RoundedBox( 2, 0, 0, w, h, Color( 60, 60, 235, 220 ) )
            if self.Player:Alive() then
                draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 100))
                draw.RoundedBox(2, 0, 0, w, h, Color(60, 60, 235, 150))
            else
                draw.RoundedBox(2, 0, 0, w, h, Color(40, 40, 40, 100))
                draw.RoundedBox(2, 0, 0, w, h, Color(60, 60, 235, 60))
            end

            return
        end
    end
}

--
-- Convert it from a normal table into a Panel Table based on DPanel
--
PLAYER_LINE = vgui.RegisterTable(PLAYER_LINE, "DPanel")

--
-- Here we define a new panel table for the scoreboard. It basically consists
-- of a header and a scrollpanel - into which the player lines are placed.
--
local SCORE_BOARD = {
    Init = function(self)
        self.Header = self:Add("Panel")
        self.Header:Dock(TOP)
        self.Header:SetHeight(80)
        self.Name = self.Header:Add("DLabel")
        self.Name:SetFont("ScoreboardDefaultTitle")
        self.Name:SetTextColor(Color(255, 255, 255, 255))
        self.Name:Dock(TOP)
        self.Name:SetHeight(40)
        self.Name:SetContentAlignment(5)
        self.Name:SetExpensiveShadow(1, Color(0, 0, 0, 200))

        function self.Name:Paint(w, h, ply)
            --draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
            draw.SimpleText(GetHostName(), "ScoreboardDefaultTitleShadow", 351, 21, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(GetHostName(), "ScoreboardDefaultTitle", 350, 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        self.Other = self.Header:Add("DLabel")
        self.Other:SetFont("ScoreboardDefaultTitle")
        self.Other:SetTextColor(Color(255, 255, 255, 255))
        self.Other:Dock(BOTTOM)
        self.Other:SetContentAlignment(5)
        self.Other:SetHeight(40)

        function self.Other:Paint(w, h, ply)
            --draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 250, 0, 200 ) )
            local scoreName = "Player"
            local scoreKills = "Kills"
            local scoreAssists = "Assists"
            local scoreDeaths = "Deaths"
            local scorePing = "Ping"
            --DropShadows
            draw.DrawText(scoreName, "ScoreboardHeadingShadow", 44 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_LEFT)
            draw.DrawText(scoreKills, "ScoreboardHeadingShadow", 393 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
            draw.DrawText(scoreAssists, "ScoreboardHeadingShadow", 473 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
            draw.DrawText(scoreDeaths, "ScoreboardHeadingShadow", 552 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
            draw.DrawText(scorePing, "ScoreboardHeadingShadow", 632 + 1, 11, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER)
            draw.DrawText(scoreName, "ScoreboardHeading", 44, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
            draw.DrawText(scoreKills, "ScoreboardHeading", 393, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(scoreAssists, "ScoreboardHeading", 473, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(scoreDeaths, "ScoreboardHeading", 552, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(scorePing, "ScoreboardHeading", 632, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        end

        self.Scores = self:Add("DScrollPanel")
        self.Scores:Dock(FILL)
    end,
    PerformLayout = function(self)
        self:SetSize(700, ScrH() - 200)
        self:SetPos(ScrW() / 2 - 350, 100)
    end,
    Paint = function(self, w, h) end,
    --draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
    Think = function(self, w, h)
        self.Name:SetText("")
        self.Other:SetText("")
        --
        -- Loop through each player, and if one doesn't have a score entry - create it.
        --
        local plyrs = player.GetAll()

        for id, pl in pairs(plyrs) do
            if (IsValid(pl.ScoreEntry)) then continue end
            pl.ScoreEntry = vgui.CreateFromTable(PLAYER_LINE, pl.ScoreEntry)
            pl.ScoreEntry:Setup(pl)
            self.Scores:AddItem(pl.ScoreEntry)
        end
    end
}

SCORE_BOARD = vgui.RegisterTable(SCORE_BOARD, "EditablePanel")

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardShow( )
	Desc: Sets the scoreboard to visible
-----------------------------------------------------------]]
function GM:ScoreboardShow()
    if (not IsValid(g_Scoreboard)) then
        g_Scoreboard = vgui.CreateFromTable(SCORE_BOARD)
    end

    if (IsValid(g_Scoreboard)) then
        g_Scoreboard:Show()
        g_Scoreboard:MakePopup()
        g_Scoreboard:SetKeyboardInputEnabled(false)
    end
end

--[[---------------------------------------------------------
	Name: gamemode:ScoreboardHide( )
	Desc: Hides the scoreboard
-----------------------------------------------------------]]
function GM:ScoreboardHide()
    if (IsValid(g_Scoreboard)) then
        g_Scoreboard:Hide()
    end
end

--[[---------------------------------------------------------
	Name: gamemode:HUDDrawScoreBoard( )
	Desc: If you prefer to draw your scoreboard the stupid way (without vgui)
-----------------------------------------------------------]]
function GM:HUDDrawScoreBoard()
end