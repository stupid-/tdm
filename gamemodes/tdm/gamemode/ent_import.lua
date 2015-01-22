--Code copied from TTT, ent_replace.lua
--Need this to read map spawn points and create the spawn entities 

ents.TDM = {}

local table = table
local pairs = pairs

local function CreateImportedEnt(cls, pos, ang, kv)
   if not cls or not pos or not ang or not kv then return false end

   local ent = ents.Create(cls)
   if not IsValid(ent) then return false end
   ent:SetPos(pos)
   ent:SetAngles(ang)

   for k,v in pairs(kv) do
      ent:SetKeyValue(k, v)
   end

   ent:Spawn()

   ent:PhysWake()

   return true
end

function ents.TDM.CanImportEntities( map )
	if not tostring( map ) then return false end

	local filename = "maps/" .. map .. "_tdm.txt"

	return file.Exists( filename, "GAME" )

end

local function ImportEntities( map )

	if not ents.TDM.CanImportEntities( map ) then return end

	local filename = "maps/" .. map .. "_tdm.txt"

	local buf = file.Read( filename, "GAME" )
	local lines = string.Explode( "\n", buf )
	local num = 0

	for k, line in ipairs(lines) do
		if (not string.match(line, "^#")) and (not string.match(line, "^setting")) and line != "" and string.byte(line) != 0 then

			local data = string.Explode("\t", line)

			local fail = true -- pessimism

			if data[2] and data[3] then
				local cls = data[1]
				local ang = nil
				local pos = nil

				local posraw = string.Explode(" ", data[2])
				pos = Vector(tonumber(posraw[1]), tonumber(posraw[2]), tonumber(posraw[3]))

				local angraw = string.Explode(" ", data[3])
				ang = Angle(tonumber(angraw[1]), tonumber(angraw[2]), tonumber(angraw[3]))

	            local kv = {}
	            if data[4] then
	                local kvraw = string.Explode(" ", data[4])
	                local key = kvraw[1]
	                local val = tonumber(kvraw[2])

	                if key and val then
	                	kv[key] = val
	                end
	            end

				-- Some dummy ents remap to different, real entity names
				fail = not CreateImportedEnt(cls, pos, ang, kv)
			end



			if fail then
				ErrorNoHalt("Invalid line " .. k .. " in " .. filename .. "\n")
			else
				num = num + 1
			end
		end
	end

	MsgN("Spawned " .. num .. " entities found in script.")

	return true

end


function ents.TDM.ProcessImportScript( map )
	MsgN("Custom spawn placements found, attempting import...")

	local result = ImportEntities( map )

	if result then
		MsgN("Custom spawns imported successfully!")
	else
		ErrorNoHalt("Spawn import has failed!\n")
	end

end