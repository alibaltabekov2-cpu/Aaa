repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local targetParent = (gethui and gethui()) or CoreGui

if targetParent:FindFirstChild("PureModMenu_Final") then
    targetParent.PureModMenu_Final:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PureModMenu_Final"
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
mainFrame.Size = UDim2.new(0, 360, 0, 460)
mainFrame.Position = UDim2.new(0.5, -180, 0.2, 0)
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

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "MOD MENU: PRO FARM"
title.TextColor3 = Color3.fromRGB(0, 242, 254)
title.TextSize = 14
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

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
openBtn.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

-- === ВКЛАДКИ ===
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, -20, 0, 32)
tabHolder.Position = UDim2.new(0, 10, 0, 48)
tabHolder.BackgroundTransparency = 1
tabHolder.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabHolder

local pagesContainer = Instance.new("Frame")
pagesContainer.Size = UDim2.new(1, -20, 1, -92)
pagesContainer.Position = UDim2.new(0, 10, 0, 86)
pagesContainer.BackgroundTransparency = 1
pagesContainer.Parent = mainFrame

local tabs = {}

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.32, -4, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(170, 170, 170)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = tabHolder

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 0, 420)
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = pagesContainer

    local l = Instance.new("UIListLayout")
    l.Padding = UDim.new(0, 8)
    l.Parent = page

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
            t.btn.TextColor3 = Color3.fromRGB(170, 170, 170)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
        btn.TextColor3 = Color3.fromRGB(15, 15, 20)
    end)

    table.insert(tabs, {btn = btn, page = page})
    return page
end

local mainPage = createTab("Main")
local espPage = createTab("ESP")
local farmPage = createTab("Auto Farm")

tabs[1].page.Visible = true
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
tabs[1].btn.TextColor3 = Color3.fromRGB(15, 15, 20)

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

--------------------------------------------------------------------------------
-- 1. MAIN
--------------------------------------------------------------------------------
local isBypassed = false

createButton(mainPage, "Anti-Cheat Bypass: ВЫКЛ", function(btn)
    if isBypassed then return end
    pcall(function()
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            local newH = hum:Clone()
            hum:Destroy()
            newH.Parent = char
            workspace.CurrentCamera.CameraSubject = newH
            newH:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            newH:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
        for _, child in pairs(char:GetChildren()) do
            if child:IsA("LocalScript") and not string.find(child.Name, "Animate") then
                child.Disabled = true
                child:Destroy()
            end
        end
        isBypassed = true
        btn.Text = "Anti-Cheat Bypass: АКТИВИРОВАН"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
    end)
end)

local speedActive = false
local speedValue = 50
local speedConn = nil

createButton(mainPage, "Smooth SpeedHack: ВЫКЛ", function(btn)
    speedActive = not speedActive
    if speedConn then speedConn:Disconnect() speedConn = nil end

    if speedActive then
        btn.Text = "Smooth SpeedHack: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        
        speedConn = RunService.RenderStepped:Connect(function(dt)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local root = char.HumanoidRootPart
                    
                    if hum.MoveDirection.Magnitude > 0 then
                        local stepMultiplier = (speedValue / 16) - 1
                        if stepMultiplier > 0 then
                            local moveVector = hum.MoveDirection * (hum.WalkSpeed * stepMultiplier * dt)
                            root.CFrame = root.CFrame + moveVector
                        end
                    end
                end
            end)
        end)
    else
        btn.Text = "Smooth SpeedHack: ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end)

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(1, 0, 0, 45)
sliderFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
sliderFrame.Parent = mainPage

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 6)
sliderCorner.Parent = sliderFrame

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

--------------------------------------------------------------------------------
-- 2. ESP
--------------------------------------------------------------------------------
local espFolder = Instance.new("Folder")
espFolder.Name = "DeltaESP_Folder"
espFolder.Parent = screenGui

