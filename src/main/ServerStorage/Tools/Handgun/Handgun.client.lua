local tool = script.Parent
local module = require(tool.GunModule)
local players = game:GetService("Players")
local contextActionService = game:GetService("ContextActionService")

local ammoDisplay = players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("AmmoDisplay")

tool.Equipped:Connect(function()
	contextActionService:BindAction('reload', module.Reload, true, Enum.KeyCode.R)
	players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
	ammoDisplay.Visible = true
end)

tool.Activated:Connect(function()
	local fireRate = tool:WaitForChild('FireRate')
	local ammo = tool:WaitForChild('Ammo')
	local maxAmmo = tool:WaitForChild('MaxAmmo')
	local totalAmmo = tool:WaitForChild('TotalAmmo')

	module.FireGun(fireRate, ammo, maxAmmo, totalAmmo, players.LocalPlayer)

	ammoDisplay.Text = string.format("Ammo: %d / %d", ammo.Value, totalAmmo.Value)
end)

tool.Unequipped:Connect(function()
	contextActionService:UnbindAction('reload', module.Reload, true, Enum.KeyCode.R)
	players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
	ammoDisplay.Visible = false
end)
