local TeleportService = game:GetService("TeleportService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local loadingScreen = TeleportService:GetArrivingTeleportGui()

if loadingScreen then
	ReplicatedFirst:RemoveDefaultLoadingScreen()
	loadingScreen.Parent = game.Players.LocalPlayer.PlayerGui

	task.wait(3)

	loadingScreen:Destroy()
end
