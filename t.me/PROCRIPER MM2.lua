-- ██████████████████████████████████████
-- MM2 PULSE HUB | MOBILE | CHUNK 1/4
-- ██████████████████████████████████████

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if game.CoreGui:FindFirstChild("PulseHub") then
    game.CoreGui.PulseHub:Destroy()
end

_G.CFG = {
    ESP  = { Enabled=true, Name=true, Role=true, Dist=true },
    Aim  = { Enabled=false, FOV=160, Smooth=0.08, Part="Head" },
    Visual = {
        InfiniteVoid = false,
        FOVCircle    = false,
        Crosshair    = false,
    },
    Farm = { Coins=false, AutoWin=false },
    Tele = {},
    Misc = { Speed=false, SpeedVal=30, NoClip=false, InfJump=false, Fly=false },
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "PulseHub"
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.IgnoreGuiInset = true
GUI.Parent = game.CoreGui

-- МОБИЛЬНАЯ КНОПКА ОТКРЫТЬ
local OpenBtn = Instance.new("TextButton", GUI)
OpenBtn.Size = UDim2.new(0,80,0,34)
OpenBtn.Position = UDim2.new(0,10,0,10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(120,50,255)
OpenBtn.Text = "⚡ MENU"
OpenBtn.TextColor3 = Color3.fromRGB(255,255,255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 13
OpenBtn.BorderSizePixel = 0
OpenBtn.ZIndex = 99
Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(0,8)

-- ГЛАВНОЕ ОКНО
local Win = Instance.new("Frame", GUI)
Win.Size = UDim2.new(0,340,0,480)
Win.Position = UDim2.new(0.5,-170,0.5,-240)
Win.BackgroundColor3 = Color3.fromRGB(8,8,14)
Win.BorderSizePixel = 0
Win.Visible = false
Win.ZIndex = 10
Instance.new("UICorner",Win).CornerRadius = UDim.new(0,12)

local WinStroke = Instance.new("UIStroke",Win)
WinStroke.Color = Color3.fromRGB(120,50,255)
WinStroke.Thickness = 1.5

local WinGrad = Instance.new("UIGradient",Win)
WinGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10,8,22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18,8,30)),
})
WinGrad.Rotation = 135

-- TOPBAR
local Top = Instance.new("Frame",Win)
Top.Size = UDim2.new(1,0,0,44)
Top.BackgroundColor3 = Color3.fromRGB(120,50,255)
Top.BorderSizePixel = 0
Top.ZIndex = 11
Instance.new("UICorner",Top).CornerRadius = UDim.new(0,12)

local TopFix = Instance.new("Frame",Top)
TopFix.Size = UDim2.new(1,0,0.5,0)
TopFix.Position = UDim2.new(0,0,0.5,0)
TopFix.BackgroundColor3 = Color3.fromRGB(120,50,255)
TopFix.BorderSizePixel = 0
TopFix.ZIndex = 11

local TopGrad = Instance.new("UIGradient",Top)
TopGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(90,30,200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170,70,255)),
})
TopGrad.Rotation = 90

local TitleLbl = Instance.new("TextLabel",Top)
TitleLbl.Size = UDim2.new(1,-80,1,0)
TitleLbl.Position = UDim2.new(0,12,0,0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "⚡ PULSE HUB MOBILE"
TitleLbl.TextColor3 = Color3.fromRGB(255,255,255)
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 14
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 12

local CloseBtn = Instance.new("TextButton",Top)
CloseBtn.Size = UDim2.new(0,34,0,34)
CloseBtn.Position = UDim2.new(1,-38,0.5,-17)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,40,80)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 12
Instance.new("UICorner",CloseBtn).CornerRadius = UDim.new(0,6)

OpenBtn.MouseButton1Click:Connect(function()
    Win.Visible = not Win.Visible
end)
CloseBtn.MouseButton1Click:Connect(function()
    Win.Visible = false
end)

-- ТАБЫ
local TabBar = Instance.new("Frame",Win)
TabBar.Size = UDim2.new(1,0,0,38)
TabBar.Position = UDim2.new(0,0,0,44)
TabBar.BackgroundColor3 = Color3.fromRGB(12,10,20)
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 11

