-- LocalScript → StarterPlayer > StarterPlayerScripts
-- PROPAGANDA: Visual + Shoot Hub

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- НАСТРОЙКИ
local TOGGLE_KEY = Enum.KeyCode.N
local SOUND_ID = ""
local CENTER = Vector3.new(0, 3000, 0)
local STREAM_COUNT, ORB_COUNT = 160, 60
local EXPAND_TIME = 2.8

-- Предметы ролей
local MURDER_TOOLS = {Knife = true, Blade = true, Sword = true}
local SHERIFF_TOOLS = {Gun = true, Revolver = true, Pistol = true}

local PURPLE = Color3.fromRGB(150, 80, 255)
local PINK = Color3.fromRGB(255, 60, 200)
local BLUE = Color3.fromRGB(80, 140, 255)
local TEXT_DIM = Color3.fromRGB(170, 160, 210)
local ESP_RED = Color3.fromRGB(255, 50, 50)
local ESP_BLUE = Color3.fromRGB(60, 130, 255)
local ESP_GREEN = Color3.fromRGB(60, 255, 120)

local rng = Random.new()
local infinity, voidActive, busy, windowOpen = false, false, false, false
local folder, voidBeat, sound, returnCF, expandStart, barrier
local streams, orbs = {}, {}
local flags = {murderer = false, sheriff = false, innocent = false, tags = false}

-- Настройки Shoot функции
local shootFlags = {
	autoShootMurderer = false,
	autoShootSheriff = false,
	killAllInnocents = false,
	flingMurderer = false
}

-- ===== Сохраняем настройки мира =====
local saved = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	FogEnd = Lighting.FogEnd,
	ExposureCompensation = Lighting.ExposureCompensation,
}
local fov = camera.FieldOfView
local origSky = Lighting:FindFirstChildOfClass("Sky")
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
local atmoDensity = atmosphere and atmosphere.Density

local voidSky = Instance.new("Sky")
voidSky.StarCount = 8000
voidSky.CelestialBodiesShown = false
for _, p in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
	voidSky[p] = ""
end

local bloom = Instance.new("BloomEffect")
bloom.Intensity, bloom.Size, bloom.Threshold = 0, 48, 0.95
bloom.Parent = Lighting
local color = Instance.new("ColorCorrectionEffect")
color.Parent = Lighting
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- ===== Вспомогательные функции =====
local function tw(obj, t, props, style, dir)
	local tween = TweenService:Create(obj,
		TweenInfo.new(t, style or Enum.EasingStyle.Sine, dir or Enum.EasingDirection.Out), props)
	tween:Play()
	return tween
end

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Parent = parent
	return o
end

local function round(o, r)
	return new("UICorner", {CornerRadius = UDim.new(0, r)}, o)
end

local function outline(o, col, th, tr)
	return new("UIStroke", {
		Color = col, Thickness = th, Transparency = tr or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, o)
end

local function rainbow()
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, PURPLE),
		ColorSequenceKeypoint.new(0.35, PINK),
		ColorSequenceKeypoint.new(0.7, BLUE),
		ColorSequenceKeypoint.new(1, PURPLE),
	})
end

local function pressFx(btn)
	local sc = new("UIScale", {Scale = 1}, btn)
	btn.MouseButton1Down:Connect(function() tw(sc, 0.08, {Scale = 0.95}) end)
	btn.MouseButton1Up:Connect(function() tw(sc, 0.15, {Scale = 1}, Enum.EasingStyle.Back) end)
	btn.MouseLeave:Connect(function() tw(sc, 0.15, {Scale = 1}) end)
end

local function makeDraggable(handle, target)
	local state = {moved = false}
	local dragging, startInput, startPos = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging, state.moved = true, false
			startInput, startPos = input.Position, target.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseMovement) then
			local d = input.Position - startInput
			if d.Magnitude > 10 then state.moved = true end
			if state.moved then
				target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
					startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	return state
