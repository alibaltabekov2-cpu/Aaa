-- ==========================================================
--   BRAINROT MERGE | CLEAN MOD MENU (ONLY AUTO MERGE)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Удаляем старое меню при перезапуске
if PlayerGui:FindFirstChild("BrainRotModMenuFix") then
    PlayerGui.BrainRotModMenuFix:Destroy()
end

local AutoMergeEnabled = false

-- 1. СОЗДАНИЕ ИНТЕРФЕЙСА
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainRotModMenuFix"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Главное окно
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 180)
main.Position = UDim2.new(0.5, -180, 0.35, -90)
main.BackgroundColor3 = Color3.fromRGB(18, 16, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(160, 32, 240)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

-- Кнопка Открыть/Закрыть (Плавающая кнопка на экране)
local openToggleBtn = Instance.new("TextButton")
openToggleBtn.Size = UDim2.new(0, 45, 0, 45)
openToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
openToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
openToggleBtn.Text = "🧠"
openToggleBtn.TextSize = 22
openToggleBtn.Parent = screenGui
openToggleBtn.Active = true
openToggleBtn.Draggable = true
Instance.new("UICorner", openToggleBtn).CornerRadius = UDim.new(0, 10)

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(160, 32, 240)
openStroke.Thickness = 1.5
openStroke.Parent = openToggleBtn

openToggleBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Шапка с кнопкой закрытия (X)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
topBar.BorderSizePixel = 0
topBar.Parent = main
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 BRAINROT MERGE | <font color='#a020f0'>HUB</font>"
title.RichText = true
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Левая панель (Только вкладка Farm)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 100, 1, -45)
tabContainer.Position = UDim2.new(0, 8, 0, 40)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = main

local farmTabBtn = Instance.new("TextButton")
farmTabBtn.Size = UDim2.new(1, 0, 0, 32)
farmTabBtn.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
farmTabBtn.Text = "⚡ Farm"
farmTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmTabBtn.TextSize = 12
farmTabBtn.Font = Enum.Font.GothamBold
farmTabBtn.Parent = tabContainer
Instance.new("UICorner", farmTabBtn).CornerRadius = UDim.new(0, 6)

-- Контейнер содержимого
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -122, 1, -45)
contentFrame.Position = UDim2.new(0, 114, 0, 40)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = main
Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

-- Переключатель Auto Merge
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, -12, 0, 40)
toggleFrame.Position = UDim2.new(0, 6, 0, 10)
toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 52)
toggleFrame.Parent = contentFrame
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 6)

local toggleLbl = Instance.new("TextLabel")
toggleLbl.Size = UDim2.new(1, -55, 1, 0)
toggleLbl.Position = UDim2.new(0, 8, 0, 0)
toggleLbl.BackgroundTransparency = 1
toggleLbl.Text = "Auto Merge"
toggleLbl.TextColor3 = Color3.fromRGB(230, 230, 245)
toggleLbl.TextSize = 12
toggleLbl.Font = Enum.Font.GothamBold
toggleLbl.TextXAlignment = Enum.TextXAlignment.Left
toggleLbl.Parent = toggleFrame

local tglBtn = Instance.new("TextButton")
tglBtn.Size = UDim2.new(0, 42, 0, 22)
tglBtn.Position = UDim2.new(1, -48, 0.5, -11)
tglBtn.BackgroundColor3 = Color3.fromRGB(50, 45, 70)
tglBtn.Text = "OFF"
tglBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tglBtn.TextSize = 10
tglBtn.Font = Enum.Font.GothamBold
tglBtn.Parent = toggleFrame
Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 5)

tglBtn.MouseButton1Click:Connect(function()
    AutoMergeEnabled = not AutoMergeEnabled
    tglBtn.BackgroundColor3 = AutoMergeEnabled and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(50, 45, 70)
    tglBtn.Text = AutoMergeEnabled and "ON" or "OFF"
end)


-- 2. ЛОГИКА АВТО-ОБЪЕДИНЕНИЯ (БЕЗ НПС И ЛИШНИХ КНОПОК)

-- Функция поиска базы игрока
local function getMyBase()
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj:IsA("ObjectValue") or obj:IsA("StringValue")) and obj.Name == "Owner" and tostring(obj.Value) == LocalPlayer.Name then
            return obj.Parent
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if AutoMergeEnabled then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local myBase = getMyBase()

                if myHrp and myBase then
                    local targets = {}

                    -- Ищем интерактивные объекты ТОЛЬКО внутри твоей базы
                    for _, desc in pairs(myBase:GetDescendants()) do
                        local nameLower = desc.Name:lower()
                        
                        -- Игнорируем НПС (Декс и др.), кнопки покупки "Купить" / "Buy"
                        if not nameLower:find("декс") and not nameLower:find("dex") and not nameLower:find("buy") and not nameLower:find("купить") then
                            
                            if desc:IsA("ProximityPrompt") then
                                table.insert(targets, {type = "prompt", obj = desc, part = desc.Parent})
                            elseif desc:IsA("ClickDetector") then
                                table.insert(targets, {type = "click", obj = desc, part = desc.Parent})
                            elseif desc:IsA("Model") and desc:FindFirstChild("TouchInterest") then
                                local p = desc.PrimaryPart or desc:FindFirstChildOfClass("BasePart")
                                if p then table.insert(targets, {type = "touch", obj = desc, part = p}) end
                            end
                        end
                    end

                    -- Переходим по каждому найденному объекту слияния
                    if #targets > 0 then
                        for _, item in ipairs(targets) do
                            if not AutoMergeEnabled then break end
                            
                            local targetPart = item.part
                            if targetPart and targetPart:IsA("BasePart") then
                                -- ТП к объекту
                                myHrp.CFrame = targetPart.CFrame * CFrame.new(0, 2.5, 0)
                                task.wait(0.15)

                                -- 1 клик / взаимодействие
                                if item.type == "prompt" then
                                    fireproximityprompt(item.obj)
                                elseif item.type == "click" then
                                    fireclickdetector(item.obj)
                                elseif item.type == "touch" then
                                    firetouchinterest(myHrp, targetPart, 0)
                                    firetouchinterest(myHrp, targetPart, 1)
                                end

                                task.wait(0.35) -- Пауза без спама
                            end
                        end
                    end

                    -- Возврат на спавн базы и ожидание новых брейнротов
                    local spawnPart = myBase:FindFirstChild("Spawn") or myBase:FindFirstChild("Floor") or myBase:FindFirstChildOfClass("BasePart")
                    if spawnPart then
                        myHrp.CFrame = spawnPart.CFrame * CFrame.new(0, 4, 0)
                    end
                    task.wait(1.5)
                end
            end)
        end
        task.wait(0.3)
    end
end)
