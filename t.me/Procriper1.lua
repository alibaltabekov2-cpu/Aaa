-- ==========================================================
--   BRAINROT MERGE | ULTIMATE HUB (PART 1: GUI)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("BrainRotMergeHub") then
    PlayerGui.BrainRotMergeHub:Destroy()
end

-- Глобальные настройки (общие для обеих частей)
getgenv().BrainRotSettings = {
    AutoCollect = false,
    AutoBuy = false,
    AutoMerge = false,
    AutoClaimTycoon = false,
    AutoRebirth = false,
    AutoClaimGifts = false,
    AntiAFK = true,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    NoClip = false,
    InfJump = false
}
local Settings = getgenv().BrainRotSettings

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainRotMergeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 45, 0, 45)
openBtn.Position = UDim2.new(0, 15, 0.25, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
openBtn.Text = "🧠"
openBtn.TextSize = 22
openBtn.Visible = false
openBtn.Parent = screenGui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 450, 0, 340)
main.Position = UDim2.new(0.5, -225, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(160, 32, 240)
Instance.new("UIStroke", main).Thickness = 1.5

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "BRAINROT MERGE <font color='#a020f0'>| ULTIMATE HUB</font>"
title.RichText = true
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() main.Visible = true; openBtn.Visible = false end)

local tabListFrame = Instance.new("ScrollingFrame")
tabListFrame.Size = UDim2.new(0, 130, 1, -50)
tabListFrame.Position = UDim2.new(0, 8, 0, 46)
tabListFrame.BackgroundTransparency = 1
tabListFrame.ScrollBarThickness = 0
tabListFrame.Parent = main

local tabListLayout = Instance.new("UIListLayout")
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 5)
tabListLayout.Parent = tabListFrame

local pagesContainer = Instance.new("Folder")
pagesContainer.Parent = main

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -155, 1, -55)
    page.Position = UDim2.new(0, 145, 0, 48)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(160, 32, 240)
    page.Visible = false
    page.Parent = pagesContainer
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.Parent = page
    return page
end

local pageFarm = createPage()
local pageUtil = createPage()
local pagePlayer = createPage()

local function createToggle(parentPage, text, defaultState, callback)
    local tgl = Instance.new("TextButton")
    tgl.Size = UDim2.new(1, -5, 0, 36)
    tgl.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    tgl.Text = "   " .. text
    tgl.TextColor3 = Color3.fromRGB(210, 210, 225)
    tgl.TextSize = 12
    tgl.Font = Enum.Font.GothamMedium
    tgl.TextXAlignment = Enum.TextXAlignment.Left
    tgl.Parent = parentPage
    Instance.new("UICorner", tgl).CornerRadius = UDim.new(0, 8)

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 34, 0, 18)
    switch.Position = UDim2.new(1, -42, 0.5, -9)
    switch.BackgroundColor3 = defaultState and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(45, 45, 60)
    switch.Parent = tgl
    Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 12, 0, 12)
    dot.Position = defaultState and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dot.Parent = switch
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = defaultState
    tgl.MouseButton1Click:Connect(function()
        state = not state
        switch.BackgroundColor3 = state and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(45, 45, 60)
        dot.Position = state and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
        callback(state)
    end)
end

local function createButton(parentPage, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 46)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parentPage
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

local function createSlider(parentPage, text, min, max, defaultVal, callback)
    local sf = Instance.new("Frame")
    sf.Size = UDim2.new(1, -5, 0, 52)
    sf.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    sf.Parent = parentPage
    Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 22)
    lbl.Position = UDim2.new(0, 8, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. defaultVal
    lbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = sf

    local bgBar = Instance.new("TextButton")
    bgBar.Size = UDim2.new(1, -20, 0, 8)
    bgBar.Position = UDim2.new(0, 10, 0, 32)
    bgBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    bgBar.Text = ""
    bgBar.Parent = sf
    Instance.new("UICorner", bgBar).CornerRadius = UDim.new(1, 0)

    local fillBar = Instance.new("Frame")
    fillBar.Size = UDim2.new((defaultVal - min) / (max - min), 0, 1, 0)
    fillBar.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
    fillBar.Parent = bgBar
    Instance.new("UICorner", fillBar).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function updateValue(input)
        local pos = math.clamp((input.Position.X - bgBar.AbsolutePosition.X) / bgBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * pos))
        fillBar.Size = UDim2.new(pos, 0, 1, 0)
        lbl.Text = text .. ": " .. val
        callback(val)
    end
    bgBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; updateValue(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then updateValue(input) end
    end)
