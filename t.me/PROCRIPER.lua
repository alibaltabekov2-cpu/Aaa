-- LocalScript → StarterPlayer > StarterPlayerScripts
-- LIMITLESS: окно → Visual → Бесконечность → кнопка «Пустота»

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- НАСТРОЙКИ
local TOGGLE_KEY = Enum.KeyCode.N          -- открыть/закрыть окно на ПК
local SOUND_ID = ""                        -- rbxassetid://... если нужна музыка
local CENTER = Vector3.new(0, 3000, 0)     -- где строится пустота
local STREAM_COUNT, ORB_COUNT = 160, 60
local EXPAND_TIME = 2.8

local PURPLE = Color3.fromRGB(150, 80, 255)
local PINK = Color3.fromRGB(255, 60, 200)
local BLUE = Color3.fromRGB(80, 140, 255)
local TEXT_DIM = Color3.fromRGB(170, 160, 210)
local PALETTE = {
	PINK, PURPLE, BLUE,
	Color3.fromRGB(255, 70, 90),
	Color3.fromRGB(255, 255, 255),
}

local rng = Random.new()
local infinity, voidActive, busy, windowOpen = false, false, false, false
local folder, voidBeat, sound, returnCF, expandStart, barrier
local streams, orbs = {}, {}

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

-- Небо пустоты (только звёзды)
local voidSky = Instance.new("Sky")
voidSky.StarCount = 8000
voidSky.CelestialBodiesShown = false
for _, p in ipairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
	voidSky[p] = ""
end

-- Эффекты
local bloom = Instance.new("BloomEffect")
bloom.Intensity, bloom.Size, bloom.Threshold = 0, 48, 0.9
bloom.Parent = Lighting
local color = Instance.new("ColorCorrectionEffect")
color.Parent = Lighting
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- ===== Помощники =====
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
	btn.MouseButton1Down:Connect(function() tw(sc, 0.08, {Scale = 0.94}) end)
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

-- ===== ЭКРАННЫЕ ЭФФЕКТЫ (вспышка и надписи) =====
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

-- ===== ОКНО =====
local uiGui = new("ScreenGui", {
	Name = "LimitlessUI", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 200,
}, playerGui)

local window = new("CanvasGroup", {
	Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(410, 250), BackgroundColor3 = Color3.fromRGB(14, 10, 32),
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

-- шапка
local titleBar = new("Frame", {Size = UDim2.new(1, 0, 0, 48), BackgroundTransparency = 1}, window)

local logo = new("Frame", {
	Position = UDim2.fromOffset(14, 9), Size = UDim2.fromOffset(30, 30),
	BackgroundColor3 = Color3.new(1, 1, 1),
}, titleBar)
round(logo, 15)
new("UIGradient", {Color = ColorSequence.new(PURPLE, PINK), Rotation = 45}, logo)
new("TextLabel", {
	Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "∞",
	Font = Enum.Font.GothamBlack, TextSize = 20, TextColor3 = Color3.new(1, 1, 1),
}, logo)

new("TextLabel", {
	Position = UDim2.fromOffset(54, 7), Size = UDim2.fromOffset(200, 20), BackgroundTransparency = 1,
	Text = "LIMITLESS", Font = Enum.Font.GothamBlack, TextSize = 16,
	TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)
new("TextLabel", {
	Position = UDim2.fromOffset(54, 26), Size = UDim2.fromOffset(200, 14), BackgroundTransparency = 1,
	Text = "Visual Hub", Font = Enum.Font.Gotham, TextSize = 12,
	TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left,
}, titleBar)

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

-- боковое меню
local sidebar = new("Frame", {
	Position = UDim2.fromOffset(14, 60), Size = UDim2.fromOffset(108, 176),
	BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94,
}, window)
round(sidebar, 14)

local tab = new("TextButton", {
	Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 38),
	BackgroundColor3 = Color3.new(1, 1, 1), Text = "Visual", Font = Enum.Font.GothamBold,
	TextSize = 15, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
}, sidebar)
round(tab, 10)
new("UIPadding", {PaddingLeft = UDim.new(0, 28)}, tab)
new("UIGradient", {Color = ColorSequence.new(PURPLE, PINK)}, tab)
local dot = new("Frame", {
	Position = UDim2.new(0, -18, 0.5, -4), Size = UDim2.fromOffset(8, 8),
	BackgroundColor3 = Color3.new(1, 1, 1),
}, tab)
round(dot, 4)
pressFx(tab)

-- содержимое раздела Visual
local content = new("Frame", {
	Position = UDim2.fromOffset(134, 60), Size = UDim2.fromOffset(262, 176),
	BackgroundTransparency = 1,
}, window)
new("UIListLayout", {Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder}, content)

new("TextLabel", {
	LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1,
	Text = "Visual", Font = Enum.Font.GothamBlack, TextSize = 20,
	TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
}, content)

-- карточка «Бесконечность»
local infCard = new("Frame", {
	LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 64),
	BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94,
}, content)
round(infCard, 14)
outline(infCard, PURPLE, 1, 0.7)

new("TextLabel", {
	Position = UDim2.fromOffset(14, 11), Size = UDim2.new(1, -84, 0, 20), BackgroundTransparency = 1,
	Text = "Бесконечность", Font = Enum.Font.GothamBold, TextSize = 15,
	TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Left,
}, infCard)
local infSub = new("TextLabel", {
	Position = UDim2.fromOffset(14, 33), Size = UDim2.new(1, -84, 0, 16), BackgroundTransparency = 1,
	Text = "Барьер вокруг тебя", Font = Enum.Font.Gotham, TextSize = 12,
	TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Left,
}, infCard)

local sw = new("TextButton", {
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0),
	Size = UDim2.fromOffset(54, 28), BackgroundColor3 = Color3.fromRGB(60, 55, 90),
	Text = "", AutoButtonColor = false,
}, infCard)
round(sw, 14)
local knob = new("Frame", {
	Position = UDim2.new(0, 3, 0.5, -11), Size = UDim2.fromOffset(22, 22),
	BackgroundColor3 = Color3.new(1, 1, 1),
}, sw)
round(knob, 11)

