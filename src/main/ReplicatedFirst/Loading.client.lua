local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local TweenService = game:GetService("TweenService")

local loadingScreen = ReplicatedFirst:WaitForChild("LoadingScreen"):Clone()
local frame = loadingScreen:WaitForChild("Frame")
local loadingLabel: TextLabel = frame:WaitForChild("Label")
local loadingBar: TextLabel = frame:WaitForChild("LoadingBar"):WaitForChild("Bar")

ReplicatedFirst:RemoveDefaultLoadingScreen()
playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

loadingScreen.Parent = playerGui

local assets = game:GetChildren()

for index, asset in assets do
	ContentProvider:PreloadAsync({ asset })
	loadingLabel.Text = string.format("Loading... %i%%", math.round(index / #assets * 100))
	TweenService:Create(loadingBar, TweenInfo.new(0.5), {
		Size = UDim2.new((index + 1) / #assets, 0, 1, 0),
	}):Play()
end

task.wait(1)

loadingScreen:Destroy()
