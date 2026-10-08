-- Автономный интерфейс Pulse Hub (без внешних библиотек)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Удаляем старое меню, если было запущено
if CoreGui:FindFirstChild("PulseHubStandalone") then
    CoreGui.PulseHubStandalone:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PulseHubStandalone"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Главное окно читера
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Шапка окна
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Pulse Hub | MM2 (Standalone)"
Title.Parent = TopBar

-- Кнопка закрытия меню
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Контейнер для функций
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -55)
Content.Position = UDim2.new(0, 10, 0, 48)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 0, 350)
Content.ScrollBarThickness = 4
Content.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Content
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)

-- Функция создания переключателей (Toggle)
local function createToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Content
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = name
    Label.Parent = ToggleFrame
    
    local TglBtn = Instance.new("TextButton")
    TglBtn.Size = UDim2.new(0, 40, 0, 22)
    TglBtn.Position = UDim2.new(1, -50, 0.5, -11)
    TglBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    TglBtn.Text = ""
    TglBtn.Parent = ToggleFrame
    
    local TglCorner = Instance.new("UICorner")
    TglCorner.CornerRadius = UDim.new(1, 0)
    TglCorner.Parent = TglBtn
    
    local active = false
    TglBtn.MouseButton1Click:Connect(function()
        active = not active
        TglBtn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(60, 60, 70)
        callback(active)
    end)
end

-- Переменные логики
local ESPEnabled = false
local KillMurdererEnabled = false
local KillSheriffEnabled = false
local KillAllEnabled = false
local FlingActive = false

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

-- Добавляем элементы в меню
createToggle("Включить ESP (Мардер:Красный, Шериф:Синий, Мирный:Зеленый)", function(v)
    ESPEnabled = v
end)

createToggle("Kill Murderer (Убить мардера)", function(v)
    KillMurdererEnabled = v
end)

createToggle("Kill Sheriff (Убить шерифа)", function(v)
    KillSheriffEnabled = v
end)

createToggle("Kill All Innocents (Убить всех мирных)", function(v)
    KillAllEnabled = v
end)

createToggle("🌪️ Fling Murderer (Скинуть с карты за мирного)", function(v)
    FlingActive = v
end)

-- Логика ESP
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

-- Логика Combat / Убийств
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

-- Логика Флинга (выброс убийцы с карты, когда ты мирный)
RunService.Stepped:Connect(function()
    if not FlingActive then return end
    
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
