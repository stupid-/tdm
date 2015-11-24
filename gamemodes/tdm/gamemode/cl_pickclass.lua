function pickClass( ply )
	local ChooseClassFrame = vgui.Create( "DFrame" )
	ChooseClassFrame:SetSize(ScrW()*0.6, ScrH()*0.6)
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
	ChooseTeamSheet:SetSize(ScrW()*0.6, ScrH()*0.6)
	ChooseTeamSheet.Paint = function()
		--draw.RoundedBox( 8, 0, 0, ChooseTeamSheet:GetWide(), ChooseTeamSheet:GetTall(), Color(40,40,40,155))
	end

	cc = -1
	for _, classes in pairs(PlayerClasses) do
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

function pickLoadout( ply, tbl )

	PlayerLevelCheck = ply:GetNWInt( "Level", 1 )

	local model_dir = "models/player/"
	local material_dir = "vgui/ttt/"

	local ChooseLoadoutFrame = vgui.Create( "DFrame" )
	ChooseLoadoutFrame:SetSize(ScrW()*0.6, ScrH()*0.6)
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

	local combobox = vgui.Create( "DComboBox" )
	combobox:SetParent(ChooseLoadoutSheet)
	combobox:SetPos(5, 30)
	combobox:SetSize(200,30)
	combobox:SetValue( "Default (Scout)" )
	for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

		if ( (tonumber(equip.required_level) <= tonumber(PlayerLevelCheck)) ) then

			combobox:AddChoice( equip.name, equip.weapon_tag )

		end

		if ( tonumber(equip.required_level) == 0 ) then

			combobox:ChooseOption( equip.name )

			PWeapon = equip.weapon_tag
			PWeaponAmmo = equip.starting_ammo
			PWeaponAmmoType = equip.starting_ammo_type

		end
	end
	combobox.OnSelect = function( panel, index, value, data)

		PWeapon = data
		for k, equip in pairs(ClassLoadouts[tbl]["PrimaryWeapons_tbl"]) do

			if equip.weapon_tag == PWeapon then 

				PWeaponAmmo = equip.starting_ammo
				PWeaponAmmoType = equip.starting_ammo_type

			end

		end
		
		--print( value .." was selected! Also known as ".. data )

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

		if ( tonumber(equip.required_level) == 0 ) then

			combobox2:ChooseOption( equip.name )

			SWeapon = equip.weapon_tag
			SWeaponAmmo = equip.starting_ammo
			SWeaponAmmoType = equip.starting_ammo_type

		end

	end
	combobox2.OnSelect = function( panel, index, value, data )

		SWeapon = data

		for k, equip in pairs(ClassLoadouts[tbl]["SecondaryWeapons_tbl"]) do

			if equip.weapon_tag == SWeapon then 

				SWeaponAmmo = equip.starting_ammo
				SWeaponAmmoType = equip.starting_ammo_type

			end

		end

		--print( value .." was selected! Also known as ".. data )

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

		if ( tonumber(equip.required_level) == 0 ) then

			combobox3:ChooseOption( equip.name )

			GWeapon = equip.weapon_tag

		end

	end
	combobox3.OnSelect = function( panel, index, value, data )

		GWeapon = data

		--print( value .." was selected! Also known as ".. data )

	end

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

		--print( SClass .. ", " .. PWeapon .. ", " .. SWeapon .. ", " .. GWeapon )

		--PrintTable( tbl )

		net.Start( "PickLoadout" )
			net.WriteTable( tbl )
		net.SendToServer()

		ChooseLoadoutFrame:Close()

	end

end

concommand.Add("pickClass", pickClass)