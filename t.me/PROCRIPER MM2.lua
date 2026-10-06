local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {aim=false, esp=false, boxes=true, names=true, dist=true, hp=true, tracers=false, teamCheck=true, speed=false, fov=120}
local accent = Color3.fromRGB(212, 164, 74)

local gui = Instance.new("ScreenGui")
gui.Name = "VDPremium"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = plr:WaitForChild("PlayerGui")

local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(720, 430)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
root.BorderSizePixel = 0
root.Active = true
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", root).Color = Color3.fromRGB(48, 48, 54)

local rail = Instance.new("Frame")
rail.Size = UDim2.new(0, 52, 1, 0)
rail.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
rail.BorderSizePixel = 0
rail.Parent = root

local top = Instance.new("Frame")
top.Size = UDim2.new(1, -52, 0, 42)
top.Position = UDim2.fromOffset(52, 0)
top.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
top.BorderSizePixel = 0
top.ZIndex = 5
top.Parent = root

local search = Instance.new("TextLabel")
search.BackgroundTransparency = 1
search.Size = UDim2.new(1, -90, 1, 0)
search.Position = UDim2.fromOffset(12, 0)
search.Font = Enum.Font.Gotham
search.TextSize = 14
search.TextXAlignment = Enum.TextXAlignment.Left
search.TextColor3 = Color3.fromRGB(140, 140, 148)
search.Text = "Search features"
search.ZIndex = 6
search.Parent = top

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(32, 32)
close.Position = UDim2.new(1, -38, 0.5, -16)
close.BackgroundColor3 = Color3.fromRGB(48, 32, 38)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 140, 155)
close.ZIndex = 20
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
close.MouseButton1Click:Connect(function()
	root.Visible = false
end)

local fab = Instance.new("TextButton")
fab.Size = UDim2.fromOffset(40, 40)
fab.Position = UDim2.new(0, 14, 1, -54)
fab.BackgroundColor3 = Color3.fromRGB(150, 70, 255)
fab.Font = Enum.Font.GothamBold
fab.TextSize = 13
fab.Text = "VD"
fab.TextColor3 = Color3.new(1, 1, 1)
fab.Parent = gui
Instance.new("UICorner", fab).CornerRadius = UDim.new(1, 0)
fab.MouseButton1Click:Connect(function()
	root.Visible = not root.Visible
end)

local drag, ds, sp
top.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 and i.Position.X < close.AbsolutePosition.X then
		drag, ds, sp = true, i.Position, root.Position
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)
UIS.InputChanged:Connect(function(i)
	if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
		local d = i.Position - ds
		root.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
	end
end)

local pages = {}
local function page(name)
	local p = Instance.new("ScrollingFrame")
	p.Size = UDim2.new(1, -64, 1, -52)
	p.Position = UDim2.fromOffset(58, 48)
	p.BackgroundTransparency = 1
	p.BorderSizePixel = 0
	p.ScrollBarThickness = 3
	p.CanvasSize = UDim2.fromOffset(0, 460)
	p.Visible = false
	p.Parent = root
	pages[name] = p
	return p
end
local function select(name)
	for n, p in pairs(pages) do p.Visible = n == name end
end
local function icon(text, y, name)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(36, 36)
	b.Position = UDim2.fromOffset(8, y)
	b.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.Text = text
	b.TextColor3 = accent
	b.Parent = rail
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	b.MouseButton1Click:Connect(function() select(name) end)
end
icon("M", 12, "Main")
icon("V", 54, "Visuals")
icon("A", 96, "Aim")
icon("+", 138, "Misc")

local function head(parent, text, y)
	local h = Instance.new("TextLabel")
	h.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	h.Size = UDim2.new(1, -12, 0, 28)
	h.Position = UDim2.fromOffset(6, y)
	h.Font = Enum.Font.GothamBold
	h.TextSize = 13
	h.TextXAlignment = Enum.TextXAlignment.Left
	h.TextColor3 = accent
	h.Text = "   " .. text
	h.Parent = parent
	Instance.new("UICorner", h).CornerRadius = UDim.new(0, 6)
