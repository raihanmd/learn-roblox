local TeleportService = game:GetService("TeleportService")
local teleportScreen = game:GetService("ReplicatedStorage"):WaitForChild("GUI"):WaitForChild("TeleportScreen")

place_shopId = 127266813076801

task.wait(10)

local teleportData = {
	Difficulty = 1,
	MaxPlayers = 5,
}

local teleportOptions = Instance.new("TeleportOptions")
-- ! this make teleport to reserved server
-- teleportOptions.ShouldReserveServer = true
teleportOptions:SetTeleportData(teleportData)

TeleportService:SetTeleportGui(teleportScreen)
TeleportService:Teleport(place_shopId, game.Players.LocalPlayer, teleportData)

-- * Teleport Async must in Server, give the player instance with table
-- TeleportService:TeleportAsync(place_shopId, { game.Players.LocalPlayer }, teleportOptions)
