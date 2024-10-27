local player  = script.Parent
local animation = script:WaitForChild('Animation')

local animator: Animator = player:WaitForChild('Humanoid'):WaitForChild('Animator')

local animationTrack = animator:LoadAnimation(animation)

task.wait(5)

animationTrack:Play()

animationTrack:GetMarkerReachedSignal('OnFinished'):Connect(function()
	print('Hormat!')
end)