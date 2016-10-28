local ply = FindMetaTable("Player")

------------------------------------------
--	How much DMG is Taken		--
------------------------------------------
-- Feel Free to Modify based on gameplay needs
function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
    -- Headshot Damage multiplyer
    ply.was_headshot = false

    if (hitgroup == HITGROUP_HEAD) then
        ply.was_headshot = true
        dmginfo:ScaleDamage(3.25)
    end

    -- Damage Taken To Centre of Mass
    if (hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH) then
        ply.was_headshot = false
        dmginfo:ScaleDamage(1.5)
    end

    -- Tamage taken if hit in limbs
    if (hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_GEAR) then
        ply.was_headshot = false
        dmginfo:ScaleDamage(1)
    end
end

------------------------------------------
--	Death Sounds						--
------------------------------------------
-- Thank you TTT
local deathsounds = {Sound("player/death1.wav"), Sound("player/death2.wav"), Sound("player/death3.wav"), Sound("player/death4.wav"), Sound("player/death5.wav"), Sound("player/death6.wav"), Sound("vo/npc/male01/pain07.wav"), Sound("vo/npc/male01/pain08.wav"), Sound("vo/npc/male01/pain09.wav"), Sound("vo/npc/male01/pain04.wav"), Sound("vo/npc/Barney/ba_pain06.wav"), Sound("vo/npc/Barney/ba_pain07.wav"), Sound("vo/npc/Barney/ba_pain09.wav"), Sound("vo/npc/Barney/ba_ohshit03.wav"), Sound("vo/npc/Barney/ba_no01.wav"), Sound("vo/npc/male01/no02.wav"), Sound("hostage/hpain/hpain1.wav"), Sound("hostage/hpain/hpain2.wav"), Sound("hostage/hpain/hpain3.wav"), Sound("hostage/hpain/hpain4.wav"), Sound("hostage/hpain/hpain5.wav"), Sound("hostage/hpain/hpain6.wav")}

local function PlayDeathSound(victim)
    if not IsValid(victim) then return end
    sound.Play(table.Random(deathsounds), victim:GetShootPos(), 90, 100)
end

--Don't play shitty hl2 beep when death occurs
function GM:PlayerDeathSound()
    return true
end

------------------------------------------
--	When the player dies				--
------------------------------------------
function GM:PlayerDeathThink(ply)
    if (ply.NextSpawnTime and ply.NextSpawnTime > CurTime()) then return end

    if (ply:KeyPressed(IN_ATTACK) or ply:KeyPressed(IN_ATTACK2) or ply:KeyPressed(IN_JUMP) and (ply:GetPData("Player_Class", "noclass") ~= "noclass")) then
        ply:Spawn()
    end

    -- Forced Player Respawn, Can't afk dead
    if (not ply:Alive() and (ply.NextSpawnTime + TDM_ForceRespawnDelay) < CurTime() and (ply:GetPData("Player_Class", "noclass") ~= "noclass")) then
        ply:Spawn()
    end
end

util.AddNetworkString("PlayerKilledSelf")
util.AddNetworkString("PlayerKilledByPlayer")
util.AddNetworkString("PlayerKilled")

