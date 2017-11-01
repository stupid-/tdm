hook.Add( "KeyPress", "StaminaBarStuff", function( ply, key ) 

	if ( ply.moveFoward == true or 
		ply.moveBack == true or 
		ply.moveLeft == true or 
		ply.moveRight == true ) then
		ply.moving = true
	else 
		ply.moving = false
	end

	if key == IN_DUCK then ply.ducking = true end

	if key == IN_FORWARD then ply.moveFoward = true
	elseif key == IN_BACK then ply.moveBack = true
	elseif key == IN_MOVELEFT then ply.moveLeft = true
	elseif key == IN_MOVERIGHT then ply.moveRight = true end

	if ( key == IN_SPEED && ply:Alive() ) then 

		ply.RunSpeed = ply:GetRunSpeed()
		ply.LocalWalkSpeed = ply.ClassWalkSpeed

		if ( ply:SteamID64() == nil ) then

			ply.StaminaDelay = "StamDelay_" .. ply:Nick()
			ply.StaminaActive = "StamActive_" .. ply:Nick()
			ply.StaminaRegen = "StamRegen_" .. ply:Nick()

		else 

			ply.StaminaDelay = "StamDelay_" .. ply:SteamID64()
			ply.StaminaActive = "StamActive_" .. ply:SteamID64()
			ply.StaminaRegen = "StamRegen_" .. ply:SteamID64()

		end

		timer.Create ( ply.StaminaActive, 0.05, 0, function() 

			if ( ply.moveFoward == true or 
				ply.moveBack == true or 
				ply.moveLeft == true or 
				ply.moveRight == true ) then
				ply.moving = true
			else 
				ply.moving = false
			end

			if ( ply.ducking == true ) then 

				ply:SetRunSpeed( ply.LocalWalkSpeed )
				timer.Remove( ply.StaminaActive )

			end

			if ( ply.Stamina > 0 && ply.moving == true && ply.ducking == false ) then

				timer.Remove( ply.StaminaDelay )
				timer.Remove( ply.StaminaRegen )
				ply.Stamina = ply.Stamina - 1
				ply:SetNWInt( "Stamina", ply.Stamina )

				if ( ply.RunSpeed == ply.LocalWalkSpeed ) then
					ply:SetRunSpeed( ply.ClassRunSpeed )
				end

			end

			if ( ply.Stamina == 0 ) then
				ply:SetRunSpeed( ply.LocalWalkSpeed )
			end

		end )

	end

	if ( key == IN_JUMP ) then

		ply.Stamina = ply.Stamina - 5

		if ply.Stamina < 0 then

			ply.Stamina = 0

		end

		ply:SetNWInt( "Stamina", ply.Stamina )

	end		

end )

hook.Add( "KeyRelease", "StaminaBarOtherStuff", function( ply, key ) 

	if key == IN_DUCK then ply.ducking = false end

	if key == IN_FORWARD then ply.moveFoward = false
	elseif key == IN_BACK then ply.moveBack = false
	elseif key == IN_MOVELEFT then ply.moveLeft = false
	elseif key == IN_MOVERIGHT then ply.moveRight = false end

	if ( ply.moveFoward == true or 
		ply.moveBack == true or 
		ply.moveLeft == true or 
		ply.moveRight == true ) then
		ply.moving = true
	else 
		ply.moving = false
	end

	if ( key == IN_SPEED && ply:Alive() ) then 

		timer.Remove( ply.StaminaActive )

		timer.Create( ply.StaminaDelay, 1, 1, function()

			timer.Create( ply.StaminaRegen, 0.065, 0, function() 

				if ( ply.Stamina != 100 ) then

					ply.Stamina = ply.Stamina + 1
					ply:SetNWInt( "Stamina", ply.Stamina )

				end

			end )

		end )
		
	end

end )

hook.Add( "PlayerSpawn", "StaminaSetOnSpawn", function( ply ) 

	ply.ducking = false

	currentPlayerClass = ply:GetPData( "Player_Class" )

	for k, class in pairs( PlayerClasses ) do

		if class.name == currentPlayerClass then

			ply.ClassWalkSpeed = class.walkSpeed
			ply.ClassRunSpeed = class.runSpeed

			break

		else 

			ply.ClassWalkSpeed = 200
			ply.ClassRunSpeed = 290

		end

	end


	ply.Stamina = 100
	ply:SetNWInt( "Stamina", ply.Stamina )

	ply:SetRunSpeed( ply.ClassRunSpeed )
	ply:SetWalkSpeed( ply.ClassWalkSpeed )


end )

hook.Add( "PlayerDisconnected", "StaminaDisconnectDestroy", function( ply ) 

	timer.Remove( ply.StaminaActive )
	timer.Remove( ply.StaminaDelay )
	timer.Remove( ply.StaminaRegen )

end )