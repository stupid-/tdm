function pickClass( ply )
	local ChooseClassFrame = vgui.Create( "DFrame" )
	ChooseClassFrame:SetSize(520, ScrH()*0.5)
	ChooseClassFrame:SetTitle("Please Choose a Class.")
	ChooseClassFrame:Center()
	ChooseClassFrame:SetVisible( true )
	ChooseClassFrame:SetDraggable( false )
	ChooseClassFrame:ShowCloseButton( true )
	ChooseClassFrame:MakePopup()
	/*
	ChooseClassFrame.Paint = function()
	end
	*/

	local ChooseTeamSheet = vgui.Create( "DPropertySheet", ChooseClassFrame)
	ChooseTeamSheet:SetPos( 0, 25)
	ChooseTeamSheet:SetSize(520, ScrH()*0.5)
	ChooseTeamSheet.Paint = function()
		--draw.RoundedBox( 8, 0, 0, ChooseTeamSheet:GetWide(), ChooseTeamSheet:GetTall(), Color(40,40,40,155))
	end

	cc = -1
	for _, classes in pairs(PlayerClasses) do

		if TDM_TeamBasedClasses == false then
			cc = cc + 1

			local ClassButton = vgui.Create('DButton')
			ClassButton:SetParent(ChooseTeamSheet)
			ClassButton:SetSize(200, 30)
			ClassButton:SetPos(5, 0 + (cc*30))
			ClassButton:SetText( classes.displayName )
			ClassButton:SetDrawBackground(true)
			ClassButton.DoClick = function() 
				ClassLabel = classes.displayName
				SClass = classes.name
				ChooseClassFrame:Close()
				pickLoadout( ply, classes.name )
			end
		elseif (TDM_TeamBasedClasses == true) then
			if classes.team == nil or (classes.team != nil and classes.team == ply:Team() ) then
				print( ply:Team() )
				if (classes.team != nil) then
					print( classes.team )
				end

				cc = cc + 1

				local ClassButton = vgui.Create('DButton')
				ClassButton:SetParent(ChooseTeamSheet)
				ClassButton:SetSize(200, 30)
				ClassButton:SetPos(5, 0 + (cc*30))
				ClassButton:SetText( classes.displayName )
				ClassButton:SetDrawBackground(true)
				ClassButton.DoClick = function() 
					ClassLabel = classes.displayName
					SClass = classes.name
					ChooseClassFrame:Close()
					pickLoadout( ply, classes.name )
				end

			end
		end


	end

end

