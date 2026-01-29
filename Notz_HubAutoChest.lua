local pgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
if pgui:FindFirstChild("NotzHubPremium") then pgui.NotzHubPremium:Destroy() end

task.spawn(function()
    local player = game:GetService("Players").LocalPlayer
    if player.Team == nil then
        repeat
            task.wait(0.5)
            if player.Parent then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
            end
        until player.Team ~= nil
    end
end)

local NotzSky = Color3.fromRGB(0, 190, 255)
local NotzRed = Color3.fromRGB(255, 50, 50)
local NotzDark = Color3.fromRGB(15, 15, 15)
local NotzCard = Color3.fromRGB(30, 30, 35)
local TextWhite = Color3.fromRGB(255, 255, 255)

local BLACKLISTED_PLAYER_IDS = {
    305444644,
    3095250,
    5224370,
    120173604,
    912348,
    17884881
}

local BlacklistedIdsMap = {}
for _, id in ipairs(BLACKLISTED_PLAYER_IDS) do
    BlacklistedIdsMap[id] = true
end

local AutoFarmData = {
    AutoFarm = false,
    Speed = 350
}

local sg = Instance.new("ScreenGui")
sg.Name = "NotzHubPremium"
sg.Parent = pgui
sg.ResetOnSpawn = false

local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 90, 0, 35)
openBtn.Position = UDim2.new(0, 10, 0.5, -17)
openBtn.BackgroundColor3 = NotzDark
openBtn.Text = "⚡ Open"
openBtn.TextColor3 = NotzSky
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 14
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = sg
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 8)
local openStroke = Instance.new("UIStroke", openBtn)
openStroke.Thickness = 2

local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 320, 0, 380)
main.Position = UDim2.new(0.5, -160, 0.4, 0)
main.BackgroundColor3 = NotzDark
main.Active = true
main.Draggable = true
main.Parent = sg
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Thickness = 3
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 0.8, 1)
        mainStroke.Color = color
        openStroke.Color = color
    end
end)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundTransparency = 1
header.Parent = main

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ NOTZ HUB PREMIUM"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextColor3 = NotzSky
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = header

local miniBtn = Instance.new("TextButton")
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -40, 0.5, -15)
miniBtn.BackgroundTransparency = 1
miniBtn.Text = "-"
miniBtn.TextColor3 = TextWhite
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 30
miniBtn.Parent = header

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -24, 1, -70)
container.Position = UDim2.new(0, 12, 0, 60)
container.BackgroundTransparency = 1
container.Parent = main
Instance.new("UIListLayout", container).Padding = UDim.new(0, 10)

local function CreateCard(height, title, icon, isTitle)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, height)
    card.BackgroundColor3 = NotzCard
    card.Parent = container
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = icon .. "  " .. title
    lbl.TextColor3 = isTitle and NotzSky or TextWhite
    lbl.Font = isTitle and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card
    return card
end

local toggleCard = CreateCard(50, "Auto Chest Farm", "⚡", true)
local toggleBtnUI = Instance.new("TextButton")
toggleBtnUI.Size = UDim2.new(0, 80, 0, 30)
toggleBtnUI.Position = UDim2.new(1, -90, 0.5, -15)
toggleBtnUI.BackgroundColor3 = NotzRed
toggleBtnUI.Text = "OFF"; toggleBtnUI.TextColor3 = TextWhite
toggleBtnUI.Font = Enum.Font.GothamBold; toggleBtnUI.Parent = toggleCard
Instance.new("UICorner", toggleBtnUI).CornerRadius = UDim.new(0, 6)

local speedCard = CreateCard(50, "Tốc độ bay", "🚀", false)
local speedInputUI = Instance.new("TextBox")
speedInputUI.Size = UDim2.new(0, 70, 0, 30)
speedInputUI.Position = UDim2.new(1, -80, 0.5, -15)
speedInputUI.BackgroundColor3 = NotzDark
speedInputUI.Text = "350"; speedInputUI.TextColor3 = NotzSky
speedInputUI.Font = Enum.Font.GothamBold; speedInputUI.Parent = speedCard
Instance.new("UICorner", speedInputUI).CornerRadius = UDim.new(0, 6)

local statusCard = CreateCard(40, "Sẵn sàng...", "💡", false)
local statusTxtUI = statusCard.TextLabel