end

-- Элементы управления интерфейсом
createToggle(pageFarm, "Auto Claim Empty Tycoon", Settings.AutoClaimTycoon, function(st) Settings.AutoClaimTycoon = st end)
createToggle(pageFarm, "Auto Collect Cash & Drops", Settings.AutoCollect, function(st) Settings.AutoCollect = st end)
createToggle(pageFarm, "Auto Buy Droppers/Upgrades", Settings.AutoBuy, function(st) Settings.AutoBuy = st end)
createToggle(pageFarm, "Auto Merge (Smart)", Settings.AutoMerge, function(st) Settings.AutoMerge = st end)

createToggle(pageUtil, "Anti-AFK (Prevent Kick)", Settings.AntiAFK, function(st) Settings.AntiAFK = st end)
createToggle(pageUtil, "Auto Rebirth", Settings.AutoRebirth, function(st) Settings.AutoRebirth = st end)
createToggle(pageUtil, "Auto Claim Gifts", Settings.AutoClaimGifts, function(st) Settings.AutoClaimGifts = st end)

-- Кнопка Телепорта на Базу (передает вызов во вторую часть через событие/глобальный метод)
createButton(pageUtil, "📍 Teleport to My Base", function()
    if getgenv().BrainRotTeleportBase then
        getgenv().BrainRotTeleportBase()
    end
end)

createButton(pageUtil, "🚀 FPS Boost (Anti-Lag)", function()
    if getgenv().BrainRotFpsBoost then
        getgenv().BrainRotFpsBoost()
    end
end)

createToggle(pagePlayer, "WalkSpeed Boost", Settings.WalkSpeedEnabled, function(st) Settings.WalkSpeedEnabled = st end)
createSlider(pagePlayer, "Speed Value", 16, 150, Settings.WalkSpeedValue, function(val) Settings.WalkSpeedValue = val end)
createToggle(pagePlayer, "Infinite Jump", Settings.InfJump, function(st) Settings.InfJump = st end)
createToggle(pagePlayer, "NoClip (Walk through walls)", Settings.NoClip, function(st) Settings.NoClip = st end)

local function createTabButton(name, targetPage)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 34)
    tabBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    tabBtn.Text = "   " .. name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.Parent = tabListFrame
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pagesContainer:GetChildren()) do p.Visible = false end
        for _, b in pairs(tabListFrame:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
                b.TextColor3 = Color3.fromRGB(180, 180, 200)
            end
        end
        targetPage.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return tabBtn
end

local btnFarm = createTabButton("🌾 Farm", pageFarm)
local btnUtil = createTabButton("🛠️ Utility", pageUtil)
local btnPlayer = createTabButton("🏃 Player", pagePlayer)

pageFarm.Visible = true
btnFarm.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
btnFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
-- ==========================================================
--   BRAINROT MERGE | ULTIMATE HUB (PART 2: LOGIC)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Защита на случай, если падает первая часть
local Settings = getgenv().BrainRotSettings or {
    AutoCollect = false,
    AutoBuy = false,
    AutoMerge = false,
    AutoClaimTycoon = false,
    AutoRebirth = false,
    AutoClaimGifts = false,
    AntiAFK = true,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    NoClip = false,
    InfJump = false
}

-- 1. Логика телепорта на базу (вызывается из интерфейса)
getgenv().BrainRotTeleportBase = function()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local tpDone = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if not tpDone and (obj:IsA("ObjectValue") or obj:IsA("StringValue")) then
            if obj.Name == "Owner" and tostring(obj.Value) == LocalPlayer.Name then
                local base = obj.Parent
                local tpPart = base:FindFirstChild("Spawn") or base:FindFirstChild("Floor") or base:FindFirstChildOfClass("BasePart")
                if tpPart then
                    myHrp.CFrame = tpPart.CFrame * CFrame.new(0, 5, 0)
                    tpDone = true
                end
            end
        end
    end
    
    if not tpDone then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find(LocalPlayer.Name:lower()) or obj.Name:lower():find("tycoon")) then
                local tpPart = obj:FindFirstChild("Spawn") or obj:FindFirstChildOfClass("BasePart")
                if tpPart then
                    myHrp.CFrame = tpPart.CFrame * CFrame.new(0, 5, 0)
                    break
                end
            end
        end
    end
