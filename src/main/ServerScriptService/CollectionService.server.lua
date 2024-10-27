local collectionService = game:GetService('CollectionService')
local killZone = collectionService:GetTagged('KillZone')

for _, zone in pairs(killZone) do
	zone.Touched:Connect(function(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		
		if humanoid then
			humanoid.Health = 0
		end
	end)
end