end
local function toggle(parent, label, key, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -12, 0, 36)
	row.Position = UDim2.fromOffset(6, y)
	row.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(1, -70, 1, 0)
	t.Position = UDim2.fromOffset(10, 0)
	t.Font = Enum.Font.Gotham
	t.TextSize = 13
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.fromRGB(230, 230, 235)
	t.Text = label
	t.Parent = row
	local track = Instance.new("TextButton")
	track.Size = UDim2.fromOffset(40, 20)
	track.Position = UDim2.new(1, -50, 0.5, -10)
	track.Text = ""
	track.AutoButtonColor = false
	track.Parent = row
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(16, 16)
	knob.Position = UDim2.fromOffset(2, 2)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = track
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	local function paint()
		local on = cfg[key]
		TweenService:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = on and accent or Color3.fromRGB(70, 70, 76)}):Play()
		TweenService:Create(knob, TweenInfo.new(0.15), {Position = on and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)}):Play()
	end
	paint()
	track.MouseButton1Click:Connect(function()
		cfg[key] = not cfg[key]
		paint()
	end)
end

local main, vis, aimP, misc = page("Main"), page("Visuals"), page("Aim"), page("Misc")
head(main, "Home", 8)
toggle(main, "Speed", "speed", 44)
head(vis, "ESP", 8)
toggle(vis, "Enabled", "esp", 48)
toggle(vis, "Boxes", "boxes", 90)
toggle(vis, "Names", "names", 132)
toggle(vis, "Distance", "dist", 174)
toggle(vis, "Health", "hp", 216)
toggle(vis, "Tracers", "tracers", 258)
head(aimP, "Aimbot", 8)
toggle(aimP, "Enabled", "aim", 48)
toggle(aimP, "Team check", "teamCheck", 90)
head(misc, "Misc", 8)
toggle(misc, "Speed", "speed", 48)
select("Visuals")

local drawings = {}
local function wipe(p)
	local d = drawings[p]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[p] = nil
end
local function slot(p)
	if drawings[p] then return drawings[p] end
	local d = {
		box = Drawing.new("Square"),
		name = Drawing.new("Text"),
		dist = Drawing.new("Text"),
		hp = Drawing.new("Line"),
		tr = Drawing.new("Line")
	}
	d.box.Thickness = 1.4
	d.box.Filled = false
	d.box.Color = accent
	d.name.Size = 13
	d.name.Center = true
	d.name.Outline = true
	d.name.Color = Color3.new(1, 1, 1)
	d.dist.Size = 12
	d.dist.Center = true
	d.dist.Color = Color3.fromRGB(200, 200, 210)
	d.hp.Thickness = 2
	d.tr.Thickness = 1
	d.tr.Color = accent
	drawings[p] = d
	return d
end

RunService.RenderStepped:Connect(function()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr then
			local ch = p.Character
			local hum = ch and ch:FindFirstChildOfClass("Humanoid")
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			local head = ch and ch:FindFirstChild("Head")
			local skip = (not cfg.esp) or (not hum) or (not hrp) or hum.Health <= 0 or (cfg.teamCheck and p.Team and plr.Team and p.Team == plr.Team)
			if skip then
				wipe(p)
			else
				local pos, on = cam:WorldToViewportPoint(hrp.Position)
				local d = slot(p)
				if not on then
					for _, o in pairs(d) do o.Visible = false end
				else
					local topP = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, 3, 0)).Position)
					local bot = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -3.5, 0)).Position)
					local h = math.abs(bot.Y - topP.Y)
					local w = h / 2
					d.box.Visible = cfg.boxes
					d.box.Size = Vector2.new(w, h)
					d.box.Position = Vector2.new(pos.X - w / 2, topP.Y)
					d.name.Visible = cfg.names
					d.name.Text = p.Name
					d.name.Position = Vector2.new(pos.X, topP.Y - 16)
					d.dist.Visible = cfg.dist
					d.dist.Text = math.floor((hrp.Position - cam.CFrame.Position).Magnitude) .. "m"
					d.dist.Position = Vector2.new(pos.X, bot.Y + 2)
					d.hp.Visible = cfg.hp
					d.hp.From = Vector2.new(pos.X - w / 2 - 5, bot.Y)
					d.hp.To = Vector2.new(pos.X - w / 2 - 5, bot.Y - h * (hum.Health / math.max(hum.MaxHealth, 1)))
					d.hp.Color = Color3.fromRGB(90, 220, 130)
					d.tr.Visible = cfg.tracers
					d.tr.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
					d.tr.To = Vector2.new(pos.X, bot.Y)
				end
			end
			if cfg.aim and head and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
				local hp2, on2 = cam:WorldToViewportPoint(head.Position)
				if on2 and (Vector2.new(hp2.X, hp2.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude < cfg.fov then
					cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
				end
			end
		end
	end
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then hum.WalkSpeed = 26 end
end)

UIS.InputBegan:Connect(function(i, g)
	if not g and i.KeyCode == Enum.KeyCode.RightShift then
		root.Visible = not root.Visible
	end
end)
Players.PlayerRemoving:Connect(wipe)
