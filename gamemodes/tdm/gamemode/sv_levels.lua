local ply = FindMetaTable("Player")

function ply:GetLevel()

	local savedLevel = self:GetPData( "tdm_player_level", 1 )

	self:SetNWInt( "Level", savedLevel )

	print( self:Nick() .. " is level " .. savedLevel )

end

function ply:GetXP()

	local savedXP = self:GetPData( "tdm_player_xp", 0 )

	print( self:Nick() .. " has " .. savedXP .. " xp.")

	self:SetNWInt( "Level_xp", savedXP )

end

function ply:GetReqXP()

	local getLevel = self:GetNWInt( "Level", 1 )

	local levelMultiplier = ( ( 500 ) + ( 100 * getLevel ) + ( 100 * getLevel * 2 ) + ( getLevel * 100) )  

	--local levelMultiplier = ( ( ( 1000 * ( getLevel ) ) + ( 100 * getLevel * getLevel ) ) * 2 )

	self:SetNWInt( "Level_xp_max", levelMultiplier )

	self:SetPData( "tdm_player_xp_req", levelMultiplier )

	print( self:Nick() .. " needs " .. levelMultiplier .. " xp to level.")

end

function ply:AddXP( amount )
	local playerLevel = self:GetNWInt( "Level", 1 )
	local savedXP = self:GetNWInt( "Level_xp", 0 )
	local maxXP = self:GetNWInt( "Level_xp_max", 100 )

	if ( not IsValid(self) ) or ( not amount ) or ( not playerLevel ) or ( not savedXP ) then return end

	amount = tonumber( amount )

	roundBasedXP = self:SetPData( "Level_xp_round", self:GetPData( "Level_xp_round", 0 ) + amount )

	local newXP = savedXP + amount

	if ( newXP >= maxXP && tonumber( playerLevel ) < 56 ) then

		--local carryOverXP = newXP - maxXP

		local carryOverXP = 0

		self:SetNWInt( "Level", playerLevel + 1 )
		self:SetPData( "tdm_player_level", playerLevel + 1 )

		self:GetReqXP()

		umsg.Start( "Level_Up_Baby", self )
			umsg.Float( self:GetPData( "tdm_player_level" ) )
		umsg.End()

		if carryOverXP > 0 then

			self:SetNWInt( "Level_xp", carryOverXP )
			self:SetPData( "tdm_player_xp", carryOverXP )

			print( self:Nick() .. " has " .. carryOverXP .. " xp out of " .. maxXP .. "." )

		else

			self:SetNWInt( "Level_xp", 0 )
			self:SetPData( "tdm_player_xp", 0 )

			print( self:Nick() .. " has 0 xp out of " .. maxXP .. "." )

		end

	elseif ( tonumber( playerLevel ) >= 55 ) then

		--Nothing for now

	else

		self:SetNWInt( "Level_xp", newXP )
		self:SetPData( "tdm_player_xp", newXP )

		print( self:Nick() .. " has " .. newXP .. " xp out of " .. maxXP .. "." )

	end

end