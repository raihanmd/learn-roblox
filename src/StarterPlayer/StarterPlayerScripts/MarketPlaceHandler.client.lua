local MarketplaceService = game:GetService("MarketplaceService")
local gamePassId = 952166348

local player = game.Players.LocalPlayer

task.wait(5)

MarketplaceService:PromptGamePassPurchase(player, gamePassId)
