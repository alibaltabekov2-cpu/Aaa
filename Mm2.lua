-- Heart Hub MM2 (ESP & AIM Edition)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HeartHubMenu") then
    CoreGui.HeartHubMenu:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HeartHubMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- === ПЛАВАЮЩАЯ КНОПКА ОТКРЫТИЯ ===
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 0.3, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
openBtn.Text = "❤️"
openBtn.TextSize = 22
openBtn.Visible = false
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

local openStroke = Instance.new("UIStroke")
openStroke.Color = Color3.fromRGB(255, 75, 125)
openStroke.Thickness = 2
openStroke.Parent = openBtn

-- === ГЛАВНОЕ ОКНО МЕНЮ ===
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 540, 0, 360)
mainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 60)
mainStroke.Thickness = 1
mainStroke.Parent = mainFrame

-- === ШАПКА ===
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 10)
headerFix.Position = UDim2.new(0, 0, 1, -10)
headerFix.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
headerFix.BorderSizePixel = 0
headerFix.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "❤️ Heart Hub • MM2"
title.TextColor3 = Color3.fromRGB(255, 100, 150)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 6.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- === БОКОВАЯ ПАНЕЛЬ ===
local sidebar = Instance.new("ScrollingFrame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 140, 1, -55)
sidebar.Position = UDim2.new(0, 10, 0, 50)
sidebar.BackgroundTransparency = 1
sidebar.ScrollBarThickness = 2
sidebar.Parent = mainFrame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 6)
sidebarLayout.Parent = sidebar

-- === КОНТЕЙНЕРЫ СТРАНИЦ ===
local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -165, 1, -55)
    page.Position = UDim2.new(0, 155, 0, 50)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 3
    page.Parent = mainFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = page
    return page
end

local pageESP = createPage()
pageESP.Visible = true
local pageAim = createPage()

