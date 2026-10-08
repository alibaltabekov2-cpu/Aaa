if game.CoreGui:FindFirstChild("PulseHub") then
    game.CoreGui.PulseHub:Destroy()
end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
shared.PH={
    ESP={Enabled=true,Gun=false,Tracers=false,All=false,Coins=false,Knife=true,Pistol=true},
    Aim={Enabled=false,Silent=false,FOV=180,NoRecoil=false},
    Move={NoClip=false,InfJump=false,AntiFling=false,Fly=false,FlySpeed=90,Speed=false,SpeedVal=28,Bhop=false},
    Farm={Coins=false,AutoWin=false},
    Visual={Crosshair=false,Fullbright=false},
    Troll={Fling=false,FlingForce=80},
}
shared.TS=TweenService
shared.UIS=UserInputService
shared.RS=RunService
shared.LP=LocalPlayer
local GUI=Instance.new("ScreenGui")
GUI.Name="PulseHub"
GUI.ResetOnSpawn=false
GUI.IgnoreGuiInset=true
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.Parent=game.CoreGui
shared.GUI=GUI
print("✅ 1/8 INIT")
local TweenService=shared.TS
local GUI=shared.GUI
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
shared.OpenBtn=OpenBtn
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
local TBarFix=Instance.new("Frame",TBar)
TBarFix.Size=UDim2.new(1,0,0.5,0)
TBarFix.Position=UDim2.new(0,0,0.5,0)
TBarFix.BackgroundColor3=Color3.fromRGB(14,14,22)
TBarFix.BorderSizePixel=0
TBarFix.ZIndex=11
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
local TabG=Instance.new("TextButton",TBar)
TabG.Size=UDim2.new(0,70,0,26)
TabG.Position=UDim2.new(0.5,-76,0.5,-13)
TabG.BackgroundColor3=Color3.fromRGB(124,58,237)
TabG.Text="Общее"
TabG.TextColor3=Color3.fromRGB(255,255,255)
TabG.Font=Enum.Font.GothamSemibold
TabG.TextSize=12
TabG.BorderSizePixel=0
TabG.ZIndex=12
Instance.new("UICorner",TabG).CornerRadius=UDim.new(0,7)
local TabUI=Instance.new("TextButton",TBar)
TabUI.Size=UDim2.new(0,46,0,26)
TabUI.Position=UDim2.new(0.5,2,0.5,-13)
TabUI.BackgroundColor3=Color3.fromRGB(28,28,40)
TabUI.Text="UI"
TabUI.TextColor3=Color3.fromRGB(130,130,150)
TabUI.Font=Enum.Font.GothamSemibold
TabUI.TextSize=12
TabUI.BorderSizePixel=0
TabUI.ZIndex=12
Instance.new("UICorner",TabUI).CornerRadius=UDim.new(0,7)
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
shared.SearchBox=SearchBox
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
print("✅ 2/8 WINDOW+TITLEBAR")
local Win=shared.Win
local GUI=shared.GUI
local IconNav=Instance.new("Frame",Win)
IconNav.Size=UDim2.new(0,58,1,-45)
IconNav.Position=UDim2.new(0,0,0,45)
IconNav.BackgroundColor3=Color3.fromRGB(14,14,22)
IconNav.BorderSizePixel=0
IconNav.ZIndex=11
local IList=Instance.new("UIListLayout",IconNav)
IList.SortOrder=Enum.SortOrder.LayoutOrder
IList.Padding=UDim.new(0,2)
IList.HorizontalAlignment=Enum.HorizontalAlignment.Center
local IPad=Instance.new("UIPadding",IconNav)
IPad.PaddingTop=UDim.new(0,8)
Instance.new("Frame",Win).Size=UDim2.new(0,1,1,-45)
local D1=Win:FindFirstChildOfClass("Frame")
for _,f in pairs(Win:GetChildren()) do
if f:IsA("Frame") and f.Size==UDim2.new(0,1,1,-45) then
f.Position=UDim2.new(0,58,0,45)
f.BackgroundColor3=Color3.fromRGB(32,32,46)
f.BorderSizePixel=0
f.ZIndex=11
break
end
end
local MidFrame=Instance.new("Frame",Win)
MidFrame.Size=UDim2.new(0,255,1,-45)
MidFrame.Position=UDim2.new(0,59,0,45)
MidFrame.BackgroundColor3=Color3.fromRGB(20,20,28)
MidFrame.BorderSizePixel=0
MidFrame.ZIndex=11
shared.MidFrame=MidFrame
local D2=Instance.new("Frame",Win)
D2.Size=UDim2.new(0,1,1,-45)
D2.Position=UDim2.new(0,314,0,45)
D2.BackgroundColor3=Color3.fromRGB(32,32,46)
D2.BorderSizePixel=0
D2.ZIndex=11
local RightFrame=Instance.new("Frame",Win)
RightFrame.Size=UDim2.new(1,-315,1,-45)
RightFrame.Position=UDim2.new(0,315,0,45)
RightFrame.BackgroundColor3=Color3.fromRGB(20,20,28)
RightFrame.BorderSizePixel=0
RightFrame.ZIndex=11
local RHdr=Instance.new("Frame",RightFrame)
RHdr.Size=UDim2.new(1,0,0,32)
RHdr.BackgroundTransparency=1
RHdr.ZIndex=12
local RHdrL=Instance.new("TextLabel",RHdr)
RHdrL.Size=UDim2.new(1,-16,1,0)
RHdrL.Position=UDim2.new(0,14,0,0)
RHdrL.BackgroundTransparency=1
RHdrL.Text="Передвижение"
RHdrL.TextColor3=Color3.fromRGB(224,224,232)
RHdrL.Font=Enum.Font.GothamBold
RHdrL.TextSize=13
RHdrL.TextXAlignment=Enum.TextXAlignment.Left
RHdrL.ZIndex=13
local RHDiv=Instance.new("Frame",RightFrame)
RHDiv.Size=UDim2.new(1,0,0,1)
RHDiv.Position=UDim2.new(0,0,0,32)
RHDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
RHDiv.BorderSizePixel=0
RHDiv.ZIndex=12
local RScroll=Instance.new("ScrollingFrame",RightFrame)
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
shared.Pages={}
shared.NavBtns={}
local NavDefs={
{ID="main",Icon="⊞",Label="Главная"},
{ID="combat",Icon="⚔",Label="Combat"},
{ID="farm",Icon="💰",Label="Автофарм"},
{ID="tele",Icon="⚡",Label="Телепорт"},
{ID="troll",Icon="😈",Label="Troll Fun"},
{ID="anim",Icon="🎭",Label="Free anims"},
{ID="fly",Icon="🪂",Label="Флинг"},
{ID="visual",Icon="✨",Label="Визуал"},
{ID="settings",Icon="⚙",Label="Настройки"},
{ID="server",Icon="🌐",Label="Сервер"},
}
for i,def in ipairs(NavDefs) do
local IBtn=Instance.new("TextButton",IconNav)
IBtn.Size=UDim2.new(0,44,0,44)
IBtn.BackgroundColor3=Color3.fromRGB(14,14,22)
IBtn.BorderSizePixel=0
IBtn.Text=""
IBtn.LayoutOrder=i
IBtn.ZIndex=12
Instance.new("UICorner",IBtn).CornerRadius=UDim.new(0,9)
local Acc=Instance.new("Frame",IBtn)
Acc.Size=UDim2.new(0,3,0.6,0)
Acc.Position=UDim2.new(0,0,0.2,0)
Acc.BackgroundColor3=Color3.fromRGB(124,58,237)
Acc.BorderSizePixel=0
Acc.Visible=false
Acc.ZIndex=13
Instance.new("UICorner",Acc).CornerRadius=UDim.new(1,0)
local IIco=Instance.new("TextLabel",IBtn)
IIco.Size=UDim2.new(1,0,0,20)
IIco.Position=UDim2.new(0,0,0,6)
IIco.BackgroundTransparency=1
IIco.Text=def.Icon
IIco.TextColor3=Color3.fromRGB(80,80,100)
IIco.Font=Enum.Font.Gotham
IIco.TextSize=16
IIco.ZIndex=13
local ILbl=Instance.new("TextLabel",IBtn)
ILbl.Size=UDim2.new(1,0,0,12)
ILbl.Position=UDim2.new(0,0,0,26)
ILbl.BackgroundTransparency=1
ILbl.Text=def.Label
ILbl.TextColor3=Color3.fromRGB(80,80,100)
ILbl.Font=Enum.Font.Gotham
ILbl.TextSize=8
ILbl.ZIndex=13
local Page=Instance.new("Frame",MidFrame)
Page.Size=UDim2.new(1,0,1,0)
Page.BackgroundTransparency=1
Page.BorderSizePixel=0
Page.Visible=(def.ID=="main")
Page.ZIndex=12
local PHdr=Instance.new("Frame",Page)
PHdr.Size=UDim2.new(1,0,0,32)
PHdr.BackgroundTransparency=1
PHdr.ZIndex=13
local PHdrL=Instance.new("TextLabel",PHdr)
PHdrL.Size=UDim2.new(1,-16,1,0)
PHdrL.Position=UDim2.new(0,12,0,0)
PHdrL.BackgroundTransparency=1
PHdrL.Text="| "..def.Label
PHdrL.TextColor3=Color3.fromRGB(224,224,232)
PHdrL.Font=Enum.Font.GothamBold
PHdrL.TextSize=13
PHdrL.TextXAlignment=Enum.TextXAlignment.Left
PHdrL.ZIndex=14
local PHDiv=Instance.new("Frame",Page)
PHDiv.Size=UDim2.new(1,0,0,1)
PHDiv.Position=UDim2.new(0,0,0,32)
PHDiv.BackgroundColor3=Color3.fromRGB(32,32,46)
PHDiv.BorderSizePixel=0
PHDiv.ZIndex=13
local PScroll=Instance.new("ScrollingFrame",Page)
PScroll.Size=UDim2.new(1,0,1,-33)
PScroll.Position=UDim2.new(0,0,0,33)
PScroll.BackgroundTransparency=1
PScroll.BorderSizePixel=0
PScroll.ScrollBarThickness=2
PScroll.ScrollBarImageColor3=Color3.fromRGB(60,60,80)
PScroll.ZIndex=13
PScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local PL=Instance.new("UIListLayout",PScroll)
PL.SortOrder=Enum.SortOrder.LayoutOrder
PL.Padding=UDim.new(0,0)
shared.Pages[def.ID]=PScroll
shared.NavBtns[def.ID]={Btn=IBtn,Acc=Acc,Ico=IIco,Lbl=ILbl}
if def.ID=="main" then
IBtn.BackgroundColor3=Color3.fromRGB(24,16,40)
Acc.Visible=true
IIco.TextColor3=Color3.fromRGB(255,255,255)
ILbl.TextColor3=Color3.fromRGB(167,139,250)
end
IBtn.MouseButton1Click:Connect(function()
for k,nb in pairs(shared.NavBtns) do
nb.Btn.BackgroundColor3=Color3.fromRGB(14,14,22)
nb.Acc.Visible=false
nb.Ico.TextColor3=Color3.fromRGB(80,80,100)
nb.Lbl.TextColor3=Color3.fromRGB(80,80,100)
end
IBtn.BackgroundColor3=Color3.fromRGB(24,16,40)
Acc.Visible=true
IIco.TextColor3=Color3.fromRGB(255,255,255)
ILbl.TextColor3=Color3.fromRGB(167,139,250)
for k,pg in pairs(shared.Pages) do
pg.Parent.Visible=(k==def.ID)
end
end)
end
print("✅ 3/8 LAYOUT+NAV")
local TS=shared.TS
local UIS=shared.UIS
local RS=shared.RS
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
function shared.Toggle(parent,label,cfgT,cfgK,cb)
local Row=Instance.new("Frame",parent)
Row.Size=UDim2.new(1,0,0,34)
Row.BackgroundColor3=Color3.fromRGB(20,20,28)
Row.BorderSizePixel=0
Row.ZIndex=14
local Div=Instance.new("Frame",Row)
Div.Size=UDim2.new(1,0,0,1)
Div.Position=UDim2.new(0,0,1,-1)
Div.BackgroundColor3=Color3.fromRGB(28,28,40)
Div.BorderSizePixel=0
Div.ZIndex=15
local Lbl=Instance.new("TextLabel",Row)
Lbl.Size=UDim2.new(1,-72,1,0)
Lbl.Position=UDim2.new(0,12,0,0)
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
function shared.Drop(parent,label,options)
local Row=Instance.new("Frame",parent)
Row.Size=UDim2.new(1,0,0,34)
Row.BackgroundColor3=Color3.fromRGB(20,20,28)
Row.BorderSizePixel=0
Row.ZIndex=14
local Div=Instance.new("Frame",Row)
Div.Size=UDim2.new(1,0,0,1)
Div.Position=UDim2.new(0,0,1,-1)
Div.BackgroundColor3=Color3.fromRGB(28,28,40)
Div.BorderSizePixel=0
Div.ZIndex=15
local Lbl=Instance.new("TextLabel",Row)
Lbl.Size=UDim2.new(0.5,0,1,0)
Lbl.Position=UDim2.new(0,12,0,0)
Lbl.BackgroundTransparency=1
Lbl.Text=label
Lbl.TextColor3=Color3.fromRGB(200,200,212)
Lbl.Font=Enum.Font.Gotham
Lbl.TextSize=12
Lbl.TextXAlignment=Enum.TextXAlignment.Left
Lbl.ZIndex=15
local DB=Instance.new("TextButton",Row)
DB.Size=UDim2.new(0,88,0,22)
DB.Position=UDim2.new(1,-96,0.5,-11)
DB.BackgroundColor3=Color3.fromRGB(28,28,40)
DB.Text=(options[1] or "None").."  ▼"
DB.TextColor3=Color3.fromRGB(170,170,185)
DB.Font=Enum.Font.Gotham
DB.TextSize=11
DB.BorderSizePixel=0
DB.ZIndex=15
Instance.new("UICorner",DB).CornerRadius=UDim.new(0,6)
Instance.new("UIStroke",DB).Color=Color3.fromRGB(40,40,58)
local idx=1
DB.MouseButton1Click:Connect(function()
idx=idx%#options+1
DB.Text=options[idx].."  ▼"
end)
end
function shared.Slider(parent,label,min,max,val,unit,cfgT,cfgK)
local F=Instance.new("Frame",parent)
F.Size=UDim2.new(1,0,0,48)
F.BackgroundColor3=Color3.fromRGB(20,20,28)
F.BorderSizePixel=0
F.ZIndex=14
local Div=Instance.new("Frame",F)
Div.Size=UDim2.new(1,0,0,1)
Div.Position=UDim2.new(0,0,1,-1)
Div.BackgroundColor3=Color3.fromRGB(28,28,40)
Div.BorderSizePixel=0
Div.ZIndex=15
local LblL=Instance.new("TextLabel",F)
LblL.Size=UDim2.new(0.65,0,0,20)
LblL.Position=UDim2.new(0,12,0,4)
LblL.BackgroundTransparency=1
LblL.Text=label
LblL.TextColor3=Color3.fromRGB(80,80,100)
LblL.Font=Enum.Font.Gotham
LblL.TextSize=11
LblL.TextXAlignment=Enum.TextXAlignment.Left
LblL.ZIndex=15
local ValL=Instance.new("TextLabel",F)
ValL.Size=UDim2.new(0.35,-12,0,20)
ValL.Position=UDim2.new(0.65,0,0,4)
ValL.BackgroundTransparency=1
ValL.Text=tostring(val)..(unit or "")
ValL.TextColor3=Color3.fromRGB(136,136,155)
ValL.Font=Enum.Font.GothamSemibold
ValL.TextSize=11
ValL.TextXAlignment=Enum.TextXAlignment.Right
ValL.ZIndex=15
local TBG=Instance.new("Frame",F)
TBG.Size=UDim2.new(1,-24,0,3)
TBG.Position=UDim2.new(0,12,0,32)
TBG.BackgroundColor3=Color3.fromRGB(40,40,56)
TBG.BorderSizePixel=0
TBG.ZIndex=15
Instance.new("UICorner",TBG).CornerRadius=UDim.new(1,0)
local ratio=math.clamp((val-min)/(max-min),0,1)
local Fill=Instance.new("Frame",TBG)
Fill.Size=UDim2.new(ratio,0,1,0)
Fill.BackgroundColor3=Color3.fromRGB(124,58,237)
Fill.BorderSizePixel=0
Fill.ZIndex=16
Instance.new("UICorner",Fill).CornerRadius=UDim.new(1,0)
local Thumb=Instance.new("TextButton",TBG)
Thumb.Size=UDim2.new(0,11,0,11)
Thumb.Position=UDim2.new(ratio,-5,0.5,-5)
Thumb.BackgroundColor3=Color3.fromRGB(167,139,250)
Thumb.Text=""
Thumb.BorderSizePixel=0
Thumb.ZIndex=17
Instance.new("UICorner",Thumb).CornerRadius=UDim.new(1,0)
local drag=false
Thumb.MouseButton1Down:Connect(function() drag=true end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
RS.RenderStepped:Connect(function()
if not drag then return end
local r=math.clamp((UIS:GetMouseLocation().X-TBG.AbsolutePosition.X)/TBG.AbsoluteSize.X,0,1)
local v=math.floor(min+r*(max-min))
Fill.Size=UDim2.new(r,0,1,0)
Thumb.Position=UDim2.new(r,-5,0.5,-5)
ValL.Text=tostring(v)..(unit or "")
if cfgT then cfgT[cfgK]=v end
end)
end
function shared.Button(parent,label,btnText,cb)
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
local Lbl=Instance.new("TextLabel",Row)
Lbl.Size=UDim2.new(0.6,0,1,0)
Lbl.Position=UDim2.new(0,12,0,0)
Lbl.BackgroundTransparency=1
Lbl.Text=label
Lbl.TextColor3=Color3.fromRGB(200,200,212)
Lbl.Font=Enum.Font.Gotham
Lbl.TextSize=12
Lbl.TextXAlignment=Enum.TextXAlignment.Left
Lbl.ZIndex=15
local Btn=Instance.new("TextButton",Row)
Btn.Size=UDim2.new(0,50,0,22)
Btn.Position=UDim2.new(1,-58,0.5,-11)
Btn.BackgroundColor3=Color3.fromRGB(28,28,40)
Btn.Text=btnText or "ТП"
Btn.TextColor3=Color3.fromRGB(167,139,250)
Btn.Font=Enum.Font.GothamSemibold
Btn.TextSize=11
Btn.BorderSizePixel=0
Btn.ZIndex=15
Instance.new("UICorner",Btn).CornerRadius=UDim.new(0,6)
Instance.new("UIStroke",Btn).Color=Color3.fromRGB(58,58,80)
Btn.MouseButton1Click:Connect(function()
TS:Create(Btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(50,28,80)}):Play()
task.delay(0.12,function()
TS:Create(Btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(28,28,40)}):Play()
end)
if cb then cb() end
end)
end
print("✅ 4/8 BUILDERS")
local PH=shared.PH
local P=shared.Pages
local S=shared.Section
local T=shared.Toggle
local D=shared.Drop
local Sl=shared.Slider
local Bu=shared.Button
S(P["main"],"ESP ролей")
T(P["main"],"Включить ESP ролей",PH.ESP,"Enabled")
T(P["main"],"ESP Пистолета",PH.ESP,"Gun")
D(P["main"],"Role ESP Style",{"Minimal","Full","Dot","Arrow"})
T(P["main"],"Tracers",PH.ESP,"Tracers")
D(P["main"],"Откуда",{"Bottom","Top","Middle","Mouse"})
T(P["main"],"Все ESP",PH.ESP,"All")
D(P["main"],"Стиль ESP",{"Full","Minimal","Dot"})
S(P["main"],"Доп. метки")
T(P["main"],"Монеты ESP",PH.ESP,"Coins")
T(P["main"],"Нож ESP",PH.ESP,"Knife")
T(P["main"],"Пистолет ESP",PH.ESP,"Pistol")
S(P["combat"],"Aimbot")
T(P["combat"],"Aimbot",PH.Aim,"Enabled")
T(P["combat"],"Silent Aim",PH.Aim,"Silent")
T(P["combat"],"FOV Круг",nil,nil)
Sl(P["combat"],"FOV Радиус",50,400,180,"",PH.Aim,"FOV")
S(P["combat"],"Прочее")
T(P["combat"],"Без отдачи",PH.Aim,"NoRecoil")
local LP=shared.LP
local function TPTo(kw)
local char=LP.Character
if not char then return end
local root=char:FindFirstChild("HumanoidRootPart")
if not root then return end
for _,obj in pairs(workspace:GetDescendants()) do
if obj.Name:lower():find(kw) and obj:IsA("BasePart") then
root.CFrame=CFrame.new(obj.Position+Vector3.new(0,5,0))
return
end
end
end
S(P["farm"],"Монеты")
T(P["farm"],"Авто-монеты",PH.Farm,"Coins")
T(P["farm"],"Авто-победа",PH.Farm,"AutoWin")
S(P["tele"],"Телепорт")
Bu(P["tele"],"К ножу","ТП",function() TPTo("knife") end)
Bu(P["tele"],"К пистолету","ТП",function() TPTo("gun") end)
Bu(P["tele"],"К выходу","ТП",function() TPTo("exit") end)
Bu(P["tele"],"К монетам","ТП",function() TPTo("coin") end)
S(P["visual"],"Эффекты")
T(P["visual"],"Кастом прицел",PH.Visual,"Crosshair")
T(P["visual"],"Фулл брайт",PH.Visual,"Fullbright")
S(P["troll"],"Troll Fun")
T(P["troll"],"Флинг",PH.Troll,"Fling")
Sl(P["troll"],"Сила флинга",1,300,80,"",PH.Troll,"FlingForce")
print("✅ 5/8 PAGES")
local PH=shared.PH
local RP=shared.RScroll
local S=shared.Section
local T=shared.Toggle
local Sl=shared.Slider
S(RP,"Движение")
T(RP,"No Clip",PH.Move,"NoClip")
T(RP,"Бесконечные прыжки",PH.Move,"InfJump")
T(RP,"Анти-флинг",PH.Move,"AntiFling")
T(RP,"Полёт",PH.Move,"Fly",function(on)
if on then if shared.StartFly then shared.StartFly() end
else if shared.StopFly then shared.StopFly() end end
end)
Sl(RP,"Скорость полёта",10,300,90,"",PH.Move,"FlySpeed")
S(RP,"Скорость")
T(RP,"Спидхак",PH.Move,"Speed")
Sl(RP,"Скорость",16,150,28,"",PH.Move,"SpeedVal")
T(RP,"Auto Bhop",PH.Move,"Bhop")
S(RP,"Прочее")
T(RP,"Нокип",PH.Move,"NoClip")
print("✅ 6/8 RIGHT PANEL")
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local LP=shared.LP
local Camera=workspace.CurrentCamera
local PH=shared.PH
local ESPFolder=Instance.new("Folder",game.CoreGui)
ESPFolder.Name="PHubESP"
local ESPCache={}
local RoleColors={
Murderer=Color3.fromRGB(239,68,68),
Sheriff=Color3.fromRGB(96,165,250),
Innocent=Color3.fromRGB(134,239,172),
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
local function BuildESP(player)
local BB=Instance.new("BillboardGui")
BB.Name=player.Name.."_ESP"
BB.AlwaysOnTop=true
BB.Size=UDim2.new(0,180,0,55)
BB.StudsOffset=Vector3.new(0,3.5,0)
BB.Parent=ESPFolder
local NameL=Instance.new("TextLabel",BB)
NameL.Size=UDim2.new(1,0,0,18)
NameL.BackgroundTransparency=1
NameL.Font=Enum.Font.GothamBold
NameL.TextSize=13
NameL.TextStrokeTransparency=0
NameL.TextStrokeColor3=Color3.new(0,0,0)
local RoleL=Instance.new("TextLabel",BB)
RoleL.Size=UDim2.new(1,0,0,14)
RoleL.Position=UDim2.new(0,0,0,18)
RoleL.BackgroundTransparency=1
RoleL.Font=Enum.Font.Gotham
RoleL.TextSize=11
RoleL.TextStrokeTransparency=0
RoleL.TextStrokeColor3=Color3.new(0,0,0)
local DistL=Instance.new("TextLabel",BB)
DistL.Size=UDim2.new(1,0,0,13)
DistL.Position=UDim2.new(0,0,0,34)
DistL.BackgroundTransparency=1
DistL.Font=Enum.Font.Gotham
DistL.TextSize=10
DistL.TextColor3=Color3.fromRGB(190,190,200)
DistL.TextStrokeTransparency=0
DistL.TextStrokeColor3=Color3.new(0,0,0)
return BB,NameL,RoleL,DistL
end
RunService.RenderStepped:Connect(function()
for _,player in pairs(Players:GetPlayers()) do
if player==LP then continue end
local char=player.Character
if not char then continue end
local root=char:FindFirstChild("HumanoidRootPart")
if not root then continue end
if not ESPCache[player.Name] then
local bb,nl,rl,dl=BuildESP(player)
ESPCache[player.Name]={BB=bb,Name=nl,Role=rl,Dist=dl}
end
local e=ESPCache[player.Name]
if not e then continue end
local role=GetRole(player)
local color=RoleColors[role]
local dist=math.floor((root.Position-Camera.CFrame.Position).Magnitude)
e.BB.Adornee=root
e.BB.Enabled=PH.ESP.Enabled
e.Name.Text=player.Name
e.Name.TextColor3=color
e.Role.Text="["..role.."]"
e.Role.TextColor3=color
e.Dist.Text=dist.."m"
end
for name,e in pairs(ESPCache) do
if not Players:FindFirstChild(name) then
if e.BB then e.BB:Destroy() end
ESPCache[name]=nil
end
end
end)
local FOVDraw=Drawing.new("Circle")
FOVDraw.Visible=false
FOVDraw.Color=Color3.fromRGB(124,58,237)
FOVDraw.Thickness=1
FOVDraw.Filled=false
FOVDraw.NumSides=80
local function GetTarget()
local best,bestD=nil,PH.Aim.FOV
local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
for _,player in pairs(Players:GetPlayers()) do
if player==LP then continue end
local char=player.Character
if not char then continue end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum and hum.Health<=0 then continue end
local part=char:FindFirstChild("Head")
if not part then continue end
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
FOVDraw.Position=center
FOVDraw.Radius=PH.Aim.FOV
local t=GetTarget()
if t then
local sp=Camera:WorldToViewportPoint(t.Position)
local np=center:Lerp(Vector2.new(sp.X,sp.Y),0.12)
local ray=Camera:ViewportPointToRay(np.X,np.Y)
Camera.CFrame=CFrame.new(Camera.CFrame.Position,Camera.CFrame.Position+ray.Direction*999)
end
end
if PH.Aim.NoRecoil then
Camera.CFrame=Camera.CFrame*CFrame.Angles(0.003,0,0)
end
end)
print("✅ 7/8 ESP+AIMBOT")
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=shared.UIS
local LP=shared.LP
local PH=shared.PH
RunService.Heartbeat:Connect(function()
if not PH.Move.Speed then return end
local char=LP.Character
if not char then return end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum then hum.WalkSpeed=PH.Move.SpeedVal end
end)
RunService.Stepped:Connect(function()
if not PH.Move.NoClip then return end
local char=LP.Character
if not char then return end
for _,p in pairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide=false end
end
end)
UIS.JumpRequest:Connect(function()
if not PH.Move.InfJump then return end
local char=LP.Character
if not char then return end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
RunService.Stepped:Connect(function()
if not PH.Move.Bhop then return end
local char=LP.Character
if not char then return end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum and hum.FloorMaterial~=Enum.Material.Air then
hum:ChangeState(Enum.HumanoidStateType.Jumping)
end
end)
RunService.Heartbeat:Connect(function()
if not PH.Move.AntiFling then return end
local char=LP.Character
if not char then return end
local root=char:FindFirstChild("HumanoidRootPart")
if not root then return end
root.AssemblyLinearVelocity=Vector3.new(
math.clamp(root.AssemblyLinearVelocity.X,-80,80),
root.AssemblyLinearVelocity.Y,
math.clamp(root.AssemblyLinearVelocity.Z,-80,80)
)
end)
RunService.Heartbeat:Connect(function()
if not PH.Farm.Coins then return end
local char=LP.Character
if not char then return end
local root=char:FindFirstChild("HumanoidRootPart")
if not root then return end
for _,obj in pairs(workspace:GetDescendants()) do
if obj.Name:lower():find("coin") and obj:IsA("BasePart") then
root.CFrame=CFrame.new(obj.Position)
task.wait(0.08)
end
end
end)
RunService.Heartbeat:Connect(function()
if not PH.Visual.Fullbright then return end
local L=game:GetService("Lighting")
L.Brightness=10
L.ClockTime=14
end)
local FlyConn,FlyBV
function shared.StartFly()
local char=LP.Character
if not char then return end
local root=char:FindFirstChild("HumanoidRootPart")
local hum=char:FindFirstChildOfClass("Humanoid")
if not root or not hum then return end
hum.PlatformStand=true
FlyBV=Instance.new("BodyVelocity",root)
FlyBV.Name="PHFly"
FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5)
FlyBV.Velocity=Vector3.zero
FlyConn=RunService.RenderStepped:Connect(function()
if not PH.Move.Fly then shared.StopFly() return end
local cam=workspace.CurrentCamera
local dir=Vector3.zero
if UIS:IsKeyDown(Enum.KeyCode.W) then dir=dir+cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.S) then dir=dir-cam.CFrame.LookVector end
if UIS:IsKeyDown(Enum.KeyCode.A) then dir=dir-cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.D) then dir=dir+cam.CFrame.RightVector end
if UIS:IsKeyDown(Enum.KeyCode.Space) then dir=dir+Vector3.new(0,1,0) end
FlyBV.Velocity=dir*PH.Move.FlySpeed
end)
end
function shared.StopFly()
if FlyConn then FlyConn:Disconnect(); FlyConn=nil end
if FlyBV then FlyBV:Destroy(); FlyBV=nil end
local char=LP.Character
if not char then return end
local hum=char:FindFirstChildOfClass("Humanoid")
if hum then hum.PlatformStand=false end
end
print("✅ 8/8 MISC+FLY+FARM")
print("🟣 PULSE HUB MM2 — ГОТОВ")
