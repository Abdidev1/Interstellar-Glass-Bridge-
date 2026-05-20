-- Makes every server have a different random path
math.randomseed(os.time()) 

local bridgeFolder = game.Workspace:WaitForChild("BridgeParts")

for _, row in pairs(bridgeFolder:GetChildren()) do
	if row:IsA("Model") then
		local tiles = {}
		for _, child in pairs(row:GetChildren()) do
			if child:IsA("BasePart") then
				child.CanCollide = true
				child.Transparency = 0
				table.insert(tiles, child)
			end
		end

		if #tiles >= 2 then
			-- Pick the fake tile
			local fakeTile = tiles[math.random(1, #tiles)]

			fakeTile.Touched:Connect(function(hit)
				local hum = hit.Parent:FindFirstChild("Humanoid")

				-- Only trigger if it's a living player and the tile is currently visible
				if hum and hum.Health > 0 and fakeTile.Transparency == 0 then
					-- 1. Make the tile disappear
					fakeTile.CanCollide = false
					fakeTile.Transparency = 1

					-- 2. Wait for 2 seconds
					task.wait(2)

					-- 3. Make the tile come back (Respawn)
					fakeTile.CanCollide = true
					fakeTile.Transparency = 0
				end
			end)
		end
	end
end
