local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local cam = workspace.CurrentCamera
local cfg = {aim=false, esp=false, boxes=true, names=true, dist=true, hp=true, tracers=false, teamCheck=true, speed=false}
local accent = Color3.fromRGB(176, 104, 255)
local gui = Instance.new("ScreenGui")
gui.Name = "VDPremium"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = plr:WaitForChild("PlayerGui")
local root = Instance.new("Frame")
root.Size = UDim2.fromOffset(640, 400)
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
root.BorderSizePixel = 0
root.ClipsDescendants = true
root.Parent = gui
Instance.new("UICorner", root).CornerRadius = UDim.new(0, 16)
local st = Instance.new("UIStroke", root)
st.Color = Color3.fromRGB(70, 48, 110)
st.Thickness = 1.2
local side = Instance.new("Frame")
side.Size = UDim2.new(0, 150, 1, -14)
side.Position = UDim2.fromOffset(7, 7)
side.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
side.BorderSizePixel = 0
side.Parent = root
Instance.new("UICorner", side).CornerRadius = UDim.new(0, 12)
local brand = Instance.new("TextLabel")
brand.BackgroundTransparency = 1
brand.Size = UDim2.new(1, -12, 0, 26)
brand.Position = UDim2.fromOffset(10, 10)
brand.Font = Enum.Font.GothamBold
brand.TextSize = 14
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.TextColor3 = Color3.new(1, 1, 1)
brand.Text = "VD"
brand.Parent = side
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(26, 26)
close.Position = UDim2.new(1, -34, 0, 10)
close.BackgroundColor3 = Color3.fromRGB(48, 28, 36)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 130, 150)
close.Parent = root
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
close.MouseButton1Click:Connect(function() root.Visible = false end)
local fab = Instance.new("TextButton")
fab.Size = UDim2.fromOffset(42, 42)
fab.Position = UDim2.new(0, 16, 1, -58)
fab.BackgroundColor3 = accent
fab.Font = Enum.Font.GothamBold
fab.TextSize = 13
fab.Text = "VD"
fab.TextColor3 = Color3.new(1, 1, 1)
fab.Parent = gui
Instance.new("UICorner", fab).CornerRadius = UDim.new(1, 0)
fab.MouseButton1Click:Connect(function() root.Visible = not root.Visible end)
local drag, ds, sp = false
root.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
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
	p.Size = UDim2.new(1, -172, 1, -20)
	p.Position = UDim2.fromOffset(164, 10)
	p.BackgroundTransparency = 1
	p.BorderSizePixel = 0
	p.ScrollBarThickness = 3
	p.ScrollBarImageColor3 = accent
	p.CanvasSize = UDim2.fromOffset(0, 460)
	p.Visible = false
	p.Parent = root
	pages[name] = p
	return p
end
local function select(name)
	for n, p in pairs(pages) do p.Visible = n == name end
end
local function tab(text, y, name)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -14, 0, 32)
	b.Position = UDim2.fromOffset(7, y)
	b.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 13
	b.Text = text
	b.TextColor3 = Color3.fromRGB(225, 225, 230)
	b.Parent = side
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	b.MouseButton1Click:Connect(function() select(name) end)
end
tab("Main", 46, "Main")
tab("Visuals", 84, "Visuals")
tab("Aim", 122, "Aim")
tab("Misc", 160, "Misc")
local function toggle(parent, label, key, y)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -12, 0, 44)
	row.Position = UDim2.fromOffset(6, y)
	row.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
	local t = Instance.new("TextLabel")
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(1, -80, 1, 0)
	t.Position = UDim2.fromOffset(12, 0)
	t.Font = Enum.Font.GothamMedium
	t.TextSize = 14
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextColor3 = Color3.fromRGB(240, 240, 245)
	t.Text = label
	t.Parent = row
	local track = Instance.new("TextButton")
	track.Size = UDim2.fromOffset(48, 26)
	track.Position = UDim2.new(1, -58, 0.5, -13)
	track.Text = ""
	track.AutoButtonColor = false
	track.Parent = row
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(20, 20)
	knob.Position = UDim2.fromOffset(3, 3)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.Parent = track
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	local glow = Instance.new("UIStroke", track)
	glow.Thickness = 0
	glow.Color = accent
	local function paint()
		local on = cfg[key]
		TweenService:Create(track, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {
			BackgroundColor3 = on and accent or Color3.fromRGB(55, 55, 62)
		}):Play()
		TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = on and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
		}):Play()
		TweenService:Create(glow, TweenInfo.new(0.18), {Thickness = on and 1.4 or 0}):Play()
	end
	paint()
	track.MouseButton1Click:Connect(function()
		cfg[key] = not cfg[key]
		paint()
	end)
end
local main, vis, aimP, misc = page("Main"), page("Visuals"), page("Aim"), page("Misc")
toggle(main, "ESP", "esp", 8)
toggle(main, "Aimbot", "aim", 58)
toggle(vis, "Boxes", "boxes", 8)
toggle(vis, "Names", "names", 58)
toggle(vis, "Distance", "dist", 108)
toggle(vis, "Health", "hp", 158)
toggle(vis, "Tracers", "tracers", 208)
toggle(aimP, "Team check", "teamCheck", 8)
toggle(misc, "Speed", "speed", 8)
select("Main")
local drawings = {}
local function wipe(p)
	local d = drawings[p]
	if not d then return end
	for _, o in pairs(d) do o:Remove() end
	drawings[p] = nil
end
local function slot(p)
	if drawings[p] then return drawings[p] end
	local d = {box=Drawing.new("Square"), name=Drawing.new("Text"), dist=Drawing.new("Text"), hp=Drawing.new("Line"), tr=Drawing.new("Line")}
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
			if not cfg.esp or not hum or not hrp or hum.Health <= 0 or (cfg.teamCheck and p.Team and plr.Team and p.Team == plr.Team) then
				wipe(p)
			else
				local pos, on = cam:WorldToViewportPoint(hrp.Position)
				local d = slot(p)
				if not on then
					for _, o in pairs(d) do o.Visible = false end
				else
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
				if on2 and (Vector2.new(hp2.X, hp2.Y) - Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude < 130 then
					cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
				end
			end
		end
	end
	local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if hum and cfg.speed then hum.WalkSpeed = 26 end
end)
UIS.InputBegan:Connect(function(i, g)
	if not g and i.KeyCode == Enum.KeyCode.RightShift then root.Visible = not root.Visible end
end)
Players.PlayerRemoving:Connect(wipe)