end

-- ===== UI ЭКРАНА И ОКНО =====
local playerGui = player:WaitForChild("PlayerGui")

local fxGui = new("ScreenGui", {
	Name = "VoidFx", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 100,
}, playerGui)

local flash = new("Frame", {
	Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 10,
}, fxGui)

local function label(text, y, h)
	return new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, y),
		Size = UDim2.fromScale(0.9, h), BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack, Text = text, TextScaled = true,
		TextColor3 = Color3.new(1, 1, 1), TextStrokeColor3 = PURPLE,
		TextTransparency = 1, TextStrokeTransparency = 1, ZIndex = 11,
	}, fxGui)
end
local title = label("Расширение территории", 0.45, 0.1)
local sub = label("Бесконечная пустота", 0.56, 0.07)

local function fadeText(l, to)
	tw(l, 0.6, {TextTransparency = to, TextStrokeTransparency = to})
end

local uiGui = new("ScreenGui", {
	Name = "PropagandaUI", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 200,
}, playerGui)

local window = new("CanvasGroup", {
	Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(440, 320), BackgroundColor3 = Color3.fromRGB(14, 10, 32),
	GroupTransparency = 1, Visible = false,
}, uiGui)
round(window, 18)
new("UIGradient", {
	Color = ColorSequence.new(Color3.fromRGB(28, 17, 62), Color3.fromRGB(8, 6, 22)),
	Rotation = 60,
}, window)
local winScale = new("UIScale", {Scale = 1}, window)

local rim = new("Frame", {
	Size = UDim2.new(1, -2, 1, -2), Position = UDim2.fromOffset(1, 1),
	BackgroundTransparency = 1, ZIndex = 5,
}, window)
round(rim, 17)
local rimStroke = outline(rim, Color3.new(1, 1, 1), 2)
local rimGrad = new("UIGradient", {Color = rainbow()}, rimStroke)

local titleBar = new("Frame", {Size = UDim2.new(1, 0, 0, 48), BackgroundTransparency = 1}, window)

do
	local logo = new("Frame", {
		Position = UDim2.fromOffset(14, 9), Size = UDim2.fromOffset(30, 30),
		BackgroundColor3 = Color3.new(1, 1, 1),
	}, titleBar)
	round(logo, 15)
	new("UIGradient", {Color = ColorSequence.new(PURPLE, PINK), Rotation = 45}, logo)
	new("TextLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "P",
		Font = Enum.Font.GothamBlack, TextSize = 18, TextColor3 = Color3.new(1, 1, 1),
	}, logo)

	new("TextLabel", {
		Position = UDim2.fromOffset(54, 7), Size = UDim2.fromOffset(220, 20), BackgroundTransparency = 1,
		Text = "PROPAGANDA", Font = Enum.Font.GothamBlack, TextSize = 16,
		TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
	}, titleBar)
	new("TextLabel", {
		Position = UDim2.fromOffset(54, 26), Size = UDim2.fromOffset(220, 14), BackgroundTransparency = 1,
		Text = "Visual & Shoot Hub", Font = Enum.Font.Gotham, TextSize = 12,
		TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left,
	}, titleBar)
end

local closeBtn = new("TextButton", {
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0),
	Size = UDim2.fromOffset(30, 30), BackgroundColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 0.9, Text = "×", Font = Enum.Font.GothamBold, TextSize = 24,
	TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false,
}, titleBar)
round(closeBtn, 15)
pressFx(closeBtn)

new("Frame", {
	Position = UDim2.fromOffset(14, 48), Size = UDim2.new(1, -28, 0, 1),
	BackgroundColor3 = PURPLE, BackgroundTransparency = 0.7, BorderSizePixel = 0,
}, window)
-- ===== БОКОВОЕ МЕНЮ И ВКЛАДКИ =====
local sidebar = new("Frame", {
	Position = UDim2.fromOffset(14, 60), Size = UDim2.fromOffset(108, 246),
	BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94,
}, window)
round(sidebar, 14)

