local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {aim=false, silent=false, esp=true, box=true, line=true, names=true, dist=true, hp=true, teamCheck=false, speed=false, antilag=false, fov=140}
local accent = Color3.fromRGB(255, 70, 70)
local blue = Color3.fromRGB(80, 170, 255)
local gui = Instance.new("ScreenGui")
gui.Name = "VDPremium"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = plr:WaitForChild("PlayerGui")
local boot = Instance.new("Frame")
boot.Size = UDim2.fromOffset(440, 160)
boot.AnchorPoint = Vector2.new(0.5, 0.5)
boot.Position = UDim2.fromScale(0.5, 0.5)
boot.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
boot.Parent = gui
Instance.new("UICorner", boot).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", boot).Color = blue
local bootText = Instance.new("TextLabel")
bootText.BackgroundTransparency = 1
bootText.Size = UDim2.new(1, -24, 0, 60)
bootText.Position = UDim2.fromOffset(12, 18)
bootText.Font = Enum.Font.GothamBold
bootText.TextSize = 22
bootText.TextColor3 = blue
bootText.Text = "скрипт от ProCriper"
bootText.Parent = boot
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -28, 0, 10)
barBg.Position = UDim2.fromOffset(14, 100)
barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
barBg.Parent = boot
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
local bar = Instance.new("Frame")
bar.Size = UDim2.fromScale(0, 1)
bar.BackgroundColor3 = blue
bar.Parent = barBg
Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
local bootSub = Instance.new("TextLabel")
bootSub.BackgroundTransparency = 1
bootSub.Size = UDim2.new(1, -24, 0, 24)
bootSub.Position = UDim2.fromOffset(12, 120)
bootSub.Font = Enum.Font.Gotham
bootSub.TextSize = 13
bootSub.TextColor3 = Color3.fromRGB(180, 180, 190)
bootSub.Text = "загрузка 0%"
bootSub.Parent = boot
local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(680, 400)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
root.Visible = false
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", root).Color = Color3.fromRGB(46, 46, 52)
local rail = Instance.new("Frame")
rail.Size = UDim2.new(0, 54, 1, 0)
rail.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
rail.Parent = root
local top = Instance.new("Frame")
top.Size = UDim2.new(1, -54, 0, 40)
top.Position = UDim2.fromOffset(54, 0)
top.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
top.ZIndex = 5
top.Parent = root
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.Font = Enum.Font.Gotham
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(150, 150, 158)
title.Text = "ProCriper"
title.ZIndex = 6
title.Parent = top
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(28, 28)
close.Position = UDim2.new(1, -34, 0.5, -14)
close.BackgroundColor3 = Color3.fromRGB(48, 32, 38)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 140, 155)
close.ZIndex = 20
close.Parent = top
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)
close.MouseButton1Click:Connect(function() root.Visible = false end)
local fab = Instance.new("TextButton")
fab.Size = UDim2.fromOffset(46, 46)
fab.Position = UDim2.new(0, 16, 1, -70)
fab.BackgroundColor3 = Color3.fromRGB(150, 70, 255)
fab.Font = Enum.Font.GothamBold
fab.TextSize = 14
fab.Text = "VD"
fab.TextColor3 = Color3.new(1, 1, 1)
fab.Visible = false
fab.Parent = gui
Instance.new("UICorner", fab).CornerRadius = UDim.new(1, 0)
fab.MouseButton1Click:Connect(function() root.Visible = not root.Visible end)
local function hookDrag(obj, target)
	local drag, ds, sp
	obj.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			if obj == top and i.Position.X >= close.AbsolutePosition.X then return end
			drag, ds, sp = true, i.Position, target.Position
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
			local d = i.Position - ds
			target.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
		end
	end)