local TabLayout = Instance.new("UIListLayout",TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0,2)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- КОНТЕНТ
local Content = Instance.new("Frame",Win)
Content.Size = UDim2.new(1,0,1,-82)
Content.Position = UDim2.new(0,0,0,82)
Content.BackgroundTransparency = 1
Content.ZIndex = 11

local Tabs = {}
local TabDefs = {
    {Name="ESP",    Icon="👁"},
    {Name="Aim",    Icon="🎯"},
    {Name="Visual", Icon="✨"},
    {Name="Farm",   Icon="💰"},
    {Name="Tele",   Icon="⚡"},
    {Name="Misc",   Icon="⚙️"},
}

local function CreatePage()
    local Page = Instance.new("ScrollingFrame",Content)
    Page.Size = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(120,50,255)
    Page.Visible = false
    Page.ZIndex = 12
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local L = Instance.new("UIListLayout",Page)
    L.Padding = UDim.new(0,6)
    L.SortOrder = Enum.SortOrder.LayoutOrder
    L.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Instance.new("UIPadding",Page).PaddingTop = UDim.new(0,8)
    return Page
end

for i, def in ipairs(TabDefs) do
    local btn = Instance.new("TextButton",TabBar)
    btn.Size = UDim2.new(0,52,0,34)
    btn.BackgroundColor3 = Color3.fromRGB(18,14,30)
    btn.Text = def.Icon
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(160,140,200)
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.ZIndex = 12
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

    local Page = CreatePage()
    Tabs[def.Name] = {Button=btn, Page=Page}

    btn.MouseButton1Click:Connect(function()
        for _,t in pairs(Tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(18,14,30)
            t.Button.TextColor3 = Color3.fromRGB(160,140,200)
        end
        Page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(120,50,255)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
    end)
end

Tabs["ESP"].Page.Visible = true
Tabs["ESP"].Button.BackgroundColor3 = Color3.fromRGB(120,50,255)
Tabs["ESP"].Button.TextColor3 = Color3.fromRGB(255,255,255)

-- ТОГЛ БИЛДЕР
function _G.MakeToggle(parent, label, cfgT, cfgK, cb)
    local Row = Instance.new("Frame",parent)
    Row.Size = UDim2.new(1,-16,0,42)
    Row.BackgroundColor3 = Color3.fromRGB(16,12,26)
    Row.BorderSizePixel = 0
    Row.ZIndex = 13
    Instance.new("UICorner",Row).CornerRadius = UDim.new(0,8)

    local Lbl = Instance.new("TextLabel",Row)
    Lbl.Size = UDim2.new(1,-70,1,0)
    Lbl.Position = UDim2.new(0,12,0,0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = Color3.fromRGB(220,210,240)
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 14

    local Track = Instance.new("Frame",Row)
    Track.Size = UDim2.new(0,46,0,24)
    Track.Position = UDim2.new(1,-54,0.5,-12)
    Track.BackgroundColor3 = cfgT[cfgK]
        and Color3.fromRGB(120,50,255)
        or  Color3.fromRGB(40,35,55)
    Track.BorderSizePixel = 0
    Track.ZIndex = 14
    Instance.new("UICorner",Track).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame",Track)
    Knob.Size = UDim2.new(0,18,0,18)
    Knob.Position = cfgT[cfgK]
        and UDim2.new(1,-21,0.5,-9)
        or  UDim2.new(0,3,0.5,-9)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 15
    Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

    local TB = Instance.new("TextButton",Track)
    TB.Size = UDim2.new(1,0,1,0)
    TB.BackgroundTransparency = 1
    TB.Text = ""
    TB.ZIndex = 16

    TB.MouseButton1Click:Connect(function()
        cfgT[cfgK] = not cfgT[cfgK]
        local on = cfgT[cfgK]
        TweenService:Create(Track,TweenInfo.new(0.15),{
            BackgroundColor3 = on
                and Color3.fromRGB(120,50,255)
                or  Color3.fromRGB(40,35,55)
        }):Play()
        TweenService:Create(Knob,TweenInfo.new(0.15),{
            Position = on
                and UDim2.new(1,-21,0.5,-9)
                or  UDim2.new(0,3,0.5,-9)
        }):Play()
        if cb then cb(on) end
    end)
end

-- КНОПКА БИЛДЕР
function _G.MakeButton(parent, label, cb)
    local Btn = Instance.new("TextButton",parent)
    Btn.Size = UDim2.new(1,-16,0,42)
    Btn.BackgroundColor3 = Color3.fromRGB(120,50,255)
    Btn.Text = label
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.BorderSizePixel = 0
    Btn.ZIndex = 13
    Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,8)
    Btn.MouseButton1Click:Connect(function() if cb then cb() end end)
end

print("✅ CHUNK 1 — CORE + UI")
-- ██████████████████████████████████████
-- MM2 PULSE HUB | MOBILE | CHUNK 2/4
-- ESP + AIMBOT
-- ██████████████████████████████████████

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CFG = _G.CFG

-- ESP
local ESPFolder = Instance.new("Folder",game.CoreGui)
ESPFolder.Name = "ESP_Folder"
local ESPCache = {}

local RoleColors = {
    Murderer = Color3.fromRGB(255,50,50),
    Sheriff  = Color3.fromRGB(50,150,255),
    Innocent = Color3.fromRGB(80,255,120),
}

local function GetRole(player)
    local char = player.Character
    if not char then return "Innocent" end
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") then
            local n = v.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") or n:find("sheriff") then return "Sheriff" end
        end
    end
    return "Innocent"
end

local function BuildESP(player)
    local BB = Instance.new("BillboardGui")
    BB.Name = player.Name.."_ESP"
    BB.AlwaysOnTop = true
    BB.Size = UDim2.new(0,180,0,65)
    BB.StudsOffset = Vector3.new(0,3.5,0)
    BB.Parent = ESPFolder

    local Name = Instance.new("TextLabel",BB)
    Name.Size = UDim2.new(1,0,0,22)
    Name.BackgroundTransparency = 1
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 13
    Name.TextStrokeTransparency = 0
    Name.TextStrokeColor3 = Color3.new(0,0,0)

    local Role = Instance.new("TextLabel",BB)
    Role.Size = UDim2.new(1,0,0,18)
    Role.Position = UDim2.new(0,0,0,22)
    Role.BackgroundTransparency = 1
    Role.Font = Enum.Font.Gotham
    Role.TextSize = 12
    Role.TextStrokeTransparency = 0
    Role.TextStrokeColor3 = Color3.new(0,0,0)

    local Dist = Instance.new("TextLabel",BB)
    Dist.Size = UDim2.new(1,0,0,16)
    Dist.Position = UDim2.new(0,0,0,40)
    Dist.BackgroundTransparency = 1
    Dist.Font = Enum.Font.Gotham
    Dist.TextSize = 11
    Dist.TextColor3 = Color3.fromRGB(200,200,200)
    Dist.TextStrokeTransparency = 0
    Dist.TextStrokeColor3 = Color3.new(0,0,0)

    return BB, Name, Role, Dist
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        if not ESPCache[player.Name] then
            local bb,n,r,d = BuildESP(player)
            ESPCache[player.Name] = {BB=bb,Name=n,Role=r,Dist=d}
        end

        local e = ESPCache[player.Name]
        if not e then continue end

        local role  = GetRole(player)
        local color = RoleColors[role]
        local dist  = math.floor((root.Position - Camera.CFrame.Position).Magnitude)

        e.BB.Adornee = root
        e.BB.Enabled = CFG.ESP.Enabled

        e.Name.Text       = CFG.ESP.Name and player.Name or ""
        e.Name.TextColor3 = color
        e.Role.Text       = CFG.ESP.Role and "["..role.."]" or ""
        e.Role.TextColor3 = color
        e.Dist.Text       = CFG.ESP.Dist and dist.."m" or ""
    end

    for name, e in pairs(ESPCache) do
        if not Players:FindFirstChild(name) then
            if e.BB then e.BB:Destroy() end
            ESPCache[name] = nil
        end
    end
end)

