local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {esp=true, box=true, line=true, names=true, dist=true, coins=false, speed=false, fling=false}
local accent = Color3.fromRGB(90, 140, 255)
local gui = Instance.new("ScreenGui")
gui.Name = "PulseHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = plr:WaitForChild("PlayerGui")
local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(860, 480)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 10)
local rail = Instance.new("Frame")
rail.Size = UDim2.new(0, 168, 1, 0)
rail.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
rail.Parent = root
local brand = Instance.new("TextLabel")
brand.BackgroundTransparency = 1
brand.Size = UDim2.new(1, -16, 0, 42)
brand.Position = UDim2.fromOffset(12, 8)
brand.Font = Enum.Font.GothamBold
brand.TextSize = 16
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.TextColor3 = Color3.new(1, 1, 1)
brand.Text = "Pulse Hub"
brand.Parent = rail
local sub = Instance.new("TextLabel")
sub.BackgroundTransparency = 1
sub.Size = UDim2.new(1, -16, 0, 16)
sub.Position = UDim2.fromOffset(12, 30)
sub.Font = Enum.Font.Gotham
sub.TextSize = 11
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.TextColor3 = Color3.fromRGB(140, 140, 150)
sub.Text = "Murder Mystery 2"
sub.Parent = rail
local tabs = {"Главная","Combat","Автофарм","Телепорт","Troll Fun","Free anims","Флинг","Визуал","Настройки","Сервер"}
local pages = {}
local function show(name)
	for n, p in pairs(pages) do p.Visible = n == name end
end
for i, name in ipairs(tabs) do
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -16, 0, 32)
	b.Position = UDim2.fromOffset(8, 52 + (i - 1) * 36)
	b.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.Text = "    " .. name
	b.TextColor3 = Color3.fromRGB(220, 220, 225)
	b.Parent = rail
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	b.MouseButton1Click:Connect(function() show(name) end)
end
local top = Instance.new("Frame")
top.Size = UDim2.new(1, -168, 0, 42)
top.Position = UDim2.fromOffset(168, 0)
top.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
top.Parent = root
local head = Instance.new("TextLabel")
head.BackgroundTransparency = 1
head.Size = UDim2.new(1, -20, 1, 0)
head.Position = UDim2.fromOffset(16, 0)
head.Font = Enum.Font.GothamBold
head.TextSize = 18
head.TextXAlignment = Enum.TextXAlignment.Left
head.TextColor3 = Color3.new(1, 1, 1)
head.Text = "Pulse Hub"
head.Parent = top
local fab = Instance.new("TextButton")
fab.Size = UDim2.fromOffset(52, 52)
fab.Position = UDim2.new(0, 12, 0.4, 0)
fab.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
fab.Font = Enum.Font.GothamBold
fab.TextSize = 13
fab.Text = "PH"
fab.TextColor3 = accent
fab.AutoButtonColor = false
fab.ZIndex = 30
fab.Parent = gui
Instance.new("UICorner", fab).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", fab).Color = accent
local drag, ds, sp, moved
fab.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		drag, moved, ds, sp = true, false, i.Position, fab.Position
	end
end)
UIS.InputChanged:Connect(function(i)
	if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local d = i.Position - ds
		if d.Magnitude > 10 then moved = true end
		if moved then fab.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y) end
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
end)
fab.MouseButton1Click:Connect(function()
	if not moved then root.Visible = not root.Visible end
end)
local function page(name)
	local p = Instance.new("ScrollingFrame")
	p.Size = UDim2.new(1, -180, 1, -52)
	p.Position = UDim2.fromOffset(176, 48)
	p.BackgroundTransparency = 1
	p.ScrollBarThickness = 3
	p.CanvasSize = UDim2.fromOffset(0, 520)
	p.Visible = false
	p.Parent = root
	pages[name] = p
	return p
end
local function card(parent, title, x, y)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0.48, -8, 0, 250)
	f.Position = UDim2.new(x, 8, 0, y)
	f.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	f.Parent = parent
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(1, -16, 0, 28)
	t.Position = UDim2.fromOffset(10, 6)
	t.Font = Enum.Font.GothamBold
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.new(1, 1, 1)
	t.Text = title
	t.Parent = f
	return f
