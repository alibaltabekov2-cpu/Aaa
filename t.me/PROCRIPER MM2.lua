local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {
	aim = false, aimFov = 120, aimPart = "Head",
	esp = false, boxes = true, names = true, dist = true, hp = true,
	tracers = false, teamCheck = true, speed = false, speedVal = 24
}
local gui = Instance.new("ScreenGui")
gui.Name = "VDMenu"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")
local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(920, 560)
root.Position = UDim2.fromScale(0.5, 0.5)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
root.BorderSizePixel = 0
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 8)
local side = Instance.new("Frame")
side.Size = UDim2.new(0, 180, 1, 0)
side.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
side.BorderSizePixel = 0
side.Parent = root
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -16, 0, 36)
title.Position = UDim2.fromOffset(12, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(235, 235, 235)
title.Text = "Violence District"
title.Parent = side
local pages, current = {}, nil
local function page(name)
	local p = Instance.new("ScrollingFrame")
	p.Size = UDim2.new(1, -196, 1, -28)
	p.Position = UDim2.fromOffset(188, 12)
	p.BackgroundTransparency = 1
	p.BorderSizePixel = 0
	p.ScrollBarThickness = 4
	p.CanvasSize = UDim2.fromOffset(0, 700)
	p.Visible = false
	p.Parent = root
	pages[name] = p
	return p
end
local function select(name)
	for n, p in pairs(pages) do p.Visible = n == name end
	current = name
end
local function tab(text, y, name)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -16, 0, 32)
	b.Position = UDim2.fromOffset(8, y)
	b.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	b.TextColor3 = Color3.fromRGB(210, 210, 210)
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.Text = text
	b.Parent = side
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	b.MouseButton1Click:Connect(function() select(name) end)
end
tab("Main", 56, "Main")
tab("Visuals", 94, "Visuals")
tab("Aim", 132, "Aim")
tab("Misc", 170, "Misc")
local function toggle(parent, label, key, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -20, 0, 36)
	row.Position = UDim2.fromOffset(10, y)
	row.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1, -70, 1, 0)
	t.Position = UDim2.fromOffset(10, 0)
	t.BackgroundTransparency = 1
	t.Font = Enum.Font.Gotham
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.fromRGB(230, 230, 230)
	t.Text = label
	t.Parent = row
	local sw = Instance.new("TextButton")
	sw.Size = UDim2.fromOffset(42, 22)
	sw.Position = UDim2.new(1, -52, 0.5, -11)
	sw.Text = ""
	sw.Parent = row
	Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)
	local function paint()
		sw.BackgroundColor3 = cfg[key] and Color3.fromRGB(150, 90, 255) or Color3.fromRGB(60, 60, 60)
	end
	paint()
	sw.MouseButton1Click:Connect(function()
		cfg[key] = not cfg[key]
		paint()
	end)
end
local main, vis, aim, misc = page("Main"), page("Visuals"), page("Aim"), page("Misc")
toggle(main, "ESP", "esp", 8)
toggle(main, "Aimbot", "aim", 52)
toggle(vis, "2D Boxes", "boxes", 8)
toggle(vis, "Names", "names", 52)
toggle(vis, "Distance", "dist", 96)
toggle(vis, "Health", "hp", 140)
toggle(vis, "Tracers", "tracers", 184)
toggle(aim, "Team check", "teamCheck", 8)
toggle(misc, "Speed", "speed", 8)
select("Main")
local drawings = {}
local function clearEsp(p)
	local d = drawings[p]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[p] = nil
end
local function ensure(p)
	if drawings[p] then return drawings[p] end
	drawings[p] = {
		box = Drawing.new("Square"),
		name = Drawing.new("Text"),
		dist = Drawing.new("Text"),
		hp = Drawing.new("Line"),
		tr = Drawing.new("Line")
	}
	local d = drawings[p]
	d.box.Thickness = 1
	d.box.Filled = false
	d.box.Color = Color3.fromRGB(170, 110, 255)
	d.name.Size = 13
	d.name.Center = true
	d.name.Color = Color3.new(1, 1, 1)
	d.name.Outline = true
	d.dist.Size = 12
	d.dist.Center = true
	d.dist.Color = Color3.fromRGB(200, 200, 200)
	d.hp.Thickness = 2
	d.tr.Thickness = 1
	d.tr.Color = Color3.fromRGB(170, 110, 255)
	return d
end
local function espStep()
	for _, p in ipairs(Players:GetPlayers()) do
		if p == plr then continue end
		local ch = p.Character
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
		if not cfg.esp or not hum or not hrp or hum.Health <= 0 then
			clearEsp(p)
			continue
		end
		if cfg.teamCheck and p.Team and plr.Team and p.Team == plr.Team then
			clearEsp(p)
			continue
		end
		local pos, on = cam:WorldToViewportPoint(hrp.Position)
		local d = ensure(p)
		if not on then
			for _, o in pairs(d) do o.Visible = false end
			continue
		end
		local top = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, 3, 0)).Position)
		local bot = cam:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -3.5, 0)).Position)
		local h = math.abs(bot.Y - top.Y)
		local w = h / 2
		d.box.Visible = cfg.boxes
		d.box.Size = Vector2.new(w, h)
		d.box.Position = Vector2.new(pos.X - w / 2, top.Y)
		d.name.Visible = cfg.names
		d.name.Text = p.Name
		d.name.Position = Vector2.new(pos.X, top.Y - 16)
		d.dist.Visible = cfg.dist
		d.dist.Text = math.floor((hrp.Position - cam.CFrame.Position).Magnitude) .. "m"
		d.dist.Position = Vector2.new(pos.X, bot.Y + 2)
		d.hp.Visible = cfg.hp
		d.hp.From = Vector2.new(pos.X - w / 2 - 4, bot.Y)
		d.hp.To = Vector2.new(pos.X - w / 2 - 4, bot.Y - h * (hum.Health / hum.MaxHealth))
		d.hp.Color = Color3.fromRGB(80, 220, 120)
		d.tr.Visible = cfg.tracers
		d.tr.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
		d.tr.To = Vector2.new(pos.X, pos.Y)
	end
end
Players.PlayerRemoving:Connect(clearEsp)
local function getTarget()
	local best, bestD = nil, cfg.aimFov
	local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
	for _, p in ipairs(Players:GetPlayers()) do
		if p == plr then continue end
		if cfg.teamCheck and p.Team and plr.Team and p.Team == plr.Team then continue end
		local ch = p.Character
		local part = ch and ch:FindFirstChild(cfg.aimPart)
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		if part and hum and hum.Health > 0 then
			local pos, on = cam:WorldToViewportPoint(part.Position)
			if on then
				local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
				if d < bestD then
					best, bestD = part, d
				end
			end
		end
	end
	return best
end
RunService.RenderStepped:Connect(function()
	espStep()
	if cfg.aim and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		local part = getTarget()
		if part then
			cam.CFrame = CFrame.new(cam.CFrame.Position, part.Position)
		end
	end
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then
		hum.WalkSpeed = cfg.speedVal
	end
end)
UIS.InputBegan:Connect(function(i, g)
	if g then return end
	if i.KeyCode == Enum.KeyCode.RightShift then
		root.Visible = not root.Visible
	end
end)
print("menu up, RightShift hide")
