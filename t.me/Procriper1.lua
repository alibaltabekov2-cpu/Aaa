-- ==========================================================
--   BRAINROT MERGE | ULTIMATE MOD MENU (NEW LOGIC)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старое меню, чтобы не было дубликатов
if PlayerGui:FindFirstChild("BrainRotModMenu") then
    PlayerGui.BrainRotModMenu:Destroy()
end

-- Настройки функции
_G.BrainRotSettings = _G.BrainRotSettings or {
    AutoMerge = false,
    WalkSpeedEnabled = false,
    InfJump = false
}
local Settings = _G.BrainRotSettings

-- ----------------------------------------------------------
-- 1. СОЗДАНИЕ ИНТЕРФЕЙСА (МОД МЕНЮ)
-- ----------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainRotModMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 260)
main.Position = UDim2.new(0.5, -210, 0.3, -130)
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

-- Шапка
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
title.Text = "🧠 BRAINROT MERGE | <font color='#a020f0'>ULTIMATE HUB</font>"
title.RichText = true
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Левая панель с разделами (Вкладками)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 110, 1, -45)
tabContainer.Position = UDim2.new(0, 8, 0, 40)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabContainer

-- Контейнер для содержимого разделов
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -132, 1, -45)
contentContainer.Position = UDim2.new(0, 124, 0, 40)
contentContainer.BackgroundColor3 = Color3.fromRGB(25, 22, 38)
contentContainer.BorderSizePixel = 0
contentContainer.Parent = main
Instance.new("UICorner", contentContainer).CornerRadius = UDim.new(0, 8)

local tabs = {}
local tabButtons = {}

local function createTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(30, 26, 46)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.new(0, 6, 0, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.Visible = false
    page.Parent = contentContainer

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    tabs[name] = page
    tabButtons[name] = btn

    btn.MouseButton1Click:Connect(function()
        for tName, tPage in pairs(tabs) do
            tPage.Visible = (tName == name)
            tabButtons[tName].BackgroundColor3 = (tName == name) and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(30, 26, 46)
            tabButtons[tName].TextColor3 = (tName == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 200)
        end
    end)

    return page
end

-- Создаем 3 раздела
local farmPage = createTab("Farm", "⚡")
local utilityPage = createTab("Utility", "🛠")
local playerPage = createTab("Player", "🏃")

-- Открываем первую вкладку по умолчанию
tabs["Farm"].Visible = true
tabButtons["Farm"].BackgroundColor3 = Color3.fromRGB(160, 32, 240)
tabButtons["Farm"].TextColor3 = Color3.fromRGB(255, 255, 255)

-- Функция создания Тумблеров (ON/OFF)
local function createToggle(parent, text, defaultState, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundColor3 = Color3.fromRGB(35, 30, 52)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 245)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 22)
    btn.Position = UDim2.new(1, -50, 0.5, -11)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(50, 45, 70)
    btn.Text = defaultState and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

    local state = defaultState
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(160, 32, 240) or Color3.fromRGB(50, 45, 70)
        btn.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

-- Вкладка FARM -> Включаем тот самый Auto Merge
createToggle(farmPage, "Auto Merge (Авто Объединение)", Settings.AutoMerge, function(val)
    Settings.AutoMerge = val
end)

-- Вкладка PLAYER -> Доп функции
createToggle(playerPage, "Скорость бега (Speed)", Settings.WalkSpeedEnabled, function(val)
    Settings.WalkSpeedEnabled = val
end)

createToggle(playerPage, "Бесконечный прыжок", Settings.InfJump, function(val)
    Settings.InfJump = val
end)


-- ----------------------------------------------------------
-- 2. ЛОГИКА ТЕЛЕПОРТА И ПОСЛЕДОВАТЕЛЬНОГО АВТО-ОБЪЕДИНЕНИЯ
-- ----------------------------------------------------------

-- Функция поиска спавна своей базы
local function getMyBaseSpawn()
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj:IsA("ObjectValue") or obj:IsA("StringValue")) and obj.Name == "Owner" and tostring(obj.Value) == LocalPlayer.Name then
            local base = obj.Parent
            return base:FindFirstChild("Spawn") or base:FindFirstChild("Floor") or base:FindFirstChildOfClass("BasePart")
        end
    end
    return nil
end

-- Логика Auto Merge
task.spawn(function()
    while true do
        if Settings.AutoMerge then
            pcall(function()
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
                
                if myHrp then
                    local brainrots = {}

                    -- Собираем ВСЕ предметы (независимо от названия)
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and not Players:GetPlayerFromCharacter(obj) then
                            local part = obj.PrimaryPart or obj:FindFirstChildOfClass("MeshPart") or obj:FindFirstChildOfClass("Part")
                            -- Если предмет не приклеен (дропнутый брейнрот)
                            if part and not part.Anchored then
                                table.insert(brainrots, obj)
                            end
                        end
                    end

                    -- Если брейнроты есть - идем по каждому
                    if #brainrots > 0 then
                        for i, rot in ipairs(brainrots) do
                            if not Settings.AutoMerge then break end -- Если выключили в процессе - стоп
                            
                            local part = rot.PrimaryPart or rot:FindFirstChildOfClass("MeshPart") or rot:FindFirstChildOfClass("Part")
                            if part then
                                -- ТП к брейнроту
                                myHrp.CFrame = part.CFrame * CFrame.new(0, 2, 0)
                                task.wait(0.1)
                                
                                -- Делаем "1 клик" по нему (ищем любой способ взаимодействия)
                                local clicked = false
                                for _, desc in pairs(rot:GetDescendants()) do
                                    if desc:IsA("ClickDetector") then
                                        fireclickdetector(desc)
                                        clicked = true
                                    elseif desc:IsA("ProximityPrompt") then
                                        fireproximityprompt(desc)
                                        clicked = true
                                    end
                                end
                                
                                -- Если кликать не на что, просто трогаем его
                                if not clicked then
                                    firetouchinterest(myHrp, part, 0)
                                    firetouchinterest(myHrp, part, 1)
                                end

                                -- Ждем немного чтобы не спамить и игра успела объединить
                                task.wait(0.3)
                            end
                        end
                    else
                        -- Если брейнротов больше нет (закончились) -> ТП на базу
                        local spawnPart = getMyBaseSpawn()
                        if spawnPart then
                            myHrp.CFrame = spawnPart.CFrame * CFrame.new(0, 4, 0)
                        end
                        -- Стоим на базе и ждем пополнения
                        task.wait(1.5)
                    end
                end
            end)
        end
        -- Небольшая пауза для всего цикла
        task.wait(0.2)
    end
end)

-- Управление игроком (Скорость / Прыжок)
RunService.RenderStepped:Connect(function()
    if Settings.WalkSpeedEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 32 end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