end

-- 2. FPS Boost
getgenv().BrainRotFpsBoost = function()
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end
    end
end

-- 3. Anti-AFK
LocalPlayer.Idled:Connect(function()
    if Settings.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

-- 4. Auto Claim Empty Tycoon
task.spawn(function()
    while true do
        if Settings.AutoClaimTycoon then
            pcall(function()
                local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if myHrp then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and obj.Name:lower():find("claim") and obj:FindFirstChild("TouchInterest") then
                            firetouchinterest(myHrp, obj, 0)
                            firetouchinterest(myHrp, obj, 1)
                        end
                    end
                end
            end)
            task.wait(2)
        else
            task.wait(1)
        end
    end
end)

-- 5. Auto Merge
local isMerging = false
task.spawn(function()
    while true do
        if Settings.AutoMerge and not isMerging then
            pcall(function()
                local pairsToMerge = {}
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                        local name = obj.Name
                        if not pairsToMerge[name] then pairsToMerge[name] = {} end
                        table.insert(pairsToMerge[name], obj)
                    end
                end

                for name, list in pairs(pairsToMerge) do
                    if #list >= 2 then
                        isMerging = true
                        local p1 = list[1]:FindFirstChild("HumanoidRootPart")
                        local p2 = list[2]:FindFirstChild("HumanoidRootPart")
                        if p1 and p2 then
                            p1.CFrame = p2.CFrame
                            task.wait(0.2) 
                        end
                        isMerging = false
                        break
                    end
                end
            end)
            task.wait(0.2)
        else
            task.wait(0.5)
        end
    end
end)

-- 6. Auto Collect & Buy
task.spawn(function()
    while true do
        pcall(function()
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                if Settings.AutoCollect then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                            local n = obj.Name:lower()
                            if n:find("coin") or n:find("cash") or n:find("drop") or n:find("money") then
                                firetouchinterest(myHrp, obj, 0)
                                firetouchinterest(myHrp, obj, 1)
                            end
                        end
                    end
                end
                
                if Settings.AutoBuy then
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            fireproximityprompt(prompt)
                        end
                    end
                    for _, pad in pairs(workspace:GetDescendants()) do
                        if pad:IsA("BasePart") and (pad.Name:lower():find("buy") or pad.Name:lower():find("button")) and pad:FindFirstChild("TouchInterest") then
                            firetouchinterest(myHrp, pad, 0)
                            firetouchinterest(myHrp, pad, 1)
                        end
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)

-- 7. Auto Rebirth & Gifts
task.spawn(function()
    while true do
        pcall(function()
            if Settings.AutoRebirth or Settings.AutoClaimGifts then
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    for _, btn in pairs(playerGui:GetDescendants()) do
                        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                            local n = btn.Name:lower()
                            if Settings.AutoRebirth and n:find("rebirth") then
                                for _, e in pairs(getconnections(btn.MouseButton1Click)) do e:Fire() end
                            end
                            if Settings.AutoClaimGifts and (n:find("claim") or n:find("reward") or n:find("gift")) then
                                for _, e in pairs(getconnections(btn.MouseButton1Click)) do e:Fire() end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(2)
    end
end)

-- 8. Player Mods (Speed, NoClip, InfJump)
RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if myChar then
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        if hum and Settings.WalkSpeedEnabled then
            hum.WalkSpeed = Settings.WalkSpeedValue
        end
        if Settings.NoClip then
            for _, part in pairs(myChar:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump then
        local myChar = LocalPlayer.Character
        local hum = myChar and myChar:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
