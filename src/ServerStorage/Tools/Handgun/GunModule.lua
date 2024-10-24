local module = {}

local isReloading = false
local lastFireTime = 0
local debris = game:GetService('Debris')
local ammo = script.Parent.Ammo
local maxAmmo = script.Parent.MaxAmmo
local totalAmmo = script.Parent.TotalAmmo
local sfx_fire = script.Parent.ShootSFX
local sfx_reload = script.Parent.ReloadSFX
local players = game:GetService("Players")
local ammoDisplay = players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("AmmoDisplay")

function module.Reload(actionName, inputState)
	if actionName == 'reload' and inputState == Enum.UserInputState.Begin and ammo.Value < maxAmmo.Value then
		isReloading = true
		sfx_reload:Play()
		task.wait(2)

		local ammoNeeded = maxAmmo.Value - ammo.Value
		if totalAmmo.Value >= ammoNeeded then
			totalAmmo.Value = totalAmmo.Value - ammoNeeded
			ammo.Value = maxAmmo.Value
		else
			ammo.Value = ammo.Value + totalAmmo.Value
			totalAmmo.Value = 0
		end

		isReloading = false
		ammoDisplay.Text = string.format("Ammo: %d / %d", ammo.Value, totalAmmo.Value)
	end
end

function module.CreateBullet(hitPosition)
	local bullet = Instance.new("Part")
	bullet.Size = Vector3.new(0.2, 0.2, 0.2)
	bullet.Shape = Enum.PartType.Ball
	bullet.Material = Enum.Material.Neon
	bullet.BrickColor = BrickColor.new("Bright yellow")
	bullet.Anchored = true
	bullet.CanCollide = false
	bullet.CFrame = CFrame.new(hitPosition)
	bullet.Parent = workspace
	debris:AddItem(bullet, 0.5)
end

function module.FireGun(fireRate, ammo, maxAmmo, totalAmmo, player)
	if os.time() - lastFireTime < fireRate.Value or isReloading then return end
	if ammo.Value <= 0 then
		print("Out of ammo!")
		module.Reload('reload', Enum.UserInputState.Begin)
		return
	end

	lastFireTime = os.time()
	sfx_fire:Play()
	ammo.Value = ammo.Value - 1

	local character = player.Character
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart then
		local startPos = humanoidRootPart.Position
		local direction = (workspace.CurrentCamera.CFrame.LookVector).unit * 500 -- Ray length
		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {character}
		local hit = workspace:Raycast(startPos, direction, rayParams)

		if hit then
			print("Hit: " .. hit.Instance.Name)
			module.CreateBullet(hit.Position)
			if hit.Instance.Parent:FindFirstChild("Humanoid") then
				hit.Instance.Parent.Humanoid:TakeDamage(20) -- Apply damage
			end
		end
	end
end

return module