local tabVisual = new("TextButton", {
	Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 34),
	BackgroundColor3 = Color3.new(1, 1, 1), Text = "Visual", Font = Enum.Font.GothamBold,
	TextSize = 14, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
}, sidebar)
round(tabVisual, 10)
new("UIPadding", {PaddingLeft = UDim.new(0, 24)}, tabVisual)
local tabVisualGrad = new("UIGradient", {Color = ColorSequence.new(PURPLE, PINK)}, tabVisual)
pressFx(tabVisual)

local tabShoot = new("TextButton", {
	Position = UDim2.fromOffset(6, 44), Size = UDim2.new(1, -12, 0, 34),
	BackgroundColor3 = Color3.fromRGB(30, 24, 50), Text = "Shott", Font = Enum.Font.GothamBold,
	TextSize = 14, TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
}, sidebar)
round(tabShoot, 10)
new("UIPadding", {PaddingLeft = UDim.new(0, 24)}, tabShoot)
pressFx(tabShoot)

-- Содержимое Visual
local scrollVisual = new("ScrollingFrame", {
	Position = UDim2.fromOffset(134, 60), Size = UDim2.fromOffset(292, 246),
	BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
	ScrollBarImageColor3 = PURPLE, CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y,
	Visible = true,
}, window)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, scrollVisual)
new("UIPadding", {PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 6)}, scrollVisual)

-- Содержимое Shoot
local scrollShoot = new("ScrollingFrame", {
	Position = UDim2.fromOffset(134, 60), Size = UDim2.fromOffset(292, 246),
	BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
	ScrollBarImageColor3 = PURPLE, CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y,
	Visible = false,
}, window)
new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, scrollShoot)
new("UIPadding", {PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 6)}, scrollShoot)

-- Функция переключения вкладок
local function switchTab(tabName)
	if tabName == "Visual" then
		scrollVisual.Visible = true
		scrollShoot.Visible = false
		tabVisual.BackgroundColor3 = Color3.new(1, 1, 1)
		tabVisual.TextColor3 = Color3.new(1, 1, 1)
		tabVisualGrad.Enabled = true
		tabShoot.BackgroundColor3 = Color3.fromRGB(30, 24, 50)
		tabShoot.TextColor3 = TEXT_DIM
	else
		scrollVisual.Visible = false
		scrollShoot.Visible = true
		tabShoot.BackgroundColor3 = Color3.new(1, 1, 1)
		tabShoot.TextColor3 = Color3.new(1, 1, 1)
		tabVisual.BackgroundColor3 = Color3.fromRGB(30, 24, 50)
		tabVisual.TextColor3 = TEXT_DIM
		tabVisualGrad.Enabled = false
	end
end

tabVisual.MouseButton1Click:Connect(function() switchTab("Visual") end)
tabShoot.MouseButton1Click:Connect(function() switchTab("Shott") end)

-- Вспомогательный элемент: Переключатель (Toggle)
local function createToggle(parent, titleText, callback)
	local frame = new("Frame", {
		Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Color3.fromRGB(24, 18, 48),
	}, parent)
	round(frame, 8)
	
	new("TextLabel", {
		Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -60, 1, 0),
		BackgroundTransparency = 1, Text = titleText, Font = Enum.Font.GothamBold,
		TextSize = 12, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
	}, frame)
	
	local btn = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.fromOffset(40, 20), BackgroundColor3 = Color3.fromRGB(45, 35, 70),
		Text = "OFF", Font = Enum.Font.GothamBold, TextSize = 10, TextColor3 = Color3.new(1, 1, 1),
	}, frame)
	round(btn, 10)
	
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and "ON" or "OFF"
		btn.BackgroundColor3 = state and PURPLE or Color3.fromRGB(45, 35, 70)
		callback(state)
	end)
	return frame
end