local timerCard = CreateCard(40, "Đổi Server: 1200s", "⏳", false)
local timerTxtUI = timerCard.TextLabel

local hopBtnUI = Instance.new("TextButton")
hopBtnUI.Size = UDim2.new(1, 0, 0, 45)
hopBtnUI.BackgroundColor3 = NotzRed
hopBtnUI.Text = "ĐỔI SERVER NGAY ⚡"; hopBtnUI.TextColor3 = TextWhite
hopBtnUI.Font = Enum.Font.GothamBlack; hopBtnUI.Parent = container
Instance.new("UICorner", hopBtnUI).CornerRadius = UDim.new(0, 8)

local scanCard = CreateCard(40, "🔍 Quét người chơi: 0/0", "👥", false)
local scanTxtUI = scanCard.TextLabel

_G.AutoFarm = AutoFarmData.AutoFarm
_G.Speed = AutoFarmData.Speed

toggleBtnUI.Text = _G.AutoFarm and "ON" or "OFF"
toggleBtnUI.BackgroundColor3 = _G.AutoFarm and NotzSky or NotzRed
toggleBtnUI.TextColor3 = _G.AutoFarm and NotzDark or TextWhite
speedInputUI.Text = tostring(_G.Speed)

local Blacklist = {}
local StartTime = tick()
local HopInterval = 1200
local CurrentTargetChest = nil 
local IsCollecting = false
local CollectionStartTime = 0
local WaitTime = 0.3 

local PatrolPoints = {
    Vector3.new(-5058, 314, -3155), Vector3.new(-12463, 374, -7543),
    Vector3.new(5747, 610, -267), Vector3.new(-9506, 164, -8510),
    Vector3.new(-15194, 25, 41), Vector3.new(-950, 40, -11000),
    Vector3.new(-2100, 40, -12100), Vector3.new(-11494, 15, -13511),
    Vector3.new(-11, 400, 100), Vector3.new(-5419, 10, 8506),
    Vector3.new(611, 400, 658), Vector3.new(-3383, 10, -3500),
    Vector3.new(-5240, 10, -6270), Vector3.new(6200, 10, -4200),
    Vector3.new(-1100, 10, 2000), Vector3.new(-7000, 10, 1500),
    Vector3.new(1000, 10, -2000), Vector3.new(5000, 10, 4000)
}
local currentPatrolIndex = 1

toggleBtnUI.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    Blacklist = {}
    CurrentTargetChest = nil
    IsCollecting = false
    
    toggleBtnUI.Text = _G.AutoFarm and "ON" or "OFF"
    toggleBtnUI.BackgroundColor3 = _G.AutoFarm and NotzSky or NotzRed
    toggleBtnUI.TextColor3 = _G.AutoFarm and NotzDark or TextWhite
    
    statusTxtUI.Text = _G.AutoFarm and "💡 ⚡ Auto Farm: BẬT" or "💡 ⚡ Auto Farm: TẮT"
end)

speedInputUI.FocusLost:Connect(function()
    local newSpeed = tonumber(speedInputUI.Text)
    if newSpeed and newSpeed > 0 then
        _G.Speed = newSpeed
        statusTxtUI.Text = "💡 ⚡ Tốc độ: " .. newSpeed
    else
        speedInputUI.Text = tostring(_G.Speed)
    end
end)

function ServerHop()
    statusTxtUI.Text = "💡 ⚡ Đang tìm server ít người..."
    
    local TPS = game:GetService("TeleportService")
    local Http = game:GetService("HttpService")
    local Api = "https://games.roblox.com/v1/games/"
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    
    local function ListServers(cursor)
        local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
        return Http:JSONDecode(Raw)
    end
    
    local Server, Next
    repeat
        local Servers = ListServers(Next)
        Server = Servers.data[1]
        Next = Servers.nextPageCursor
    until Server
    
    TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
end

hopBtnUI.MouseButton1Click:Connect(ServerHop)

local function CheckAndContinueAutoFarm()
    if _G.AutoFarm then
        task.wait(2)
        statusTxtUI.Text = "💡 ⚡ Tiếp tục Auto Farm..."
        
        Blacklist = {}
        CurrentTargetChest = nil
        IsCollecting = false
        StartTime = tick()
    end
end

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
    CheckAndContinueAutoFarm()
end)

if game:GetService("Players").LocalPlayer.Character then
    CheckAndContinueAutoFarm()
