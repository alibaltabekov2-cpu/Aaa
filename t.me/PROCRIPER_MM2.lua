-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 1/7
-- INIT + CONFIG
-- ██████████████████████████████████████

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer      = Players.LocalPlayer

if game.CoreGui:FindFirstChild("PulseHub") then
    game.CoreGui.PulseHub:Destroy()
end

_G.PH = {
    ESP    = {Enabled=true, Gun=false, Style="Minimal", Tracers=false,
              TracerFrom="Bottom", All=false, Coins=false, Knife=true, Pistol=true},
    Aim    = {Enabled=false, Silent=false, FOV=180, NoRecoil=false, AutoKill=false},
    Move   = {NoClip=false, InfJump=false, AntiFling=false, BombJump=false,
              Fly=false, FlySpeed=90, FlyAnim=false, Speed=false, SpeedVal=28,
              Bhop=false, Levitate=false},
    Farm   = {Coins=false, AutoWin=false},
    Visual = {Crosshair=false, Fullbright=false, Chams=false},
    Troll  = {Fling=false, FlingForce=80, Spin=false},
}

-- GUI ROOT
local GUI = Instance.new("ScreenGui")
GUI.Name = "PulseHub"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = game.CoreGui
_G.PHGUI = GUI

-- OPEN BUTTON
local OpenBtn = Instance.new("TextButton", GUI)
OpenBtn.Size = UDim2.new(0,100,0,28)
OpenBtn.Position = UDim2.new(0,10,0,10)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30,30,42)
OpenBtn.Text = "⚡ Pulse Hub"
OpenBtn.TextColor3 = Color3.fromRGB(167,139,250)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 12
OpenBtn.BorderSizePixel = 0
OpenBtn.ZIndex = 200
OpenBtn.Active = true
OpenBtn.Draggable = true
Instance.new("UICorner",OpenBtn).CornerRadius = UDim.new(0,7)
Instance.new("UIStroke",OpenBtn).Color = Color3.fromRGB(58,58,80)
_G.PHOpenBtn = OpenBtn

print("✅ 1/7 — INIT + CONFIG")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 2/7
-- MAIN WINDOW + TITLEBAR
-- ██████████████████████████████████████

local TweenService = game:GetService("TweenService")
local GUI = _G.PHGUI

-- WINDOW
local Win = Instance.new("Frame", GUI)
Win.Size = UDim2.new(0,800,0,520)
Win.Position = UDim2.new(0.5,-400,0.5,-260)
Win.BackgroundColor3 = Color3.fromRGB(22,22,30)
Win.BorderSizePixel = 0
Win.Visible = false
Win.ZIndex = 10
Win.Active = true
Win.Draggable = true
Instance.new("UICorner",Win).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke",Win).Color = Color3.fromRGB(42,42,58)
_G.PHWin = Win

-- TITLEBAR
local TBar = Instance.new("Frame",Win)
TBar.Size = UDim2.new(1,0,0,44)
TBar.BackgroundColor3 = Color3.fromRGB(17,17,24)
TBar.BorderSizePixel = 0
TBar.ZIndex = 11
Instance.new("UICorner",TBar).CornerRadius = UDim.new(0,12)
local TFix = Instance.new("Frame",TBar)
TFix.Size = UDim2.new(1,0,0.5,0)
TFix.Position = UDim2.new(0,0,0.5,0)
TFix.BackgroundColor3 = Color3.fromRGB(17,17,24)
TFix.BorderSizePixel = 0; TFix.ZIndex = 11

-- LOGO
local LogoBox = Instance.new("Frame",TBar)
LogoBox.Size = UDim2.new(0,28,0,28)
LogoBox.Position = UDim2.new(0,12,0.5,-14)
LogoBox.BackgroundColor3 = Color3.fromRGB(124,58,237)
LogoBox.BorderSizePixel = 0; LogoBox.ZIndex = 12
Instance.new("UICorner",LogoBox).CornerRadius = UDim.new(0,7)
local LGrad = Instance.new("UIGradient",LogoBox)
LGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(100,40,200)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(168,85,247)),
})
LGrad.Rotation = 135
local LogoTxt = Instance.new("TextLabel",LogoBox)
LogoTxt.Size = UDim2.new(1,0,1,0)
LogoTxt.BackgroundTransparency = 1
LogoTxt.Text = "P"
LogoTxt.TextColor3 = Color3.fromRGB(255,255,255)
LogoTxt.Font = Enum.Font.GothamBold
LogoTxt.TextSize = 16; LogoTxt.ZIndex = 13

-- TITLE
local TitleL = Instance.new("TextLabel",TBar)
TitleL.Size = UDim2.new(0,80,0,18)
TitleL.Position = UDim2.new(0,48,0,6)
TitleL.BackgroundTransparency = 1
TitleL.Text = "Pulse Hub"
TitleL.TextColor3 = Color3.fromRGB(255,255,255)
TitleL.Font = Enum.Font.GothamBold
TitleL.TextSize = 14
TitleL.TextXAlignment = Enum.TextXAlignment.Left
TitleL.ZIndex = 12

local SubL = Instance.new("TextLabel",TBar)
SubL.Size = UDim2.new(0,130,0,14)
SubL.Position = UDim2.new(0,48,0,24)
SubL.BackgroundTransparency = 1
SubL.Text = "Murder Mystery 2"
SubL.TextColor3 = Color3.fromRGB(85,85,100)
SubL.Font = Enum.Font.Gotham
SubL.TextSize = 10
SubL.TextXAlignment = Enum.TextXAlignment.Left
SubL.ZIndex = 12

