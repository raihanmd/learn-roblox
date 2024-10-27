local PurchaseHistory = game:GetService("DataStoreService"):GetDataStore("PurchaseHistory")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local gamePassId = 952166348

local producFunctions = {
	[2389675369] = function(player: Player)
		local humanoid = player.Character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.WalkSpeed += 50
			return true
		end
		return false
	end,
}

print(MarketplaceService:GetProductInfo(2389675369, Enum.InfoType.Product))

game.Players.PlayerAdded:Connect(function(player)
	local success, hasOwnGamePass =
		pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, gamePassId)

	if success and hasOwnGamePass then
		print("Player " .. player.Name .. " already owns game pass " .. gamePassId)
	end

	local purchaseHistory = PurchaseHistory:GetAsync(player.UserId)
	print(purchaseHistory)
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, id, success)
	if success and id == gamePassId then
		local receipt = { Name = "Test", Id = gamePassId, Date = os.date(), Price = 100 }

		local success, purchaseHistory = pcall(PurchaseHistory.GetAsync, PurchaseHistory, player.UserId)

		if not success then
			error("Failed to load purchase history")
			return
		end

		if purchaseHistory == nil then
			purchaseHistory = {}
		end

		table.insert(purchaseHistory, receipt)

		local success, errorMessage = pcall(PurchaseHistory.SetAsync, PurchaseHistory, player.UserId, purchaseHistory)
		if not success then
			warn(errorMessage)
		end

		print("Player " .. player.Name .. " purchased game pass " .. id)
	end
end)

MarketplaceService.ProcessReceipt = function(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	local productId = receiptInfo.ProductId

	local receiptId = player.UserId .. "_" .. receiptInfo.PurchaseId

	local success, purchased = pcall(PurchaseHistory.GetAsync, PurchaseHistory, receiptId)

	if not success then
		error("Failed to load purchase history")
		return Enum.ProductPurchaseDecision.NotProcessed
	end

	if purchased then
		return Enum.ProductPurchaseDecision.PurchaseAlreadyPurchased
	end

	local success, errorMessage = pcall(PurchaseHistory.SetAsync, PurchaseHistory, receiptId, true)
	if not success then
		warn(errorMessage)
		return Enum.ProductPurchaseDecision.NotProcessed
	end

	local success, errorMessage = pcall(producFunctions[productId], player)
	if not success then
		warn(errorMessage)
		return Enum.ProductPurchaseDecision.NotProcessed
	end

	return Enum.ProductPurchaseDecision.PurchaseGranted
end