-- AIMBOT (без кнопки — просто тогл)
local function GetClosest()
    local best, bestDist = nil, CFG.Aim.FOV
    local center = Vector2.new(
        Camera.ViewportSize.X/2,
        Camera.ViewportSize.Y/2
    )
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local part = char:FindFirstChild(CFG.Aim.Part)
        if not part then continue end
        local sp, vis = Camera:WorldToViewportPoint(part.Position)
        if not vis then continue end
        local dist = (Vector2.new(sp.X,sp.Y) - center).Magnitude
        if dist < bestDist then
            bestDist = dist
            best = part
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    if not CFG.Aim.Enabled then return end
    local target = GetClosest()
    if not target then return end
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local sp = Camera:WorldToViewportPoint(target.Position)
    local tPos = Vector2.new(sp.X, sp.Y)
    local newPos = center:Lerp(tPos, CFG.Aim.Smooth)
    local ray = Camera:ViewportPointToRay(newPos.X, newPos.Y)
    Camera.CFrame = CFrame.new(
        Camera.CFrame.Position,
        Camera.CFrame.Position + ray.Direction * 1000
    )
end)

-- POPULATE TABS
local ESPPage = Tabs["ESP"].Page
_G.MakeToggle(ESPPage, "ESP Включён",        CFG.ESP, "Enabled")
_G.MakeToggle(ESPPage, "Показать Имя",       CFG.ESP, "Name")
_G.MakeToggle(ESPPage, "Показать Роль",      CFG.ESP, "Role")
_G.MakeToggle(ESPPage, "Показать Дистанцию", CFG.ESP, "Dist")

