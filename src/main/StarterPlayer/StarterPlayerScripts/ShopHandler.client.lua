local replicatedStorage = game:GetService('ReplicatedStorage')
local Player = game:GetService('Players')

local rf_BuyButton = replicatedStorage.RemoteFunction.BuyButton

local sfx_purchase = replicatedStorage.SFX.Purchase
local sfx_notEnoughScore = replicatedStorage.SFX.NotEnoughMoney

local shopData = require(replicatedStorage.Data.ShopData)
local shopItems = workspace:WaitForChild('Shop')
local notification = game:GetService('StarterGui').ScreenGui.Notification

for _, item in pairs(shopItems:GetChildren()) do
	local proximityPrompt = item:WaitForChild('Part'):WaitForChild('ProximityPrompt')
	local player = Player.LocalPlayer or Player.PlayerAdded:Wait()
	for _, tool in ipairs(player.Backpack:GetChildren()) do
		if tool.Name == item.Name then
			proximityPrompt.Enabled = false -- Nonaktifkan ProximityPrompt
			break
		end
	end
	proximityPrompt.Triggered:Connect(function()
		
		local result = rf_BuyButton:InvokeServer(item.Name)
		if result == true then
			sfx_purchase:Play()
			proximityPrompt.Enabled = false
			notification.Text = 'Purchased ' .. item.Name .. '!'
			notification.BackgroundColor3 = Color3.new(0, 255, 0)
			notification.Visible = true
			task.delay(2, function()
				notification.Visible = false
			end)
			return
		end
		
		sfx_notEnoughScore:Play()
		notification.Text = 'Not enough score!'
		notification.BackgroundColor3 = Color3.new(255, 0, 0)
		notification.Visible = true
		task.delay(2, function()
			notification.Visible = false
		end)
	end)
end