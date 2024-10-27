local timerEvent = game:GetService("ReplicatedStorage").RemoteEvent.Timer
local timerLabel = script.Parent

timerEvent.OnClientEvent:Connect(function()
	timerLabel.Text = timerEvent:WaitForChild("Time").Value
end)