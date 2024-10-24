local re_cheat = game:GetService('ReplicatedStorage').RemoteEvent.Cheat

re_cheat.OnServerEvent:Connect(function(player)
	player.leaderstats.Score.Value += 200
end)