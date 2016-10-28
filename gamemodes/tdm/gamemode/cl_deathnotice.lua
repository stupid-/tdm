local hud_deathnotice_time = CreateConVar("hud_deathnotice_time", "6", FCVAR_REPLICATED, "Amount of time to show death notice")
-- These are our kill icons
local Color_Icon = Color(255, 80, 0, 255)
local NPC_Color = Color(250, 50, 50, 255)

surface.CreateFont("CSKillIcons", {
    font = "csd",
    size = 60,
    weight = 400,
    antialias = true,
    blur = 0.1,
    shadow = false
})

--Default Killicons
killicon.AddFont("prop_physics", "HL2MPTypeDeath", "9", Color_Icon)
killicon.AddFont("weapon_smg1", "HL2MPTypeDeath", "/", Color_Icon)
killicon.AddFont("weapon_357", "HL2MPTypeDeath", ".", Color_Icon)
killicon.AddFont("weapon_ar2", "HL2MPTypeDeath", "2", Color_Icon)
killicon.AddFont("crossbow_bolt", "HL2MPTypeDeath", "1", Color_Icon)
killicon.AddFont("weapon_shotgun", "HL2MPTypeDeath", "0", Color_Icon)
killicon.AddFont("rpg_missile", "HL2MPTypeDeath", "3", Color_Icon)
killicon.AddFont("npc_grenade_frag", "HL2MPTypeDeath", "4", Color_Icon)
killicon.AddFont("weapon_pistol", "HL2MPTypeDeath", "-", Color_Icon)
killicon.AddFont("prop_combine_ball", "HL2MPTypeDeath", "8", Color_Icon)
killicon.AddFont("grenade_ar2", "HL2MPTypeDeath", "7", Color_Icon)
killicon.AddFont("weapon_stunstick", "HL2MPTypeDeath", "!", Color_Icon)
killicon.AddFont("npc_satchel", "HL2MPTypeDeath", "*", Color_Icon)
killicon.AddFont("npc_tripmine", "HL2MPTypeDeath", "*", Color_Icon)
killicon.AddFont("weapon_physcannon", "HL2MPTypeDeath", ",", Color_Icon)
--CSS Killicons
killicon.AddFont("weapon_zm_improvised", "HL2MPTypeDeath", "6", Color_Icon)
killicon.AddFont("weapon_ttt_m16", "CSKillIcons", "w", Color_Icon)
killicon.AddFont("weapon_ttt_silm4a1", "CSKillIcons", "w", Color_Icon)
killicon.AddFont("weapon_ttt_ak47", "CSKillIcons", "b", Color_Icon)
killicon.AddFont("weapon_ttt_famas", "CSKillIcons", "t", Color_Icon)
killicon.AddFont("weapon_zm_rifle", "CSKillIcons", "n", Color_Icon)
killicon.AddFont("weapon_zm_shotgun", "CSKillIcons", "B", Color_Icon)
killicon.AddFont("weapon_ttt_pump", "CSKillIcons", "k", Color_Icon)
killicon.AddFont("weapon_zm_mac10", "CSKillIcons", "l", Color_Icon)
killicon.AddFont("weapon_ttt_galil", "CSKillIcons", "v", Color_Icon)
killicon.AddFont("weapon_ttt_sipistol", "CSKillIcons", "a", Color_Icon)
killicon.AddFont("weapon_zm_pistol", "CSKillIcons", "y", Color_Icon)
killicon.AddFont("weapon_ttt_glock", "CSKillIcons", "c", Color_Icon)
killicon.AddFont("weapon_ttt_famas", "CSKillIcons", "t", Color_Icon)
killicon.AddFont("weapon_ttt_g3", "CSKillIcons", "i", Color_Icon)
killicon.AddFont("weapon_ttt_sg550", "CSKillIcons", "o", Color_Icon)
killicon.AddFont("weapon_ttt_awp", "CSKillIcons", "r", Color_Icon)
killicon.AddFont("weapon_ttt_sg552", "CSKillIcons", "A", Color_Icon)
killicon.AddFont("weapon_ttt_mp5", "CSKillIcons", "x", Color_Icon)
killicon.AddFont("weapon_ttt_p90", "CSKillIcons", "m", Color_Icon)
killicon.AddFont("weapon_ttt_aug", "CSKillIcons", "e", Color_Icon)
killicon.AddFont("weapon_zm_revolver", "CSKillIcons", "f", Color_Icon)
killicon.AddFont("ttt_frag_proj", "CSKillIcons", "h", Color_Icon)
killicon.AddFont("headshot", "CSKillIcons", "D", Color_Icon)
local Deaths = {}

local function PlayerIDOrNameToString(var)
    if (type(var) == "string") then
        if (var == "") then return "" end

        return "#" .. var
    end

    local ply = Entity(var)
    if (not IsValid(ply)) then return "NULL!" end

    return ply:Name()
end

local function RecvPlayerKilledByPlayer()
    local victim = net.ReadEntity()
    local inflictor = net.ReadString()
    local attacker = net.ReadEntity()
    local was_headshot = net.ReadBit()
    if (not IsValid(attacker)) then return end
    if (not IsValid(victim)) then return end
    GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, victim:Name(), victim:Team(), was_headshot)
end

net.Receive("PlayerKilledByPlayer", RecvPlayerKilledByPlayer)

local function RecvPlayerKilledSelf()
    local victim = net.ReadEntity()
    if (not IsValid(victim)) then return end
    GAMEMODE:AddDeathNotice(nil, 0, "suicide", victim:Name(), victim:Team())
