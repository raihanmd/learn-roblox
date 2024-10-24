local userInputService = game:GetService('UserInputService')
local re_cheat = game:GetService('ReplicatedStorage').RemoteEvent.Cheat

local isJumping = false
local currentTick = os.time()

if userInputService.KeyboardEnabled then
	workspace:WaitForChild("Baseplate").Color = Color3.fromRGB(212, 162, 255)
end

userInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.F then
		re_cheat:FireServer()
	end
	
	if os.time() - currentTick <= .3 and input.UserInputType == Enum.UserInputType.MouseButton1 then
		print("double click")
	end
	currentTick = os.time()
end)

userInputService.JumpRequest:Connect(function()
	if not isJumping  then
		isJumping = true
		print("Player jumping")
		
		task.wait(.5)
		isJumping = false
	end
end)