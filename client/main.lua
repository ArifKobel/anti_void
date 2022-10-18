function TeleportPedToGround()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  SetEntityCoords(ped, coords.x, coords.y, 1000.0)
  coords = GetEntityCoords(ped)
  local groundZ = getGroundZ(coords.x, coords.y, coords.z)
  SetEntityCoords(ped, coords.x, coords.y, groundZ)
end

function getGroundZ(x, y, z)
  local retval, groundZ = GetGroundZFor_3dCoord(x, y, z, true)
  
  return groundZ
end


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(config.Settings.CheckingInterval)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local groundZ = getGroundZ(coords.x, coords.y, coords.z)

    if groundZ == 0.0 then
      TeleportPedToGround()
    end
  end
end)