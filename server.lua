local DataStoreService = game:GetService("DataStoreService")
local playerData = DataStoreService:GetDataStore("StatsTime")
local Players = game:GetService("Players")

local function Format(Int)
	return string.format("%02i", Int)
end

local function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
end

local function savePlayerData(playerUserId, plr)
	local success, err = pcall(function()
		playerData:SetAsync(playerUserId, plr.leaderstats.CombatLog.Value)
		print("Saved!")
	end)
	if success then
		print("No errors")
	else
		print(err)
	end

end


local function saveOnExit(player)

	savePlayerData(player.UserId, player)
	
end

local function onPlayerAdded(plr)
	local playerUserId = plr.UserId
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = plr
	leaderstats.Name = 'leaderstats'
	local timee = Instance.new("BoolValue")
	timee.Parent = leaderstats
	timee.Name = 'CombatLog'
	local data = playerData:GetAsync(playerUserId)
	timee.Value = data
	print(timee.Value)
	print(data)
	if timee.Value == true then 
		plr.CharacterAdded:Connect(function()
			wait(2)
			print("trying bruh")
			local char = plr.Character
			print(char)
				char:PivotTo(CFrame.new(Vector3.new(129.862, 3.2, 36.966)))
				print(char:PivotTo(CFrame.new(Vector3.new(129.862, 3.2, 36.966))))
				wait(5)
			char:PivotTo(CFrame.new(workspace.Baseplate.Position + Vector3.new(0,30,0)))
		end)
		timee.Value = false
		print(timee.Value)
	end

end
Players.PlayerRemoving:Connect(saveOnExit)
Players.PlayerAdded:Connect(onPlayerAdded)
workspace:WaitForChild("Part").ProximityPrompt.Triggered:Connect(function(plr)
	plr.leaderstats:WaitForChild("CombatLog").Value = true
end)
