local MarketplaceService = game:GetService("MarketplaceService")
local gamePassId = 952166348
local productId = 2389675369

local player = game.Players.LocalPlayer

task.wait(5)

MarketplaceService:PromptProductPurchase(player, productId)
