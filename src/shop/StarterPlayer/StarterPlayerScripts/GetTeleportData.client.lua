local TeleportService = game:GetService("TeleportService")

local teleportData = TeleportService:GetLocalPlayerTeleportData()
for key, value in teleportData do
	print(key, value)
end
