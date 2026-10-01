-- ==========================================================
--   ANIME ARENA | MOD HUB (LOWEST HP CAMLOCK, AUTO COMBO & HEALTH ESP)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Удаляем предыдущий GUI, если он запущен
if PlayerGui:FindFirstChild("AnimeArenaRemote") then
    PlayerGui.AnimeArenaRemote:Destroy()
end

-- Настройки мода
local Settings = {
    KillAura = false,
    AutoSkill = false,
    AutoTP = false,
    CamLock = false,
    AntiHit = false,
    FakeDashEnabled = false,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 16,
    NoClip = false,
    AuraDistance = 60,
    ESP = false,
    HealthESP = false, -- Включение полоски ХП
    MinYHeight = -5
}

-- ==================== СОЗДАНИЕ ИНТЕРФЕЙСА (GUI) ====================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnimeArenaRemote"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Кнопка открытия GUI (⚡)
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Size = UDim2.new(0, 45, 0, 45)
openBtn.Position = UDim2.new(0, 15, 0.25, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
openBtn.Text = "⚡"
openBtn.TextSize = 22
openBtn.Visible = false
openBtn.Parent = screenGui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- Перетаскиваемая кнопка DASH
local dashHudBtn = Instance.new("TextButton")
dashHudBtn.Name = "DashHUDButton"
dashHudBtn.Size = UDim2.new(0, 50, 0, 50)
dashHudBtn.Position = UDim2.new(0.8, 0, 0.6, 0)
dashHudBtn.BackgroundColor3 = Color3.fromRGB(240, 60, 60)
dashHudBtn.Text = "DASH"
dashHudBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
dashHudBtn.TextSize = 11
dashHudBtn.Font = Enum.Font.GothamBold
dashHudBtn.Visible = false
dashHudBtn.Parent = screenGui
Instance.new("UICorner", dashHudBtn).CornerRadius = UDim.new(0, 8)

local draggingDash = false
local dragInputDash, dragStartDash, startPosDash

dashHudBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingDash = true
        dragStartDash = input.Position
        startPosDash = dashHudBtn.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingDash = false
            end
        end)
    end
end)

dashHudBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputDash = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInputDash and draggingDash then
        local delta = input.Position - dragStartDash
        dashHudBtn.Position = UDim2.new(startPosDash.X.Scale, startPosDash.X.Offset + delta.X, startPosDash.Y.Scale, startPosDash.Y.Offset + delta.Y)
    end
end)

-- Главное окно
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 440, 0, 330)
main.Position = UDim2.new(0.5, -220, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.Active = true
main.Visible = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 60, 60)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

-- Шапка
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "ANIME ARENA <font color='#ff3c3c'>| MOD HUB</font>"
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
closeBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() main.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() main.Visible = true; openBtn.Visible = false end)

-- Табы
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
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
    page.Visible = false
    page.Parent = pagesContainer

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = page
    return page
end

local pageAttack = createPage()
local pagePlayer = createPage()
local pageESP = createPage()

-- Toggle UI
local function createToggle(parentPage, text, defaultState, callback)
    local tgl = Instance.new("TextButton")
    tgl.Size = UDim2.new(1, -5, 0, 36)
    tgl.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
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
    switch.BackgroundColor3 = defaultState and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(45, 45, 60)
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
            TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.15), {Position = UDim2.new(1, -15, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}):Play()
            TweenService:Create(dot, TweenInfo.new(0.15), {Position = UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = Color3.fromRGB(150, 150, 170)}):Play()
        end
        callback(state)
    end)
end

-- Slider UI
local function createSlider(parentPage, text, min, max, defaultVal, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -5, 0, 52)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
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
    fillBar.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
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

