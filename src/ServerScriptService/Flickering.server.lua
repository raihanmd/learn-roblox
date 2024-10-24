local flickering = workspace:WaitForChild('Flickering')

local coroutines = {}

for i, value: Part in pairs(flickering:GetChildren()) do
	coroutines[i] = coroutine.wrap(function()
		while true do
			value.Color = Color3.new(math.random(255), math.random(255), math.random(255))
			task.wait()
		end
	end)
end


for _, value in pairs(coroutines) do
	value()
end
