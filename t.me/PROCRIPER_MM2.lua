local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {esp=true, box=true, line=true, names=true, dist=true, coins=false, speed=false, kSheriff=false, kMurder=false, kInno=false}
local accent = Color3.fromRGB(255, 80, 110)
local gui = Instance.new("ScreenGui")
gui.Name = "MM2Premium"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = plr:WaitForChild("PlayerGui")
local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(620, 390)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", root).Color = Color3.fromRGB(48, 48, 56)
local rail = Instance.new("Frame")
rail.Size = UDim2.new(0, 54, 1, 0)
rail.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
rail.Parent = root
local top = Instance.new("Frame")
top.Size = UDim2.new(1, -54, 0, 42)
top.Position = UDim2.fromOffset(54, 0)
top.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
top.Parent = root
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -12, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = accent
title.Text = "MM2"
title.Parent = top
local fab = Instance.new("TextButton")
fab.Size = UDim2.fromOffset(54, 54)
fab.Position = UDim2.new(0, 14, 0.38, 0)
fab.BackgroundColor3 = Color3.fromRGB(22, 16, 24)
fab.Font = Enum.Font.GothamBold
fab.TextSize = 14
fab.Text = "MM"
fab.TextColor3 = Color3.fromRGB(255, 170, 185)
fab.AutoButtonColor = false
fab.ZIndex = 40
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
local tdrag, tds, tsp
top.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		tdrag, tds, tsp = true, i.Position, root.Position
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then tdrag = false end
end)
UIS.InputChanged:Connect(function(i)
	if tdrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local d = i.Position - tds
		root.Position = UDim2.new(tsp.X.Scale, tsp.X.Offset + d.X, tsp.Y.Scale, tsp.Y.Offset + d.Y)
	end
end)
local pages = {}
local function page(name)
	local p = Instance.new("ScrollingFrame")
	p.Size = UDim2.new(1, -66, 1, -52)
	p.Position = UDim2.fromOffset(60, 48)
	p.BackgroundTransparency = 1
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
icon("V", 12, "Visuals")
icon("K", 54, "Kill")
icon("+", 96, "Misc")
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
local vis, kill, misc = page("Visuals"), page("Kill"), page("Misc")
toggle(vis, "ESP", "esp", 8)
toggle(vis, "Box", "box", 50)
toggle(vis, "Line", "line", 92)
toggle(vis, "Name", "names", 134)
toggle(vis, "Distance", "dist", 176)
toggle(vis, "Coins", "coins", 218)
toggle(kill, "Kill Sheriff", "kSheriff", 8)
toggle(kill, "Kill Murderer", "kMurder", 50)
toggle(kill, "Kill all Innocent", "kInno", 92)
toggle(misc, "Speed", "speed", 8)
select("Visuals")
local function tool(p, name)
	local bag, ch = p:FindFirstChild("Backpack"), p.Character
	return (bag and bag:FindFirstChild(name)) or (ch and ch:FindFirstChild(name))
end
local function role(p)
	if tool(p, "Knife") then return "Murder", Color3.fromRGB(255, 40, 40) end
	if tool(p, "Gun") then return "Sheriff", Color3.fromRGB(70, 150, 255) end
	return "Innocent", Color3.fromRGB(60, 220, 90)
end
local function openView(part, model)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {plr.Character, model}
	local hit = workspace:Raycast(cam.CFrame.Position, part.Position - cam.CFrame.Position, params)
	return not hit or hit.Instance:IsDescendantOf(model)
end
local function act(target)
	local head = target.Character and (target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart"))
	if not head then return end
	cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
	local gun = tool(plr, "Gun")
	local knife = tool(plr, "Knife")
	if gun then pcall(function() gun:Activate() end) end
	if knife then pcall(function() knife:Activate() end) end
end
local function screenBtn(text, x, key, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(132, 36)
	b.Position = UDim2.new(1, -146, 0.35, x)
	b.BackgroundColor3 = color
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Visible = false
	b.Parent = gui
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	b.MouseButton1Click:Connect(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= plr then
				local tag = role(p)
				local head = p.Character and (p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart"))
				if key == "kSheriff" and tag == "Murder" and head and openView(head, p.Character) then act(p) end
				if key == "kMurder" and tag == "Sheriff" and head and openView(head, p.Character) then act(p) end
				if key == "kInno" and tag == "Innocent" then act(p) end
			end
		end
	end)
	return b
end
local b1 = screenBtn("Kill Sheriff", 0, "kSheriff", Color3.fromRGB(40, 90, 180))
local b2 = screenBtn("Kill Murder", 44, "kMurder", Color3.fromRGB(160, 40, 50))
local b3 = screenBtn("Kill Innocent", 88, "kInno", Color3.fromRGB(40, 140, 70))
local drawings = {}
local function wipe(key)
	local d = drawings[key]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[key] = nil
end
local function slot(key)
	if drawings[key] then return drawings[key] end
	local d = {box=Drawing.new("Square"), line=Drawing.new("Line"), name=Drawing.new("Text"), dist=Drawing.new("Text")}
	d.box.Thickness = 1.6 d.box.Filled = false
	d.line.Thickness = 1.2
	d.name.Size = 14 d.name.Center = true d.name.Outline = true
	d.dist.Size = 13 d.dist.Center = true d.dist.Outline = true
	drawings[key] = d
	return d
end
RunService.RenderStepped:Connect(function()
	b1.Visible = cfg.kSheriff
	b2.Visible = cfg.kMurder
	b3.Visible = cfg.kInno
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then hum.WalkSpeed = 26 end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr then
			local ch = p.Character
			local root = ch and (ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChild("Head"))
			local ph = ch and ch:FindFirstChildOfClass("Humanoid")
			if not cfg.esp or not root or not ph or ph.Health <= 0 then wipe(p.Name) else
				local tag, col = role(p)
				local pos, vis = cam:WorldToViewportPoint(root.Position)
				local d = slot(p.Name)
				d.box.Color, d.line.Color, d.name.Color, d.dist.Color = col, col, col, col
				if not vis then
					for _, o in pairs(d) do o.Visible = false end
				else
					local topP = cam:WorldToViewportPoint((root.CFrame * CFrame.new(0, 3, 0)).Position)
					local bot = cam:WorldToViewportPoint((root.CFrame * CFrame.new(0, -3.4, 0)).Position)
					local h = math.max(math.abs(bot.Y - topP.Y), 10)
					local w = h / 2
					d.box.Visible = cfg.box
					d.box.Size = Vector2.new(w, h)
					d.box.Position = Vector2.new(pos.X - w / 2, topP.Y)
					d.line.Visible = cfg.line
					d.line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
					d.line.To = Vector2.new(pos.X, bot.Y)
					d.name.Visible = cfg.names
					d.name.Text = p.Name .. "  " .. tag
					d.name.Position = Vector2.new(pos.X, topP.Y - 16)
					d.dist.Visible = cfg.dist
					d.dist.Text = math.floor((root.Position - cam.CFrame.Position).Magnitude) .. "m"
					d.dist.Position = Vector2.new(pos.X, bot.Y + 2)
				end
			end
		end
	end
end)
