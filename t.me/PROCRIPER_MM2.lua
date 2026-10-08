-- Загрузка UI библиотеки
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

local ESPEnabled = false
local KillSheriffEnabled = false
local KillMurdererEnabled = false
local KillAllEnabled = false
local FlingActive = false -- Переключатель для экранной кнопки флинга

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
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
            elseif role == "Sheriff" then
                highlight.FillColor = Color3.fromRGB(0, 0, 255)
            else
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end)

-- ==================== COMBAT / УБИЙСТВА ====================
Tabs.Combat:AddToggle("KillMurderer", {
    Title = "On/Off Kill Murderer",
    Default = false,
    Callback = function(Value)
        KillMurdererEnabled = Value
    end
})

Tabs.Combat:AddToggle("KillSheriff", {
    Title = "On/Off Kill Sheriff",
    Default = false,
    Callback = function(Value)
        KillSheriffEnabled = Value
    end
})

Tabs.Combat:AddToggle("KillAll", {
    Title = "On/Off Kill All Innocents",
    Default = false,
    Callback = function(Value)
        KillAllEnabled = Value
    end
})

task.spawn(function()
    while task.wait(0.2) do
        local char = LocalPlayer.Character
        if char and (char:FindFirstChild("Knife") or char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")) then
            local tool = char:FindFirstChildOfClass("Tool")
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local role = getRole(p)
                    local hrp = p.Character.HumanoidRootPart
                    
                    if KillMurdererEnabled and role == "Murderer" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                    
                    if KillSheriffEnabled and role == "Sheriff" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                    
                    if KillAllEnabled and role == "Innocent" then
                        tool:Activate()
                        char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, 2)
                    end
                end
            end
        end
    end
end)

-- ==================== ФЛИНГ МАРДЕРА (ПО КНОПКЕ НА ЭКРАНЕ) ====================
RunService.Stepped:Connect(function()
    if not FlingActive then return end
    
    local myRole = getRole(LocalPlayer)
    -- Работает только если ты мирный
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

-- ==================== ЭКРАННЫЕ КНОПКИ (В ТОМ ЧИСЛЕ FLING) ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PulseHubScreenButtons"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 190)
Frame.Position = UDim2.new(0, 40, 0, 180)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

local UIList = Instance.new("UIListLayout")
UIList.Parent = Frame
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)

local function createScreenButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
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

-- Главная экранная кнопка флинга убийцы
createScreenButton("🌪️ Fling Murderer", function()
    FlingActive = not FlingActive
    Fluent:Notify({ Title = "Pulse Hub", Content = "Fling Murderer (Мирный): " .. tostring(FlingActive), Duration = 2 })
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs.Settings)
InterfaceManager:SetupWindow(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({
    Title = "Pulse Hub Запущен!",
    Content = "Все функции и экранные кнопки активны.",
    Duration = 4
})