end
local function toggle(parent, label, key, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -16, 0, 28)
	row.Position = UDim2.fromOffset(8, y)
	row.BackgroundTransparency = 1
	row.Parent = parent
	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(1, -54, 1, 0)
	t.Font = Enum.Font.Gotham
	t.TextSize = 13
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.fromRGB(220, 220, 225)
	t.Text = label
	t.Parent = row
	local track = Instance.new("TextButton")
	track.Size = UDim2.fromOffset(36, 18)
	track.Position = UDim2.new(1, -40, 0.5, -9)
	track.Text = ""
	track.AutoButtonColor = false
	track.Parent = row
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(14, 14)
	knob.Position = UDim2.fromOffset(2, 2)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = track
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	local function paint()
		local on = cfg[key]
		TweenService:Create(track, TweenInfo.new(0.12), {BackgroundColor3 = on and accent or Color3.fromRGB(60, 60, 68)}):Play()
		TweenService:Create(knob, TweenInfo.new(0.12), {Position = on and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 2)}):Play()
	end
	paint()
	track.MouseButton1Click:Connect(function() cfg[key] = not cfg[key] paint() end)
end
local home = page("Главная")
local left = card(home, "Мотив", 0, 8)
local right = card(home, "Передвижение", 0.5, 8)
toggle(left, "ESP ролей", "esp", 40)
toggle(left, "Включить ESP ролей", "box", 74)
toggle(left, "ESP пистолета", "line", 108)
toggle(left, "Tracers", "names", 142)
toggle(left, "Все ESP", "dist", 176)
toggle(right, "Speed", "speed", 40)
toggle(right, "Coins", "coins", 74)
local flingPage = page("Флинг")
local flingCard = card(flingPage, "Fling", 0, 8)
toggle(flingCard, "Fling Murder", "fling", 40)
local go = Instance.new("TextButton")
go.Size = UDim2.new(1, -20, 0, 34)
go.Position = UDim2.fromOffset(10, 90)
go.BackgroundColor3 = accent
go.Font = Enum.Font.GothamBold
go.TextSize = 13
go.Text = "Скинуть мардера"
go.TextColor3 = Color3.new(1, 1, 1)
go.Parent = flingCard
Instance.new("UICorner", go).CornerRadius = UDim.new(0, 6)
show("Главная")
local function tool(p, name)
	local bag, ch = p:FindFirstChild("Backpack"), p.Character
	return (bag and bag:FindFirstChild(name)) or (ch and ch:FindFirstChild(name))
end
local function role(p)
	if tool(p, "Knife") then return "Murder", Color3.fromRGB(255, 40, 40) end
	if tool(p, "Gun") then return "Sheriff", Color3.fromRGB(70, 150, 255) end
	return "Innocent", Color3.fromRGB(60, 220, 90)
end
local function flingMurder()
	if role(plr) ~= "Innocent" then return end
	for _, p in ipairs(Players:GetPlayers()) do
		if role(p) == "Murder" and p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				pcall(function()
					hrp.AssemblyLinearVelocity = Vector3.new(0, 900, 0)
					hrp.Velocity = Vector3.new(0, 900, 0)
				end)
			end
		end
	end
end
go.MouseButton1Click:Connect(flingMurder)
local drawings = {}
local function wipe(key)
	local d = drawings[key]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[key] = nil
end
local function slot(key)
	if drawings[key] then return drawings[key] end
	local d = {box=Drawing.new("Square"), line=Drawing.new("Line"), name=Drawing.new("Text")}
	d.box.Thickness = 1.6 d.box.Filled = false
	d.line.Thickness = 1.2
	d.name.Size = 14 d.name.Center = true d.name.Outline = true
	drawings[key] = d
	return d
end
RunService.RenderStepped:Connect(function()
	if cfg.fling then flingMurder() end
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then hum.WalkSpeed = 26 end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr then
			local ch = p.Character
			local rootP = ch and (ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChild("Head"))
			local ph = ch and ch:FindFirstChildOfClass("Humanoid")
			if not cfg.esp or not rootP or not ph or ph.Health <= 0 then wipe(p.Name) else
				local tag, col = role(p)
				local pos, vis = cam:WorldToViewportPoint(rootP.Position)
				local d = slot(p.Name)
				d.box.Color, d.line.Color, d.name.Color = col, col, col
				if not vis then
					for _, o in pairs(d) do o.Visible = false end
				else
					local topP = cam:WorldToViewportPoint((rootP.CFrame * CFrame.new(0, 3, 0)).Position)
					local bot = cam:WorldToViewportPoint((rootP.CFrame * CFrame.new(0, -3.4, 0)).Position)
					local h = math.max(math.abs(bot.Y - topP.Y), 10)
					d.box.Visible = cfg.box
					d.box.Size = Vector2.new(h / 2, h)
					d.box.Position = Vector2.new(pos.X - h / 4, topP.Y)
					d.line.Visible = cfg.line
					d.line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
					d.line.To = Vector2.new(pos.X, bot.Y)
					d.name.Visible = cfg.names
					d.name.Text = p.Name .. "  " .. tag
					d.name.Position = Vector2.new(pos.X, topP.Y - 16)
				end
			end
		end
	end
end)
