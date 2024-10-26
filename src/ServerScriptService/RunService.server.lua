local RunService = game:GetService("RunService")
local heartBeatPart: Part = game.Workspace:WaitForChild("HeartBeat")
local steppedPart: Part = game.Workspace:WaitForChild("Stepped")

-- Idk but this can be we disconnect it

local conn = RunService.Heartbeat:Connect(function(dt)
	heartBeatPart.Position = heartBeatPart.Position + Vector3.new(0, 0, -10) * dt
end)

local conn2 = RunService.Stepped:Connect(function(t, dt)
	steppedPart.Position = steppedPart.Position + Vector3.new(0, 0, -10) * dt
end)

task.wait(3)

conn:Disconnect()
conn2:Disconnect()
