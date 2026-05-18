local DataStoreService = game:GetService("DataStoreService")
local myDataStore = DataStoreService:GetDataStore("CompletionDataV1") -- Name of your database

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local completed = Instance.new("IntValue")
	completed.Name = "Completed"
	completed.Parent = leaderstats

	-- LOAD DATA
	local playerKey = "Player_" .. player.UserId
	local success, savedValue = pcall(function()
		return myDataStore:GetAsync(playerKey)
	end)

	if success and savedValue then
		completed.Value = savedValue
	else
		completed.Value = 0 -- Default if no data exists
	end
end)

-- SAVE DATA WHEN PLAYER LEAVES
game.Players.PlayerRemoving:Connect(function(player)
	local playerKey = "Player_" .. player.UserId
	local success, err = pcall(function()
		myDataStore:SetAsync(playerKey, player.leaderstats.Completed.Value)
	end)

	if not success then
		warn("Could not save data for " .. player.Name .. ": " .. err)
	end
end)