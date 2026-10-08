if game.CoreGui:FindFirstChild("PulseHub") then
game.CoreGui.PulseHub:Destroy()
end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
shared.PH={
ESP={
Sheriff=true,
Murderer=true,
Innocent=true,
HP=true,
Distance=true,
Name=true,
Coins=false,
Gun=false,
Chams=false,
FOVCircle=false,
},
}
shared.TS=TweenService
shared.UIS=UserInputService
shared.RS=RunService
shared.LP=LocalPlayer
shared.Players=Players
local GUI=Instance.new("ScreenGui")
GUI.Name="PulseHub"
GUI.ResetOnSpawn=false
GUI.IgnoreGuiInset=true
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.Parent=game.CoreGui
shared.GUI=GUI
local OpenBtn=Instance.new("TextButton",GUI)
OpenBtn.Size=UDim2.new(0,105,0,30)
OpenBtn.Position=UDim2.new(0.5,-52,0,10)
OpenBtn.BackgroundColor3=Color3.fromRGB(28,28,40)
OpenBtn.Text="⚡  PULSE HUB"
OpenBtn.TextColor3=Color3.fromRGB(167,139,250)
OpenBtn.Font=Enum.Font.GothamBold
OpenBtn.TextSize=12
OpenBtn.BorderSizePixel=0
OpenBtn.ZIndex=200
OpenBtn.Active=true
OpenBtn.Draggable=true
Instance.new("UICorner",OpenBtn).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",OpenBtn).Color=Color3.fromRGB(80,50,180)
local Win=Instance.new("Frame",GUI)
Win.Size=UDim2.new(0,780,0,500)
Win.Position=UDim2.new(0.5,-390,0.5,-250)
Win.BackgroundColor3=Color3.fromRGB(20,20,28)
Win.BorderSizePixel=0
Win.Visible=true
Win.ZIndex=10
Win.Active=true
Win.Draggable=true
Instance.new("UICorner",Win).CornerRadius=UDim.new(0,12)
Instance.new("UIStroke",Win).Color=Color3.fromRGB(40,40,58)
shared.Win=Win
local TBar=Instance.new("Frame",Win)
TBar.Size=UDim2.new(1,0,0,44)
TBar.BackgroundColor3=Color3.fromRGB(14,14,22)
TBar.BorderSizePixel=0
TBar.ZIndex=11
Instance.new("UICorner",TBar).CornerRadius=UDim.new(0,12)
local TFix=Instance.new("Frame",TBar)
TFix.Size=UDim2.new(1,0,0.5,0)
TFix.Position=UDim2.new(0,0,0.5,0)
TFix.BackgroundColor3=Color3.fromRGB(14,14,22)
TFix.BorderSizePixel=0
TFix.ZIndex=11
local Logo=Instance.new("Frame",TBar)
Logo.Size=UDim2.new(0,28,0,28)
Logo.Position=UDim2.new(0,12,0.5,-14)
Logo.BackgroundColor3=Color3.fromRGB(124,58,237)
Logo.BorderSizePixel=0
Logo.ZIndex=12
Instance.new("UICorner",Logo).CornerRadius=UDim.new(0,7)
local LogoT=Instance.new("TextLabel",Logo)
LogoT.Size=UDim2.new(1,0,1,0)
LogoT.BackgroundTransparency=1
LogoT.Text="P"
LogoT.TextColor3=Color3.fromRGB(255,255,255)
LogoT.Font=Enum.Font.GothamBold
LogoT.TextSize=16
LogoT.ZIndex=13
local TitleL=Instance.new("TextLabel",TBar)
TitleL.Size=UDim2.new(0,90,0,18)
TitleL.Position=UDim2.new(0,48,0,5)
TitleL.BackgroundTransparency=1
TitleL.Text="Pulse Hub"
TitleL.TextColor3=Color3.fromRGB(255,255,255)
TitleL.Font=Enum.Font.GothamBold
TitleL.TextSize=14
TitleL.TextXAlignment=Enum.TextXAlignment.Left
TitleL.ZIndex=12
local SubL=Instance.new("TextLabel",TBar)
SubL.Size=UDim2.new(0,140,0,14)
SubL.Position=UDim2.new(0,48,0,24)
SubL.BackgroundTransparency=1
SubL.Text="Murder Mystery 2"
SubL.TextColor3=Color3.fromRGB(80,80,100)
SubL.Font=Enum.Font.Gotham
SubL.TextSize=10
SubL.TextXAlignment=Enum.TextXAlignment.Left
SubL.ZIndex=12
local TabESP=Instance.new("TextButton",TBar)
TabESP.Size=UDim2.new(0,60,0,26)
TabESP.Position=UDim2.new(0.5,-30,0.5,-13)
TabESP.BackgroundColor3=Color3.fromRGB(124,58,237)
TabESP.Text="ESP"
TabESP.TextColor3=Color3.fromRGB(255,255,255)
TabESP.Font=Enum.Font.GothamSemibold
TabESP.TextSize=12
TabESP.BorderSizePixel=0
TabESP.ZIndex=12
Instance.new("UICorner",TabESP).CornerRadius=UDim.new(0,7)
local SearchBox=Instance.new("TextBox",TBar)
SearchBox.Size=UDim2.new(0,140,0,26)
SearchBox.Position=UDim2.new(1,-228,0.5,-13)
SearchBox.BackgroundColor3=Color3.fromRGB(28,28,40)
SearchBox.PlaceholderText="🔍 Поиск..."
SearchBox.PlaceholderColor3=Color3.fromRGB(70,70,90)
SearchBox.Text=""
SearchBox.TextColor3=Color3.fromRGB(200,200,210)
SearchBox.Font=Enum.Font.Gotham
SearchBox.TextSize=12
SearchBox.BorderSizePixel=0
SearchBox.ZIndex=12
SearchBox.ClearTextOnFocus=false
Instance.new("UICorner",SearchBox).CornerRadius=UDim.new(0,7)
Instance.new("UIStroke",SearchBox).Color=Color3.fromRGB(40,40,58)
local CloseBtn=Instance.new("TextButton",TBar)
CloseBtn.Size=UDim2.new(0,22,0,22)
CloseBtn.Position=UDim2.new(1,-30,0.5,-11)
CloseBtn.BackgroundColor3=Color3.fromRGB(74,21,32)
CloseBtn.Text="✕"
CloseBtn.TextColor3=Color3.fromRGB(248,113,113)
CloseBtn.Font=Enum.Font.GothamBold
CloseBtn.TextSize=10
CloseBtn.BorderSizePixel=0
CloseBtn.ZIndex=12
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,5)
CloseBtn.MouseButton1Click:Connect(function() Win.Visible=false end)
local MinBtn=Instance.new("TextButton",TBar)
MinBtn.Size=UDim2.new(0,22,0,22)
MinBtn.Position=UDim2.new(1,-56,0.5,-11)
MinBtn.BackgroundColor3=Color3.fromRGB(35,35,50)
MinBtn.Text="—"
MinBtn.TextColor3=Color3.fromRGB(120,120,140)
MinBtn.Font=Enum.Font.GothamBold
MinBtn.TextSize=10
MinBtn.BorderSizePixel=0
MinBtn.ZIndex=12
Instance.new("UICorner",MinBtn).CornerRadius=UDim.new(0,5)
local mini=false
MinBtn.MouseButton1Click:Connect(function()
mini=not mini
Win.Size=mini and UDim2.new(0,780,0,44) or UDim2.new(0,780,0,500)
end)
OpenBtn.MouseButton1Click:Connect(function()
Win.Visible=not Win.Visible
end)
local TDiv=Instance.new("Frame",Win)
TDiv.Size=UDim2.new(1,0,0,1)
TDiv.Position=UDim2.new(0,0,0,44)
TDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
TDiv.BorderSizePixel=0
TDiv.ZIndex=11
print("✅ 1/4")
local Win=shared.Win
local TS=shared.TS
local UIS=shared.UIS
local RS=shared.RS
-- ЛЕВАЯ ПАНЕЛЬ (монеты, пистолет)
local LeftPanel=Instance.new("Frame",Win)
LeftPanel.Size=UDim2.new(0,200,1,-45)
LeftPanel.Position=UDim2.new(0,0,0,45)
LeftPanel.BackgroundColor3=Color3.fromRGB(14,14,22)
LeftPanel.BorderSizePixel=0
LeftPanel.ZIndex=11
local LD=Instance.new("Frame",Win)
LD.Size=UDim2.new(0,1,1,-45)
LD.Position=UDim2.new(0,200,0,45)
LD.BackgroundColor3=Color3.fromRGB(32,32,46)
LD.BorderSizePixel=0
LD.ZIndex=11
local LHdr=Instance.new("Frame",LeftPanel)
LHdr.Size=UDim2.new(1,0,0,32)
LHdr.BackgroundTransparency=1
LHdr.ZIndex=12
local LHdrL=Instance.new("TextLabel",LHdr)
LHdrL.Size=UDim2.new(1,-16,1,0)
LHdrL.Position=UDim2.new(0,14,0,0)
LHdrL.BackgroundTransparency=1
LHdrL.Text="| Метки"
LHdrL.TextColor3=Color3.fromRGB(224,224,232)
LHdrL.Font=Enum.Font.GothamBold
LHdrL.TextSize=13
LHdrL.TextXAlignment=Enum.TextXAlignment.Left
LHdrL.ZIndex=13
local LHDiv=Instance.new("Frame",LeftPanel)
LHDiv.Size=UDim2.new(1,0,0,1)
LHDiv.Position=UDim2.new(0,0,0,32)
LHDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
LHDiv.BorderSizePixel=0
LHDiv.ZIndex=12
local LScroll=Instance.new("ScrollingFrame",LeftPanel)
LScroll.Size=UDim2.new(1,0,1,-33)
LScroll.Position=UDim2.new(0,0,0,33)
LScroll.BackgroundTransparency=1
LScroll.BorderSizePixel=0
LScroll.ScrollBarThickness=2
LScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,80)
LScroll.ZIndex=12
LScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local LL=Instance.new("UIListLayout",LScroll)
LL.SortOrder=Enum.SortOrder.LayoutOrder
LL.Padding=UDim.new(0,0)
shared.LScroll=LScroll
-- СРЕДНЯЯ ПАНЕЛЬ (роли ESP)
local MidPanel=Instance.new("Frame",Win)
MidPanel.Size=UDim2.new(0,230,1,-45)
MidPanel.Position=UDim2.new(0,201,0,45)
MidPanel.BackgroundColor3=Color3.fromRGB(20,20,28)
MidPanel.BorderSizePixel=0
MidPanel.ZIndex=11
local MD=Instance.new("Frame",Win)
MD.Size=UDim2.new(0,1,1,-45)
MD.Position=UDim2.new(0,431,0,45)
MD.BackgroundColor3=Color3.fromRGB(32,32,46)
MD.BorderSizePixel=0
MD.ZIndex=11
local MHdr=Instance.new("Frame",MidPanel)
MHdr.Size=UDim2.new(1,0,0,32)
MHdr.BackgroundTransparency=1
MHdr.ZIndex=12
local MHdrL=Instance.new("TextLabel",MHdr)
MHdrL.Size=UDim2.new(1,-16,1,0)
MHdrL.Position=UDim2.new(0,14,0,0)
MHdrL.BackgroundTransparency=1
MHdrL.Text="| ESP Роли"
MHdrL.TextColor3=Color3.fromRGB(224,224,232)
MHdrL.Font=Enum.Font.GothamBold
MHdrL.TextSize=13
MHdrL.TextXAlignment=Enum.TextXAlignment.Left
MHdrL.ZIndex=13
local MHDiv=Instance.new("Frame",MidPanel)
MHDiv.Size=UDim2.new(1,0,0,1)
MHDiv.Position=UDim2.new(0,0,0,32)
MHDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
MHDiv.BorderSizePixel=0
MHDiv.ZIndex=12
local MScroll=Instance.new("ScrollingFrame",MidPanel)
MScroll.Size=UDim2.new(1,0,1,-33)
MScroll.Position=UDim2.new(0,0,0,33)
MScroll.BackgroundTransparency=1
MScroll.BorderSizePixel=0
MScroll.ScrollBarThickness=2
MScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,80)
MScroll.ZIndex=12
MScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local ML=Instance.new("UIListLayout",MScroll)
ML.SortOrder=Enum.SortOrder.LayoutOrder
ML.Padding=UDim.new(0,0)
shared.MScroll=MScroll
-- ПРАВАЯ ПАНЕЛЬ (доп функции)
local RightPanel=Instance.new("Frame",Win)
RightPanel.Size=UDim2.new(1,-432,1,-45)
RightPanel.Position=UDim2.new(0,432,0,45)
RightPanel.BackgroundColor3=Color3.fromRGB(14,14,22)
RightPanel.BorderSizePixel=0
RightPanel.ZIndex=11
local RHdr=Instance.new("Frame",RightPanel)
RHdr.Size=UDim2.new(1,0,0,32)
RHdr.BackgroundTransparency=1
RHdr.ZIndex=12
local RHdrL=Instance.new("TextLabel",RHdr)
RHdrL.Size=UDim2.new(1,-16,1,0)
RHdrL.Position=UDim2.new(0,14,0,0)
RHdrL.BackgroundTransparency=1
RHdrL.Text="| ESP Настройки"
RHdrL.TextColor3=Color3.fromRGB(224,224,232)
RHdrL.Font=Enum.Font.GothamBold
RHdrL.TextSize=13
RHdrL.TextXAlignment=Enum.TextXAlignment.Left
RHdrL.ZIndex=13
local RHDiv=Instance.new("Frame",RightPanel)
RHDiv.Size=UDim2.new(1,0,0,1)
RHDiv.Position=UDim2.new(0,0,0,32)
RHDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
RHDiv.BorderSizePixel=0
RHDiv.ZIndex=12
local RScroll=Instance.new("ScrollingFrame",RightPanel)
RScroll.Size=UDim2.new(1,0,1,-33)
RScroll.Position=UDim2.new(0,0,0,33)
RScroll.BackgroundTransparency=1
RScroll.BorderSizePixel=0
RScroll.ScrollBarThickness=2
RScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,80)
RScroll.ZIndex=12
RScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local RL=Instance.new("UIListLayout",RScroll)
RL.SortOrder=Enum.SortOrder.LayoutOrder
RL.Padding=UDim.new(0,0)
shared.RScroll=RScroll
-- TOGGLE BUILDER
function shared.Toggle(parent,label,dotColor,cfgT,cfgK,cb)
local Row=Instance.new("Frame",parent)
Row.Size=UDim2.new(1,0,0,36)
Row.BackgroundColor3=Color3.fromRGB(20,20,28)
Row.BorderSizePixel=0
Row.ZIndex=14
local Div=Instance.new("Frame",Row)
Div.Size=UDim2.new(1,0,0,1)
Div.Position=UDim2.new(0,0,1,-1)
Div.BackgroundColor3=Color3.fromRGB(28,28,40)
Div.BorderSizePixel=0
Div.ZIndex=15
if dotColor then
local Dot=Instance.new("Frame",Row)
Dot.Size=UDim2.new(0,8,0,8)
Dot.Position=UDim2.new(0,10,0.5,-4)
Dot.BackgroundColor3=dotColor
Dot.BorderSizePixel=0
Dot.ZIndex=15
Instance.new("UICorner",Dot).CornerRadius=UDim.new(1,0)
end
local Lbl=Instance.new("TextLabel",Row)
Lbl.Size=UDim2.new(1,-72,1,0)
Lbl.Position=UDim2.new(0,dotColor and 24 or 12,0,0)
Lbl.BackgroundTransparency=1
Lbl.Text=label
Lbl.TextColor3=Color3.fromRGB(200,200,212)
Lbl.Font=Enum.Font.Gotham
Lbl.TextSize=12
Lbl.TextXAlignment=Enum.TextXAlignment.Left
Lbl.ZIndex=15
local on0=cfgT and cfgT[cfgK] or false
local Track=Instance.new("Frame",Row)
Track.Size=UDim2.new(0,36,0,18)
Track.Position=UDim2.new(1,-44,0.5,-9)
Track.BackgroundColor3=on0 and Color3.fromRGB(124,58,237) or Color3.fromRGB(40,40,56)
Track.BorderSizePixel=0
Track.ZIndex=15
Instance.new("UICorner",Track).CornerRadius=UDim.new(1,0)
local Knob=Instance.new("Frame",Track)
Knob.Size=UDim2.new(0,12,0,12)
Knob.Position=on0 and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6)
Knob.BackgroundColor3=on0 and Color3.fromRGB(255,255,255) or Color3.fromRGB(100,100,120)
Knob.BorderSizePixel=0
Knob.ZIndex=16
Instance.new("UICorner",Knob).CornerRadius=UDim.new(1,0)
local TB=Instance.new("TextButton",Row)
TB.Size=UDim2.new(1,0,1,0)
TB.BackgroundTransparency=1
TB.Text=""
TB.ZIndex=17
TB.MouseButton1Click:Connect(function()
if cfgT then cfgT[cfgK]=not cfgT[cfgK] end
local on=cfgT and cfgT[cfgK] or false
TS:Create(Track,TweenInfo.new(0.15),{BackgroundColor3=on and Color3.fromRGB(124,58,237) or Color3.fromRGB(40,40,56)}):Play()
TS:Create(Knob,TweenInfo.new(0.15),{Position=on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,3,0.5,-6),BackgroundColor3=on and Color3.fromRGB(255,255,255) or Color3.fromRGB(100,100,120)}):Play()
if cb then cb(on) end
end)
end
-- SECTION BUILDER
function shared.Section(parent,text)
local F=Instance.new("Frame",parent)
F.Size=UDim2.new(1,0,0,26)
F.BackgroundTransparency=1
F.ZIndex=14
local Pipe=Instance.new("TextLabel",F)
Pipe.Size=UDim2.new(0,10,1,0)
Pipe.BackgroundTransparency=1
Pipe.Text="|"
Pipe.TextColor3=Color3.fromRGB(124,58,237)
Pipe.Font=Enum.Font.GothamBold
Pipe.TextSize=13
Pipe.ZIndex=15
local L=Instance.new("TextLabel",F)
L.Size=UDim2.new(1,-20,1,0)
L.Position=UDim2.new(0,14,0,0)
L.BackgroundTransparency=1
L.Text=text
L.TextColor3=Color3.fromRGB(80,80,100)
L.Font=Enum.Font.GothamBold
L.TextSize=10
L.TextXAlignment=Enum.TextXAlignment.Left
L.ZIndex=15
end
print("✅ 2/4")
local PH=shared.PH
local T=shared.Toggle
local S=shared.Section
local L=shared.LScroll
local M=shared.MScroll
local R=shared.RScroll
-- ════════════
-- ЛЕВАЯ — метки
-- ════════════
S(L,"Предметы")
T(L,"ESP Монет",Color3.fromRGB(255,215,0),PH.ESP,"Coins")
T(L,"ESP Пистолет Шерифа",Color3.fromRGB(96,165,250),PH.ESP,"Gun")
-- ════════════
-- СРЕДНЯЯ — роли
-- ════════════
S(M,"Роли игроков")
T(M,"ESP Шерифа",Color3.fromRGB(96,165,250),PH.ESP,"Sheriff")
T(M,"ESP Убийцы",Color3.fromRGB(239,68,68),PH.ESP,"Murderer")
T(M,"ESP Невинного",Color3.fromRGB(74,222,128),PH.ESP,"Innocent")
S(M,"Информация")
T(M,"ESP HP",nil,PH.ESP,"HP")
T(M,"ESP Дистанция",nil,PH.ESP,"Distance")
T(M,"ESP Ник",nil,PH.ESP,"Name")
-- ════════════
-- ПРАВАЯ — доп функции
-- ════════════
S(R,"Визуал")
T(R,"Чамсы игроков",nil,PH.ESP,"Chams")
T(R,"FOV Круг",nil,PH.ESP,"FOVCircle")
print("✅ 3/4")
local Players=shared.Players
local RunService=shared.RS
local LP=shared.LP
local Camera=workspace.CurrentCamera
local PH=shared.PH
local ESPFolder=Instance.new("Folder",game.CoreGui)
ESPFolder.Name="PHubESP"
local ESPCache={}
local RoleColors={
Murderer=Color3.fromRGB(239,68,68),
Sheriff=Color3.fromRGB(96,165,250),
Innocent=Color3.fromRGB(74,222,128),
}
local RoleEnabled={
Murderer=function() return PH.ESP.Murderer end,
Sheriff=function() return PH.ESP.Sheriff end,
Innocent=function() return PH.ESP.Innocent end,
}
local function GetRole(player)
local char=player.Character
if not char then return "Innocent" end
for _,v in pairs(char:GetChildren()) do
if v:IsA("Tool") then
local n=v.Name:lower()
if n:find("knife") then return "Murderer" end
if n:find("gun") or n:find("sheriff") then return "Sheriff" end
end
end
return "Innocent"
end
local function GetHP(player)
local char=player.Character
if not char then return 100,100 end
local hum=char:FindFirstChildOfClass("Humanoid")
if not hum then return 100,100 end
return hum.Health,hum.MaxHealth
end
local function BuildESP(player)
local BB=Instance.new("BillboardGui")
BB.Name=player.Name.."_ESP"
BB.AlwaysOnTop=true
BB.Size=UDim2.new(0,200,0,70)
BB.StudsOffset=Vector3.new(0,4,0)
BB.Parent=ESPFolder
-- НИК
local NameL=Instance.new("TextLabel",BB)
NameL.Size=UDim2.new(1,0,0,18)
NameL.Position=UDim2.new(0,0,0,0)
NameL.BackgroundTransparency=1
NameL.Font=Enum.Font.GothamBold
NameL.TextSize=13
NameL.TextStrokeTransparency=0
NameL.TextStrokeColor3=Color3.new(0,0,0)
NameL.Name="NameL"
-- HP BG
local HBG=Instance.new("Frame",BB)
HBG.Size=UDim2.new(0,100,0,5)
HBG.Position=UDim2.new(0.5,-50,0,20)
HBG.BackgroundColor3=Color3.fromRGB(40,40,40)
HBG.BorderSizePixel=0
HBG.Name="HBG"
Instance.new("UICorner",HBG).CornerRadius=UDim.new(1,0)
-- HP FILL
local HFill=Instance.new("Frame",HBG)
HFill.Size=UDim2.new(1,0,1,0)
HFill.BackgroundColor3=Color3.fromRGB(74,222,128)
HFill.BorderSizePixel=0
HFill.Name="HFill"
Instance.new("UICorner",HFill).CornerRadius=UDim.new(1,0)
-- HP TEXT
local HPL=Instance.new("TextLabel",BB)
HPL.Size=UDim2.new(1,0,0,13)
HPL.Position=UDim2.new(0,0,0,27)
HPL.BackgroundTransparency=1
HPL.Font=Enum.Font.Gotham
HPL.TextSize=10
HPL.TextColor3=Color3.fromRGB(200,200,200)
HPL.TextStrokeTransparency=0
HPL.TextStrokeColor3=Color3.new(0,0,0)
HPL.Name="HPL"
-- ДИСТАНЦИЯ
local DistL=Instance.new("TextLabel",BB)
DistL.Size=UDim2.new(1,0,0,13)
DistL.Position=UDim2.new(0,0,0,42)
DistL.BackgroundTransparency=1
DistL.Font=Enum.Font.Gotham
DistL.TextSize=10
DistL.TextColor3=Color3.fromRGB(190,190,200)
DistL.TextStrokeTransparency=0
DistL.TextStrokeColor3=Color3.new(0,0,0)
DistL.Name="DistL"
return BB,NameL,HBG,HFill,HPL,DistL
end
-- COINS ESP
local CoinCache={}
local function BuildCoinESP(part)
local BB=Instance.new("BillboardGui")
BB.AlwaysOnTop=true
BB.Size=UDim2.new(0,60,0,20)
BB.StudsOffset=Vector3.new(0,2,0)
BB.Adornee=part
BB.Parent=ESPFolder
local L=Instance.new("TextLabel",BB)
L.Size=UDim2.new(1,0,1,0)
L.BackgroundTransparency=1
L.Text="💰"
L.TextSize=14
L.ZIndex=2
return BB
end
-- PISTOL ESP
local GunCache={}
local function BuildGunESP(part)
local BB=Instance.new("BillboardGui")
BB.AlwaysOnTop=true
BB.Size=UDim2.new(0,80,0,20)
BB.StudsOffset=Vector3.new(0,2,0)
BB.Adornee=part
BB.Parent=ESPFolder
local L=Instance.new("TextLabel",BB)
L.Size=UDim2.new(1,0,1,0)
L.BackgroundTransparency=1
L.Text="🔫 Пистолет"
L.TextColor3=Color3.fromRGB(96,165,250)
L.Font=Enum.Font.GothamBold
L.TextSize=11
L.TextStrokeTransparency=0
L.TextStrokeColor3=Color3.new(0,0,0)
L.ZIndex=2
return BB
end
RunService.RenderStepped:Connect(function()
-- PLAYER ESP
for _,player in pairs(Players:GetPlayers()) do
if player==LP then continue end
local char=player.Character
if not char then continue end
local root=char:FindFirstChild("HumanoidRootPart")
if not root then continue end
if not ESPCache[player.Name] then
local bb,nl,hbg,hf,hpl,dl=BuildESP(player)
ESPCache[player.Name]={BB=bb,Name=nl,HBG=hbg,HFill=hf,HPL=hpl,Dist=dl}
end
local e=ESPCache[player.Name]
if not e then continue end
local role=GetRole(player)
local color=RoleColors[role]
local enabled=RoleEnabled[role]()
local hp,maxhp=GetHP(player)
local hpR=math.clamp(hp/maxhp,0,1)
local dist=math.floor((root.Position-Camera.CFrame.Position).Magnitude)
e.BB.Adornee=root
e.BB.Enabled=enabled
e.Name.Text=PH.ESP.Name and player.Name or ""
e.Name.TextColor3=color
e.HBG.Visible=PH.ESP.HP
e.HFill.Size=UDim2.new(hpR,0,1,0)
e.HFill.BackgroundColor3=Color3.fromRGB(math.floor((1-hpR)*239),math.floor(hpR*222),math.floor(hpR*128))
e.HPL.Text=PH.ESP.HP and math.floor(hp).."/"..math.floor(maxhp) or ""
e.HPL.TextColor3=color
e.Dist.Text=PH.ESP.Distance and dist.."m" or ""
e.Dist.TextColor3=color
end
-- CLEANUP PLAYERS
for name,e in pairs(ESPCache) do
if not Players:FindFirstChild(name) then
if e.BB then e.BB:Destroy() end
ESPCache[name]=nil
end
end
-- COIN ESP
for _,obj in pairs(workspace:GetDescendants()) do
local n=obj.Name:lower()
if n:find("coin") and obj:IsA("BasePart") then
if not CoinCache[obj] then
CoinCache[obj]=BuildCoinESP(obj)
end
if CoinCache[obj] then
CoinCache[obj].Enabled=PH.ESP.Coins
end
end
end
-- GUN ESP
for _,obj in pairs(workspace:GetDescendants()) do
local n=obj.Name:lower()
if (n:find("gun") or n:find("revolver")) and obj:IsA("BasePart") then
if not GunCache[obj] then
GunCache[obj]=BuildGunESP(obj)
end
if GunCache[obj] then
GunCache[obj].Enabled=PH.ESP.Gun
end
end
end
end)
print("✅ 4/4")
print("🟣 PULSE HUB ESP — ГОТОВ")
