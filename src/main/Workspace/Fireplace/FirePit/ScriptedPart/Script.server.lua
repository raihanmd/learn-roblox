----------------------------------------
----- Script developed by 101PILOT -----
----------------------------------------

-- all configurations can be found in the "configurations" model

local configs = script.Parent.Parent.Configurations

script.Parent.Touched:connect(function(hit) -- this is the main function that is called whenever the fire is touched
	if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Humanoid.Health > 0 then -- if we have a player or an AI then	
		if configs.CanKill.Value == true and configs.CanCatchFire.Value == true then -- if the fire sets players alight and gives them damamge then
			local fire = script.Parent.Parent.FirePart.Fire:Clone() -- gatting some fire
			fire.Parent = hit -- putting the fire in the part of the person that touched the fire
			fire.Size = configs.FireSize.Value
			for i = 1, configs.FireDuration.Value do -- this deals with giving damamge to the player
				if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Humanoid.Health > 0 then
					hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - 1 -- reduce health
					wait(configs.HarmSpeed.Value) -- this is the time between giving damamge to the player	
				end
			end
			if fire and hit then -- removing unneeded fire
				fire:Destroy()
			end			
		elseif configs.CanKill.Value == true then -- else if we can only kill
			hit.Parent:BreakJoints() -- kill instantly
		elseif configs.CanCatchFire.Value == true then -- else if we can only set alight
			local fire = script.Parent.Parent.FirePart.Fire:Clone() -- getting some fire
			fire.Parent = hit -- making its parent the part that touched the fire
			fire.Size = configs.FireSize.Value
			wait(configs.FireDuration.Value) -- waiting before removing fire
			fire:Destroy() -- removing fire
		end
	end
end)