local function createTabButton(name, targetPage, active)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = active and Color3.fromRGB(35, 35, 50) or Color3.fromRGB(24, 24, 32)
    btn.Text = "   " .. name
    btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        pageESP.Visible = (targetPage == pageESP)
        pageAim.Visible = (targetPage == pageAim)
        for _, child in pairs(sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
                child.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

createTabButton("ESP", pageESP, true)
createTabButton("Aim", pageAim, false)

-- === ФУНКЦИИ СОЗДАНИЯ UI-ЭЛЕМЕНТОВ ===
local function createToggle(parent, text, callback)
    local tgl = Instance.new("TextButton")
    tgl.Size = UDim2.new(1, 0, 0, 38)
    tgl.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    tgl.Text = "   " .. text
    tgl.TextColor3 = Color3.fromRGB(200, 200, 200)
    tgl.TextSize = 13
    tgl.Font = Enum.Font.GothamMedium
    tgl.TextXAlignment = Enum.TextXAlignment.Left
    tgl.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = tgl

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 60, 1, 0)
    status.Position = UDim2.new(1, -65, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "ВЫКЛ"
    status.TextColor3 = Color3.fromRGB(200, 60, 60)
    status.TextSize = 12
    status.Font = Enum.Font.GothamBold
    status.Parent = tgl

    local active = false
    tgl.MouseButton1Click:Connect(function()
        active = not active
        status.Text = active and "ВКЛ" or "ВЫКЛ"
        status.TextColor3 = active and Color3.fromRGB(60, 220, 100) or Color3.fromRGB(200, 60, 60)
        callback(active)
    end)
    return tgl
end

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- === ЛОГИКА ESP ===
local espFolder = Instance.new("Folder")
espFolder.Name = "MM2_ESP_Folder"
espFolder.Parent = screenGui

local function clearEspType(tag)
    for _, obj in pairs(espFolder:GetChildren()) do
        if string.find(obj.Name, tag) then
            obj:Destroy()
        end
    end
end

local function addHighlight(char, color, tag)
    if not char or char:FindFirstChild("MM2_" .. tag) then return end
    local hl = Instance.new("Highlight")
    hl.Name = "MM2_" .. tag
    hl.Adornee = char
    hl.FillColor = color
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.4
    hl.Parent = espFolder
end

local function addGunEsp(gunPart)
    if not gunPart or espFolder:FindFirstChild("MM2_GunDrop") then return end
    local bb = Instance.new("BillboardGui")
    bb.Name = "MM2_GunDrop"
    bb.Adornee = gunPart
    bb.Size = UDim2.new(0, 40, 0, 40)
    bb.AlwaysOnTop = true
    bb.Parent = espFolder

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    frame.BackgroundTransparency = 0.3
    frame.Parent = bb

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = frame
end

createToggle(pageESP, "Murderer ESP", function(state)
    task.spawn(function()
        while state and task.wait(1) do
            clearEspType("Murder")
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Backpack then
                    if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then
                        addHighlight(p.Character, Color3.fromRGB(255, 0, 0), "Murder")
                    end
                end
            end
        end
        clearEspType("Murder")
    end)
end)

createToggle(pageESP, "Sheriff ESP", function(state)
    task.spawn(function()
        while state and task.wait(1) do
            clearEspType("Sheriff")
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Backpack then
                    if p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then
                        addHighlight(p.Character, Color3.fromRGB(0, 100, 255), "Sheriff")
                    end
                end
            end
        end
        clearEspType("Sheriff")
    end)
end)

createToggle(pageESP, "Players ESP", function(state)
    task.spawn(function()
        while state and task.wait(1) do
            clearEspType("PlayerNormal")
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local k = p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife"))
                    local g = p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun"))
                    if not k and not g then
                        addHighlight(p.Character, Color3.fromRGB(0, 255, 0), "PlayerNormal")
                    end
                end
            end
        end
        clearEspType("PlayerNormal")
    end)
end)

createToggle(pageESP, "Sheriff Gun Drop ESP", function(state)
    task.spawn(function()
        while state and task.wait(0.5) do
            clearEspType("GunDrop")
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "GunDrop" then
                    local part = obj:IsA("Model") and obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part then addGunEsp(part) end
                end
            end
        end
        clearEspType("GunDrop")
    end)
end)

-- === РАЗДЕЛ AIM ===
local aimSettingsOpen = false
local aimEnabled = false
local aimTargetType = "Murderer" -- "Murderer" или "Sheriff"
local fovRadius = 150

-- Контейнер для строки Aimbot с кнопкой настроек (смайлик)
local aimMainRow = Instance.new("Frame")
aimMainRow.Size = UDim2.new(1, 0, 0, 38)
aimMainRow.BackgroundTransparency = 1
aimMainRow.Parent = pageAim

local aimToggleBtn = Instance.new("TextButton")
aimToggleBtn.Size = UDim2.new(1, -45, 1, 0)
aimToggleBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
aimToggleBtn.Text = "   Aimbot"
aimToggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
aimToggleBtn.TextSize = 13
aimToggleBtn.Font = Enum.Font.GothamMedium
aimToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
aimToggleBtn.Parent = aimMainRow

local aimCorner = Instance.new("UICorner")
aimCorner.CornerRadius = UDim.new(0, 8)
aimCorner.Parent = aimToggleBtn

local aimStatus = Instance.new("TextLabel")
aimStatus.Size = UDim2.new(0, 60, 1, 0)
aimStatus.Position = UDim2.new(1, -65, 0, 0)
aimStatus.BackgroundTransparency = 1
aimStatus.Text = "ВЫКЛ"
aimStatus.TextColor3 = Color3.fromRGB(200, 60, 60)
aimStatus.TextSize = 12
aimStatus.Font = Enum.Font.GothamBold
aimStatus.Parent = aimToggleBtn

aimToggleBtn.MouseButton1Click:Connect(function()
    aimEnabled = not aimEnabled
    aimStatus.Text = aimEnabled and "ВКЛ" or "ВЫКЛ"
    aimStatus.TextColor3 = aimEnabled and Color3.fromRGB(60, 220, 100) or Color3.fromRGB(200, 60, 60)
end)

-- Кнопка со смайликом настроек рядом
local settingsEmojiBtn = Instance.new("TextButton")
settingsEmojiBtn.Size = UDim2.new(0, 38, 1, 0)
settingsEmojiBtn.Position = UDim2.new(1, -38, 0, 0)
settingsEmojiBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
settingsEmojiBtn.Text = "⚙️"
settingsEmojiBtn.TextSize = 16
settingsEmojiBtn.Parent = aimMainRow

local emojiCorner = Instance.new("UICorner")
emojiCorner.CornerRadius = UDim.new(0, 8)
emojiCorner.Parent = settingsEmojiBtn

-- Выпадающее меню настроек Аима
local aimSettingsPanel = Instance.new("Frame")
aimSettingsPanel.Size = UDim2.new(1, 0, 0, 140)
aimSettingsPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
aimSettingsPanel.Visible = false
aimSettingsPanel.Parent = pageAim

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 8)
panelCorner.Parent = aimSettingsPanel

local panelLayout = Instance.new("UIListLayout")
panelLayout.Padding = UDim.new(0, 6)
panelLayout.Parent = aimSettingsPanel

settingsEmojiBtn.MouseButton1Click:Connect(function()
    aimSettingsOpen = not aimSettingsOpen
    aimSettingsPanel.Visible = aimSettingsOpen
end)