-- Кнопки управления
createToggle(pageAttack, "Auto Skill Combo (R->E->M1x2)", Settings.AutoSkill, function(st) Settings.AutoSkill = st end)
createToggle(pageAttack, "KillAura (Pure M1)", Settings.KillAura, function(st) Settings.KillAura = st end)
createToggle(pageAttack, "Auto TP (Strict Behind)", Settings.AutoTP, function(st) Settings.AutoTP = st end)
createToggle(pageAttack, "Cam Lock (Lowest HP)", Settings.CamLock, function(st) Settings.CamLock = st end)
createToggle(pageAttack, "Anti-Hit (Evade)", Settings.AntiHit, function(st) Settings.AntiHit = st end)
createToggle(pageAttack, "Fake Dash Button", Settings.FakeDashEnabled, function(st)
    Settings.FakeDashEnabled = st
    dashHudBtn.Visible = st
end)

createToggle(pagePlayer, "Enable Speed Boost", Settings.WalkSpeedEnabled, function(st) Settings.WalkSpeedEnabled = st end)
createSlider(pagePlayer, "Speed Value", 16, 200, Settings.WalkSpeedValue, function(val) Settings.WalkSpeedValue = val end)
createToggle(pagePlayer, "NoClip", Settings.NoClip, function(st) Settings.NoClip = st end)

createToggle(pageESP, "ESP Box / Highlight", Settings.ESP, function(st)
    Settings.ESP = st
    if not st then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
                plr.Character.ESPHighlight:Destroy()
            end
        end
    end
end)

createToggle(pageESP, "ESP Health Bar", Settings.HealthESP, function(st)
    Settings.HealthESP = st
    if not st then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local bgui = plr.Character.Head:FindFirstChild("HealthESP_BGui")
                if bgui then bgui:Destroy() end
            end
        end
    end
end)

local function createTabButton(name, targetPage)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 34)
    tabBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
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
                b.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
                b.TextColor3 = Color3.fromRGB(180, 180, 200)
            end
        end
        targetPage.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return tabBtn
end

local btnAttack = createTabButton("⚔️ Attack", pageAttack)
local btnPlayer = createTabButton("🏃 Player", pagePlayer)
local btnESP = createTabButton("👁️ ESP", pageESP)

pageAttack.Visible = true
btnAttack.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
btnAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
-- ==================== ЛОГИКА АТАКИ, CAMLOCK И HEALTH ESP ====================

local activeAutoSkillTarget = nil
local activeCamLockTarget = nil
local comboStep = 1

local function isTargetAlive(plr)
    if not plr or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if hum and hum.Health > 0 and hrp and hrp.Position.Y >= Settings.MinYHeight then
        return true
    end
    return false
end

-- Поиск цели с самым низким ХП
local function getLowestHPPlayer()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myHrp = myChar.HumanoidRootPart

    local lowestPlr = nil
    local minHealth = 9999999

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isTargetAlive(plr) then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health < minHealth then
                minHealth = hum.Health
                lowestPlr = plr
            end
        end
    end
    return lowestPlr
end

-- Поиск ближайшего игрока (для ТП / Ауры)
local function getClosestPlayer()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myHrp = myChar.HumanoidRootPart
    
    local closestPlr = nil
    local minDistance = 99999

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and isTargetAlive(plr) then
            local enemyHrp = plr.Character.HumanoidRootPart
            local dist = (myHrp.Position - enemyHrp.Position).Magnitude
            if dist < minDistance then
                minDistance = dist
                closestPlr = plr
            end
        end
    end
    return closestPlr
end

-- Нажатие скилла на клавиатуре
local function pressKey(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

-- Гарантированный удар M1
local function doGuaranteedAttack()
    local myChar = LocalPlayer.Character
    if myChar then
        local tool = myChar:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.03)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

-- DASH Кнопка
dashHudBtn.MouseButton1Click:Connect(function()
    local myChar = LocalPlayer.Character
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        local hrp = myChar.HumanoidRootPart
        local hum = myChar:FindFirstChildOfClass("Humanoid")
        pcall(function()
            local lookVector = hrp.CFrame.LookVector
            if hum and hum.MoveDirection.Magnitude > 0 then lookVector = hum.MoveDirection end
            local targetCFrame = hrp.CFrame + (lookVector * 18)
            local tween = TweenService:Create(hrp, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetCFrame})
            tween:Play()
        end)
    end