end

local function CheckForBlacklistedPlayers()
    local players = game:GetService("Players"):GetPlayers()
    local blacklistedCount = 0
    local totalPlayers = #players
    
    for _, player in ipairs(players) do
        if BlacklistedIdsMap[player.UserId] then
            blacklistedCount = blacklistedCount + 1
        end
    end
    
    scanTxtUI.Text = "🔍 Quét người chơi: " .. blacklistedCount .. "/" .. totalPlayers
    
    if blacklistedCount > 0 and _G.AutoFarm then
        statusTxtUI.Text = "🚨 Phát hiện Admin! Đổi server..."
        ServerHop()
        return true
    end
    
    return false
end

task.spawn(function()
    local scanInterval = 1
    local lastScanTime = 0
    
    while true do
        task.wait(1)
        
        if _G.AutoFarm then
            local currentTime = tick()
            
            local timeElapsed = currentTime - StartTime
            local timeRemaining = math.max(0, HopInterval - timeElapsed)
            timerTxtUI.Text = "⏳ Đổi Server: " .. math.floor(timeRemaining) .. "s"
            
            if timeElapsed >= HopInterval then
                statusTxtUI.Text = "⏰ Đổi server định kỳ..."
                ServerHop()
                StartTime = tick()
            end
            
            if currentTime - lastScanTime >= scanInterval then
                CheckForBlacklistedPlayers()
                lastScanTime = currentTime
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        if _G.AutoFarm then
            local p = game.Players.LocalPlayer
            local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if not (IsCollecting and CurrentTargetChest and CurrentTargetChest.Parent) then
                    local found = nil
                    local minDistance = math.huge
                    for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                        if v:IsA("BasePart") and (v.Name:find("Chest") or v.Name:find("Lucky")) then
                            if not Blacklist[v] and v.Parent and v.Position then
                                local dist = (v.Position - root.Position).Magnitude
                                if dist < minDistance then
                                    minDistance = dist
                                    found = v
                                end
                            end
                        end
                    end
                    CurrentTargetChest = found
                end
            end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if _G.AutoFarm then
        local p = game.Players.LocalPlayer
        local char = p.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            for _, v in pairs(char:GetDescendants()) do 
                if v:IsA("BasePart") then 
                    v.CanCollide = false 
                end 
            end
            root.Velocity = Vector3.new(0,0,0)

            if CurrentTargetChest and CurrentTargetChest.Parent then
                if CurrentTargetChest:IsA("BasePart") and CurrentTargetChest.Parent then
                    local tPos = CurrentTargetChest.Position
                    local dist = (tPos - root.Position).Magnitude
                    if IsCollecting then
                        statusTxtUI.Text = "💡 ⚡ Nhặt rương..."
                        root.CFrame = CurrentTargetChest.CFrame
                        firetouchinterest(root, CurrentTargetChest, 0)
                        firetouchinterest(root, CurrentTargetChest, 1)
                        CollectionStartTime = tick()
                        Blacklist[CurrentTargetChest] = true
                        CurrentTargetChest = nil
                        IsCollecting = false
                    else
                        statusTxtUI.Text = "💡 ⚡ Bay đến rương"
                        root.CFrame = CFrame.new(root.Position, tPos) * CFrame.new(0, 0, -(_G.Speed / 60))
                        if dist < 8 then 
                            IsCollecting = true 
                        end
                    end
                else
                    CurrentTargetChest = nil
                end
            else
                statusTxtUI.Text = "💡 ⚡ Đảo tuần tra: " .. currentPatrolIndex
                local pPos = PatrolPoints[currentPatrolIndex]
                root.CFrame = CFrame.new(root.Position, pPos) * CFrame.new(0, 0, -(_G.Speed / 60))
                if (root.Position - pPos).Magnitude < 150 then
                    currentPatrolIndex = (currentPatrolIndex % #PatrolPoints) + 1
                end
            end
        end
    end
end)

local function RainbowText(textLabel)
    local tweenService = game:GetService("TweenService")
    while true do
        for i = 0, 1, 0.05 do
            local color = Color3.fromHSV(i, 1, 1)
            textLabel.TextColor3 = color
            task.wait(0.1)
        end
    end
end

task.spawn(function()
    RainbowText(titleLabel)
end)

print("✅ NOTZ HUB PREMIUM")