-- CENTER TABS
local TabG = Instance.new("TextButton",TBar)
TabG.Size = UDim2.new(0,72,0,28)
TabG.Position = UDim2.new(0.5,-78,0.5,-14)
TabG.BackgroundColor3 = Color3.fromRGB(124,58,237)
TabG.Text = "Общее"
TabG.TextColor3 = Color3.fromRGB(255,255,255)
TabG.Font = Enum.Font.GothamSemibold
TabG.TextSize = 12; TabG.BorderSizePixel = 0; TabG.ZIndex = 12
Instance.new("UICorner",TabG).CornerRadius = UDim.new(0,7)

local TabUI = Instance.new("TextButton",TBar)
TabUI.Size = UDim2.new(0,48,0,28)
TabUI.Position = UDim2.new(0.5,2,0.5,-14)
TabUI.BackgroundColor3 = Color3.fromRGB(30,30,42)
TabUI.Text = "UI"
TabUI.TextColor3 = Color3.fromRGB(136,136,155)
TabUI.Font = Enum.Font.GothamSemibold
TabUI.TextSize = 12; TabUI.BorderSizePixel = 0; TabUI.ZIndex = 12
Instance.new("UICorner",TabUI).CornerRadius = UDim.new(0,7)

-- SEARCH
local SearchBox = Instance.new("TextBox",TBar)
SearchBox.Size = UDim2.new(0,150,0,28)
SearchBox.Position = UDim2.new(1,-240,0.5,-14)
SearchBox.BackgroundColor3 = Color3.fromRGB(30,30,42)
SearchBox.PlaceholderText = "🔍 Поиск..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(68,68,85)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(200,200,210)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.BorderSizePixel = 0; SearchBox.ZIndex = 12
SearchBox.ClearTextOnFocus = false
Instance.new("UICorner",SearchBox).CornerRadius = UDim.new(0,7)
Instance.new("UIStroke",SearchBox).Color = Color3.fromRGB(42,42,58)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = SearchBox.Text:lower()
    for _, row in pairs(game.CoreGui.PulseHub:GetDescendants()) do
        if row.Name == "PHRow" then
            local lbl = row:FindFirstChildOfClass("TextLabel")
            row.Visible = not q ~= "" or (lbl and lbl.Text:lower():find(q) ~= nil)
        end
    end
end)

-- CLOSE / MIN
local CloseBtn = Instance.new("TextButton",TBar)
CloseBtn.Size = UDim2.new(0,22,0,22)
CloseBtn.Position = UDim2.new(1,-30,0.5,-11)
CloseBtn.BackgroundColor3 = Color3.fromRGB(74,21,32)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(248,113,113)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10; CloseBtn.BorderSizePixel = 0; CloseBtn.ZIndex = 12
Instance.new("UICorner",CloseBtn).CornerRadius = UDim.new(0,5)
CloseBtn.MouseButton1Click:Connect(function() Win.Visible=false end)

local MinBtn = Instance.new("TextButton",TBar)
MinBtn.Size = UDim2.new(0,22,0,22)
MinBtn.Position = UDim2.new(1,-56,0.5,-11)
MinBtn.BackgroundColor3 = Color3.fromRGB(37,37,52)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(119,119,136)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 10; MinBtn.BorderSizePixel = 0; MinBtn.ZIndex = 12
Instance.new("UICorner",MinBtn).CornerRadius = UDim.new(0,5)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Win.Size = minimized
        and UDim2.new(0,800,0,44)
        or  UDim2.new(0,800,0,520)
end)

_G.PHOpenBtn.MouseButton1Click:Connect(function()
    Win.Visible = not Win.Visible
end)

-- TITLEBAR DIVIDER
local TDiv = Instance.new("Frame",Win)
TDiv.Size = UDim2.new(1,0,0,1)
TDiv.Position = UDim2.new(0,0,0,44)
TDiv.BackgroundColor3 = Color3.fromRGB(34,34,48)
TDiv.BorderSizePixel = 0; TDiv.ZIndex = 11

print("✅ 2/7 — WINDOW + TITLEBAR")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 3/7
-- 3-COLUMN LAYOUT
-- ██████████████████████████████████████

local Win = _G.PHWin

-- LEFT ICON NAV
local IconNav = Instance.new("Frame",Win)
IconNav.Size = UDim2.new(0,58,1,-45)
IconNav.Position = UDim2.new(0,0,0,45)
IconNav.BackgroundColor3 = Color3.fromRGB(17,17,24)
IconNav.BorderSizePixel = 0; IconNav.ZIndex = 11
local INavList = Instance.new("UIListLayout",IconNav)
INavList.SortOrder = Enum.SortOrder.LayoutOrder
INavList.Padding = UDim.new(0,2)
INavList.HorizontalAlignment = Enum.HorizontalAlignment.Center
local INavPad = Instance.new("UIPadding",IconNav)
INavPad.PaddingTop = UDim.new(0,8)

local IconDiv = Instance.new("Frame",Win)
IconDiv.Size = UDim2.new(0,1,1,-45)
IconDiv.Position = UDim2.new(0,58,0,45)
IconDiv.BackgroundColor3 = Color3.fromRGB(30,30,42)
IconDiv.BorderSizePixel = 0; IconDiv.ZIndex = 11

-- MID PANEL
local MidFrame = Instance.new("Frame",Win)
MidFrame.Size = UDim2.new(0,260,1,-45)
MidFrame.Position = UDim2.new(0,59,0,45)
MidFrame.BackgroundColor3 = Color3.fromRGB(22,22,30)
MidFrame.BorderSizePixel = 0; MidFrame.ZIndex = 11
_G.PHMidFrame = MidFrame

local MidDiv = Instance.new("Frame",Win)
MidDiv.Size = UDim2.new(0,1,1,-45)
MidDiv.Position = UDim2.new(0,319,0,45)
MidDiv.BackgroundColor3 = Color3.fromRGB(30,30,42)
MidDiv.BorderSizePixel = 0; MidDiv.ZIndex = 11