end

net.Receive("PlayerKilledSelf", RecvPlayerKilledSelf)

local function RecvPlayerKilled()
    local victim = net.ReadEntity()
    if (not IsValid(victim)) then return end
    local inflictor = net.ReadString()
    local attacker = "#" .. net.ReadString()
    GAMEMODE:AddDeathNotice(attacker, -1, inflictor, victim:Name(), victim:Team())
end

net.Receive("PlayerKilled", RecvPlayerKilled)

local function RecvPlayerKilledNPC()
    local victimtype = net.ReadString()
    local victim = "#" .. victimtype
    local inflictor = net.ReadString()
    local attacker = net.ReadEntity()
    --
    -- For some reason the killer isn't known to us, so don't proceed.
    --
    if (not IsValid(attacker)) then return end
    GAMEMODE:AddDeathNotice(attacker:Name(), attacker:Team(), inflictor, victim, -1)
    local bIsLocalPlayer = (IsValid(attacker) and attacker == LocalPlayer())
    local bIsEnemy = IsEnemyEntityName(victimtype)
    local bIsFriend = IsFriendEntityName(victimtype)

    if (bIsLocalPlayer and bIsEnemy) then
        achievements.IncBaddies()
    end

    if (bIsLocalPlayer and bIsFriend) then
        achievements.IncGoodies()
    end

    if (bIsLocalPlayer and (not bIsFriend and not bIsEnemy)) then
        achievements.IncBystander()
    end
end

net.Receive("PlayerKilledNPC", RecvPlayerKilledNPC)

local function RecvNPCKilledNPC()
    local victim = "#" .. net.ReadString()
    local inflictor = net.ReadString()
    local attacker = "#" .. net.ReadString()
    GAMEMODE:AddDeathNotice(attacker, -1, inflictor, victim, -1)
end

net.Receive("NPCKilledNPC", RecvNPCKilledNPC)

--[[---------------------------------------------------------
   Name: gamemode:AddDeathNotice( Victim, Attacker, Weapon )
   Desc: Adds an death notice entry
-----------------------------------------------------------]]
function GM:AddDeathNotice(Victim, team1, Inflictor, Attacker, team2, was_headshot)
    local Death = {}
    Death.victim = Victim
    Death.attacker = Attacker
    Death.time = CurTime()
    Death.left = Victim
    Death.right = Attacker
    Death.icon = Inflictor
    Death.headshot = was_headshot

    if (team1 == -1) then
        Death.color1 = table.Copy(NPC_Color)
    else
        Death.color1 = table.Copy(team.GetColor(team1))
    end

    if (team2 == -1) then
        Death.color2 = table.Copy(NPC_Color)
    else
        Death.color2 = table.Copy(team.GetColor(team2))
    end

    if (Death.left == Death.right) then
        Death.left = nil
        Death.icon = "suicide"
    end

    table.insert(Deaths, Death)
end

local function DrawDeath(x, y, death, hud_deathnotice_time)
    local w, h = killicon.GetSize(death.icon)
    if (not w or not h) then return end
    local fadeout = (death.time + hud_deathnotice_time) - CurTime()
    local alpha = math.Clamp(fadeout * 255, 0, 255)
    death.color1.a = alpha
    death.color2.a = alpha

    --Counter Strike: Source headshot looking killicon
    if death.headshot == 1 then
        local w2, h2 = killicon.GetSize("headshot")
        -- Draw Icon
        killicon.Draw(x - w2 + 16, y, death.icon, alpha)
        killicon.Draw(x + 16, y, "headshot", alpha)

        -- Draw KILLER
        if (death.left) then
            draw.SimpleText(death.left, "ChatFont", x - (w / 2) - 32 - (w2 / 2), y, death.color1, TEXT_ALIGN_RIGHT)
        end

        -- Draw VICTIM
        draw.SimpleText(death.right, "ChatFont", x + (w / 2) + 16, y, death.color2, TEXT_ALIGN_LEFT)
        -- Draw Icon
        -- Draw KILLER
        -- Draw VICTIM

        return (y + h * 0.70)
    else
        killicon.Draw(x, y, death.icon, alpha)

        if (death.left) then
            draw.SimpleText(death.left, "ChatFont", x - (w / 2) - 16, y, death.color1, TEXT_ALIGN_RIGHT)
        end

        draw.SimpleText(death.right, "ChatFont", x + (w / 2) + 16, y, death.color2, TEXT_ALIGN_LEFT)

        return (y + h * 0.70)
    end
end

function GM:DrawDeathNotice(x, y)
    if (GetConVarNumber("cl_drawhud") == 0) then return end
    local hud_deathnotice_time = hud_deathnotice_time:GetFloat()
    x = x * ScrW()
    y = y * ScrH()

    -- Draw
    for k, Death in pairs(Deaths) do
        if (Death.time + hud_deathnotice_time > CurTime()) then
            if (Death.lerp) then
                x = x * 0.3 + Death.lerp.x * 0.7
                y = y * 0.3 + Death.lerp.y * 0.7
            end

            Death.lerp = Death.lerp or {}
            Death.lerp.x = x
            Death.lerp.y = y
            y = DrawDeath(x, y, Death, hud_deathnotice_time)
        end
    end

    -- We want to maintain the order of the table so instead of removing
    -- expired entries one by one we will just clear the entire table
    -- once everything is expired.
    for k, Death in pairs(Deaths) do
        if (Death.time + hud_deathnotice_time > CurTime()) then return end
    end

    Deaths = {}
end