local AimPage = Tabs["Aim"].Page
_G.MakeToggle(AimPage, "Aimbot Включён", CFG.Aim, "Enabled")

print("✅ CHUNK 2 — ESP + AIMBOT")
-- ██████████████████████████████████████
-- MM2 PULSE HUB | MOBILE | CHUNK 3/4
-- ВИЗУАЛИЗАЦИЯ — БЕСКОНЕЧНАЯ ПУСТОТА
-- ██████████████████████████████████████

local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local CFG = _G.CFG

local VoidGUI = Instance.new("ScreenGui")
VoidGUI.Name = "VoidLayer"
VoidGUI.IgnoreGuiInset = true
VoidGUI.ResetOnSpawn = false
VoidGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
VoidGUI.Parent = game.CoreGui

-- ФОНОВЫЙ СЛОЙ
local VoidBG = Instance.new("Frame",VoidGUI)
VoidBG.Size = UDim2.new(1,0,1,0)
VoidBG.BackgroundColor3 = Color3.fromRGB(0,0,12)
VoidBG.BackgroundTransparency = 1
VoidBG.BorderSizePixel = 0
VoidBG.ZIndex = 1
VoidBG.Visible = false

local BGGrad = Instance.new("UIGradient",VoidBG)
BGGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,18)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,4,35)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,12)),
})
BGGrad.Rotation = 45

-- КОЛЬЦА
local Ring1 = Instance.new("Frame",VoidGUI)
Ring1.Size = UDim2.new(0,0,0,0)
Ring1.AnchorPoint = Vector2.new(0.5,0.5)
Ring1.Position = UDim2.new(0.5,0,0.5,0)
Ring1.BackgroundColor3 = Color3.fromRGB(80,40,200)
Ring1.BackgroundTransparency = 0.5
Ring1.BorderSizePixel = 0
Ring1.ZIndex = 2
Ring1.Visible = false
Instance.new("UICorner",Ring1).CornerRadius = UDim.new(1,0)

local Ring2 = Instance.new("Frame",VoidGUI)
Ring2.Size = UDim2.new(0,0,0,0)
Ring2.AnchorPoint = Vector2.new(0.5,0.5)
Ring2.Position = UDim2.new(0.5,0,0.5,0)
Ring2.BackgroundColor3 = Color3.fromRGB(120,60,255)
Ring2.BackgroundTransparency = 0.65
Ring2.BorderSizePixel = 0
Ring2.ZIndex = 3
Ring2.Visible = false
Instance.new("UICorner",Ring2).CornerRadius = UDim.new(1,0)

-- ЯДРО
local Core = Instance.new("Frame",VoidGUI)
Core.Size = UDim2.new(0,0,0,0)
Core.AnchorPoint = Vector2.new(0.5,0.5)
Core.Position = UDim2.new(0.5,0,0.5,0)
Core.BackgroundColor3 = Color3.fromRGB(200,160,255)
Core.BackgroundTransparency = 0.3
Core.BorderSizePixel = 0
Core.ZIndex = 4
Core.Visible = false
Instance.new("UICorner",Core).CornerRadius = UDim.new(1,0)

-- ТЕКСТ
local VoidText = Instance.new("TextLabel",VoidGUI)
VoidText.Size = UDim2.new(1,0,0,55)
VoidText.Position = UDim2.new(0,0,0.5,-28)
VoidText.BackgroundTransparency = 1
VoidText.Text = "無限空虚"
VoidText.TextColor3 = Color3.fromRGB(200,160,255)
VoidText.Font = Enum.Font.GothamBold
VoidText.TextSize = 38
VoidText.TextTransparency = 1
VoidText.ZIndex = 5
VoidText.Visible = false