-- RIGHT FRAME
local RightFrame = Instance.new("Frame",Win)
RightFrame.Size = UDim2.new(1,-320,1,-45)
RightFrame.Position = UDim2.new(0,320,0,45)
RightFrame.BackgroundColor3 = Color3.fromRGB(22,22,30)
RightFrame.BorderSizePixel = 0; RightFrame.ZIndex = 11

local RHeader = Instance.new("Frame",RightFrame)
RHeader.Size = UDim2.new(1,0,0,32)
RHeader.BackgroundTransparency = 1; RHeader.ZIndex = 12

local RHeaderL = Instance.new("TextLabel",RHeader)
RHeaderL.Size = UDim2.new(1,-20,1,0)
RHeaderL.Position = UDim2.new(0,14,0,0)
RHeaderL.BackgroundTransparency = 1
RHeaderL.Text = "Передвижение"
RHeaderL.TextColor3 = Color3.fromRGB(224,224,232)
RHeaderL.Font = Enum.Font.GothamBold
RHeaderL.TextSize = 13
RHeaderL.TextXAlignment = Enum.TextXAlignment.Left
RHeaderL.ZIndex = 13

local RHDiv = Instance.new("Frame",RightFrame)
RHDiv.Size = UDim2.new(1,0,0,1)
RHDiv.Position = UDim2.new(0,0,0,32)
RHDiv.BackgroundColor3 = Color3.fromRGB(30,30,42)
RHDiv.BorderSizePixel = 0; RHDiv.ZIndex = 12

local RScroll = Instance.new("ScrollingFrame",RightFrame)
RScroll.Size = UDim2.new(1,0,1,-33)
RScroll.Position = UDim2.new(0,0,0,33)
RScroll.BackgroundTransparency = 1; RScroll.BorderSizePixel = 0
RScroll.ScrollBarThickness = 2
RScroll.ScrollBarImageColor3 = Color3.fromRGB(60,60,80)
RScroll.ZIndex = 12
RScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local RList = Instance.new("UIListLayout",RScroll)
RList.SortOrder = Enum.SortOrder.LayoutOrder
RList.Padding = UDim.new(0,0)
_G.PHRScroll = RScroll

-- NAV PAGES
_G.PHPages = {}
_G.PHNavBtns = {}

local NavDefs = {
    {ID="main",     Icon="⊞", Label="Главная"},
    {ID="combat",   Icon="⚔", Label="Combat"},
    {ID="farm",     Icon="💰", Label="Автофарм"},
    {ID="tele",     Icon="⚡", Label="Телепорт"},
    {ID="troll",    Icon="😈", Label="Troll Fun"},
    {ID="anim",     Icon="🎭", Label="Free anims"},
    {ID="fly",      Icon="🪂", Label="Флинг"},
    {ID="visual",   Icon="✨", Label="Визуал"},
    {ID="settings", Icon="⚙", Label="Настройки"},
    {ID="server",   Icon="🌐", Label="Сервер"},
}

for i, def in ipairs(NavDefs) do
    local IBtn = Instance.new("TextButton",IconNav)
    IBtn.Size = UDim2.new(0,44,0,44)
    IBtn.BackgroundColor3 = Color3.fromRGB(17,17,24)
    IBtn.BorderSizePixel = 0; IBtn.Text = ""; IBtn.LayoutOrder = i; IBtn.ZIndex = 12
    Instance.new("UICorner",IBtn).CornerRadius = UDim.new(0,9)

    local Accent = Instance.new("Frame",IBtn)
    Accent.Size = UDim2.new(0,3,0.6,0)
    Accent.Position = UDim2.new(0,0,0.2,0)
    Accent.BackgroundColor3 = Color3.fromRGB(124,58,237)
    Accent.BorderSizePixel = 0; Accent.Visible = false; Accent.ZIndex = 13
    Instance.new("UICorner",Accent).CornerRadius = UDim.new(1,0)

    local IIco = Instance.new("TextLabel",IBtn)
    IIco.Size = UDim2.new(1,0,0,20)
    IIco.Position = UDim2.new(0,0,0,6)
    IIco.BackgroundTransparency = 1
    IIco.Text = def.Icon
    IIco.TextColor3 = Color3.fromRGB(85,85,100)
    IIco.Font = Enum.Font.Gotham; IIco.TextSize = 16; IIco.ZIndex = 13

    local ILbl = Instance.new("TextLabel",IBtn)
    ILbl.Size = UDim2.new(1,0,0,12)
    ILbl.Position = UDim2.new(0,0,0,26)
    ILbl.BackgroundTransparency = 1
    ILbl.Text = def.Label
    ILbl.TextColor3 = Color3.fromRGB(85,85,100)
    ILbl.Font = Enum.Font.Gotham; ILbl.TextSize = 8; ILbl.ZIndex = 13

    -- PAGE
    local Page = Instance.new("Frame",MidFrame)
    Page.Size = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency = 1; Page.BorderSizePixel = 0
    Page.Visible = (def.ID=="main"); Page.ZIndex = 12

    local PHdr = Instance.new("Frame",Page)
    PHdr.Size = UDim2.new(1,0,0,32)
    PHdr.BackgroundTransparency = 1; PHdr.ZIndex = 13

    local PHdrL = Instance.new("TextLabel",PHdr)
    PHdrL.Size = UDim2.new(1,-20,1,0)
    PHdrL.Position = UDim2.new(0,12,0,0)
    PHdrL.BackgroundTransparency = 1
    PHdrL.Text = "| "..def.Label
    PHdrL.TextColor3 = Color3.fromRGB(224,224,232)
    PHdrL.Font = Enum.Font.GothamBold; PHdrL.TextSize = 13
    PHdrL.TextXAlignment = Enum.TextXAlignment.Left; PHdrL.ZIndex = 14

    local PHdrDiv = Instance.new("Frame",Page)
    PHdrDiv.Size = UDim2.new(1,0,0,1)
    PHdrDiv.Position = UDim2.new(0,0,0,32)
    PHdrDiv.BackgroundColor3 = Color3.fromRGB(30,30,42)
    PHdrDiv.BorderSizePixel = 0; PHdrDiv.ZIndex = 13

    local PScroll = Instance.new("ScrollingFrame",Page)
    PScroll.Size = UDim2.new(1,0,1,-33)
    PScroll.Position = UDim2.new(0,0,0,33)
    PScroll.BackgroundTransparency = 1; PScroll.BorderSizePixel = 0
    PScroll.ScrollBarThickness = 2
    PScroll.ScrollBarImageColor3 = Color3.fromRGB(60,60,80)
    PScroll.ZIndex = 13
    PScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local PList = Instance.new("UIListLayout",PScroll)
    PList.SortOrder = Enum.SortOrder.LayoutOrder; PList.Padding = UDim.new(0,0)

    _G.PHPages[def.ID] = PScroll
    _G.PHNavBtns[def.ID] = {Btn=IBtn,Accent=Accent,Ico=IIco,Lbl=ILbl}

    if def.ID=="main" then
        IBtn.BackgroundColor3 = Color3.fromRGB(25,18,42)
        Accent.Visible=true
        IIco.TextColor3 = Color3.fromRGB(255,255,255)
        ILbl.TextColor3 = Color3.fromRGB(167,139,250)
    end

    IBtn.MouseButton1Click:Connect(function()
        for k,nb in pairs(_G.PHNavBtns) do
            nb.Btn.BackgroundColor3 = Color3.fromRGB(17,17,24)
            nb.Accent.Visible=false
            nb.Ico.TextColor3 = Color3.fromRGB(85,85,100)
            nb.Lbl.TextColor3 = Color3.fromRGB(85,85,100)
        end
        IBtn.BackgroundColor3 = Color3.fromRGB(25,18,42)
        Accent.Visible=true
        IIco.TextColor3 = Color3.fromRGB(255,255,255)
        ILbl.TextColor3 = Color3.fromRGB(167,139,250)
        for k,pg in pairs(_G.PHPages) do
            pg.Parent.Visible = (k==def.ID)
        end
    end)
