local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local coinSFX: Sound = ReplicatedStorage.SFX:WaitForChild("CoinSFX")
local coinModel = ReplicatedStorage.Prefab:WaitForChild("Coin")
local spawnArea = workspace.SpawnArea
local spawnInterval = 1
local coinLifetime = 5

local function spawnCoin()
	local newCoin = coinModel:Clone()

	local x = math.random(spawnArea.Position.X - spawnArea.Size.X / 2, spawnArea.Position.X + spawnArea.Size.X / 2)
	local z = math.random(spawnArea.Position.Z - spawnArea.Size.Z / 2, spawnArea.Position.Z + spawnArea.Size.Z / 2)
	local y = spawnArea.Position.Y + spawnArea.Size.Y / 2 + 2

	newCoin.Position = Vector3.new(x, y, z)
	newCoin.Parent = workspace

	Debris:AddItem(newCoin, coinLifetime)

	local isCollected = false
	newCoin.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and not isCollected then
			isCollected = true
			player.leaderstats.Score.Value += 100
			coinSFX:Play()
			newCoin:Destroy()
		end
	end)
end

while true do
	spawnCoin()
	wait(spawnInterval)
end