local VoidSub = Instance.new("TextLabel",VoidGUI)
VoidSub.Size = UDim2.new(1,0,0,26)
VoidSub.Position = UDim2.new(0,0,0.5,30)
VoidSub.BackgroundTransparency = 1
VoidSub.Text = "Infinite Void  ·  Gojo Satoru"
VoidSub.TextColor3 = Color3.fromRGB(160,120,220)
VoidSub.Font = Enum.Font.Gotham
VoidSub.TextSize = 15
VoidSub.TextTransparency = 1
VoidSub.ZIndex = 5
VoidSub.Visible = false

-- ЧАСТИЦЫ
local Particles = {}
for i = 1, 35 do
    local p = Instance.new("Frame",VoidGUI)
    p.Size = UDim2.new(0,math.random(2,5),0,math.random(2,5))
    p.Position = UDim2.new(math.random(),0,math.random(),0)
    p.BackgroundColor3 = Color3.fromRGB(
        math.random(100,200),
        math.random(50,110),
        255
    )
    p.BackgroundTransparency = math.random(3,7)/10
    p.BorderSizePixel = 0
    p.ZIndex = 3
    p.Visible = false
    Instance.new("UICorner",p).CornerRadius = UDim.new(1,0)
    table.insert(Particles, p)
end

local voidOpen = false

local function OpenVoid()
    if voidOpen then return end
    voidOpen = true
    VoidBG.Visible=true Ring1.Visible=true
    Ring2.Visible=true  Core.Visible=true
    VoidText.Visible=true VoidSub.Visible=true
    for _,p in pairs(Particles) do p.Visible=true end

    TweenService:Create(VoidBG,TweenInfo.new(0.8),{BackgroundTransparency=0.12}):Play()
    TweenService:Create(Ring1,TweenInfo.new(1.2,Enum.EasingStyle.Back),{
        Size=UDim2.new(0,820,0,820), BackgroundTransparency=0.75
    }):Play()
    task.delay(0.2,function()
        TweenService:Create(Ring2,TweenInfo.new(1.0,Enum.EasingStyle.Back),{
            Size=UDim2.new(0,520,0,520), BackgroundTransparency=0.8
        }):Play()
    end)
    task.delay(0.4,function()
        TweenService:Create(Core,TweenInfo.new(0.8,Enum.EasingStyle.Elastic),{
            Size=UDim2.new(0,140,0,140), BackgroundTransparency=0.4
        }):Play()
    end)
    task.delay(0.6,function()
        TweenService:Create(VoidText,TweenInfo.new(0.6),{TextTransparency=0}):Play()
        TweenService:Create(VoidSub,TweenInfo.new(0.8),{TextTransparency=0}):Play()
    end)
    for _,p in pairs(Particles) do
        TweenService:Create(p,TweenInfo.new(
            math.random(18,38)/10,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            -1, true
        ),{Position=UDim2.new(math.random(),0,math.random(),0)}):Play()
    end
end