end

print("✅ 3/7 — LAYOUT + NAV")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 4/7
-- BUILDERS
-- ██████████████████████████████████████

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

-- SECTION
function _G.PHSection(parent, text)
    local F = Instance.new("Frame",parent)
    F.Size = UDim2.new(1,0,0,26)
    F.BackgroundTransparency = 1; F.ZIndex = 14
    local Pipe = Instance.new("TextLabel",F)
    Pipe.Size = UDim2.new(0,10,1,0)
    Pipe.BackgroundTransparency = 1
    Pipe.Text = "|"; Pipe.TextColor3 = Color3.fromRGB(124,58,237)
    Pipe.Font = Enum.Font.GothamBold; Pipe.TextSize = 13; Pipe.ZIndex = 15
    local L = Instance.new("TextLabel",F)
    L.Size = UDim2.new(1,-24,1,0)
    L.Position = UDim2.new(0,14,0,0)
    L.BackgroundTransparency = 1
    L.Text = text; L.TextColor3 = Color3.fromRGB(85,85,100)
    L.Font = Enum.Font.GothamBold; L.TextSize = 10
    L.TextXAlignment = Enum.TextXAlignment.Left; L.ZIndex = 15
end

-- TOGGLE
function _G.PHToggle(parent, label, cfgT, cfgK, cb)
    local Row = Instance.new("Frame",parent)
    Row.Name = "PHRow"
    Row.Size = UDim2.new(1,0,0,32)
    Row.BackgroundColor3 = Color3.fromRGB(22,22,30)
    Row.BorderSizePixel = 0; Row.ZIndex = 14

    local Div = Instance.new("Frame",Row)
    Div.Size = UDim2.new(1,0,0,1)
    Div.Position = UDim2.new(0,0,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(28,28,38)
    Div.BorderSizePixel = 0; Div.ZIndex = 15

    local Lbl = Instance.new("TextLabel",Row)
    Lbl.Size = UDim2.new(1,-72,1,0)
    Lbl.Position = UDim2.new(0,12,0,0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label; Lbl.TextColor3 = Color3.fromRGB(200,200,212)
    Lbl.Font = Enum.Font.Gotham; Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left; Lbl.ZIndex = 15

    local on0 = cfgT and cfgT[cfgK] or false

    local Track = Instance.new("Frame",Row)
    Track.Size = UDim2.new(0,34,0,18)
    Track.Position = UDim2.new(1,-44,0.5,-9)
    Track.BackgroundColor3 = on0
        and Color3.fromRGB(124,58,237)
        or  Color3.fromRGB(42,42,58)
    Track.BorderSizePixel = 0; Track.ZIndex = 15
    Instance.new("UICorner",Track).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame",Track)
    Knob.Size = UDim2.new(0,12,0,12)
    Knob.Position = on0
        and UDim2.new(1,-15,0.5,-6)
        or  UDim2.new(0,3,0.5,-6)
    Knob.BackgroundColor3 = on0
        and Color3.fromRGB(255,255,255)
        or  Color3.fromRGB(102,102,119)
    Knob.BorderSizePixel = 0; Knob.ZIndex = 16
    Instance.new("UICorner",Knob).CornerRadius = UDim.new(1,0)

    local TB = Instance.new("TextButton",Row)
    TB.Size = UDim2.new(1,0,1,0)
    TB.BackgroundTransparency = 1; TB.Text = ""; TB.ZIndex = 17

    TB.MouseButton1Click:Connect(function()
        if cfgT then cfgT[cfgK] = not cfgT[cfgK] end
        local on = cfgT and cfgT[cfgK] or false
        TweenService:Create(Track,TweenInfo.new(0.15),{
            BackgroundColor3 = on
                and Color3.fromRGB(124,58,237)
                or  Color3.fromRGB(42,42,58)
        }):Play()
        TweenService:Create(Knob,TweenInfo.new(0.15),{
            Position = on
                and UDim2.new(1,-15,0.5,-6)
                or  UDim2.new(0,3,0.5,-6),
            BackgroundColor3 = on
                and Color3.fromRGB(255,255,255)
                or  Color3.fromRGB(102,102,119)
        }):Play()
        TweenService:Create(Row,TweenInfo.new(0.08),{
            BackgroundColor3 = Color3.fromRGB(26,26,36)
        }):Play()
        task.delay(0.1,function()
            TweenService:Create(Row,TweenInfo.new(0.08),{
                BackgroundColor3=Color3.fromRGB(22,22,30)
            }):Play()
        end)
        if cb then cb(on) end
    end)
end

-- DROPDOWN
function _G.PHDrop(parent, label, options)
    local Row = Instance.new("Frame",parent)
    Row.Name = "PHRow"
    Row.Size = UDim2.new(1,0,0,32)
    Row.BackgroundColor3 = Color3.fromRGB(22,22,30)
    Row.BorderSizePixel = 0; Row.ZIndex = 14

    local Div = Instance.new("Frame",Row)
    Div.Size = UDim2.new(1,0,0,1)
    Div.Position = UDim2.new(0,0,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(28,28,38)
    Div.BorderSizePixel = 0; Div.ZIndex = 15

    local Lbl = Instance.new("TextLabel",Row)
    Lbl.Size = UDim2.new(0.5,0,1,0)
    Lbl.Position = UDim2.new(0,12,0,0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label; Lbl.TextColor3 = Color3.fromRGB(200,200,212)
    Lbl.Font = Enum.Font.Gotham; Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left; Lbl.ZIndex = 15

    local DropBtn = Instance.new("TextButton",Row)
    DropBtn.Size = UDim2.new(0,90,0,22)
    DropBtn.Position = UDim2.new(1,-98,0.5,-11)
    DropBtn.BackgroundColor3 = Color3.fromRGB(30,30,42)
    DropBtn.Text = (options[1] or "None").."  ▼"
    DropBtn.TextColor3 = Color3.fromRGB(170,170,185)
    DropBtn.Font = Enum.Font.Gotham; DropBtn.TextSize = 11
    DropBtn.BorderSizePixel = 0; DropBtn.ZIndex = 15
    Instance.new("UICorner",DropBtn).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke",DropBtn).Color = Color3.fromRGB(42,42,58)

    local idx = 1
    DropBtn.MouseButton1Click:Connect(function()
        idx = idx % #options + 1
        DropBtn.Text = options[idx].."  ▼"
        TweenService:Create(DropBtn,TweenInfo.new(0.1),{
            BackgroundColor3=Color3.fromRGB(42,30,65)
        }):Play()
        task.delay(0.12,function()
            TweenService:Create(DropBtn,TweenInfo.new(0.1),{
                BackgroundColor3=Color3.fromRGB(30,30,42)
            }):Play()
        end)
    end)
end

-- SLIDER
function _G.PHSlider(parent, label, min, max, val, unit, cfgT, cfgK)
    local F = Instance.new("Frame",parent)
    F.Name = "PHRow"
    F.Size = UDim2.new(1,0,0,46)
    F.BackgroundColor3 = Color3.fromRGB(22,22,30)
    F.BorderSizePixel = 0; F.ZIndex = 14

    local Div = Instance.new("Frame",F)
    Div.Size = UDim2.new(1,0,0,1)
    Div.Position = UDim2.new(0,0,1,-1)
    Div.BackgroundColor3 = Color3.fromRGB(28,28,38)
    Div.BorderSizePixel = 0; Div.ZIndex = 15

    local LblL = Instance.new("TextLabel",F)
    LblL.Size = UDim2.new(0.65,0,0,20)
    LblL.Position = UDim2.new(0,12,0,4)
    LblL.BackgroundTransparency = 1
    LblL.Text = label; LblL.TextColor3 = Color3.fromRGB(85,85,100)
    LblL.Font = Enum.Font.Gotham; LblL.TextSize = 11
    LblL.TextXAlignment = Enum.TextXAlignment.Left; LblL.ZIndex = 15

    local ValL = Instance.new("TextLabel",F)
    ValL.Size = UDim2.new(0.35,0,0,20)
    ValL.Position = UDim2.new(0.65,0,0,4)
    ValL.BackgroundTransparency = 1
    ValL.Text = tostring(val)..(unit or "")
    ValL.TextColor3 = Color3.fromRGB(136,136,155)
    ValL.Font = Enum.Font.GothamSemibold; ValL.TextSize = 11
    ValL.TextXAlignment = Enum.TextXAlignment.Right; ValL.ZIndex = 15

    local TrackBG = Instance.new("Frame",F)
    TrackBG.Size = UDim2.new(1,-24,0,3)
    TrackBG.Position = UDim2.new(0,12,0,30)
    TrackBG.BackgroundColor3 = Color3.fromRGB(42,42,58)
    TrackBG.BorderSizePixel = 0; TrackBG.ZIndex = 15
    Instance.new("UICorner",TrackBG).CornerRadius = UDim.new(1,0)

    local ratio = math.clamp((val-min)/(max-min),0,1)
    local Fill = Instance.new("Frame",TrackBG)
Fill.Size = UDim2.new(ratio,0,1,0)
Fill.BackgroundColor3 = Color3.fromRGB(124,58,237)
Fill.BorderSizePixel = 0
Fill.ZIndex = 16
Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)
local Thumb = Instance.new("TextButton",TrackBG)
Thumb.Size = UDim2.new(0,11,0,11)
Thumb.Position = UDim2.new(ratio,-5,0.5,-5)
Thumb.BackgroundColor3 = Color3.fromRGB(167,139,250)
Thumb.Text = ""
Thumb.BorderSizePixel = 0
Thumb.ZIndex = 17
Instance.new("UICorner",Thumb).CornerRadius = UDim.new(1,0)
local dragging = false
Thumb.MouseButton1Down:Connect(function() dragging=true end)
UserInputService.InputEnded:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
end)
RunService.RenderStepped:Connect(function()
if not dragging then return end
local r = math.clamp((UserInputService:GetMouseLocation().X - TrackBG.AbsolutePosition.X)/TrackBG.AbsoluteSize.X,0,1)
local v = math.floor(min + r*(max-min))
Fill.Size = UDim2.new(r,0,1,0)
Thumb.Position = UDim2.new(r,-5,0.5,-5)
ValL.Text = tostring(v)..(unit or "")
if cfgT then cfgT[cfgK]=v end
end)
end
function _G.PHButton(parent, label, btnText, cb)
local Row = Instance.new("Frame",parent)
Row.Name = "PHRow"
Row.Size = UDim2.new(1,0,0,36)
Row.BackgroundColor3 = Color3.fromRGB(22,22,30)
Row.BorderSizePixel = 0
Row.ZIndex = 14
local Div = Instance.new("Frame",Row)
Div.Size = UDim2.new(1,0,0,1)
Div.Position = UDim2.new(0,0,1,-1)
Div.BackgroundColor3 = Color3.fromRGB(28,28,38)
Div.BorderSizePixel = 0
Div.ZIndex = 15
local Lbl = Instance.new("TextLabel",Row)
Lbl.Size = UDim2.new(0.6,0,1,0)
Lbl.Position = UDim2.new(0,12,0,0)
Lbl.BackgroundTransparency = 1
Lbl.Text = label
Lbl.TextColor3 = Color3.fromRGB(200,200,212)
Lbl.Font = Enum.Font.Gotham
Lbl.TextSize = 12
Lbl.TextXAlignment = Enum.TextXAlignment.Left
Lbl.ZIndex = 15
local Btn = Instance.new("TextButton",Row)
Btn.Size = UDim2.new(0,50,0,22)
Btn.Position = UDim2.new(1,-58,0.5,-11)
Btn.BackgroundColor3 = Color3.fromRGB(30,30,42)
Btn.Text = btnText or "ТП"
Btn.TextColor3 = Color3.fromRGB(167,139,250)
Btn.Font = Enum.Font.GothamSemibold
Btn.TextSize = 11
Btn.BorderSizePixel = 0
Btn.ZIndex = 15
Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke",Btn).Color = Color3.fromRGB(58,58,80)
Btn.MouseButton1Click:Connect(function()
TweenService:Create(Btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(50,30,80)}):Play()
task.delay(0.12,function()
TweenService:Create(Btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(30,30,42)}):Play()
end)
if cb then cb() end
end)
end
print("✅ 4/7 — BUILDERS COMPLETE")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 5/7
-- PAGES: ESP + COMBAT + FARM + TELE
-- ██████████████████████████████████████

