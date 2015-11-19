------------------------------------------
--			Class Switching				--
------------------------------------------

function classReset( ply )

	ply:SetPData("Player_Class", "noclass" )
	ply:SetPData("Player_PickedClass", "noclass" )

end

--Not entirely necessary anymore
function classSelected( ply, class )

	if (ply:GetPData("Player_Class", "noclass" ) == "noclass") then
		if ply:Alive() then 
			ply:Kill() 
		end

		ply:StripWeapons()
		ply:Spawn()		
	end

end

function classUpdate( ply, class )

	ply:SetPData("Player_Class", class)

end

net.Receive( "PickLoadout", function( len, ply )

	local tbl = net.ReadTable()

	ply:SetPData("Player_PickedClass", tbl.class or "noclass")
	ply:SetPData("Player_Primary", tbl.primary or "")
	ply:SetPData("Player_Primary_Ammo", tbl.primary_ammo or "")
	ply:SetPData("Player_Primary_Ammo_Type", tbl.primary_ammo_type or "")
	ply:SetPData("Player_Secondary", tbl.secondary or "")
	ply:SetPData("Player_Secondary_Ammo", tbl.secondary_ammo or "")
	ply:SetPData("Player_Secondary_Ammo_Type", tbl.secondary_ammo_type or "")
	ply:SetPData("Player_Grenade", tbl.grenade or "")

	classSelected ( ply, tbl.class )

end )