end)

-- AUTO TP
task.spawn(function()
    while true do
        if Settings.AutoTP then
            pcall(function()
                local target = activeAutoSkillTarget or getClosestPlayer()
                if target and target.Character then
                    local myChar = LocalPlayer.Character
                    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local enemyHrp = target.Character:FindFirstChild("HumanoidRootPart")

                    if myHrp and enemyHrp then
                        myHrp.CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 2.2)
                        myHrp.CFrame = CFrame.new(myHrp.Position, enemyHrp.Position)
                    end
                end
            end)
            task.wait(0.04)
        else
            task.wait(0.2)
        end
    end
end)

-- AUTO SKILL (РОТАЦИЯ: R -> E -> M1 -> M1 -> ПОВТОР ДО СМЕРТИ)
task.spawn(function()
    while true do
        if Settings.AutoSkill then
            pcall(function()
                -- Держим одного игрока намертво пока не умрет
                if not activeAutoSkillTarget or not isTargetAlive(activeAutoSkillTarget) then
                    activeAutoSkillTarget = getClosestPlayer()
                    comboStep = 1
                end

                if activeAutoSkillTarget and activeAutoSkillTarget.Character then
                    local myChar = LocalPlayer.Character
                    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local enemyHrp = activeAutoSkillTarget.Character:FindFirstChild("HumanoidRootPart")

                    if myHrp and enemyHrp then
                        local dist = (myHrp.Position - enemyHrp.Position).Magnitude
                        if dist <= Settings.AuraDistance then
                            -- Разворот к врагу
                            myHrp.CFrame = CFrame.new(myHrp.Position, Vector3.new(enemyHrp.Position.X, myHrp.Position.Y, enemyHrp.Position.Z))

                            -- Цепочка: 1. R -> 2. E -> 3. Клик -> 4. Клик -> Повтор
                            if comboStep == 1 then
                                pressKey(Enum.KeyCode.R)
                                comboStep = 2
                                task.wait(0.25)
                            elseif comboStep == 2 then
                                pressKey(Enum.KeyCode.E)
                                comboStep = 3
                                task.wait(0.25)
                            elseif comboStep == 3 then
                                doGuaranteedAttack()
                                comboStep = 4
                                task.wait(0.12)
                            elseif comboStep == 4 then
                                doGuaranteedAttack()
                                comboStep = 1
                                task.wait(0.2)
                            end
                        end
                    end
                else
                    activeAutoSkillTarget = nil
                    comboStep = 1
                end
            end)
            task.wait(0.05)
        else
            activeAutoSkillTarget = nil
            comboStep = 1
            task.wait(0.2)
        end
    end
end)

-- KILLAURA (ТОЛЬКО ОБЫЧНЫЕ УДАРЫ M1)
task.spawn(function()
    while true do
        if Settings.KillAura and not Settings.AutoSkill then
            pcall(function()
                local target = activeAutoSkillTarget or getClosestPlayer()
                if target and target.Character then
                    local myChar = LocalPlayer.Character
                    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local enemyHrp = target.Character:FindFirstChild("HumanoidRootPart")
                    if myHrp and enemyHrp then
                        local dist = (myHrp.Position - enemyHrp.Position).Magnitude
                        if dist <= Settings.AuraDistance then
                            myHrp.CFrame = CFrame.new(myHrp.Position, Vector3.new(enemyHrp.Position.X, myHrp.Position.Y, enemyHrp.Position.Z))
                            doGuaranteedAttack()
                        end
                    end
                end
            end)
            task.wait(0.06)
        else
            task.wait(0.2)
        end
    end
end)