end
hookDrag(top, root)
hookDrag(fab, fab)
local pages = {}
local function page(name)
	local p = Instance.new("ScrollingFrame")
	p.Size = UDim2.new(1, -66, 1, -50)
	p.Position = UDim2.fromOffset(60, 46)
	p.BackgroundTransparency = 1
	p.BorderSizePixel = 0
	p.ScrollBarThickness = 3
	p.CanvasSize = UDim2.fromOffset(0, 520)
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
	b.Position = UDim2.fromOffset(9, y)
	b.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.Text = text
	b.TextColor3 = accent
	b.Parent = rail
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	b.MouseButton1Click:Connect(function() select(name) end)
end
icon("M", 10, "Main")
icon("V", 52, "Visuals")
icon("A", 94, "Aim")
icon("+", 136, "Misc")
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
	track.MouseButton1Click:Connect(function() cfg[key] = not cfg[key] paint() end)
end
local function slider(parent, label, key, min, max, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -12, 0, 48)
	row.Position = UDim2.fromOffset(6, y)
	row.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(1, -16, 0, 20)
	t.Position = UDim2.fromOffset(10, 4)
	t.Font = Enum.Font.Gotham
	t.TextSize = 13
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.fromRGB(230, 230, 235)
	t.Text = label .. "  " .. cfg[key]
	t.Parent = row
	local barBtn = Instance.new("TextButton")
	barBtn.Size = UDim2.new(1, -20, 0, 8)
	barBtn.Position = UDim2.fromOffset(10, 30)
	barBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 56)
	barBtn.Text = ""
	barBtn.AutoButtonColor = false
	barBtn.Parent = row
	Instance.new("UICorner", barBtn).CornerRadius = UDim.new(1, 0)
	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale((cfg[key] - min) / (max - min), 1)
	fill.BackgroundColor3 = accent
	fill.Parent = barBtn
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	barBtn.MouseButton1Down:Connect(function()
		local rel = math.clamp((UIS:GetMouseLocation().X - barBtn.AbsolutePosition.X) / barBtn.AbsoluteSize.X, 0, 1)
		cfg[key] = math.floor(min + (max - min) * rel)
		fill.Size = UDim2.fromScale(rel, 1)
		t.Text = label .. "  " .. cfg[key]
	end)
end
local main, vis, aimP, misc = page("Main"), page("Visuals"), page("Aim"), page("Misc")
head(main, "Home", 8)
toggle(main, "Anti-lag", "antilag", 44)
head(vis, "ESP", 8)
toggle(vis, "Enabled", "esp", 44)
toggle(vis, "Box", "box", 86)
toggle(vis, "Line", "line", 128)
toggle(vis, "Name", "names", 170)
toggle(vis, "Distance", "dist", 212)
toggle(vis, "HP", "hp", 254)
head(aimP, "Aimbot", 8)
toggle(aimP, "Enabled", "aim", 44)
toggle(aimP, "Silent aim", "silent", 86)
toggle(aimP, "Team check", "teamCheck", 128)
slider(aimP, "FOV", "fov", 1, 360, 170)
head(misc, "Misc", 8)
toggle(misc, "Speed", "speed", 44)
select("Visuals")
local function visible(part)
	local origin = cam.CFrame.Position
	local dir = part.Position - origin
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {plr.Character, part.Parent}
	local hit = workspace:Raycast(origin, dir, params)
	return not hit or hit.Instance:IsDescendantOf(part.Parent)
end
local function findModel(p)
	local ch = p.Character
	if ch and ch:FindFirstChildOfClass("Humanoid") and ch:FindFirstChild("HumanoidRootPart") and ch:FindFirstChildOfClass("Humanoid").Health > 0 then
		return ch
	end
	for _, m in ipairs(workspace:GetDescendants()) do
		if m:IsA("Model") and m.Name == p.Name then
			local hum = m:FindFirstChildOfClass("Humanoid")
			if hum and hum.Health > 0 and (m:FindFirstChild("Head") or m:FindFirstChild("HumanoidRootPart")) then
				return m
			end
		end
	end
end
local targetPart
local drawings = {}
local function wipe(p)
	local d = drawings[p]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[p] = nil
