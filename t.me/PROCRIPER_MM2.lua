-- Точный дизайн Pulse Hub (Standalone / Без внешних библиотек)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("PulseHubExact") then
    CoreGui.PulseHubExact:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PulseHubExact"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 380)
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Pulse Hub  |  Murder Mystery 2"
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0, 6.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Боковая панель категорий (слева, как на скрине)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarList = Instance.new("UIListLayout")
SidebarList.Parent = Sidebar
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 4)

-- Контейнер для содержимого вкладок
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -160, 1, -45)
Container.Position = UDim2.new(0, 160, 0, 45)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local Pages = {}

local function createPage(name)
    local PageFrame = Instance.new("ScrollingFrame")
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.BackgroundTransparency = 1
    PageFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
    PageFrame.ScrollBarThickness = 4
    PageFrame.Visible = false
    PageFrame.Parent = Container
    
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = PageFrame
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 8)
    
    Pages[name] = PageFrame
    return PageFrame
end

local function createTabButton(name, pageName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.fromRGB(180, 180, 190)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "   " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(180, 180, 190) end
        end
        Pages[pageName].Visible = true
        btn.TextColor3 = Color3.fromRGB(0, 170, 255)
    end)
end

-- Создаем страницы
createPage("Main")
createPage("Combat")
createPage("Visuals")
createPage("Troll")

createTabButton("🏠  Главная", "Main")
createTabButton("⚔️  Combat / Kill", "Combat")
createTabButton("👁️  Визуал (ESP)", "Visuals")
createTabButton("🌪️  Флинг & Troll", "Troll")

Pages["Main"].Visible = true -- Открыта главная по умолчанию

-- Функция создания тумблера On/Off
local function addToggle(page, title, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = page
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -65, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = title
    Label.Parent = Frame
    
    local TglBtn = Instance.new("TextButton")
    TglBtn.Size = UDim2.new(0, 44, 0, 24)
    TglBtn.Position = UDim2.new(1, -54, 0.5, -12)
    TglBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    TglBtn.Text = ""
    TglBtn.Parent = Frame
    
    local TglCorner = Instance.new("UICorner")
    TglCorner.CornerRadius = UDim.new(1, 0)
    TglCorner.Parent = TglBtn
    
    local active = false
    TglBtn.MouseButton1Click:Connect(function()
        active = not active
        TglBtn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(50, 50, 60)
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

-- Наполняем вкладки элементами
addToggle(Pages["Visuals"], "Включить ESP ролей (Мардер:Красный, Шериф:Синий)", function(v) ESPEnabled = v end)

addToggle(Pages["Combat"], "Kill Murderer (Убить мардера)", function(v) KillMurdererEnabled = v end)
addToggle(Pages["Combat"], "Kill Sheriff (Убить шерифа)", function(v) KillSheriffEnabled = v end)
addToggle(Pages["Combat"], "Kill All Innocents (Убить всех мирных)", function(v) KillAllEnabled = v end)

addToggle(Pages["Troll"], "Fling Murderer (Скинуть мардера с карты за мирного)", function(v) FlingActive = v end)

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

-- Логика Combat
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

-- Логика Флинга
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