local PH = _G.PH

-- ════════════════════
-- MAIN — ESP ролей
-- ════════════════════
local MainP = _G.PHPages["main"]
_G.PHSection(MainP,"ESP ролей")
_G.PHToggle(MainP,"Включить ESP ролей",      PH.ESP,"Enabled")
_G.PHToggle(MainP,"ESP Пистолета",            PH.ESP,"Gun")
_G.PHDrop(MainP,"Role ESP Style",{"Minimal","Full","Dot","Arrow"})
_G.PHToggle(MainP,"Tracers",                  PH.ESP,"Tracers")
_G.PHDrop(MainP,"Откуда",{"Bottom","Top","Middle","Mouse"})
_G.PHToggle(MainP,"Все ESP",                  PH.ESP,"All")
_G.PHDrop(MainP,"Стиль",{"Full","Minimal","Dot"})
_G.PHSection(MainP,"Доп. метки")
_G.PHToggle(MainP,"Монеты ESP",               PH.ESP,"Coins")
_G.PHToggle(MainP,"Нож ESP",                  PH.ESP,"Knife")
_G.PHToggle(MainP,"Пистолет ESP",             PH.ESP,"Pistol")

-- ════════════════════
-- COMBAT
-- ════════════════════
local CombatP = _G.PHPages["combat"]
_G.PHSection(CombatP,"Aimbot")
_G.PHToggle(CombatP,"Aimbot",                 PH.Aim,"Enabled")
_G.PHToggle(CombatP,"Silent Aim",             PH.Aim,"Silent")
_G.PHToggle(CombatP,"FOV Круг",               nil,nil)
_G.PHSlider(CombatP,"FOV Радиус",50,400,180,"",PH.Aim,"FOV")
_G.PHSection(CombatP,"Прочее")
_G.PHToggle(CombatP,"Без отдачи",             PH.Aim,"NoRecoil")
_G.PHToggle(CombatP,"Авто-убийство",          PH.Aim,"AutoKill")

