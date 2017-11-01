include("shared.lua")

--Vgui elements
include("cl_menus.lua")
include("cl_hud.lua")
include("cl_welcome.lua")
include("cl_welcome2.lua")
include("cl_pickclass.lua")
include("cl_voice.lua")
include("cl_scoreboard.lua")
include("cl_targetid.lua")
include("cl_deathnotice.lua")
include("cl_deathscreen.lua")
include("cl_levels.lua")
include("cl_notify.lua")
include("cl_admin.lua")
include("cl_wpnswitch.lua")
include("mapvote/cl_mapvote.lua")

--Class Config
include("config/loadout_config.lua")

function GM:Tick()
	local ply = LocalPlayer()

	if IsValid( ply ) then

		if ply:Alive() and ply:Team() != TEAM_SPEC then

			WSWITCH:Think()

		end

	end
end

--OVERRIDE
function GM:PlayerBindPress(ply, bind, pressed)
	if not IsValid(ply) then return end

	if bind == "invnext" and pressed then
		if ply:Team() == TEAM_SPEC then
			--Do Nothing
		else
			WSWITCH:SelectNext()
		end

    	return true
	elseif bind == "invprev" and pressed then
      if ply:Team() == TEAM_SPEC then
        	--Do Nothing
      else
        WSWITCH:SelectPrev()
      end
      return true
   elseif bind == "+attack" then
      if WSWITCH:PreventAttack() then
         if not pressed then
            WSWITCH:ConfirmSelection()
         end
         return true
      end
   elseif string.sub(bind, 1, 4) == "slot" and pressed then
      local idx = tonumber(string.sub(bind, 5, -1)) or 1
      WSWITCH:SelectSlot(idx)

      return true
   end
end