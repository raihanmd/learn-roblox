local part = script.Parent
local player = game.Players:WaitForChild("XenoniteDz")
local character = player.Character or player.CharacterAdded:Wait()

local playerPart = character:WaitForChild("HumanoidRootPart")

while true do
	if playerPart and part then
		part.CFrame = playerPart.CFrame * CFrame.new(0, 1, 5)
	end
	task.wait()
end