-- кнопка «Пустота» (появляется, когда Бесконечность включена)
local voidWrap = new("Frame", {
	LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, ClipsDescendants = true,
}, content)

local voidBtn = new("TextButton", {
	Size = UDim2.new(1, 0, 0, 56), BackgroundColor3 = Color3.new(1, 1, 1),
	Text = "Пустота", Font = Enum.Font.GothamBlack, TextSize = 21,
	TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false,
}, voidWrap)
round(voidBtn, 14)
outline(voidBtn, Color3.new(1, 1, 1), 1.5, 0.6)
local voidGrad = new("UIGradient", {Color = ColorSequence.new(PINK, PURPLE)}, voidBtn)
pressFx(voidBtn)

-- кнопка-значок, открывает окно (перетаскивается)
local launcher = new("TextButton", {
	Position = UDim2.new(0, 14, 0.35, 0), Size = UDim2.fromOffset(56, 56),
	BackgroundColor3 = Color3.fromRGB(16, 10, 38), Text = "∞", Font = Enum.Font.GothamBlack,
	TextSize = 30, TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false,
}, uiGui)
round(launcher, 28)
local lStroke = outline(launcher, Color3.new(1, 1, 1), 2.5)
local lGrad = new("UIGradient", {Color = rainbow()}, lStroke)
pressFx(launcher)

local launcherDrag = makeDraggable(launcher, launcher)
makeDraggable(titleBar, window)

-- ===== Окно: открыть / закрыть =====
local function fit()
	local vp = camera.ViewportSize
	return math.clamp(math.min(vp.X / 460, vp.Y / 300), 0.55, 1.15)
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

-- ===== Барьер «Бесконечность» вокруг игрока =====
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

-- постоянный цикл интерфейса (вращение рамок, барьер)
RunService.Heartbeat:Connect(function(dt)
	rimGrad.Rotation = (rimGrad.Rotation + dt * 70) % 360
	lGrad.Rotation = (lGrad.Rotation + dt * 90) % 360
	voidGrad.Rotation = (voidGrad.Rotation + dt * 40) % 360
	if barrier then
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local t = os.clock()
			barrier.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, t * 0.6, t * 0.3)
		end
	end
end)

-- ===== Создание пустоты =====
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
		r.Transparency = 0.1
		tw(r, 2.6, {Size = Vector3.new(0.6, 1400, 1400), Transparency = 1}, Enum.EasingStyle.Quad)
		task.delay(2.7, function() r:Destroy() end)
	end)
end

