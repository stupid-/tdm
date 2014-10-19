include( "shared.lua" )

--Vgui elements
include( "cl_menus.lua" )
include( "cl_hud.lua" )
include( "cl_welcome.lua" )
include( "cl_pickclass.lua" )
include( "mapvote/cl_mapvote.lua" )

--Classes
include( "player_class/noclass.lua" )
include( "player_class/assault.lua" )
include( "player_class/infantry.lua" )

--not my code, displaying hand models
function GM:PostDrawViewModel( vm, ply, weapon )

	if ( weapon.UseHands || !weapon:IsScripted() ) then

    	local hands = LocalPlayer():GetHands()
    	
    	if ( IsValid( hands ) ) then hands:DrawModel() end

	end

end