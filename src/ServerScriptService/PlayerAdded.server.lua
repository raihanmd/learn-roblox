local timer = game:GetService("ReplicatedStorage").RemoteEvent.Timer
local serverStorage = game:GetService('ServerStorage')
local dataStoreService = game:GetService('DataStoreService')
local BadgeService = game:GetService('BadgeService')

local BADGE = require(game:GetService('ServerStorage').Data.BadgeData)


game.Players.PlayerAdded:Connect(function(player)
	local success, playerStore = pcall(function()
		return dataStoreService:GetDataStore(player.UserId)
	end)
	
	if not success then
		warn('Failed load data')
	end
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	if not playerStore:GetAsync('Tool') then
		playerStore:SetAsync('Tool', {})
	end
	
	local score = Instance.new("IntValue")
	local success, playerScore = pcall(function()
		return playerStore:GetAsync('Score')
	end)
	if success then
		score.Value = playerScore
	else
		score.Value = 0
	end
	score.Name = "Score"
	score.Parent = leaderstats
	
	local success, playerTool = pcall(function()
		return playerStore:GetAsync('Tool')
	end)
	if success then
		for i, v in pairs(playerTool) do
			local tool = serverStorage.Tools:WaitForChild(v)
			tool:Clone().Parent = player.Backpack
			
			local starterTool = tool:Clone()
			starterTool.Parent = player.StarterGear
		end
	else
		warn('Failed load tools')
	end
	
	print(BadgeService:CheckUserBadgesAsync(player.UserId, {BADGE.DENO}))
	task.wait(5)
	if BadgeService:UserHasBadgeAsync(player.UserId, BADGE.DENO) then
		print('You already received this badge')
		return
	end

	BadgeService:AwardBadge(player.UserId, BADGE.DENO)
end)

while true do
	task.wait(1)
	timer.Time.Value += 1
	timer:FireAllClients()
end