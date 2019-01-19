		local player = PlayerPedId()
		local inside = false
		local locked = false

Citizen.CreateThread(function()
	  	while true do
		    Citizen.Wait(5)

		    	player = PlayerPedId()
			local plyCoords = GetEntityCoords(player, false)
			local vehicle = VehicleInFront()

if IsDisabledControlPressed(0, 19) and IsDisabledControlJustReleased(1, 44) and GetVehiclePedIsIn(player, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
	if not inside then
		hideintrunk()
	elseif inside and not locked then
		outoftrunk()
	end
end

RegisterNetEvent('core:hideintrunk')
AddEventHandler('core:hideintrunk', function()
	hideintrunk()
local lockedmath = math.random(1, 100)
if lockedmath >= 60 then
	locked = false
	SetTextComponentFormat("STRING")
	AddTextComponentString('~INPUT_JUMP~ invisible ~n~~s~~INPUT_CHARACTER_WHEEL~+~INPUT_COVER~ get out')
	DisplayHelpTextFromStringLabel(0, 1, 1, -1)		
else
	locked = true
	SetTextComponentFormat("STRING")
	AddTextComponentString('~INPUT_JUMP~ invisible ~n~~r~ LOCKED')
	DisplayHelpTextFromStringLabel(0, 1, 1, -1)		
end	

end)	
RegisterNetEvent('core:outoftrunk')
AddEventHandler('core:outoftrunk', function()
	outoftrunk()
	locked = false
end)				
function hideintrunk()
 	SetVehicleDoorOpen(vehicle, 5, false, false)    	
    	AttachEntityToEntity(player, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		       		
   		RaiseConvertibleRoof(vehicle, false)
   		if IsEntityAttached(player) then
   			if not locked then
			SetTextComponentFormat("STRING")
			AddTextComponentString('~INPUT_JUMP~ invisible ~n~~s~~INPUT_CHARACTER_WHEEL~+~INPUT_COVER~ get out')
			DisplayHelpTextFromStringLabel(0, 1, 1, -1)	
			elseif locked then
			SetTextComponentFormat("STRING")
			AddTextComponentString('~INPUT_JUMP~ invisible ~n~~r~ LOCKED')
			DisplayHelpTextFromStringLabel(0, 1, 1, -1)	
			end				
			ClearPedTasksImmediately(player)
			Citizen.Wait(100)	       			
			TaskPlayAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
        	if not (IsEntityPlayingAnim(player, 'timetable@floyd@cryingonbed@base', 'base', 3) == 1) then
      			Streaming('timetable@floyd@cryingonbed@base', function()
		  		TaskPlayAnim(playerPed, 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 49, 0, 0, 0, 0)
           	end)
        end    
       	
		inside = true 						         		
		end   
	Citizen.Wait(2000)
	SetVehicleDoorShut(vehicle, 5, false) 		
end

function outoftrunk()
 	SetVehicleDoorOpen(vehicle, 5, false, false)   			
		
		DetachEntity(player, true, true)
		SetEntityVisible(player, true, true)
			ClearPedTasks(player)   
		inside = false
		ClearAllHelpMessages()		    	

	Citizen.Wait(2000)
	SetVehicleDoorShut(vehicle, 5, false)    	
end

    	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then
					SetTextComponentFormat("STRING")
					AddTextComponentString('~INPUT_CHARACTER_WHEEL~+~INPUT_COVER~ hide in')
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)	
		elseif DoesEntityExist(vehicle) and inside then
	    		car = GetEntityAttachedTo(player)
	    		carxyz = GetEntityCoords(car, 0)
	   			local visible = true
	   			DisableAllControlActions(0)
	   			DisableAllControlActions(1)
	   			DisableAllControlActions(2)
	   			EnableControlAction(0, 0, true) --- V - camera
	   			EnableControlAction(0, 249, true) --- N - push to talk	
	   			EnableControlAction(2, 1, true) --- camera moving
	   			EnableControlAction(2, 2, true) --- camera moving	
	   			EnableControlAction(0, 177, true) --- BACKSPACE
	   			EnableControlAction(0, 200, true) --- ESC					
	     			if IsDisabledControlJustPressed(1, 22) then
	     				if visible then
	    					SetEntityVisible(player, false, false)
	    					visible = false			
	    				end   	
	    			end 					
		elseif not DoesEntityExist(vehicle) and inside then
	    		DetachEntity(player, true, true)
	    		SetEntityVisible(player, true, true)
	   			ClearPedTasks(player)  	  
	    		inside = false		
	   			ClearAllHelpMessages()	 		    			
		end  	
  	end
end)

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end	
function VehicleInFront()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end