-- ════════════════════
-- FARM
-- ════════════════════
local FarmP = _G.PHPages["farm"]
_G.PHSection(FarmP,"Монеты")
_G.PHToggle(FarmP,"Авто-монеты",              PH.Farm,"Coins")
_G.PHToggle(FarmP,"Авто-победа",              PH.Farm,"AutoWin")

-- ════════════════════
-- TELEPORT
-- ════════════════════
local TeleP = _G.PHPages["tele"]
local LocalPlayer = game.Players.LocalPlayer
local function TPTo(kw)
    local char = LocalPlayer.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
    for _,obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(kw) and obj:IsA("BasePart") then
            root.CFrame = CFrame.new(obj.Position+Vector3.new(0,5,0))
            return
        end
    end
end

_G.PHSection(TeleP,"Телепорт")
_G.PHButton(TeleP,"К ножу",       "ТП", function() TPTo("knife")   end)
_G.PHButton(TeleP,"К пистолету",  "ТП", function() TPTo("gun")     end)
_G.PHButton(TeleP,"К выходу",     "ТП", function() TPTo("exit")    end)
_G.PHButton(TeleP,"К монетам",    "ТП", function() TPTo("coin")    end)

-- ════════════════════
-- VISUAL
-- ════════════════════
local VisP = _G.PHPages["visual"]
_G.PHSection(VisP,"Эффекты")
_G.PHToggle(VisP,"Кастом прицел", PH.Visual,"Crosshair")
_G.PHToggle(VisP,"Фулл брайт",   PH.Visual,"Fullbright")
_G.PHToggle(VisP,"Чамсы",        PH.Visual,"Chams")