local function getArcaFolder()
    return workspace:FindFirstChild("ArcaEggSlotsClient", true)
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
createButton(espPage, "ESP Biggest Egg: ВЫКЛ", function(btn)
    espBiggest = not espBiggest
    if espBiggest then
        btn.Text = "ESP Biggest Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        task.spawn(function()
            while espBiggest do
                clearESP("ESP_B")
                local folder = getArcaFolder()
                if folder then
                    local biggest = nil
                    local maxV = 0
                    for _, child in pairs(folder:GetChildren()) do
                        pcall(function()
                            local sz = child:IsA("Model") and select(2, child:GetBoundingBox()) or (child:IsA("BasePart") and child.Size or Vector3.new(0,0,0))
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
        clearESP("ESP_B")
    end
end)

local espParasite = false
createButton(espPage, "ESP Parasite Egg: ВЫКЛ", function(btn)
    espParasite = not espParasite
    if espParasite then
        btn.Text = "ESP Parasite Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        task.spawn(function()
            while espParasite do
                clearESP("ESP_P")
                local folder = getArcaFolder()
                if folder then
                    for _, child in pairs(folder:GetChildren()) do
                        pcall(function()
                            for _, desc in pairs(child:GetDescendants()) do
                                if desc.Name == "MonsterParasiteVisual" then
                                    drawESP(child, "[PARASITE]", Color3.fromRGB(0, 255, 100), "ESP_P")
                                    break
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
        clearESP("ESP_P")
    end
end)

local espSecret = false
createButton(espPage, "ESP Secret Egg: ВЫКЛ", function(btn)
    espSecret = not espSecret
    if espSecret then
        btn.Text = "ESP Secret Egg: ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)
        task.spawn(function()
            while espSecret do
                clearESP("ESP_S")
                local folder = getArcaFolder()
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
        clearESP("ESP_S")
    end
end)

--------------------------------------------------------------------------------
-- 3. AUTO FARM
--------------------------------------------------------------------------------
local selectedEggType = "Biggest Egg"
local selectedZoneName = "All Zones"
local farmActive = false

local typeBtn = createButton(farmPage, "Egg Type: Biggest Egg", function()
    if selectedEggType == "Biggest Egg" then
        selectedEggType = "Parasite Egg"
    elseif selectedEggType == "Parasite Egg" then
        selectedEggType = "Secret Egg"
    else
        selectedEggType = "Biggest Egg"
    end
    typeBtn.Text = "Egg Type: " .. selectedEggType
end)

local zoneBtn = createButton(farmPage, "Zone: All Zones", function() end)

local function getZones()
    local zones = {}
    pcall(function()
        local signs = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "RequiredSpeedSign" then
                local ground = obj.Parent and obj.Parent:FindFirstChild("Ground") or nil
                if not ground then
                    for _, d in pairs(obj.Parent:GetChildren()) do
                        if d.Name == "Ground" then ground = d break end
                    end
                end
                if ground then
                    local dist = (obj.Position - ground.Position).Magnitude
                    table.insert(signs, {sign = obj, ground = ground, dist = dist})
                end
            end
        end
        table.sort(signs, function(a, b) return a.dist < b.dist end)
        for i, data in ipairs(signs) do
            table.insert(zones, {name = "Zone " .. i, sign = data.sign, ground = data.ground})
        end
    end)
    return zones
end

zoneBtn.MouseButton1Click:Connect(function()
    local zones = getZones()
    if selectedZoneName == "All Zones" then
        if #zones > 0 then selectedZoneName = zones[1].name end
    else
        local foundIdx = nil
        for i, z in ipairs(zones) do
            if z.name == selectedZoneName then foundIdx = i break end
        end
        if foundIdx and foundIdx < #zones then
            selectedZoneName = zones[foundIdx + 1].name
        else
            selectedZoneName = "All Zones"
        end
    end
    zoneBtn.Text = "Zone: " .. selectedZoneName
end)

local function getAreaFolder()
    return workspace:FindFirstChild("AreaEggSlotsClient", true)
end

local function getEggsInZone()
    local folder = getAreaFolder()
    if not folder then return {} end

    local zones = getZones()
    local eggs = {}

    for _, egg in pairs(folder:GetChildren()) do
        pcall(function()
            local eggPos = egg:IsA("Model") and egg:GetPivot().Position or (egg:IsA("BasePart") and egg.Position or nil)
            if eggPos then
                if selectedZoneName == "All Zones" then
                    table.insert(eggs, {egg = egg, pos = eggPos})
                else
                    local closestZone = nil
                    local minD = math.huge
                    for _, z in ipairs(zones) do
                        local d = (eggPos - z.sign.Position).Magnitude
                        if d < minD then
                            minD = d
                            closestZone = z.name
                        end
                    end
                    if closestZone == selectedZoneName then
                        table.insert(eggs, {egg = egg, pos = eggPos})
                    end
                end
            end
        end)
    end
    return eggs, zones
end

local function selectBestEgg()
    local eggs, zones = getEggsInZone()
    if #eggs == 0 then return nil, zones end

    if selectedEggType == "Biggest Egg" then
        local best = nil
        local maxV = 0
        for _, item in pairs(eggs) do
            pcall(function()
                local sz = item.egg:IsA("Model") and select(2, item.egg:GetBoundingBox()) or (item.egg:IsA("BasePart") and item.egg.Size or Vector3.new(1,1,1))
                local v = sz.X * sz.Y * sz.Z
                if v > maxV then maxV = v; best = item end
            end)
        end
        return best, zones
    elseif selectedEggType == "Parasite Egg" then
        for _, item in pairs(eggs) do
            local isP = false
            for _, desc in pairs(item.egg:GetDescendants()) do
                if desc.Name == "MonsterParasiteVisual" then isP = true break end
            end
            if isP then return item, zones end
        end
    elseif selectedEggType == "Secret Egg" then
        for _, item in pairs(eggs) do
            if checkEffects(item.egg) then return item, zones end
        end
    end
    return nil, zones
end

local function smoothMoveTo(targetPos)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRoot")
    if not root then return end

    while farmActive and char and root and root.Parent do
        local currentPos = root.Position
        local dist = (targetPos - currentPos).Magnitude

        if dist <= 2.5 then
            root.CFrame = CFrame.new(targetPos)
            break
        end

        local dir = (targetPos - currentPos).Unit
        local dt = task.wait()
        local currentSpeed = speedActive and speedValue or 32
        local moveStep = math.min(dist, currentSpeed * dt)
        root.CFrame = root.CFrame + (dir * moveStep)
    end
end

local function hasEggInHand()
    local char = LocalPlayer.Character
    if not char then return false end
    for _, item in pairs(char:GetChildren()) do
        if item:IsA("Model") or item:IsA("Tool") or string.find(string.lower(item.Name), "egg") then
            return true
        end
    end
    return false
end

local function getGroundForZone(zones)
    if selectedZoneName == "All Zones" then
        return zones[1] and zones[1].ground or nil
    else
        for _, z in ipairs(zones) do
            if z.name == selectedZoneName then return z.ground end
        end
    end
    return zones[1] and zones[1].ground or nil
end

local farmThread = nil

createButton(farmPage, "Auto Farm (Steal & Base): ВЫКЛ", function(btn)
    farmActive = not farmActive

    if farmActive then
        btn.Text = "Auto Farm (Steal & Base): ВКЛ"
        btn.TextColor3 = Color3.fromRGB(0, 242, 254)

        farmThread = task.spawn(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local basePosition = root and root.Position or nil

            while farmActive do
                pcall(function()
                    local best, zones = selectBestEgg()
                    if best then
                        local groundData = getGroundForZone(zones)
                        if basePosition == nil and groundData then
                            basePosition = groundData.Position
                        end

                        -- 1. Движемся к яйцу
                        smoothMoveTo(best.pos)
                        task.wait(0.2)

                        -- 2. Активируем ProximityPrompt
                        local target = best.egg
                        if target then
                            local prompt = target:FindFirstChildWhichIsA("ProximityPrompt", true)
                            if prompt then
                                prompt:InputHoldBegin()
                                task.wait(1.2)
                                prompt:InputHoldEnd()
                            end
                        end

                        -- 3. Ждем, пока яйцо окажется в руках (максимум 3 секунды)
                        local startTime = tick()
                        while farmActive and not hasEggInHand() and (tick() - startTime) < 3 do
                            task.wait(0.2)
                        end

                        -- 4. Возвращаемся на базу/землю
                        if basePosition then
                            smoothMoveTo(basePosition)
                            task.wait(0.5)
                            
                            pcall(function()
                                local c = LocalPlayer.Character
                                if c then
                                    for _, tool in pairs(c:GetChildren()) do
                                        if tool:IsA("Tool") then
                                            tool:Activate()
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        btn.Text = "Auto Farm (Steal & Base): ВЫКЛ"
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        if farmThread then
            task.cancel(farmThread)
            farmThread = nil
        end
    end
end)

print("[MOD MENU] ВСЕ КОМПОНЕНТЫ УСПЕШНО ЗАГРУЖЕНЫ!")
