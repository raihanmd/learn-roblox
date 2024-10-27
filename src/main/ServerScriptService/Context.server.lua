local RunService = game:GetService("RunService")

if RunService:IsStudio() then
	print("Running in Studio")
end

if RunService:IsServer() then
	print("Running in Server")
end

if RunService:IsClient() then
	print("Running in Client")
end
