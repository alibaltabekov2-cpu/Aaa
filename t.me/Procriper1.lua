-- ==========================================================
--   MERGE BRAINROT | MOD HUB (AUTO FARM, MERGE & ESP)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("BrainRotMergeHub") then
    PlayerGui.BrainRotMergeHub:Destroy()
end

local Settings = {
    AutoCollect = false,
    AutoBuy = false,
    AutoMerge = false,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    NoClip = false,
    ESP = false
}

-- ==================== GUI ИНТЕРФЕЙС ====================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainRotMergeHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Кнопка открытия/закрытия меню
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 45, 0, 45)
openBtn.Position = UDim2.new(0, 15, 0.25, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
openBtn.Text = "🧠"
openBtn.TextSize = 22
openBtn.Visible = false
openBtn.Parent = screenGui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- Главное окно
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 440, 0, 320)
main.Position = UDim2.new(0.5, -220, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
main.BorderSizePixel = 0
main.Active = true
main.Visible = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(160, 32, 240)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

-- Шапка
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "BRAINROT MERGE <font color='#a020f0'>| MOD HUB</font>"
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
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() main.Visible = true; openBtn.Visible = false end)

-- Вкладки
local tabListFrame = Instance.new("ScrollingFrame")
tabListFrame.Size = UDim2.new(0, 120, 1, -50)
tabListFrame.Position = UDim2.new(0, 8, 0, 46)
tabListFrame.BackgroundTransparency = 1
tabListFrame.ScrollBarThickness = 0
tabListFrame.Parent = main

local tabListLayout = Instance.new("UIListLayout")
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 5)
tabListLayout.Parent = tabListFrame

local pagesContainer = Instance.new("Folder")
pagesContainer.Name = "PagesContainer"
pagesContainer.Parent = main

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -145, 1, -55)
    page.Position = UDim2.new(0, 135, 0, 48)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Color3.fromRGB(160, 32, 240)
    page.Visible = false
    page.Parent = pagesContainer

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = page
    return page
end

local pageFarm = createPage()
local pagePlayer = createPage()
local pageESP = createPage()

-- Элементы UI (Toggle)
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
    dot.BackgroundColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
    dot.Parent = switch
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local state = defaultState
    tgl.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(160, 32, 240)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.15), {Position = UDim2.new(1, -15, 0.5, -6)}):Play()
        else
            TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.15), {Position = UDim2.new(0, 3, 0.5, -6)}):Play()
        end
        callback(state)
    end)
end

-- Элементы UI (Slider)
local function createSlider(parentPage, text, min, max, defaultVal, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -5, 0, 52)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    sliderFrame.Parent = parentPage
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 8)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -16, 0, 22)
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = text .. ": " .. defaultVal
    titleLbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    titleLbl.TextSize = 12
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = sliderFrame

    local bgBar = Instance.new("TextButton")
    bgBar.Size = UDim2.new(1, -20, 0, 8)
    bgBar.Position = UDim2.new(0, 10, 0, 32)
    bgBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    bgBar.Text = ""
    bgBar.AutoButtonColor = false
    bgBar.Parent = sliderFrame
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
        titleLbl.Text = text .. ": " .. val
        callback(val)
    end

    bgBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateValue(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input)
        end
    end)
end

-- Переключатели
createToggle(pageFarm, "Auto Collect Cash / Coins", Settings.AutoCollect, function(st) Settings.AutoCollect = st end)
createToggle(pageFarm, "Auto Buy / Spawn Items", Settings.AutoBuy, function(st) Settings.AutoBuy = st end)
createToggle(pageFarm, "Auto Merge (Combine)", Settings.AutoMerge, function(st) Settings.AutoMerge = st end)

createToggle(pagePlayer, "WalkSpeed Boost", Settings.WalkSpeedEnabled, function(st) Settings.WalkSpeedEnabled = st end)
createSlider(pagePlayer, "Speed Value", 16, 150, Settings.WalkSpeedValue, function(val) Settings.WalkSpeedValue = val end)
createToggle(pagePlayer, "NoClip", Settings.NoClip, function(st) Settings.NoClip = st end)

createToggle(pageESP, "ESP Players", Settings.ESP, function(st)
    Settings.ESP = st
    if not st then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
                plr.Character.ESPHighlight:Destroy()
            end
        end
    end
end)

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

local btnFarm = createTabButton("🌾 Auto Farm", pageFarm)
local btnPlayer = createTabButton("🏃 Player", pagePlayer)
local btnESP = createTabButton("👁️ ESP", pageESP)

pageFarm.Visible = true
btnFarm.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
btnFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
-- ==================== ЛОГИКА ФАРМА И МЕХАНИК ====================

-- 1. АВТО-СБОР МОНЕТ И КЕША
task.spawn(function()
    while true do
        if Settings.AutoCollect then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                
                if myHrp then
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                            local name = obj.Name:lower()
                            if name:find("coin") or name:find("cash") or name:find("drop") or name:find("money") or name:find("orb") then
                                firetouchinterest(myHrp, obj, 0)
                                firetouchinterest(myHrp, obj, 1)
                            end
                        end
                    end
                end
            end)
            task.wait(0.2)
        else
            task.wait(0.5)
        end
    end
end)

-- 2. АВТО-ПОКУПКА / СПАВН ЮНИТОВ
task.spawn(function()
    while true do
        if Settings.AutoBuy then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                
                -- Взаимодействие с ProximityPrompts и кнопками покупки
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        fireproximityprompt(prompt)
                    end
                end

                -- Нажатие на напольные плиты покупки
                if myHrp then
                    for _, pad in pairs(workspace:GetDescendants()) do
                        if pad:IsA("BasePart") and (pad.Name:lower():find("buy") or pad.Name:lower():find("spawn") or pad.Name:lower():find("button")) then
                            firetouchinterest(myHrp, pad, 0)
                            firetouchinterest(myHrp, pad, 1)
                        end
                    end
                end
            end)
            task.wait(0.3)
        else
            task.wait(0.5)
        end
    end
end)

-- 3. АВТО-ОБЪЕДИНЕНИЕ (AUTO MERGE)
task.spawn(function()
    while true do
        if Settings.AutoMerge then
            pcall(function()
                local itemsMap = {}

                -- Находим одинаковые предметы и сближаем их для соединения
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                        local itemName = obj.Name
                        if not itemsMap[itemName] then
                            itemsMap[itemName] = {}
                        end
                        table.insert(itemsMap[itemName], obj)
                    end
                end

                for name, list in pairs(itemsMap) do
                    if #list >= 2 then
                        local item1 = list[1]:FindFirstChild("HumanoidRootPart")
                        local item2 = list[2]:FindFirstChild("HumanoidRootPart")
                        if item1 and item2 then
                            item1.CFrame = item2.CFrame
                        end
                    end
                end
            end)
            task.wait(0.4)
        else
            task.wait(0.5)
        end
    end
end)

-- 4. СКОРОСТЬ, NOCLIP И ESP
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

    -- ESP Подсветка игроков
    if Settings.ESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local char = plr.Character
                local hl = char:FindFirstChild("ESPHighlight")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "ESPHighlight"
                    hl.Parent = char
                end
                hl.FillColor = Color3.fromRGB(160, 32, 240)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end)