end
local function slot(p)
	if drawings[p] then return drawings[p] end
	local d = {box=Drawing.new("Square"), line=Drawing.new("Line"), hp=Drawing.new("Line"), bg=Drawing.new("Line"), name=Drawing.new("Text"), dist=Drawing.new("Text")}
	d.box.Thickness = 1.6 d.box.Filled = false d.box.Color = accent
	d.line.Thickness = 1.4 d.line.Color = accent
	d.bg.Thickness = 3 d.bg.Color = Color3.fromRGB(20,20,20)
	d.hp.Thickness = 2
	d.name.Size = 14 d.name.Center = true d.name.Outline = true d.name.Color = Color3.new(1,1,1)
	d.dist.Size = 13 d.dist.Center = true d.dist.Outline = true d.dist.Color = Color3.fromRGB(180,220,255)
	drawings[p] = d
	return d
end
RunService.RenderStepped:Connect(function()
	if cfg.antilag then Lighting.GlobalShadows = false Lighting.FogEnd = 100000 end
	targetPart = nil
	local best, bestD = nil, cfg.fov
	local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
	local firing = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr then
			local m = findModel(p)
			local hum = m and m:FindFirstChildOfClass("Humanoid")
			local hrp = m and (m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Head"))
			local head = m and (m:FindFirstChild("Head") or hrp)
			local hide = (not cfg.esp) or (not m) or (not hum) or (not hrp) or hum.Health <= 0 or (cfg.teamCheck and p.Team and plr.Team and p.Team == plr.Team)
			if hide then wipe(p) else
				local pos, on = cam:WorldToViewportPoint(hrp.Position)
				local d = slot(p)
				if not on then
					for _, o in pairs(d) do o.Visible = false end
				else
					local topP = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, 3, 0)).Position)
					local bot = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -3.6, 0)).Position)
					local h = math.max(math.abs(bot.Y - topP.Y), 8)
					local w = h / 2
					local x = pos.X - w / 2
					d.box.Visible = cfg.box
					d.box.Size = Vector2.new(w, h)
					d.box.Position = Vector2.new(x, topP.Y)
					d.line.Visible = cfg.line
					d.line.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
					d.line.To = Vector2.new(pos.X, bot.Y)
					d.name.Visible = cfg.names
					d.name.Text = p.Name
					d.name.Position = Vector2.new(pos.X, topP.Y - 16)
					d.dist.Visible = cfg.dist
					d.dist.Text = math.floor((hrp.Position - cam.CFrame.Position).Magnitude) .. "m"
					d.dist.Position = Vector2.new(pos.X, bot.Y + 2)
					local ratio = hum.Health / math.max(hum.MaxHealth, 1)
					d.bg.Visible = cfg.hp
					d.hp.Visible = cfg.hp
					d.bg.From = Vector2.new(x - 5, bot.Y)
					d.bg.To = Vector2.new(x - 5, topP.Y)
					d.hp.From = Vector2.new(x - 5, bot.Y)
					d.hp.To = Vector2.new(x - 5, bot.Y - h * ratio)
				end
				if head and visible(head) then
					local hp2, on2 = cam:WorldToViewportPoint(head.Position)
					if on2 then
						local dist = (Vector2.new(hp2.X, hp2.Y) - center).Magnitude
						if dist < bestD then best, bestD = head, dist end
					end
				end
			end
		end
	end
	if firing and (cfg.aim or cfg.silent) then targetPart = best end
	if firing and cfg.aim and targetPart then
		cam.CFrame = CFrame.new(cam.CFrame.Position, targetPart.Position)
	end
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then hum.WalkSpeed = 26 end
end)
pcall(function()
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if cfg.silent and targetPart and method == "Raycast" then
			local args = {...}
			if typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
				args[2] = (targetPart.Position - args[1]).Unit * 1000
				return old(self, unpack(args))
			end
		end
		return old(self, ...)
	end)
	setreadonly(mt, true)
end)
UIS.InputBegan:Connect(function(i, g)
	if not g and i.KeyCode == Enum.KeyCode.RightShift then root.Visible = not root.Visible end
end)
Players.PlayerRemoving:Connect(wipe)
task.spawn(function()
	for i = 1, 20 do
		bar.Size = UDim2.fromScale(i / 20, 1)
		bootSub.Text = "загрузка " .. (i * 5) .. "%"
		task.wait(0.06)
	end
	boot.Visible = false
	root.Visible = true
	fab.Visible = true
end)
