repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local targetParent = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")

if targetParent:FindFirstChild("PureModMenu_Delta") then
    targetParent.PureModMenu_Delta:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PureModMenu_Delta"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999999
screenGui.Parent = targetParent

-- === ПЛАВАЮЩАЯ КНОПКА MENU ===
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenMenuButton"
openBtn.Size = UDim2.new(0, 75, 0, 35)
openBtn.Position = UDim2.new(0, 15, 0.25, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
openBtn.Text = "MENU"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 14
openBtn.Font = Enum.Font.SourceSansBold
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 8)
openCorner.Parent = openBtn

-- === ГЛАВНОЕ ОКНО ===
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 440)
mainFrame.Position = UDim2.new(0.5, -170, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Шапка
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
header.BorderSizePixel = 0
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "MOD MENU (FIXED AUTO FARM)"
title.TextColor3 = Color3.fromRGB(0, 242, 254)
title.TextSize = 13
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 6)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Вкладки
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, -20, 0, 30)
tabHolder.Position = UDim2.new(0, 10, 0, 46)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = mainFrame

local pageMain = Instance.new("ScrollingFrame")
pageMain.Size = UDim2.new(1, -20, 1, -90)
pageMain.Position = UDim2.new(0, 10, 0, 82)
pageMain.BackgroundTransparency = 1
pageMain.CanvasSize = UDim2.new(0, 0, 0, 280)
pageMain.ScrollBarThickness = 4
pageMain.Parent = mainFrame

local pageESP = Instance.new("ScrollingFrame")
pageESP.Size = UDim2.new(1, -20, 1, -90)
pageESP.Position = UDim2.new(0, 10, 0, 82)
pageESP.BackgroundTransparency = 1
pageESP.Visible = false
pageESP.CanvasSize = UDim2.new(0, 0, 0, 280)
pageESP.ScrollBarThickness = 4
pageESP.Parent = mainFrame

local pageFarm = Instance.new("ScrollingFrame")
pageFarm.Size = UDim2.new(1, -20, 1, -90)
pageFarm.Position = UDim2.new(0, 10, 0, 82)
pageFarm.BackgroundTransparency = 1
pageFarm.Visible = false
pageFarm.CanvasSize = UDim2.new(0, 0, 0, 320)
pageFarm.ScrollBarThickness = 4
pageFarm.Parent = mainFrame

for _, p in pairs({pageMain, pageESP, pageFarm}) do
    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, 8)
    l.Parent = p
end

local function createTabBtn(text, active)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.33, -4, 1, 0)
    btn.BackgroundColor3 = active and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(30, 30, 42)
    btn.Text = text
    btn.TextColor3 = active and Color3.fromRGB(15, 15, 20) or Color3.fromRGB(200, 200, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = tabHolder

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    return btn
end

local btnTabMain = createTabBtn("Main", true)
local btnTabESP = createTabBtn("ESP", false)
local btnTabFarm = createTabBtn("Auto Farm", false)

local function switchTab(activeBtn, targetPage)
    pageMain.Visible = (targetPage == pageMain)
    pageESP.Visible = (targetPage == pageESP)
    pageFarm.Visible = (targetPage == pageFarm)

    for _, btn in pairs({btnTabMain, btnTabESP, btnTabFarm}) do
        if btn == activeBtn then
            btn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
            btn.TextColor3 = Color3.fromRGB(15, 15, 20)
        else
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

btnTabMain.MouseButton1Click:Connect(function() switchTab(btnTabMain, pageMain) end)
btnTabESP.MouseButton1Click:Connect(function() switchTab(btnTabESP, pageESP) end)
btnTabFarm.MouseButton1Click:Connect(function() switchTab(btnTabFarm, pageFarm) end)

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- === MAIN (SpeedHack + Slider) ===
local isBypassed = false
local speedActive = false
local speedValue = 50
local speedConn = nil

createButton(pageMain, "Bypass AntiCheat", function(btn)
    if isBypassed then return end
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            local oldH = char:FindFirstChildOfClass("Humanoid")
            local newH = oldH:Clone()
            oldH:Destroy()
            newH.Parent = char
            workspace.CurrentCamera.CameraSubject = newH
            isBypassed = true
            btn.Text = "Bypass: АКТИВИРОВАН"
            btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        end
    end)
end)

createButton(pageMain, "SpeedHack CFrame: ВЫКЛ", function(btn)
    speedActive = not speedActive
    if speedConn then speedConn:Disconnect() speedConn = nil end

    if speedActive then
        btn.Text = "SpeedHack CFrame: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        speedConn = RunService.Heartbeat:Connect(function(dt)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local root = char.HumanoidRootPart
                    if hum.MoveDirection.Magnitude > 0 then
                        root.CFrame = root.CFrame + (hum.MoveDirection * speedValue * dt)
                    end
                end
            end)
        end)
    else
        btn.Text = "SpeedHack CFrame: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end)

