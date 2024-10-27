local tweenService = game:GetService('TweenService')
local part = script.Parent

local tween = tweenService:Create(
	part, 
	TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
	{
		Size = Vector3.new(10, 10, 10)
	}
)

tween:Play()

-- can catch on complete with this
tween.Completed:Connect(function()
	print("Tween Completed")
end)

--or this
tween.Completed:Wait()

print("Whatever completed")