-- Выбор цели для аима (Шериф или Мардер)
local targetSelectBtn = Instance.new("TextButton")
targetSelectBtn.Size = UDim2.new(1, 0, 0, 35)
targetSelectBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
targetSelectBtn.Text = "Цель Аима: Murderer"
targetSelectBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
targetSelectBtn.TextSize = 12
targetSelectBtn.Font = Enum.Font.GothamBold
targetSelectBtn.Parent = aimSettingsPanel

targetSelectBtn.MouseButton1Click:Connect(function()
    if aimTargetType == "Murderer" then
        aimTargetType = "Sheriff"
        targetSelectBtn.Text = "Цель Аима: Sheriff"
        targetSelectBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
    else
        aimTargetType = "Murderer"
        targetSelectBtn.Text = "Цель Аима: Murderer"
        targetSelectBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Настройка FOV (размер круга)
local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(1, 0, 0, 25)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = " FOV (Радиус): 150"
fovLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fovLabel.TextSize = 12
fovLabel.Font = Enum.Font.Gotham
fovLabel.TextXAlignment = Enum.TextXAlignment.Left
fovLabel.Parent = aimSettingsPanel

-- Кнопки изменения FOV
local fovChangeRow = Instance.new("Frame")
fovChangeRow.Size = UDim2.new(1, 0, 0, 32)
fovChangeRow.BackgroundTransparency = 1
fovChangeRow.Parent = aimSettingsPanel

local fovMinus = Instance.new("TextButton")
fovMinus.Size = UDim2.new(0.48, 0, 1, 0)
fovMinus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
fovMinus.Text = "Уменьшить FOV"
fovMinus.TextColor3 = Color3.fromRGB(200, 200, 200)
fovMinus.TextSize = 11
fovMinus.Parent = fovChangeRow
Instance.new("UICorner", fovMinus).CornerRadius = UDim.new(0, 6)

local fovPlus = Instance.new("TextButton")
fovPlus.Size = UDim2.new(0.48, 0, 1, 0)
fovPlus.Position = UDim2.new(0.52, 0, 0, 0)
fovPlus.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
fovPlus.Text = "Увеличить FOV"
fovPlus.TextColor3 = Color3.fromRGB(200, 200, 200)
fovPlus.TextSize = 11
fovPlus.Parent = fovChangeRow
Instance.new("UICorner", fovPlus).CornerRadius = UDim.new(0, 6)

fovMinus.MouseButton1Click:Connect(function()
    fovRadius = math.clamp(fovRadius - 25, 50, 400)
    fovLabel.Text = " FOV (Радиус): " .. fovRadius
end)

fovPlus.MouseButton1Click:Connect(function()
    fovRadius = math.clamp(fovRadius + 25, 50, 400)
    fovLabel.Text = " FOV (Радиус): " .. fovRadius
end)

-- Проверка: находится ли игрок в открытом поле (без преград между камерой и им)
local function isOpenField(targetChar)
    local head = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
    if not head then return false end
    
    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = RaycastParams.FilterType.Exclude
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, espFolder}
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then
        -- Если луч попал в часть целевого персонажа, значит преград нет (открытое поле)
        if result.Instance:IsDescendantOf(targetChar) then
            return true
        end
        return false
    end
    return true
end

-- Поиск цели в открытом поле и внутри FOV
local function getBestTarget()
    local bestTarget = nil
    local shortestDist = fovRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Backpack then
            local isMatch = false
            if aimTargetType == "Murderer" then
                if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then isMatch = true end
            else
                if p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then isMatch = true end
            end
            
            if isMatch then
                local char = p.Character
                local root = char:FindFirstChild("HumanoidRootPart")
                if root and isOpenField(char) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            bestTarget = root
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

-- Автонаводка (Aim)
RunService.RenderStepped:Connect(function()
    if aimEnabled then
        local target = getBestTarget()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- === КНОПКИ KILL (Убийство в открытом поле) ===
createButton(pageAim, "⚡ Kill Murderer", function()
    pcall(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Backpack then
                if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then
                    if isOpenField(p.Character) then
                        local root = p.Character:FindFirstChild("HumanoidRootPart")
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and myRoot then
                            -- Телепортируем пулю / наводим для выстрела
                            myRoot.CFrame = root.CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                end
            end
        end
    end)
end)

createButton(pageAim, "⚡ Kill Sheriff", function()
    pcall(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Backpack then
                if p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then
                    if isOpenField(p.Character) then
                        local root = p.Character:FindFirstChild("HumanoidRootPart")
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if root and myRoot then
                            myRoot.CFrame = root.CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                end
            end
                    end
                end
            end
        end
    end)
end)

-- === ПЕРЕМЕЩЕНИЕ И СВОРАЧИВАНИЕ МЕНЮ ===
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openBtn.Visible = false
end)