-- ════════════════════
-- TROLL
-- ════════════════════
local TrollP = _G.PHPages["troll"]
_G.PHSection(TrollP,"Troll")
_G.PHToggle(TrollP,"Флинг",       PH.Troll,"Fling")
_G.PHSlider(TrollP,"Сила флинга",1,300,80,"",PH.Troll,"FlingForce")
_G.PHToggle(TrollP,"Спин",        PH.Troll,"Spin")

print("✅ 5/7 — PAGES POPULATED")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 6/7
-- RIGHT PANEL + ESP SYSTEM
-- ██████████████████████████████████████

local Players   = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local PH = _G.PH
local RP = _G.PHRScroll

-- ════════════════════
-- RIGHT — ПЕРЕДВИЖЕНИЕ
-- ════════════════════
_G.PHSection(RP,"Движение")
_G.PHToggle(RP,"No Clip",              PH.Move,"NoClip")
_G.PHToggle(RP,"Бесконечные прыжки",   PH.Move,"InfJump")
_G.PHToggle(RP,"Анти-флинг",           PH.Move,"AntiFling")
_G.PHToggle(RP,"Бомба прыжок",         PH.Move,"BombJump")
_G.PHToggle(RP,"Полёт",                PH.Move,"Fly", function(on)
    if on then if _G.PHStartFly then _G.PHStartFly() end
    else if _G.PHStopFly then _G.PHStopFly() end end
end)
_G.PHSlider(RP,"Скорость полёта",10,300,90,"",PH.Move,"FlySpeed")
_G.PHToggle(RP,"Анимация полёта",      PH.Move,"FlyAnim")
_G.PHSection(RP,"Скорость")
_G.PHToggle(RP,"Спидхак",             PH.Move,"Speed")
_G.PHSlider(RP,"Скорость",16,150,28,"",PH.Move,"SpeedVal")
_G.PHToggle(RP,"Auto Bhop",           PH.Move,"Bhop")
_G.PHSection(RP,"Прочее")
_G.PHToggle(RP,"Нокип",               PH.Move,"NoClip")
_G.PHToggle(RP,"Левитация",           PH.Move,"Levitate")

-- ════════════════════
-- ESP SYSTEM
-- ════════════════════
local ESPFolder = Instance.new("Folder",game.CoreGui)
ESPFolder.Name = "PHubESP"
local ESPCache = {}

local RoleColors = {
    Murderer = Color3.fromRGB(239,68,68),
    Sheriff  = Color3.fromRGB(96,165,250),
    Innocent = Color3.fromRGB(134,239,172),
}

local function GetRole(player)
    local char = player.Character; if not char then return "Innocent" end
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
    BB.Size = UDim2.new(0,180,0,55)
    BB.StudsOffset = Vector3.new(0,3.5,0)
    BB.Parent = ESPFolder

    local NameL = Instance.new("TextLabel",BB)
    NameL.Size = UDim2.new(1,0,0,18)
    NameL.BackgroundTransparency = 1
    NameL.Font = Enum.Font.GothamBold; NameL.TextSize = 13
    NameL.TextStrokeTransparency = 0
    NameL.TextStrokeColor3 = Color3.new(0,0,0)
    NameL.Name = "NameL"

    local RoleL = Instance.new("TextLabel",BB)
    RoleL.Size = UDim2.new(1,0,0,14)
    RoleL.Position = UDim2.new(0,0,0,18)
    RoleL.BackgroundTransparency = 1
    RoleL.Font = Enum.Font.Gotham; RoleL.TextSize = 11
    RoleL.TextStrokeTransparency = 0
    RoleL.TextStrokeColor3 = Color3.new(0,0,0)
    RoleL.Name = "RoleL"

    local DistL = Instance.new("TextLabel",BB)
    DistL.Size = UDim2.new(1,0,0,13)
    DistL.Position = UDim2.new(0,0,0,34)
    DistL.BackgroundTransparency = 1
    DistL.Font = Enum.Font.Gotham; DistL.TextSize = 10
    DistL.TextColor3 = Color3.fromRGB(190,190,200)
    DistL.TextStrokeTransparency = 0
    DistL.TextStrokeColor3 = Color3.new(0,0,0)
    DistL.Name = "DistL"

    return BB, NameL, RoleL, DistL
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character; if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart"); if not root then continue end

        if not ESPCache[player.Name] then
            local bb,nl,rl,dl = BuildESP(player)
            ESPCache[player.Name] = {BB=bb,Name=nl,Role=rl,Dist=dl}
        end
        local e = ESPCache[player.Name]; if not e then continue end

        local role  = GetRole(player)
        local color = RoleColors[role]
        local dist  = math.floor((root.Position-Camera.CFrame.Position).Magnitude)

        e.BB.Adornee = root
        e.BB.Enabled = PH.ESP.Enabled
        e.Name.Text       = player.Name
        e.Name.TextColor3 = color
        e.Role.Text       = "["..role.."]"
        e.Role.TextColor3 = color
        e.Dist.Text       = dist.."m"
    end

    for name,e in pairs(ESPCache) do
        if not Players:FindFirstChild(name) then
            if e.BB then e.BB:Destroy() end
            ESPCache[name] = nil
        end
    end
