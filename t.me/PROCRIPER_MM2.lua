-- Загрузка красивой UI библиотеки в стиле премиум-хабов
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/InterfaceManager.lua"))()

local Window = Fluent:Window({
    Title = "Pulse Hub | Murder Mystery 2",
    SubTitle = "Delta Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Вкладки меню (как на премиум софтах)
local Tabs = {
    Main = Window:AddTab({ Title = "Главная", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat / Kill", Icon = "sword" }),
    Visuals = Window:AddTab({ Title = "Визуал (ESP)", Icon = "eye" }),
    Troll = Window:AddTab({ Title = "Флинг & Troll", Icon = "wind" }),
    Settings = Window:AddTab({ Title = "Настройки", Icon = "settings" })
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Переменные состояния функций
local ESPEnabled = false
local KillSheriffEnabled = false
local KillMurdererEnabled = false
local KillAllEnabled = false
local FlingMurdererEnabled = false

-- Функция точного определения роли в MM2
local function getRole(player)
    if not player.Character then return "Innocent" end
    if player.Character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife") then
        return "Murderer"
    elseif player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Revolver") or player.Backpack:FindFirstChild("Revolver") then
        return "Sheriff"
    else
        return "Innocent"
    end
end

-- ==================== ВИЗУАЛ (ESP) ====================
Tabs.Visuals:AddToggle("ESPEnabled", {
    Title = "Включить ESP ролей (Мардер:Красный, Шериф:Синий, Мирный:Зеленый)",
    Default = false,
    Callback = function(Value)
        ESPEnabled = Value
    end
})

-- Рендер ESP с подсветкой через стены
RunService.RenderStepped:Connect(function()
    if not ESPEnabled then 
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("MM2_ESP_Highlight") then
                p.Character.MM2_ESP_Highlight:Destroy()
            end
        end
        return 
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local role = getRole(p)
            local highlight = p.Character:FindFirstChild("MM2_ESP_Highlight")
            
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "MM2_ESP_Highlight"
                highlight.Adornee = p.Character
                highlight.Parent = p.Character
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end

            if role == "Murderer" then
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Красный для Мардера
            elseif role == "Sheriff" then
                highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Синий для Шерифа
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Зеленый для Мирных
            end
        end
    end
end)


-- ==================== COMBAT / УБИЙСТВА ====================

Tabs.Combat:AddToggle("KillMurderer", {
    Title = "On/Off Kill Murderer (Убить мардера)",
    Default = false,
    Callback = function(Value)
        KillMurdererEnabled = Value
    end
})

Tabs.Combat:AddToggle("KillSheriff", {
    Title = "On/Off Kill Sheriff (Убить шерифа)",
    Default = false,
    Callback = function(Value)
        KillSheriffEnabled = Value
    end
})

Tabs.Combat:AddToggle("KillAll", {
    Title = "On/Off Kill All Innocents (Убить всех мирных)",
    Default = false,
    Callback = function(Value)
        KillAllEnabled = Value
    end
})

-- Логика автоматического применения оружия при включенных тумблерах
task.spawn(function()
    while task.wait(0.2) do
        local char = LocalPlayer.Character
        if char and (char:FindFirstChild("Knife") or char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")) then
            local tool = char:FindFirstChildOfClass("Tool")
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local role = getRole(p)
                    local hrp = p.Character.HumanoidRootPart
                    
                    -- Убийство мардера (если он в поле видимости / не за стеной)
                    if KillMurdererEnabled and role == "Murderer" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                    
                    -- Убийство шерифа
                    if KillSheriffEnabled and role == "Sheriff" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                    
                    -- Убийство всех мирных (не важно где они находятся и под чем)
                    if KillAllEnabled and role == "Innocent" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                end
            end
        end
    end
end)


-- ==================== ФЛИНГ & TROLL ====================

Tabs.Troll:AddToggle("FlingMurderer", {
    Title = "Fling Murderer (Скинуть мардера с карты за мирного)",
    Default = false,
    Callback = function(Value)
        FlingMurdererEnabled = Value
    end
})

-- Логика флинга: работает только если ты мирный, сбрасывает мардера с карты
RunService.Stepped:Connect(function()
    if not FlingMurdererEnabled then return end
    
    local myRole = getRole(LocalPlayer)
    if myRole == "Innocent" then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and getRole(p) == "Murderer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHRP = p.Character.HumanoidRootPart
                    hrp.CFrame = targetHRP.CFrame
                    hrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
                    hrp.AssemblyAngularVelocity = Vector3.new(99999, 99999, 99999)
                end
            end
        end
    end
end)


-- ==================== ПЛАВАЮЩИЕ КНОПКИ НА ЭКРАНЕ (3 КНОПКИ) ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PulseHubScreenButtons"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 150)
Frame.Position = UDim2.new(0, 40, 0, 180)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true -- Панель можно двигать по экрану пальцем

local UIList = Instance.new("UIListLayout")
UIList.Parent = Frame
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)

local function createScreenButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.Parent = Frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
end

-- Создание трех экранных кнопок быстрого доступа
createScreenButton("⚡ Kill Murderer", function()
    KillMurdererEnabled = not KillMurdererEnabled
    Fluent:Notify({ Title = "Pulse Hub", Content = "Kill Murderer: " .. tostring(KillMurdererEnabled), Duration = 2 })
end)

createScreenButton("🎯 Kill Sheriff", function()
    KillSheriffEnabled = not KillSheriffEnabled
    Fluent:Notify({ Title = "Pulse Hub", Content = "Kill Sheriff: " .. tostring(KillSheriffEnabled), Duration = 2 })
end)

createScreenButton("💥 Kill All Innocents", function()
    KillAllEnabled = not KillAllEnabled
    Fluent:Notify({ Title = "Pulse Hub", Content = "Kill All Innocents: " .. tostring(KillAllEnabled), Duration = 2 })
end)

-- Инициализация менеджеров интерфейса Fluent
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs.Settings)
InterfaceManager:SetupWindow(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Pulse Hub Запущен!",
    Content = "Все модули MM2 успешно активированы.",
    Duration = 4
})