-- Слайдер Скорости (Нормальный диапазон до 250, чтобы не кикало)
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(1, 0, 0, 45)
sliderFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
sliderFrame.Parent = pageMain

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(1, -10, 0, 20)
sliderLabel.Position = UDim2.new(0, 5, 0, 2)
sliderLabel.Text = "Скорость: 50"
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.TextSize = 12
sliderLabel.Font = Enum.Font.SourceSansBold
sliderLabel.BackgroundTransparency = 1
sliderLabel.Parent = sliderFrame

local sliderBar = Instance.new("Frame")
sliderBar.Size = UDim2.new(1, -20, 0, 8)
sliderBar.Position = UDim2.new(0, 10, 0, 26)
sliderBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
sliderBar.Parent = sliderFrame

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.2, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
sliderFill.Parent = sliderBar

local isSliding = false
local function updateSlider(input)
    local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
    speedValue = math.floor(16 + (pos * 234))
    sliderLabel.Text = "Скорость: " .. tostring(speedValue)
end

sliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = true
        updateSlider(input)
    end
end)

sliderBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)

-- === ESP ===
local espFolder = Instance.new("Folder")
espFolder.Name = "DeltaESP_Folder"
espFolder.Parent = targetParent

local function getEggFolder()
    return workspace:FindFirstChild("AreaEggSlotsClient", true) or workspace:FindFirstChild("ArcaEggSlotsClient", true)
end

local function clearESP(tag)
    for _, item in pairs(espFolder:GetChildren()) do
        if string.find(item.Name, "^" .. tag) then
            item:Destroy()
        end
    end
end

local function drawESP(model, text, color, tag)
    if not model then return end
    pcall(function()
        local part = model:IsA("BasePart") and model or model:FindFirstChildWhichIsA("BasePart", true)
        if not part then return end

        local bb = Instance.new("BillboardGui")
        bb.Name = tag .. "_" .. tostring(model:GetDebugId())
        bb.Adornee = part
        bb.Size = UDim2.new(0, 100, 0, 25)
        bb.AlwaysOnTop = true
        bb.Parent = espFolder

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = color
        lbl.TextStrokeTransparency = 0
        lbl.TextSize = 13
        lbl.Font = Enum.Font.SourceSansBold
        lbl.Parent = bb
    end)
end

local function checkEffects(obj)
    for _, child in pairs(obj:GetDescendants()) do
        if string.find(string.lower(child.Name), "fx") or child:IsA("ParticleEmitter") or child:IsA("Beam") then
            return true
        end
    end
    return false
end

local espBiggest = false
local espBiggestThread = nil
createButton(pageESP, "ESP Biggest Egg: ВЫКЛ", function(btn)
    espBiggest = not espBiggest
    if espBiggest then
        btn.Text = "ESP Biggest Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        espBiggestThread = task.spawn(function()
            while espBiggest do
                clearESP("ESP_B")
                local folder = getEggFolder()
                if folder then
                    local biggest = nil
                    local maxV = 0
                    for _, child in pairs(folder:GetChildren()) do
                        pcall(function()
                            local sz = child:IsA("Model") and select(2, child:GetBoundingBox()) or child.Size
                            local v = sz.X * sz.Y * sz.Z
                            if v > maxV then maxV = v; biggest = child end
                        end)
                    end
                    if biggest then drawESP(biggest, "[BIGGEST]", Color3.fromRGB(170, 0, 255), "ESP_B") end
                end
                task.wait(1.5)
            end
        end)
    else
        btn.Text = "ESP Biggest Egg: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        if espBiggestThread then task.cancel(espBiggestThread) end
        clearESP("ESP_B")
    end
end)

local espParasite = false
local espParasiteThread = nil
createButton(pageESP, "ESP Parasite Egg: ВЫКЛ", function(btn)
    espParasite = not espParasite
    if espParasite then
        btn.Text = "ESP Parasite Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        espParasiteThread = task.spawn(function()
            while espParasite do
                clearESP("ESP_P")
                local folder = getEggFolder()
                if folder then
                    for _, child in pairs(folder:GetChildren()) do
                        pcall(function()
                            for _, desc in pairs(child:GetDescendants()) do
                                if desc.Name == "MonsterParasiteVisual" then
                                    drawESP(child, "[PARASITE]", Color3.fromRGB(0, 255, 100), "ESP_P")
                                end
                            end
                        end)
                    end
                end
                task.wait(1.5)
            end
        end)
    else
        btn.Text = "ESP Parasite Egg: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        if espParasiteThread then task.cancel(espParasiteThread) end
        clearESP("ESP_P")
    end
end)

