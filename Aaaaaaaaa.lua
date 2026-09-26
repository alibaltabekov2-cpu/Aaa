print("==================================")
print("[MOD MENU] Запуск полного меню...")

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

    -- Контейнер интерфейса
    local targetParent = nil
    if gethui then
        targetParent = gethui()
    else
        local ok, core = pcall(function() return game:GetService("CoreGui") end)
        if ok and core then 
            targetParent = core 
        else 
            targetParent = LocalPlayer:WaitForChild("PlayerGui", 5) 
        end
    end

    if not targetParent then error("UI Container not found") end

    if targetParent:FindFirstChild("PureModMenu_Full") then
        targetParent.PureModMenu_Full:Destroy()
    end

    -- Gui Root
    local sg = Instance.new("ScreenGui")
    sg.Name = "PureModMenu_Full"
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 999999
    sg.Parent = targetParent

    -- Кнопка MENU
    local openBtn = Instance.new("TextButton")
    openBtn.Name = "OpenBtn"
    openBtn.Size = UDim2.new(0, 75, 0, 36)
    openBtn.Position = UDim2.new(0, 15, 0.3, 0)
    openBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    openBtn.Text = "MENU"
    openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    openBtn.TextSize = 15
    openBtn.Font = Enum.Font.SourceSansBold
    openBtn.Active = true
    openBtn.Draggable = true
    openBtn.ZIndex = 10000
    openBtn.Parent = sg

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = openBtn

    -- Главное Окно
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 310, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -155, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Visible = true
    mainFrame.ZIndex = 9999
    mainFrame.Parent = sg

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = mainFrame

    -- Шапка
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 38)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    header.BorderSizePixel = 0
    header.ZIndex = 10000
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "MOD MENU (DELTA)"
    title.TextColor3 = Color3.fromRGB(0, 242, 254)
    title.TextSize = 13
    title.Font = Enum.Font.SourceSansBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.ZIndex = 10001
    title.Parent = header

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.Position = UDim2.new(1, -30, 0, 6)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.ZIndex = 10001
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    openBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)

    -- Навигация вкладок
    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, -20, 0, 30)
    tabHolder.Position = UDim2.new(0, 10, 0, 44)
    tabHolder.BackgroundTransparency = 1
    tabHolder.ZIndex = 10000
    tabHolder.Parent = mainFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabHolder

    local pageMain = Instance.new("ScrollingFrame")
    pageMain.Size = UDim2.new(1, -20, 1, -85)
    pageMain.Position = UDim2.new(0, 10, 0, 80)
    pageMain.BackgroundTransparency = 1
    pageMain.CanvasSize = UDim2.new(0, 0, 0, 260)
    pageMain.ScrollBarThickness = 3
    pageMain.ZIndex = 10000
    pageMain.Parent = mainFrame

    local pageESP = Instance.new("ScrollingFrame")
    pageESP.Size = UDim2.new(1, -20, 1, -85)
    pageESP.Position = UDim2.new(0, 10, 0, 80)
    pageESP.BackgroundTransparency = 1
    pageESP.Visible = false
    pageESP.CanvasSize = UDim2.new(0, 0, 0, 260)
    pageESP.ScrollBarThickness = 3
    pageESP.ZIndex = 10000
    pageESP.Parent = mainFrame

    local pageFarm = Instance.new("ScrollingFrame")
    pageFarm.Size = UDim2.new(1, -20, 1, -85)
    pageFarm.Position = UDim2.new(0, 10, 0, 80)
    pageFarm.BackgroundTransparency = 1
    pageFarm.Visible = false
    pageFarm.CanvasSize = UDim2.new(0, 0, 0, 280)
    pageFarm.ScrollBarThickness = 3
    pageFarm.ZIndex = 10000
    pageFarm.Parent = mainFrame

    for _, p in pairs({pageMain, pageESP, pageFarm}) do
        local l = Instance.new("UIListLayout")
        l.Padding = UDim.new(0, 8)
        l.Parent = p
    end

    local function createTabBtn(text, active)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.33, -4, 1, 0)
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(32, 32, 44)
        btn.Text = text
        btn.TextColor3 = active and Color3.fromRGB(15, 15, 20) or Color3.fromRGB(200, 200, 200)
        btn.TextSize = 12
        btn.Font = Enum.Font.SourceSansBold
        btn.ZIndex = 10001
        btn.Parent = tabHolder
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
                btn.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
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
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        btn.TextSize = 13
        btn.Font = Enum.Font.SourceSansBold
        btn.ZIndex = 10001
        btn.Parent = parent

        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 6)
        c.Parent = btn

        btn.MouseButton1Click:Connect(function() callback(btn) end)
        return btn
    end

    -- === MAIN ===
    local isBypassed = false
    local speedActive = false
    local speedValue = 100
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

    -- Слайдер Скорости
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 45)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    sliderFrame.ZIndex = 10001
    sliderFrame.Parent = pageMain

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = sliderFrame

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, -10, 0, 20)
    sliderLabel.Position = UDim2.new(0, 5, 0, 2)
    sliderLabel.Text = "Скорость: 100"
    sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    sliderLabel.TextSize = 12
    sliderLabel.Font = Enum.Font.SourceSansBold
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.ZIndex = 10002
    sliderLabel.Parent = sliderFrame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -20, 0, 8)
    sliderBar.Position = UDim2.new(0, 10, 0, 26)
    sliderBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    sliderBar.ZIndex = 10002
    sliderBar.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0.1, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 242, 254)
    sliderFill.ZIndex = 10003
    sliderFill.Parent = sliderBar

    local isSliding = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        speedValue = math.floor(16 + (pos * 984))
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
        return workspace:FindFirstChild("AreaEggSlotsClient", true) or workspace:FindFirstChild("ArcaEggSlotsClient", true) or workspace:FindFirstChild("World", true)
    end

    local function clearESP(tag)
        for _, item in pairs(espFolder:GetChildren()) do
            if string.find(item.Name, "^" .. tag) then item:Destroy() end
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

    local espBiggest, espParasite, espSecret = false, false, false
    local tB, tP, tS

    createButton(pageESP, "ESP Biggest Egg: ВЫКЛ", function(btn)
        espBiggest = not espBiggest
        btn.Text = espBiggest and "ESP Biggest Egg: ВКЛ" or "ESP Biggest Egg: ВЫКЛ"
        btn.TextColor3 = espBiggest and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(220, 220, 220)
        if espBiggest then
            tB = task.spawn(function()
                while espBiggest do
                    clearESP("ESP_B")
                    local folder = getEggFolder()
                    if folder then
                        local biggest, maxV = nil, 0
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
            if tB then task.cancel(tB) end
            clearESP("ESP_B")
        end
    end)

    createButton(pageESP, "ESP Parasite Egg: ВЫКЛ", function(btn)
        espParasite = not espParasite
        btn.Text = espParasite and "ESP Parasite Egg: ВКЛ" or "ESP Parasite Egg: ВЫКЛ"
        btn.TextColor3 = espParasite and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(220, 220, 220)
        if espParasite then
            tP = task.spawn(function()
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
            if tP then task.cancel(tP) end
            clearESP("ESP_P")
        end
    end)

    createButton(pageESP, "ESP Secret Egg: ВЫКЛ", function(btn)
        espSecret = not espSecret
        btn.Text = espSecret and "ESP Secret Egg: ВКЛ" or "ESP Secret Egg: ВЫКЛ"
        btn.TextColor3 = espSecret and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(220, 220, 220)
        if espSecret then
            tS = task.spawn(function()
                while espSecret do
                    clearESP("ESP_S")
                    local folder = getEggFolder()
                    if folder then
                        for _, child in pairs(folder:GetChildren()) do
                            pcall(function()
                                for _, d in pairs(child:GetDescendants()) do
                                    if string.find(string.lower(d.Name), "fx") or d:IsA("ParticleEmitter") then
                                        drawESP(child, "[SECRET]", Color3.fromRGB(255, 215, 0), "ESP_S")
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
            if tS then task.cancel(tS) end
            clearESP("ESP_S")
        end
    end)

    -- === AUTO FARM ===
    local eggType = "Biggest Egg"
    local farmActive = false
    local farmThread = nil
    local basePosition = nil

    createButton(pageFarm, "Egg Type: Biggest Egg", function(btn)
        if eggType == "Biggest Egg" then eggType = "Parasite Egg"
        elseif eggType == "Parasite Egg" then eggType = "Secret Egg"
        else eggType = "Biggest Egg" end
        btn.Text = "Egg Type: " .. eggType
    end)

    createButton(pageFarm, "Set Base: НЕ ЗАДАНА", function(btn)
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                basePosition = char.HumanoidRootPart.Position
                btn.Text = "Set Base: ЗАДАНА"
                btn.TextColor3 = Color3.fromRGB(0, 242, 254)
            end
        end)
    end)

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

    createButton(pageFarm, "Auto Farm (Steal & Base): ВЫКЛ", function(btn)
        farmActive = not farmActive
        btn.Text = farmActive and "Auto Farm (Steal & Base): ВКЛ" or "Auto Farm (Steal & Base): ВЫКЛ"
        btn.TextColor3 = farmActive and Color3.fromRGB(0, 242, 254) or Color3.fromRGB(220, 220, 220)

        if farmActive then
            if not basePosition then
                pcall(function()
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        basePosition = char.HumanoidRootPart.Position
                    end
                end)
            end

            farmThread = task.spawn(function()
                while farmActive do
                    pcall(function()
                        local folder = getEggFolder()
                        if folder then
                            local target = nil
                            if eggType == "Biggest Egg" then
                                local maxV = 0
                                for _, child in pairs(folder:GetChildren()) do
                                    local sz = child:IsA("Model") and select(2, child:GetBoundingBox()) or child.Size
                                    local v = sz.X * sz.Y * sz.Z
                                    if v > maxV then maxV = v; target = child end
                                end
                            elseif eggType == "Parasite Egg" then
                                for _, child in pairs(folder:GetChildren()) do
                                    for _, desc in pairs(child:GetDescendants()) do
                                        if desc.Name == "MonsterParasiteVisual" then
                                            target = child
                                            break
                                        end
                                    end
                                    if target then break end
                                end
                            elseif eggType == "Secret Egg" then
                                for _, child in pairs(folder:GetChildren()) do
                                    for _, d in pairs(child:GetDescendants()) do
                                        if string.find(string.lower(d.Name), "fx") or d:IsA("ParticleEmitter") then
                                            target = child
                                            break
                                        end
                                    end
                                    if target then break end
                                end
                            end

                            if target then
                                local part = target:IsA("BasePart") and target or target:FindFirstChildWhichIsA("BasePart", true)
                                if part then
                                    smoothMoveTo(part.Position)
                                    task.wait(0.5)

                                    local prompt = target:FindFirstChildWhichIsA("ProximityPrompt", true)
                                    if prompt then
                                        prompt:InputHoldBegin()
                                        task.wait(1.5)
                                        prompt:InputHoldEnd()
                                    end

                                    if basePosition then
                                        smoothMoveTo(basePosition)
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        else
            if farmThread then task.cancel(farmThread) end
        end
    end)
end)

if not success then
    warn("[MOD MENU ERROR]: " .. tostring(err))
else
    print("[MOD MENU] Меню успешно запущено!")
end