local function buildVoid()
	folder = Instance.new("Folder")
	folder.Name = "InfiniteVoid"
	folder.Parent = workspace

	-- светящаяся платформа под ногами
	local plat = part(Vector3.new(1, 44, 44),
		CFrame.new(CENTER) * CFrame.Angles(0, 0, math.rad(90)),
		PURPLE, Enum.Material.ForceField, Enum.PartType.Cylinder)
	plat.CanCollide = true
	new("PointLight", {Color = PINK, Range = 60, Brightness = 3}, plat)
	local edge = part(Vector3.new(1.2, 46, 46),
		CFrame.new(CENTER + Vector3.new(0, -0.6, 0)) * CFrame.Angles(0, 0, math.rad(90)),
		PINK, Enum.Material.Neon, Enum.PartType.Cylinder)
	edge.Transparency = 0.3

	-- мерцающие звёздные искры
	local dust = part(Vector3.new(1600, 1200, 1600), CFrame.new(CENTER),
		Color3.new(1, 1, 1), Enum.Material.SmoothPlastic)
	dust.Transparency = 1
	new("ParticleEmitter", {
		Rate = 120, Lifetime = NumberRange.new(6, 10), Speed = NumberRange.new(0, 3),
		Size = NumberSequence.new(4), LightEmission = 1, LightInfluence = 0,
		RotSpeed = NumberRange.new(-30, 30),
		Color = ColorSequence.new(Color3.fromRGB(255, 170, 255), Color3.fromRGB(150, 170, 255)),
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.2),
			NumberSequenceKeypoint.new(0.8, 0.2), NumberSequenceKeypoint.new(1, 1),
		}),
	}, dust)

	-- потоки света
	streams = {}
	for i = 1, STREAM_COUNT do
		local w = rng:NextNumber(0.2, 0.9)
		local s = part(Vector3.new(w, w, rng:NextNumber(30, 220)), CFrame.new(CENTER),
			PALETTE[rng:NextInteger(1, #PALETTE)], Enum.Material.Neon)
		s.Transparency = rng:NextNumber(0, 0.4)
		streams[i] = {
			p = s, a = rng:NextNumber(0, math.pi * 2), r = rng:NextNumber(10, 260),
			z = rng:NextNumber(-800, 800), v = rng:NextNumber(250, 900),
		}
	end

	-- пузыри
	orbs = {}
	for i = 1, ORB_COUNT do
		local d = rng:NextNumber(10, 60)
		local dir = Vector3.new(rng:NextNumber(-1, 1), rng:NextNumber(-0.6, 0.6), rng:NextNumber(-1, 1)).Unit
		local pos = CENTER + dir * rng:NextNumber(60, 500)
		local o = part(Vector3.new(d, d, d), CFrame.new(pos), Color3.fromRGB(200, 220, 255),
			Enum.Material.Glass, Enum.PartType.Ball)
		o.Transparency = rng:NextNumber(0.5, 0.8)
		orbs[i] = {p = o, base = pos, ph = rng:NextNumber(0, 6.28), sp = rng:NextNumber(0.2, 0.8)}
	end

	-- огромные светящиеся планеты вдали
	for i = 1, 3 do
		local dir = Vector3.new(math.cos(i * 2.1), rng:NextNumber(-0.2, 0.4), math.sin(i * 2.1)).Unit
		local g = part(Vector3.new(700, 700, 700), CFrame.new(CENTER + dir * 1800),
			PALETTE[i], Enum.Material.Neon, Enum.PartType.Ball)
		g.Transparency = 0.35
	end
end

local function startLoop()
	expandStart = os.clock()
	voidBeat = RunService.Heartbeat:Connect(function(dt)
		local k = math.clamp((os.clock() - expandStart) / EXPAND_TIME, 0, 1)
		k = 1 - (1 - k) ^ 3 -- территория плавно раскрывается
		for _, s in ipairs(streams) do
			s.z += s.v * dt
			if s.z > 800 then s.z -= 1600 end
			local r = s.r * k
			s.p.CFrame = CFrame.new(CENTER + Vector3.new(math.cos(s.a) * r, math.sin(s.a) * r, s.z))
		end
		local t = os.clock()
		for _, o in ipairs(orbs) do
			local bob = Vector3.new(0, math.sin(t * o.sp + o.ph) * 8, 0)
			o.p.CFrame = CFrame.new(CENTER + (o.base - CENTER) * k + bob)
		end
	end)
end

local function teleport(cf)
	local char = player.Character
	if char then char:PivotTo(cf) end
end

local function refreshVoidButton()
	voidBtn.Text = voidActive and "Выйти из пустоты" or "Пустота"
	voidBtn.TextSize = voidActive and 17 or 21
end

-- ===== ВХОД В ПУСТОТУ =====
local function enterVoid()
	busy = true
	setWindow(false)
	task.wait(0.35)

	fadeText(title, 0)
	task.wait(0.4)
	fadeText(sub, 0)
	task.wait(1.2)

	-- вспышка → чёрный экран
	flash.BackgroundColor3 = Color3.new(1, 1, 1)
	tw(flash, 0.15, {BackgroundTransparency = 0})
	tw(blur, 0.2, {Size = 30})
	task.wait(0.2)
	flash.BackgroundColor3 = Color3.new(0, 0, 0)
	task.wait(0.4)

	-- мир превращается в пустоту
	if origSky then origSky.Parent = nil end
	voidSky.Parent = Lighting
	if atmosphere then atmosphere.Density = 0 end
	Lighting.ClockTime = 0
	Lighting.Brightness = 1
	Lighting.Ambient = Color3.fromRGB(60, 30, 110)
	Lighting.OutdoorAmbient = Color3.fromRGB(60, 30, 110)
	Lighting.FogEnd = 100000
	color.TintColor = Color3.fromRGB(235, 215, 255)
	color.Saturation, color.Contrast = 0.5, 0.2
	tw(bloom, 2, {Intensity = 1.2})

	buildVoid()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then returnCF = hrp.CFrame end
	teleport(CFrame.new(CENTER + Vector3.new(0, 5, 0)))

	if SOUND_ID ~= "" then
		sound = Instance.new("Sound")
		sound.SoundId = SOUND_ID
		sound.Looped = true
		sound.Parent = SoundService
		sound:Play()
	end

	tw(camera, 2.5, {FieldOfView = 95})
	startLoop()
	shockwave(0.2, PINK)
	shockwave(0.7, PURPLE)
	shockwave(1.2, BLUE)
	voidActive = true

	-- открываем экран
	tw(flash, 1.5, {BackgroundTransparency = 1})
	tw(blur, 1.5, {Size = 0})
	fadeText(title, 1)
	fadeText(sub, 1)

	-- тряска камеры
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local t0 = os.clock()
	while hum and os.clock() - t0 < 0.8 do
		hum.CameraOffset = Vector3.new(rng:NextNumber(-0.4, 0.4), rng:NextNumber(-0.4, 0.4), 0)
		task.wait()
	end
	if hum then hum.CameraOffset = Vector3.zero end
	busy = false
end

-- ===== ВЫХОД ИЗ ПУСТОТЫ =====
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
	bloom.Intensity = 0
	color.TintColor = Color3.new(1, 1, 1)
	color.Saturation, color.Contrast = 0, 0
	camera.FieldOfView = fov
	if sound then sound:Destroy() sound = nil end
	if returnCF then teleport(returnCF) end
	voidActive = false

	tw(flash, 0.8, {BackgroundTransparency = 1})
	tw(blur, 0.8, {Size = 0})
	busy = false
end

-- ===== Переключатель «Бесконечность» =====
local function setInfinity(on)
	infinity = on
	tw(sw, 0.25, {BackgroundColor3 = on and PURPLE or Color3.fromRGB(60, 55, 90)})
	tw(knob, 0.25, {Position = on and UDim2.new(1, -25, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)},
		Enum.EasingStyle.Back)
	infSub.Text = on and "Барьер включён" or "Барьер вокруг тебя"
	setBarrier(on)

	if on then
		tw(voidWrap, 0.4, {Size = UDim2.new(1, 0, 0, 56)}, Enum.EasingStyle.Back)
	else
		tw(voidWrap, 0.25, {Size = UDim2.new(1, 0, 0, 0)})
		if voidActive then
			task.spawn(function()
				while busy do task.wait() end
				if voidActive then exitVoid() end
				refreshVoidButton()
			end)
		end
	end
end

sw.Activated:Connect(function()
	if busy then return end
	setInfinity(not infinity)
end)

voidBtn.Activated:Connect(function()
	if busy or not infinity then return end
	task.spawn(function()
		if voidActive then exitVoid() else enterVoid() end
		refreshVoidButton()
	end)
end)

-- открыть / закрыть окно
launcher.Activated:Connect(function()
	if not launcherDrag.moved then setWindow(not windowOpen) end
end)
closeBtn.Activated:Connect(function() setWindow(false) end)

UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == TOGGLE_KEY then
		setWindow(not windowOpen)
	end
end)

-- Если умер внутри пустоты, возвращаем обратно
player.CharacterAdded:Connect(function(char)
	if voidActive then
		task.wait(0.5)
		char:PivotTo(CFrame.new(CENTER + Vector3.new(0, 5, 0)))
	end
end)
