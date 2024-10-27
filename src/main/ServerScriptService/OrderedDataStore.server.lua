local DataStoreService = game:GetService('DataStoreService')

local PlayerScoreStore = DataStoreService:GetOrderedDataStore('PlayerScore')

PlayerScoreStore:SetAsync('Adit', 100)
PlayerScoreStore:SetAsync('Adit2', 150)
PlayerScoreStore:SetAsync('Adit3', 125)
PlayerScoreStore:SetAsync('Adit4', 400)
PlayerScoreStore:SetAsync('Adit5', 60)
PlayerScoreStore:SetAsync('Adit6', 0)

local pages: DataStorePages = PlayerScoreStore:GetSortedAsync(false, 5)

while true do
	local entries = pages:GetCurrentPage()
	
	for key, val in pairs(entries) do
		print(key .. '. ' .. val.key .. ' Scoring: ' .. val.value)
	end
	
	if pages.IsFinished then
		break
	else
		print('------')
		pages:AdvanceToNextPageAsync()
	end
end