function pickLoadout( ply, tbl )

	PlayerLevelCheck = ply:GetNWInt( "Level", 1 )

	local model_dir = "models/player/"
	local material_dir = "vgui/ttt/"

	local ChooseLoadoutFrame = vgui.Create( "DFrame" )
	ChooseLoadoutFrame:SetSize( 520, ScrH()*0.5)
	ChooseLoadoutFrame:SetTitle("Choose a Loadout")
	ChooseLoadoutFrame:Center()
	ChooseLoadoutFrame:SetVisible( true )
	ChooseLoadoutFrame:SetDraggable( false )
	ChooseLoadoutFrame:ShowCloseButton( true )
	ChooseLoadoutFrame:MakePopup()

	local ChooseLoadoutSheet = vgui.Create( "DPropertySheet", ChooseLoadoutFrame)
	ChooseLoadoutSheet:SetPos( 0, 25)
	ChooseLoadoutSheet:SetSize(ScrW()*0.6, ScrH()*0.6)
	ChooseLoadoutSheet.Paint = function()
		
	end

	if file.Exists( "tdm/"..tbl..".txt", "DATA" ) == true then

		local data = file.Read( "tdm/"..tbl..".txt", "DATA" )
		savedData = string.Explode( "\n", data )
		--PrintTable( savedData )

	end

	local pWPanel = vgui.Create( "DPanel", ChooseLoadoutSheet )
	pWPanel:SetPos( 210, 0 )
	pWPanel:SetSize( 150, 150 )

	local primaryWpnPanel = vgui.Create( "DModelPanel", pWPanel )
	--primaryWpnPanel:SetParent(ChooseLoadoutFrame)
	primaryWpnPanel:SetPos( -80, -190 )
	primaryWpnPanel:SetSize( 300, 300 )
	function primaryWpnPanel:LayoutEntity( Entity ) return end


	local sWPanel = vgui.Create( "DPanel", ChooseLoadoutSheet )
	sWPanel:SetPos( 365, 0 )
	sWPanel:SetSize( 150, 150 )

	local secondaryWpnPanel = vgui.Create( "DModelPanel", sWPanel )
	--primaryWpnPanel:SetParent(ChooseLoadoutFrame)
	secondaryWpnPanel:SetPos( -80, -190 )
	secondaryWpnPanel:SetSize( 300, 300 )
	function secondaryWpnPanel:LayoutEntity( Entity ) return end
	--primaryWpnPanel:SetFOV(90)

	--function primaryWpnPanel:LayoutEntity( Entity ) return end

	--primaryWpnPanel:SetCamPos( Vector( 20, 20, 60 ) )
	--primaryWpnPanel:SetLookAt( Vector( 0, 0, 60 ) )


	--primaryWpnPanel:SetCamAng( Vector( 40, 40, 40 ) )
	--primaryWpnPanel:SetAnimated(false)


	local combobox = vgui.Create( "DComboBox" )
	combobox:SetParent(ChooseLoadoutSheet)
	combobox:SetPos(5, 30)
	combobox:SetSize(200,30)
	combobox:SetValue( "Default (Scout)" )
	for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

		if ( (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) ) then

			combobox:AddChoice( equip.name, equip.weapon_tag )

		end

		if ( (tonumber(equip.required_level) > tonumber(PlayerLevelCheck)) ) then

			combobox:AddChoice( equip.name .. " (Lvl " .. equip.required_level .. ")", -1 )

		end

		if ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == true ) then

			for k, v in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

				if savedData[2] == v.weapon_tag and tonumber(v.required_level) <= tonumber(ply:GetNWInt( "Level", 1 )) then

					foundName = v.name

					combobox:ChooseOption( foundName )

					PWeapon = savedData[2]
					PWeaponAmmo = v.starting_ammo
					PWeaponAmmoType = v.starting_ammo_type

					break
				else 

					combobox:ChooseOption( equip.name )

					PWeapon = equip.weapon_tag
					PWeaponAmmo = equip.starting_ammo
					PWeaponAmmoType = equip.starting_ammo_type

				end

			end

		elseif ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == false ) then

			foundName = equip.name

			combobox:ChooseOption( foundName )

			PWeapon = equip.weapon_tag
			PWeaponAmmo = equip.starting_ammo
			PWeaponAmmoType = equip.starting_ammo_type

		end

		primaryWpnPanel:SetModel( weapons.GetStored( PWeapon )['WorldModel'] )

	end
	combobox.OnSelect = function( panel, index, value, data)

		if ( data == -1 ) then

			combobox:ChooseOption( foundName )

			for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

				if equip.name == foundName then 

					PWeapon = equip.weapon_tag
					PWeaponAmmo = equip.starting_ammo
					PWeaponAmmoType = equip.starting_ammo_type



				end

			end			

		else

			PWeapon = data
			for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

				if equip.weapon_tag == PWeapon then 

					foundName = equip.name

					PWeaponAmmo = equip.starting_ammo
					PWeaponAmmoType = equip.starting_ammo_type

				end

			end	

			for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

				if (equip.weapon_tag == PWeapon) and (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) then

					primaryWpnPanel:SetModel( weapons.GetStored( PWeapon )['WorldModel'] )	

				end

			end

				

		end

	end

	local combobox2 = vgui.Create( "DComboBox" )
	combobox2:SetParent(ChooseLoadoutSheet)
	combobox2:SetPos(5,60)
	combobox2:SetSize(200,30)
	combobox2:SetValue( "Default (Silenced Pistol)" )
	for k, equip in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

		if ( (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) ) then

			combobox2:AddChoice( equip.name, equip.weapon_tag )

		end

		if ( (tonumber(equip.required_level) > tonumber(PlayerLevelCheck)) ) then

			combobox2:AddChoice( equip.name .. " (Lvl " .. equip.required_level .. ")", -1 )

		end

		if ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == true ) then

			for k, v in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

				if savedData[5] == v.weapon_tag and tonumber(v.required_level) <= tonumber(ply:GetNWInt( "Level", 1 )) then

					foundSName = v.name

					combobox2:ChooseOption( foundSName )

					SWeapon = savedData[5]
					SWeaponAmmo = v.starting_ammo
					SWeaponAmmoType = v.starting_ammo_type

					break

				else 

					foundSName = equip.name

					combobox2:ChooseOption( equip.name )

					SWeapon = equip.weapon_tag
					SWeaponAmmo = equip.starting_ammo
					SWeaponAmmoType = equip.starting_ammo_type

				end

			end

		elseif ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == false ) then

			combobox2:ChooseOption( equip.name )

			foundSName = equip.name

			SWeapon = equip.weapon_tag
			SWeaponAmmo = equip.starting_ammo
			SWeaponAmmoType = equip.starting_ammo_type

		end

		secondaryWpnPanel:SetModel( weapons.GetStored( SWeapon )['WorldModel'] )

	end
	combobox2.OnSelect = function( panel, index, value, data )

		if ( data == -1 ) then

			combobox2:ChooseOption( foundSName )

			for k, equip in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

				if equip.name == foundSName then 

					SWeapon = equip.weapon_tag
					SWeaponAmmo = equip.starting_ammo
					SWeaponAmmoType = equip.starting_ammo_type

				end

			end

		else

			SWeapon = data

			for k, equip in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

				if equip.weapon_tag == SWeapon then 

					SWeaponAmmo = equip.starting_ammo
					SWeaponAmmoType = equip.starting_ammo_type

				end

			end

			for k, equip in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

				if (equip.weapon_tag == SWeapon) and (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) then

					secondaryWpnPanel:SetModel( weapons.GetStored( SWeapon )['WorldModel'] )	

				end

			end


		end

	end

	local combobox3 = vgui.Create( "DComboBox" )
	combobox3:SetParent(ChooseLoadoutSheet)
	combobox3:SetPos(5,90)
	combobox3:SetSize(200,30)
	combobox3:SetValue( "Default (Smoke Grenade)" )
	for k, equip in pairs(ClassLoadouts[tbl]["TertiaryWeapons_tbl"]) do

		if ( (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) ) then

			combobox3:AddChoice( equip.name, equip.weapon_tag )

		end

		if ( (tonumber(equip.required_level) > tonumber(PlayerLevelCheck)) ) then

			combobox3:AddChoice( equip.name .. " (Lvl " .. equip.required_level .. ")", -1 )

		end

		if ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == true ) then

			for k, v in pairs(ClassLoadouts[tbl]["TertiaryWeapons_tbl"]) do

				if savedData[8] == v.weapon_tag and tonumber(v.required_level) <= tonumber(ply:GetNWInt( "Level", 1 )) then

					foundGName = v.name

					combobox3:ChooseOption( foundGName )

					GWeapon = savedData[8]

					break
				else

					foundGName = equip.name

					combobox3:ChooseOption( equip.name )

					GWeapon = equip.weapon_tag

				end

			end

		elseif ( tonumber(equip.required_level) == 0 and file.Exists( "tdm/"..tbl..".txt", "DATA" ) == false ) then

			combobox3:ChooseOption( equip.name )

			foundGName = equip.name

			GWeapon = equip.weapon_tag

		end

	end
	combobox3.OnSelect = function( panel, index, value, data )

		if ( data == -1 ) then

			combobox3:ChooseOption( foundGName )

			for k, equip in pairs(ClassLoadouts[tbl]["TertiaryWeapons_tbl"]) do

				if equip.name == foundGName then 

					GWeapon = equip.weapon_tag

				end

			end

		else

			GWeapon = data

		end

	end

	--PrintTable(weapons.GetStored( PWeapon ))

	local ClassButton = vgui.Create('DButton')
	ClassButton:SetParent(ChooseLoadoutSheet)
	ClassButton:SetSize(200, 30)
	ClassButton:SetPos(5, 0)
	ClassButton:SetText(ClassLabel)
	ClassButton:SetDisabled( true )
	ClassButton:SetDrawBackground(true)
	ClassButton.DoClick = function() 
	end

	local BackButton = vgui.Create('DButton')
	BackButton:SetParent(ChooseLoadoutSheet)
	BackButton:SetSize(100, 30)
	BackButton:SetPos(5, 120)
	BackButton:SetText('Back')
	BackButton:SetDrawBackground(true)
	BackButton.DoClick = function() 
		ChooseLoadoutFrame:Close()
		pickClass( ply )
	end

	local SelectButton = vgui.Create('DButton')
	SelectButton:SetParent(ChooseLoadoutSheet)
	SelectButton:SetSize(100, 30)
	SelectButton:SetPos(105, 120)
	SelectButton:SetText('Ok')
	SelectButton:SetDrawBackground(true)
	SelectButton.DoClick = function() 

		local tbl = {}
		tbl.class = SClass
		tbl.primary = PWeapon
		tbl.primary_ammo = PWeaponAmmo
		tbl.primary_ammo_type = PWeaponAmmoType
		tbl.secondary = SWeapon
		tbl.secondary_ammo = SWeaponAmmo
		tbl.secondary_ammo_type = SWeaponAmmoType
		tbl.grenade = GWeapon

		if file.Exists( "tdm", "DATA" ) == true then 
			file.Write( "tdm/"..SClass..".txt", tbl.class.."\n"..tbl.primary.."\n"..tbl.primary_ammo.."\n"..tbl.primary_ammo_type.."\n"..tbl.secondary.."\n"..tbl.secondary_ammo.."\n"..tbl.secondary_ammo_type.."\n"..tbl.grenade )
		else
			file.CreateDir( "tdm" )
			file.Write( "tdm/"..SClass..".txt", tbl.class.."\n"..tbl.primary.."\n"..tbl.primary_ammo.."\n"..tbl.primary_ammo_type.."\n"..tbl.secondary.."\n"..tbl.secondary_ammo.."\n"..tbl.secondary_ammo_type.."\n"..tbl.grenade )
		end

		--PrintTable( tbl )

		net.Start( "PickLoadout" )
			net.WriteTable( tbl )
		net.SendToServer()

		ChooseLoadoutFrame:Close()

	end

end

concommand.Add("pickClass", pickClass)