-- ===== СОЗДАНИЕ ПЛАВАЮЩИХ КНОПКИ НА ЭКРАНЕ =====
local function createActionBtn(text, pos)
	local b = new("TextButton", {
		Position = pos, Size = UDim2.fromOffset(170, 42),
		BackgroundColor3 = Color3.fromRGB(20, 14, 42), Text = text,
		Font = Enum.Font.GothamBlack, TextSize = 12, TextColor3 = Color3.new(1, 1, 1),
		Visible = false, ZIndex = 300, AutoButtonColor = false,
	}, uiGui)
	round(b, 12)
	local str = outline(b, Color3.new(1, 1, 1), 2)
	new("UIGradient", {Color = rainbow()}, str)
	pressFx(b)
	makeDraggable(b, b)
	return b
end

local floatShootMurderer = createActionBtn("auto shoot marder", UDim2.new(0.05, 0, 0.3, 0))
local floatShootSheriff = createActionBtn("auto shoot sherif", UDim2.new(0.05, 0, 0.4, 0))
local floatKillInnocent = createActionBtn("kill all inconettet", UDim2.new(0.05, 0, 0.5, 0))
local floatFlingMurderer = createActionBtn("Fling Murderer", UDim2.new(0.05, 0, 0.6, 0))

-- Кнопка запуск окна
local launcher = new("TextButton", {
	Position = UDim2.new(1, -72, 0.4, 0), Size = UDim2.fromOffset(56, 56),
	BackgroundColor3 = Color3.fromRGB(16, 10, 38), Text = "∞", Font = Enum.Font.GothamBlack,
	TextSize = 30, TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false,
}, uiGui)
round(launcher, 28)
local lStroke = outline(launcher, Color3.new(1, 1, 1), 2.5)
new("UIGradient", {Color = rainbow()}, lStroke)
pressFx(launcher)

makeDraggable(launcher, launcher)
makeDraggable(titleBar, window)
-- ===== УПРАВЛЕНИЕ ОКНОМ =====
local function fit()
	local vp = camera.ViewportSize
	return math.clamp(math.min(vp.X / 490, vp.Y / 380), 0.5, 1.15)
end

local function setWindow(open)
	if windowOpen == open then return end
	windowOpen = open
	local s = fit()
	if open then
		window.Visible = true
		window.GroupTransparency = 1
		winScale.Scale = s * 0.8
		tw(winScale, 0.4, {Scale = s}, Enum.EasingStyle.Back)
		tw(window, 0.3, {GroupTransparency = 0})
	else
		tw(winScale, 0.22, {Scale = s * 0.85}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		tw(window, 0.22, {GroupTransparency = 1})
		task.delay(0.25, function()
			if not windowOpen then window.Visible = false end
		end)
	end
end

camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	if windowOpen then winScale.Scale = fit() end
end)

closeBtn.MouseButton1Click:Connect(function() setWindow(false) end)
launcher.MouseButton1Click:Connect(function() setWindow(not windowOpen) end)

UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == TOGGLE_KEY then
		setWindow(not windowOpen)
	end
end)

-- ===== ЛОГИКА ПУСТОТЫ =====
local function setBarrier(on)
	if on then
		if barrier then barrier:Destroy() end
		barrier = new("Part", {
			Shape = Enum.PartType.Ball, Size = Vector3.new(0.5, 0.5, 0.5), Anchored = true,
			CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false,
			Material = Enum.Material.ForceField, Color = Color3.fromRGB(110, 190, 255),
			Transparency = 0.35,
		}, workspace)
		tw(barrier, 0.7, {Size = Vector3.new(9, 9, 9)}, Enum.EasingStyle.Back)
	elseif barrier then
		local b = barrier
		barrier = nil
		tw(b, 0.4, {Size = Vector3.new(0.5, 0.5, 0.5), Transparency = 1})
		task.delay(0.45, function() b:Destroy() end)
	end
end

