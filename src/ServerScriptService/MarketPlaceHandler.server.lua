local PurchaseHistory = game:GetService("DataStoreService"):GetDataStore("PurchaseHistory")
local MarketplaceService = game:GetService("MarketplaceService")
local gamePassId = 952166348

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