local espSecret = false
local espSecretThread = nil
createButton(pageESP, "ESP Secret Egg: ВЫКЛ", function(btn)
    espSecret = not espSecret
    if espSecret then
        btn.Text = "ESP Secret Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        espSecretThread = task.spawn(function()
            while espSecret do
                clearESP("ESP_S")
                local folder = getEggFolder()
                if folder then
                    for _, child in pairs(folder:GetChildren()) do
                        pcall(function()
                            if checkEffects(child) then
                                drawESP(child, "[SECRET]", Color3.fromRGB(255, 215, 0), "ESP_S")
                            end
                        end)
                    end
                end
                task.wait(1.5)
            end
        end)
    else
        btn.Text = "ESP Secret Egg: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        if espSecretThread then task.cancel(espSecretThread) end
        clearESP("ESP_S")
    end
end)

-- === AUTO FARM + SAVE BASE ===
local eggType = "Biggest Egg"
local farmActive = false
local farmThread = nil
local savedBasePosition = nil

createButton(pageFarm, "Egg Type: Biggest Egg", function(btn)
    if eggType == "Biggest Egg" then
        eggType = "Parasite Egg"
    elseif eggType == "Parasite Egg" then
        eggType = "Secret Egg"
    else
        eggType = "Biggest Egg"
    end
    btn.Text = "Egg Type: " .. eggType
end)

createButton(pageFarm, "Save Base (Текущая позиция)", function(btn)
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            savedBasePosition = char.HumanoidRootPart.Position
            btn.Text = "Base Saved! ✓"
            btn.TextColor3 = Color3.fromRGB(0, 255, 100)
            task.wait(1.5)
            btn.Text = "Save Base (Текущая позиция)"
            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
    end)
end)

local function getTargetEgg()
    local folder = getEggFolder()
    if not folder then return nil end
    local list = folder:GetChildren()
    
    if eggType == "Biggest Egg" then
        local target = nil
        local maxV = 0
        for _, child in pairs(list) do
            pcall(function()
                local sz = child:IsA("Model") and select(2, child:GetBoundingBox()) or child.Size
                local v = sz.X * sz.Y * sz.Z
                if v > maxV then maxV = v; target = child end
            end)
        end
        return target
    elseif eggType == "Parasite Egg" then
        for _, child in pairs(list) do
            for _, desc in pairs(child:GetDescendants()) do
                if desc.Name == "MonsterParasiteVisual" then return child end
            end
        end
    elseif eggType == "Secret Egg" then
        for _, child in pairs(list) do
            if checkEffects(child) then return child end
        end
    end
    return nil
end

local function smoothMoveTo(targetPos)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    while farmActive and char and root and root.Parent do
        local currentPos = root.Position
        local dist = (targetPos - currentPos).Magnitude

        if dist <= 3 then
            root.CFrame = CFrame.new(targetPos)
            break
        end

        local dir = (targetPos - currentPos).Unit
        local dt = task.wait()
        local moveStep = math.min(dist, speedValue * dt)
        root.CFrame = CFrame.new(currentPos + dir * moveStep)
    end
end

local function hasEggInHand()
    local char = LocalPlayer.Character
    if not char then return false end
    for _, item in pairs(char:GetChildren()) do
        if item:IsA("Tool") then
            return true
        end
    end
    return false
end

createButton(pageFarm, "Auto Farm: ВЫКЛ", function(btn)
    farmActive = not farmActive
    if farmActive then
        btn.Text = "Auto Farm: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)

        -- Если база не была сохранена вручную, берем текущую точку при включении
        if not savedBasePosition then
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    savedBasePosition = char.HumanoidRootPart.Position
                end
            end)
        end

        farmThread = task.spawn(function()
            while farmActive do
                pcall(function()
                    local egg = getTargetEgg()
                    if egg and egg.Parent then
                        local eggPos = egg:IsA("Model") and egg:GetPivot().Position or egg.Position
                        
                        -- 1. Идем к яйцу
                        smoothMoveTo(eggPos + Vector3.new(0, 2, 0))

                        -- 2. Взаимодействуем и ЖДЕМ пока яйцо окажется в руках
                        if farmActive and egg and egg.Parent then
                            local prompt = egg:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                prompt:InputHoldBegin()
                                
                                local waitTimer = 0
                                while farmActive and not hasEggInHand() and waitTimer < 5 do
                                    task.wait(0.1)
                                    waitTimer = waitTimer + 0.1
                                end
                                
                                prompt:InputHoldEnd()
                            end
                        end

                        task.wait(0.2)

                        -- 3. Летим на сохраненную базу
                        if farmActive and savedBasePosition then
                            smoothMoveTo(savedBasePosition + Vector3.new(0, 3, 0))
                            task.wait(0.8) -- Даем время сбросить яйцо на базе
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    else
        btn.Text = "Auto Farm: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        if farmThread then task.cancel(farmThread) end
    end
end)