function GM:PlayerDeath(ply, inflictor, attacker)
    local roundState = GetGlobalInt("TDM_RoundState")
    ply.NextSpawnTime = CurTime() + TDM_RespawnDelay -- Default 3 Seconds to respawn
    ply.DeathTime = CurTime()

    if (roundState == ROUND_IN_PROGRESS) then
        ply:SetPData("tdm_stats_deaths", (ply:GetPData("tdm_stats_deaths", 0) + 1))
        MsgN(ply:Nick() .. "s deaths: " .. ply:GetPData("tdm_stats_deaths", 0))
    end

    if (not ply.was_headshot and attacker:IsPlayer()) then
        PlayDeathSound(ply)
    end

    if (IsValid(attacker) and attacker:GetClass() == "trigger_hurt") then
        attacker = ply
    end

    if (IsValid(attacker) and attacker:IsVehicle() and IsValid(attacker:GetDriver())) then
        attacker = attacker:GetDriver()
    end

    if (not IsValid(inflictor) and IsValid(attacker)) then
        inflictor = attacker
    end

    if (IsValid(inflictor) and inflictor == attacker and (inflictor:IsPlayer() or inflictor:IsNPC())) then
        inflictor = inflictor:GetActiveWeapon()

        if (not IsValid(inflictor)) then
            inflictor = attacker
        end
    end

    if (attacker == ply) then
        net.Start("PlayerKilledSelf")
        net.WriteEntity(ply)
        net.Broadcast()
        MsgAll(attacker:Nick() .. " suicided!\n")
        --Issue of players suiciding with grenades to force team loss
        ply.SuicideCount = ply.SuicideCount + 1

        if (ply.SuicideCount >= 3) then
            ply:Ban(10, false)
            ply:Kick("Banned for 10 minutes. Reason: Forcing team loss.")
        end

        return
    end

    if (attacker:IsPlayer()) then
        net.Start("PlayerKilledByPlayer")
        net.WriteEntity(ply)
        net.WriteString(inflictor:GetClass())
        net.WriteEntity(attacker)
        net.WriteBit(ply.was_headshot)
        net.Broadcast()
        MsgAll(attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n")

        if (roundState == ROUND_IN_PROGRESS) then
            attacker:SetPData("tdm_stats_kills", (attacker:GetPData("tdm_stats_kills", 0) + 1))
            MsgN(attacker:Nick() .. "s kills: " .. attacker:GetPData("tdm_stats_kills", 0))

            if ply.was_headshot then
                attacker:AddXP(500)
                attacker:SetPData("tdm_stats_headshot", (attacker:GetPData("tdm_stats_headshot", 0) + 1))
                MsgN(attacker:Nick() .. "s headshots: " .. attacker:GetPData("tdm_stats_headshot", 0))
            else
                attacker:AddXP(250)
            end

            local deathPos = ply:GetPos()
            local deathAng = ply:GetAngles()
            CreateAmmoOnDeath(deathPos, deathAng)
        end

        if ply.was_headshot then
            umsg.Start("Headshot_Death", attacker)
            umsg.End()
        end

        return
    end

    net.Start("PlayerKilled")
    net.WriteEntity(ply)
    net.WriteString(inflictor:GetClass())
    net.WriteString(attacker:GetClass())
    net.Broadcast()
    MsgAll(ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n")
end

function CreateAmmoOnDeath(pos, ang)
    local ammo_types = {"item_ammo_357_ttt", "item_ammo_pistol_ttt", "item_ammo_smg1_ttt", "item_box_buckshot_ttt", "item_ammo_revolver_ttt"}
    pos = pos + Vector(0, 0, 20)
    local ent = ents.Create(table.Random(ammo_types))
    if not IsValid(ent) then return end
    ent:SetPos(pos)
    ent:SetAngles(ang)
    ent:Spawn()
    ent:PhysWake()

    timer.Simple(45, function()
        if ent:IsValid() then
            ent:Remove()
        end
    end)
end

--Stop the pickup of props
function GM:AllowPlayerPickup(ply, object)
    return false
end

hook.Add("PlayerDisconnected", "HealthRegenDestruction", function(ply)
    timer.Remove(ply.RegenDelay)
    timer.Remove(ply.RegenActive)
    timer.Remove(ply.ResetValues)
end)

--Health Regen
hook.Add("PlayerHurt", "WhenHurtHealthRegen", function(ply, attacker)
    --Create unique id's for players who are hurt
    ply.RegenDelay = "Delay_" .. ply:SteamID64()
    ply.RegenActive = "Active_" .. ply:SteamID64()
    ply.ResetValues = "Values_" .. ply:SteamID64()
    --Stop Healing if Hurt
    timer.Remove(ply.RegenDelay)
    timer.Remove(ply.RegenActive)
    timer.Remove(ply.ResetValues)

    timer.Create(ply.ResetValues, 6, 1, function()
        --Reset Damage Table / Assists if no damage taken after 6 seconds.
        ply.EnemyAttackers = {}
        ply.DamageTable = nil
    end)

    --After 7 seconds of not being hurt
    timer.Create(ply.RegenDelay, 7, 1, function()
        --Start the healing over this interval
        timer.Create(ply.RegenActive, 0.10, 0, function()
            if (ply:Alive() and ply:Health() < 100) then
                ply:SetHealth(ply:Health() + 1)
            end

            if (not ply:Alive() or ply:Health() == 100) then
                timer.Remove(ply.RegenDelay)
                timer.Remove(ply.RegenActive)
            end
        end)
    end)
end)

--Assists Baby
hook.Add("PlayerHurt", "TDMAssists", function(victim, attacker, damageTaken)
    if (attacker:IsPlayer() and not table.HasValue(victim.EnemyAttackers, attacker)) then
        table.insert(victim.EnemyAttackers, attacker)
    end

    if attacker:IsPlayer() then
        victim.DamageTable = victim.DamageTable or {null, 0, 0}

        if victim.DamageTable[1] == attacker then
            victim.DamageTable[2] = victim.DamageTable[2] + 1
            victim.DamageTable[3] = victim.DamageTable[3] + damageTaken
        else
            victim.DamageTable[1] = attacker
            victim.DamageTable[2] = victim.DamageTable[2] + 1
            victim.DamageTable[3] = victim.DamageTable[3] + damageTaken
        end
    end
end)

--Add assists on death
hook.Add("PlayerDeath", "TDMAssistspt2", function(victim, inflictor, attacker)
    local roundState = GetGlobalInt("TDM_RoundState")

    for k, v in pairs(victim.EnemyAttackers) do
        if (v:Nick() ~= attacker:Nick() and roundState == ROUND_IN_PROGRESS) then
            v:SetNWInt("Assists", (v:GetNWInt("Assists", 0) + 1))
            table.RemoveByValue(victim.EnemyAttackers, v)
            v:SetPData("tdm_stats_assists", (v:GetPData("tdm_stats_assists", 0) + 1))
            MsgN(v:Nick() .. "s assists: " .. v:GetPData("tdm_stats_assists", 0))
            v:AddXP(50)
        end
    end

    --Death Message Incoming
    if attacker == inflictor and attacker == victim then
        victim.DamageTable = nil
    end

    if roundState == ROUND_IN_PROGRESS then --[[

		timer.Simple(0.1, function() 

			net.Start( "PlayerDeathMessage" )
				--send attacker
				net.WriteEntity( attacker )
				--send attacker team
				--net.WriteEntity( attacker:Team() )
				--send hits
				net.WriteInt( victim.DamageTable[2], 8 )
				--send damage
				net.WriteInt( math.Round( victim.DamageTable[3] ), 16 )

			net.Send( victim )

			victim.DamageTable = nil

		end )

		]] end
end)

--In case player dies from world
hook.Add("EntityTakeDamage", "TDMEntityDamageTable", function(ply, dmg)
    ply.DamageTable = ply.DamageTable or {null, 0, 0}

    if not dmg:GetAttacker():IsPlayer() then
        ply.DamageTable[1] = null
        ply.DamageTable[2] = ply.DamageTable[2] + 1
        ply.DamageTable[3] = ply.DamageTable[3] + dmg:GetDamage()
    end
end)