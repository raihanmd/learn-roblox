local BadgeService = game:GetService("BadgeService")
local BADGE = require(game:GetService("ServerStorage").Data.BadgeData)

game.Players.PlayerAdded:Connect(function(player)
	local badge = BadgeService:GetBadgeInfoAsync(BADGE.DENO)

	print(badge)

	task.wait(5)

	BadgeService:AwardBadge(player.UserId, BADGE.DENO)
end)
