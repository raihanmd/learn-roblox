local rf_BuyButton = game:GetService('ReplicatedStorage').RemoteFunction.BuyButton

local shopData = require(game:GetService('ReplicatedStorage').Data.ShopData)
local shopItems = game.Workspace:WaitForChild('Shop')
local dataStoreService = game:GetService('DataStoreService')


rf_BuyButton.OnServerInvoke = function(player, itemId)
	local currentTool = player:WaitForChild('StarterGear'):GetChildren()
	
	for _, tool in pairs(currentTool) do
		if tool.Name == itemId then
			print("Dupe forbidden: " .. itemId)
			return false
		end
	end
	
	local playerStore = dataStoreService:GetDataStore(player.UserId)
	
	if player.leaderstats.Score.Value >= shopData[itemId]["price"] then
		player.leaderstats.Score.Value -= shopData[itemId]["price"]
		
		local tool = game:GetService('ServerStorage').Tools[itemId]:Clone()
		tool.Parent = player.Backpack
		
		local starterTool = tool:Clone()
		starterTool.Parent = player.StarterGear
		
		return true
	end
	
	return false
end

for _, item in pairs(shopItems:GetChildren()) do
	local proxymityPrompt = item:WaitForChild("Part"):WaitForChild("ProximityPrompt")
	proxymityPrompt.ActionText = string.format("Price: %d", shopData[item.Name]["price"])
end