local function CloseVoid()
    if not voidOpen then return end
    voidOpen = false
    TweenService:Create(VoidBG,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
    TweenService:Create(Ring1,TweenInfo.new(0.4),{Size=UDim2.new(0,0,0,0),BackgroundTransparency=0.5}):Play()
    TweenService:Create(Ring2,TweenInfo.new(0.35),{Size=UDim2.new(0,0,0,0),BackgroundTransparency=0.65}):Play()
    TweenService:Create(Core,TweenInfo.new(0.3),{Size=UDim2.new(0,0,0,0)}):Play()
    TweenService:Create(VoidText,TweenInfo.new(0.3),{TextTransparency=1}):Play()
    TweenService:Create(VoidSub,TweenInfo.new(0.3),{TextTransparency=1}):Play()
    task.delay(0.7,function()
        VoidBG.Visible=false Ring1.Visible=false
        Ring2.Visible=false  Core.Visible=false
        VoidText.Visible=false VoidSub.Visible=false
        for _,p in pairs(Particles) do p.Visible=false end
    end)
end

-- ПУЛЬС АНИМАЦИЯ
RunService.RenderStepped:Connect(function()
    if not voidOpen then return end
    local t = tick()
    local pulse = math.sin(t*2)*0.04
    Ring1.BackgroundTransparency = 0.75+pulse
    Ring2.BackgroundTransparency = 0.80+pulse
    Core.BackgroundTransparency  = 0.40-pulse
    BGGrad.Rotation = (t*8)%360
end)

-- POPULATE VISUAL TAB
local VisPage = Tabs["Visual"].Page
_G.MakeToggle(VisPage,"✨ Бесконечная Пустота",CFG.Visual,"InfiniteVoid",function(on)
    if on then OpenVoid() else CloseVoid() end
end)
_G.MakeToggle(VisPage,"⭕ FOV Круг",    CFG.Visual,"FOVCircle")
_G.MakeToggle(VisPage,"➕ Кастом прицел",CFG.Visual,"Crosshair")

print("✅ CHUNK 3 — ВИЗУАЛИЗАЦИЯ")
-- ██████████████████████████████████████
-- MM2 PULSE HUB | MOBILE | CHUNK 4/4
-- FARM + TELEPORT + MISC
-- ██████████████████████████████████████

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local CFG = _G.CFG

-- COIN FARM
RunService.Heartbeat:Connect(function()
    if not CFG.Farm.Coins then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        local n = obj.Name:lower()
        if (n:find("coin") or n:find("gold")) and obj:IsA("BasePart") then
            root.CFrame = CFrame.new(obj.Position)
            task.wait(0.08)
        end
    end
end)

-- TELEPORT ФУНКЦИЯ
local function TeleTo(keyword)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(keyword) and obj:IsA("BasePart") then
            root.CFrame = CFrame.new(obj.Position + Vector3.new(0,5,0))
            return
        end
    end
end

-- SPEED
RunService.Heartbeat:Connect(function()
    if not CFG.Misc.Speed then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = CFG.Misc.SpeedVal end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if not CFG.Misc.NoClip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _,p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)

-- INF JUMP
game:GetService("UserInputService").JumpRequest:Connect(function()
    if not CFG.Misc.InfJump then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- FLY
local FlyConn
local function ToggleFly(state)
    if not state then
        if FlyConn then FlyConn:Disconnect() FlyConn=nil end
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if hum then hum.PlatformStand = false end
            if root then
                local bv = root:FindFirstChild("FlyBV")
                if bv then bv:Destroy() end
            end
        end
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    hum.PlatformStand = true
    local BV = Instance.new("BodyVelocity",root)
    BV.Name = "FlyBV"
    BV.MaxForce = Vector3.new(1e5,1e5,1e5)
    BV.Velocity = Vector3.zero
    local UIS = game:GetService("UserInputService")
    FlyConn = RunService.RenderStepped:Connect(function()
        if not CFG.Misc.Fly then ToggleFly(false) return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir=dir+cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir=dir-cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir=dir-cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir=dir+cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
        BV.Velocity = dir*38
    end)
end

-- POPULATE TABS
local FarmPage = Tabs["Farm"].Page
_G.MakeToggle(FarmPage,"💰 Авто-Монеты", CFG.Farm,"Coins")
_G.MakeToggle(FarmPage,"🏆 Авто-Победа", CFG.Farm,"AutoWin")

local TelePage = Tabs["Tele"].Page
_G.MakeButton(TelePage,"🔫 К Пистолету",  function() TeleTo("gun")   end)
_G.MakeButton(TelePage,"🔪 К Ножу",       function() TeleTo("knife") end)
_G.MakeButton(TelePage,"🚪 К Выходу",     function() TeleTo("exit")  end)

local MiscPage = Tabs["Misc"].Page
_G.MakeToggle(MiscPage,"💨 Спидхак",           CFG.Misc,"Speed")
_G.MakeToggle(MiscPage,"👻 Без коллизий",       CFG.Misc,"NoClip")
_G.MakeToggle(MiscPage,"🦘 Бесконечный прыжок", CFG.Misc,"InfJump")
_G.MakeToggle(MiscPage,"🦅 Полёт",              CFG.Misc,"Fly", ToggleFly)

print("✅ CHUNK 4 — FARM + TELE + MISC")
print("🟣 PULSE HUB MOBILE — FULLY LOADED")
print("📌 Кнопка ⚡ MENU в углу экрана")