local function part(size, cf, col, mat, shape)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanQuery, p.CastShadow = true, false, false, false
	p.Size, p.CFrame, p.Color, p.Material = size, cf, col, mat
	if shape then p.Shape = shape end
	p.Parent = folder
	return p
end

local function shockwave(delay, col)
	task.delay(delay, function()
		if not folder then return end
		local r = part(Vector3.new(0.6, 10, 10),
			CFrame.new(CENTER) * CFrame.Angles(0, 0, math.rad(90)),
			col, Enum.Material.Neon, Enum.PartType.Cylinder)
		r.Transparency = 0.6
		tw(r, 2.6, {Size = Vector3.new(0.6, 1400, 1400), Transparency = 1}, Enum.EasingStyle.Quad)
		task.delay(2.7, function() r:Destroy() end)
	end)
end

local function buildVoid()
	folder = Instance.new("Folder")
	folder.Name = "InfiniteVoid"
	folder.Parent = workspace

	local plat = part(Vector3.new(1, 44, 44),
		CFrame.new(CENTER) * CFrame.Angles(0, 0, math.rad(90)),
		Color3.fromRGB(22, 14, 48), Enum.Material.SmoothPlastic, Enum.PartType.Cylinder)
	plat.CanCollide = true
	plat.Reflectance = 0.1
	new("PointLight", {Color = PURPLE, Range = 40, Brightness = 0.6}, plat)
	
	local glow = part(Vector3.new(0.4, 48, 48),
		CFrame.new(CENTER + Vector3.new(0, -0.8, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		PINK, Enum.Material.Neon, Enum.PartType.Cylinder)
	glow.Transparency = 0.85

	streams, orbs = {}, {}
	for i = 1, STREAM_COUNT do
		local w = rng:NextNumber(0.2, 0.9)
		local s = part(Vector3.new(w, w, rng:NextNumber(30, 220)), CFrame.new(CENTER),
			PURPLE, Enum.Material.Neon)
		s.Transparency = rng:NextNumber(0, 0.4)
		streams[i] = {
			p = s, a = rng:NextNumber(0, math.pi * 2), r = rng:NextNumber(10, 260),
			z = rng:NextNumber(-800, 800), v = rng:NextNumber(250, 900),
		}
	end
end

local function startLoop()
	expandStart = os.clock()
	voidBeat = RunService.Heartbeat:Connect(function(dt)
		local k = math.clamp((os.clock() - expandStart) / EXPAND_TIME, 0, 1)
		k = 1 - (1 - k) ^ 3
		for _, s in ipairs(streams) do
			s.z += s.v * dt
			if s.z > 800 then s.z -= 1600 end
			local r = s.r * k
			s.p.CFrame = CFrame.new(CENTER + Vector3.new(math.cos(s.a) * r, math.sin(s.a) * r, s.z))
		end
	end)
end

local function enterVoid()
	busy = true
	setWindow(false)
	task.wait(0.35)

	fadeText(title, 0)
	task.wait(0.4)
	fadeText(sub, 0)
	task.wait(1.2)

	flash.BackgroundColor3 = Color3.new(1, 1, 1)
	tw(flash, 0.15, {BackgroundTransparency = 0})
	tw(blur, 0.2, {Size = 30})
	task.wait(0.2)
	flash.BackgroundColor3 = Color3.new(0, 0, 0)
	task.wait(0.4)

	if origSky then origSky.Parent = nil end
	voidSky.Parent = Lighting
	if atmosphere then atmosphere.Density = 0 end
	Lighting.ClockTime = 0
	Lighting.Brightness = 1
	Lighting.Ambient = Color3.fromRGB(45, 25, 85)
	Lighting.OutdoorAmbient = Color3.fromRGB(45, 25, 85)
	Lighting.FogEnd = 100000

	buildVoid()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then returnCF = hrp.CFrame end
	if char then char:PivotTo(CFrame.new(CENTER + Vector3.new(0, 5, 0))) end

	startLoop()
	shockwave(0.2, PINK)
	voidActive = true

	tw(flash, 1.5, {BackgroundTransparency = 1})
	tw(blur, 1.5, {Size = 0})
	fadeText(title, 1)
	fadeText(sub, 1)
	busy = false
end

local function exitVoid()
	busy = true
	setWindow(false)
	flash.BackgroundColor3 = Color3.new(1, 1, 1)
	tw(flash, 0.2, {BackgroundTransparency = 0})
	tw(blur, 0.2, {Size = 25})
	task.wait(0.3)

	if voidBeat then voidBeat:Disconnect() voidBeat = nil end
	if folder then folder:Destroy() folder = nil end
	voidSky.Parent = nil
	if origSky then origSky.Parent = Lighting end
	if atmosphere and atmoDensity then atmosphere.Density = atmoDensity end
	for k, v in pairs(saved) do Lighting[k] = v end
	camera.FieldOfView = fov
	if returnCF and player.Character then player.Character:PivotTo(returnCF) end
	voidActive = false

	tw(flash, 0.8, {BackgroundTransparency = 1})
	tw(blur, 0.8, {Size = 0})
	busy = false
end

-- ===== ОПРЕДЕЛЕНИЕ РОЛЕЙ И ESP =====
local function toolIn(container, set)
	if not container then return false end
	for _, c in ipairs(container:GetChildren()) do
		if c:IsA("Tool") and set[c.Name] then return true end
	end
	return false
end

local function getRole(plr)
	if not plr then return "innocent" end
	local char = plr.Character
	local attr = plr:GetAttribute("Role")
	if attr == nil and char then attr = char:GetAttribute("Role") end
	if typeof(attr) == "string" then
		local a = attr:lower()
		if a:find("murder") then return "murderer" end
		if a:find("sheriff") or a:find("hero") then return "sheriff" end
	end
	local bp = plr:FindFirstChildOfClass("Backpack")
	if toolIn(char, MURDER_TOOLS) or toolIn(bp, MURDER_TOOLS) then return "murderer" end
	if toolIn(char, SHERIFF_TOOLS) or toolIn(bp, SHERIFF_TOOLS) then return "sheriff" end
	return "innocent"
end

local function getPlayerByRole(targetRole)
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and getRole(p) == targetRole then
			return p
		end
	end
	return nil
end
-- ===== БОЕВАЯ ЛОГИКА (SHOOT, KILL ALL, FLING) =====

-- Функция автоматического выстрела
local function shootTarget(targetPlr)
	if not targetPlr or not targetPlr.Character then return end
	local targetHrp = targetPlr.Character:FindFirstChild("HumanoidRootPart") or targetPlr.Character:FindFirstChild("Head")
	if not targetHrp then return end

	local char = player.Character
	if not char then return end

	-- Ищем оружие в персонаже или инвентаре
	local gun = char:FindFirstChildOfClass("Tool")
	if not gun or not (SHERIFF_TOOLS[gun.Name] or MURDER_TOOLS[gun.Name]) then
		for _, t in ipairs(player.Backpack:GetChildren()) do
			if t:IsA("Tool") then
				t.Parent = char
				gun = t
				break
			end
		end
	end

	if gun then
		-- Попытка активировать через события
		local remote = gun:FindFirstChildOfClass("RemoteEvent") 
			or game:GetService("ReplicatedStorage"):FindFirstChild("ShootGun", true) 
			or game:GetService("ReplicatedStorage"):FindFirstChild("Shoot", true)

		if remote then
			remote:FireServer(targetHrp.Position, targetHrp.CFrame)
		end
		
		gun:Activate()
	end
end

-- Функция Kill All Innocents
local function killAllInnocents()
	if getRole(player) ~= "murderer" then return end
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local knife = char:FindFirstChildOfClass("Tool")
	if not knife then
		for _, t in ipairs(player.Backpack:GetChildren()) do
			if t:IsA("Tool") and MURDER_TOOLS[t.Name] then
				t.Parent = char
				knife = t
				break
			end
		end
	end

	local savedPos = char.HumanoidRootPart.CFrame
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and getRole(p) == "innocent" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
			task.wait(0.08)
			if knife then knife:Activate() end
			task.wait(0.12)
		end
	end
	char.HumanoidRootPart.CFrame = savedPos
end

-- Функция Fling Murderer
local function flingPlayer(targetPlr)
	if not targetPlr or not targetPlr.Character then return end
	local targetHrp = targetPlr.Character:FindFirstChild("HumanoidRootPart")
	local myChar = player.Character
	local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not targetHrp or not myHrp then return end

	local bvm = Instance.new("BodyVelocity")
	bvm.Velocity = Vector3.new(999999, 999999, 999999)
	bvm.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bvm.Parent = myHrp

	local bvr = Instance.new("BodyAngularVelocity")
	bvr.AngularVelocity = Vector3.new(999999, 999999, 999999)
	bvr.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bvr.Parent = myHrp

	local startCF = myHrp.CFrame
	local t0 = os.clock()
	while os.clock() - t0 < 1.2 and targetHrp and targetHrp.Parent do
		myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 0)
		myHrp.Velocity = Vector3.new(999999, 999999, 999999)
		RunService.Heartbeat:Wait()
	end

	bvm:Destroy()
	bvr:Destroy()
	myHrp.Velocity = Vector3.zero
	myHrp.RotVelocity = Vector3.zero
	myHrp.CFrame = startCF
end

-- ===== ПОДКЛЮЧЕНИЕ КНОПОК РАЗДЕЛА SHOOT =====

-- 1) Auto Shoot Murderer
createToggle(scrollShoot, "Auto Shoot Murderer", function(val)
	shootFlags.autoShootMurderer = val
	floatShootMurderer.Visible = val
end)