end)

-- AIMBOT
local FOVDraw = Drawing.new("Circle")
FOVDraw.Visible=false; FOVDraw.Color=Color3.fromRGB(124,58,237)
FOVDraw.Thickness=1; FOVDraw.Filled=false; FOVDraw.NumSides=80

local function GetTarget()
    local best,bestD = nil, PH.Aim.FOV
    local center = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
    for _,player in pairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        local char=player.Character; if not char then continue end
        local hum=char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health<=0 then continue end
        local part=char:FindFirstChild("Head"); if not part then continue end
        local sp,vis=Camera:WorldToViewportPoint(part.Position)
        if not vis then continue end
        local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
        if d<bestD then bestD=d; best=part end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
    FOVDraw.Visible=PH.Aim.Enabled
    if PH.Aim.Enabled then
        FOVDraw.Position=center; FOVDraw.Radius=PH.Aim.FOV
        local t=GetTarget()
        if t then
            local sp=Camera:WorldToViewportPoint(t.Position)
            local np=center:Lerp(Vector2.new(sp.X,sp.Y),0.12)
            local ray=Camera:ViewportPointToRay(np.X,np.Y)
            Camera.CFrame=CFrame.new(Camera.CFrame.Position,
                Camera.CFrame.Position+ray.Direction*999)
        end
    end
    if PH.Aim.NoRecoil then
        Camera.CFrame=Camera.CFrame*CFrame.Angles(0.003,0,0)
    end
end)

print("✅ 6/7 — RIGHT PANEL + ESP")
-- ██████████████████████████████████████
-- PULSE HUB | MM2 | CHUNK 7/7
-- MISC + FLY + FARM + FINAL
-- ██████████████████████████████████████

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer      = Players.LocalPlayer
local PH = _G.PH

-- SPEED
RunService.Heartbeat:Connect(function()
    if not PH.Move.Speed then return end
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed=PH.Move.SpeedVal end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if not PH.Move.NoClip then return end
    local char=LocalPlayer.Character; if not char then return end
    for _,p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide=false end
    end
end)

-- INF JUMP
UserInputService.JumpRequest:Connect(function()
    if not PH.Move.InfJump then return end
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- BHOP
RunService.Stepped:Connect(function()
    if not PH.Move.Bhop then return end
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum and hum.FloorMaterial~=Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ANTI FLING
RunService.Heartbeat:Connect(function()
    if not PH.Move.AntiFling then return end
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    root.AssemblyLinearVelocity=Vector3.new(
        math.clamp(root.AssemblyLinearVelocity.X,-80,80),
        root.AssemblyLinearVelocity.Y,
        math.clamp(root.AssemblyLinearVelocity.Z,-80,80)
    )
end)

-- TROLL FLING
RunService.Heartbeat:Connect(function()
    if not PH.Troll.Fling then return end
    for _,player in pairs(Players:GetPlayers()) do
        if player==LocalPlayer then continue end
        local char=player.Character; if not char then continue end
        local root=char:FindFirstChild("HumanoidRootPart"); if not root then continue end
        root.AssemblyLinearVelocity=Vector3.new(
            math.random(-1,1)*PH.Troll.FlingForce,
            PH.Troll.FlingForce,
            math.random(-1,1)*PH.Troll.FlingForce
        )
    end
end)

-- COIN FARM
RunService.Heartbeat:Connect(function()
    if not PH.Farm.Coins then return end
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
    for _,obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("coin") and obj:IsA("BasePart") then
            root.CFrame=CFrame.new(obj.Position)
            task.wait(0.08)
        end
    end
end)

-- FULLBRIGHT
RunService.Heartbeat:Connect(function()
    if not PH.Visual.Fullbright then return end
    local L=game:GetService("Lighting")
    L.Brightness=10; L.ClockTime=14
end)

-- FLY
local FlyConn, FlyBV
function _G.PHStartFly()
    local char=LocalPlayer.Character; if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    hum.PlatformStand=true
    FlyBV=Instance.new("BodyVelocity",root)
    FlyBV.Name="PHFly"; FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
    FlyConn=RunService.RenderStepped:Connect(function()
        if not PH.Move.Fly then _G.PHStopFly() return end
        local cam=workspace.CurrentCamera
        local dir=Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir=dir+cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir=dir-cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir=dir-cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir=dir+cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
        FlyBV.Velocity=dir*PH.Move.FlySpeed
    end)
end

function _G.PHStopFly()
    if FlyConn then FlyConn:Disconnect(); FlyConn=nil end
    if FlyBV   then FlyBV:Destroy();      FlyBV=nil   end
    local char=LocalPlayer.Character; if not char then return end
    local hum=char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand=false end
end

print("✅ 7/7 — MISC + FLY + FARM")
print("🟣 PULSE HUB MM2 — FULLY LOADED")
print("📌 Кнопка ⚡ Pulse Hub — перетаскивается")