-- ANTI-HIT
task.spawn(function()
    local lastEvade = 0
    while true do
        if Settings.AntiHit then
            pcall(function()
                local myChar = LocalPlayer.Character
                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                    local myHrp = myChar.HumanoidRootPart
                    local now = tick()
                    
                    if now - lastEvade > 0.25 then
                        for _, plr in pairs(Players:GetPlayers()) do
                            if plr ~= LocalPlayer and isTargetAlive(plr) then
                                local enemyHrp = plr.Character.HumanoidRootPart
                                local dist = (myHrp.Position - enemyHrp.Position).Magnitude
                                if dist < 10 then
                                    lastEvade = now
                                    local evadeCFrame = myHrp.CFrame * CFrame.new(math.random(-8, 8), 0, math.random(6, 12))
                                    myHrp.CFrame = evadeCFrame
                                    break
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.03)
        else
            task.wait(0.3)
        end
    end
end)

-- ФУНКЦИЯ ОБНОВЛЕНИЯ ПОЛОСКИ ХП (HEALTH ESP)
local function updateHealthESP(plr)
    if not plr.Character or not plr.Character:FindFirstChild("Head") then return end
    local head = plr.Character.Head
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    local bgui = head:FindFirstChild("HealthESP_BGui")

    if not Settings.HealthESP then
        if bgui then bgui:Destroy() end
        return
    end

    if not bgui then
        bgui = Instance.new("BillboardGui")
        bgui.Name = "HealthESP_BGui"
        bgui.Size = UDim2.new(0, 65, 0, 7)
        bgui.StudsOffset = Vector3.new(0, 2.8, 0)
        bgui.AlwaysOnTop = true
        bgui.Parent = head

        local bgFrame = Instance.new("Frame")
        bgFrame.Name = "BG"
        bgFrame.Size = UDim2.new(1, 0, 1, 0)
        bgFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        bgFrame.BorderSizePixel = 0
        bgFrame.Parent = bgui
        Instance.new("UICorner", bgFrame).CornerRadius = UDim.new(0, 3)

        local fillFrame = Instance.new("Frame")
        fillFrame.Name = "Fill"
        fillFrame.Size = UDim2.new(1, 0, 1, 0)
        fillFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        fillFrame.BorderSizePixel = 0
        fillFrame.Parent = bgFrame
        Instance.new("UICorner", fillFrame).CornerRadius = UDim.new(0, 3)
    end

    local fill = bgui.BG.Fill
    local hpPercent = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
    fill.Size = UDim2.new(hpPercent, 0, 1, 0)

    -- Цвет по уровню здоровья
    if hpPercent > 0.6 then
        fill.BackgroundColor3 = Color3.fromRGB(0, 255, 100) -- Зеленый
    elseif hpPercent >= 0.3 then
        fill.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Оранжевый
    else
        fill.BackgroundColor3 = Color3.fromRGB(255, 30, 30) -- Красный
    end
end

-- КАМЕРА, LOWEST HP CAMLOCK И ESP
local camera = workspace.CurrentCamera

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

    -- Cam Lock на цель с самым низким ХП (Не отпускает до смерти)
    if Settings.CamLock then
        if not activeCamLockTarget or not isTargetAlive(activeCamLockTarget) then
            activeCamLockTarget = getLowestHPPlayer()
        end

        if activeCamLockTarget and activeCamLockTarget.Character then
            local enemyHrp = activeCamLockTarget.Character:FindFirstChild("HumanoidRootPart")
            if enemyHrp and camera then
                camera.CFrame = CFrame.new(camera.CFrame.Position, enemyHrp.Position)
            end
        else
            activeCamLockTarget = nil
        end
    else
        activeCamLockTarget = nil
    end

    -- Отрисовка ESP & Health Bars
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            updateHealthESP(plr)

            if plr.Character then
                local char = plr.Character
                local isCurrent = (plr == activeAutoSkillTarget or plr == activeCamLockTarget)

                local hl = char:FindFirstChild("ESPHighlight")
                if isCurrent then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "ESPHighlight"
                        hl.Parent = char
                    end
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                else
                    if Settings.ESP then
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.Name = "ESPHighlight"
                            hl.Parent = char
                        end
                        hl.FillColor = Color3.fromRGB(255, 50, 50)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    else
                        if hl then hl:Destroy() end
                    end
                end
            end
        end
    end
end)