floatShootMurderer.MouseButton1Click:Connect(function()
	if getRole(player) == "sheriff" then
		local m = getPlayerByRole("murderer")
		if m then shootTarget(m) end
	end
end)

-- 2) Auto Shoot Sheriff
createToggle(scrollShoot, "Auto Shoot Sheriff", function(val)
	shootFlags.autoShootSheriff = val
	floatShootSheriff.Visible = val
end)

floatShootSheriff.MouseButton1Click:Connect(function()
	if getRole(player) == "murderer" then
		local s = getPlayerByRole("sheriff")
		if s then shootTarget(s) end
	end
end)

-- 3) Auto Shoot All Innocents
createToggle(scrollShoot, "Kill All Innocents", function(val)
	shootFlags.killAllInnocents = val
	floatKillInnocent.Visible = val
end)

floatKillInnocent.MouseButton1Click:Connect(function()
	if getRole(player) == "murderer" then
		killAllInnocents()
	end
end)

-- 4) Fling Murderer
createToggle(scrollShoot, "Fling Murderer", function(val)
	shootFlags.flingMurderer = val
	floatFlingMurderer.Visible = val
end)

floatFlingMurderer.MouseButton1Click:Connect(function()
	local m = getPlayerByRole("murderer")
	if m then flingPlayer(m) end
end)

-- ===== ЭЛЕМЕНТЫ ВКЛАДКИ VISUAL =====
createToggle(scrollVisual, "Бесконечность", function(val)
	if busy then return end
	infinity = val
	setBarrier(val)
	if val and not voidActive then
		enterVoid()
	elseif not val and voidActive then
		exitVoid()
	end
end)

createToggle(scrollVisual, "ESP Мардер", function(val) flags.murderer = val end)
createToggle(scrollVisual, "ESP Шериф", function(val) flags.sheriff = val end)
createToggle(scrollVisual, "ESP Мирный", function(val) flags.innocent = val end)

-- Инициализация
setWindow(false)
