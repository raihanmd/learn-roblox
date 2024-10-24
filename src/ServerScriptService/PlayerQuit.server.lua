local Player = game:GetService('Players')
local DataStoreService = game:GetService('DataStoreService')

Player.PlayerRemoving:Connect(function(player)
	local playerData = DataStoreService:GetDataStore(player.UserId)
	
	--playerData:SetAsync('Score', player.leaderstats.Score.Value)
	
	local success, errorMessage = pcall(playerData.SetAsync, playerData, 'Score', player.leaderstats.Score.Value)
	if not success then warn(errorMessage) end
	
	
	local currentTools = {}
	
	for _, tool in pairs(player:WaitForChild('StarterGear'):GetChildren()) do
		table.insert(currentTools, tool.Name)
	end
	
	--playerData:SetAsync('Tool', currentTools)
	
	local success, errorMessage = pcall(playerData.SetAsync, playerData, 'Tool', currentTools)
	if not success then warn(errorMessage) end
end)