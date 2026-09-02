
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--============================================================
-- CONFIG
--============================================================

local CONFIG = {
	Name = "Nova Hub",
	Version = "1.0",
	LoadingTime = 5,

	Accent = Color3.fromRGB(120, 70, 255),

	Background = Color3.fromRGB(20, 12, 24),
	Panel = Color3.fromRGB(32, 20, 38),
	Panel2 = Color3.fromRGB(42, 27, 49),

	Text = Color3.fromRGB(245, 245, 250),
	SubText = Color3.fromRGB(170, 160, 175),

	Transparency = 0.08,
	Scale = 1,
}

-- Session settings
local Settings = {
	RGBMode = false,
	FollowVisualColor = true,
	ShowFPS = true,
	Notifications = true,
	LowGraphics = false,
	MenuBlur = false,
	CompactMode = false,
}

--============================================================
-- HELPERS
--============================================================

local function Tween(object, properties, duration, style, direction)
	local info = TweenInfo.new(
		duration or 0.25,
		style or Enum.EasingStyle.Quint,
		direction or Enum.EasingDirection.Out
	)

	local tween = TweenService:Create(object, info, properties)
	tween:Play()

	return tween
end

local function Create(className, properties, parent)
	local object = Instance.new(className)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	object.Parent = parent

	return object
end

local function Corner(parent, radius)
	local corner = Create("UICorner", {
		CornerRadius = UDim.new(0, radius or 10)
	}, parent)

	return corner
end

local function Stroke(parent, color, transparency)
	local stroke = Create("UIStroke", {
		Color = color or Color3.new(1, 1, 1),
		Transparency = transparency or 0.8,
		Thickness = 1
	}, parent)

	return stroke
end

local function Gradient(parent, color1, color2, rotation)
	local gradient = Create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, color1),
			ColorSequenceKeypoint.new(1, color2)
		}),
		Rotation = rotation or 0
	}, parent)

	return gradient
end

local function Darken(color, amount)
	return Color3.new(
		math.clamp(color.R - amount, 0, 1),
		math.clamp(color.G - amount, 0, 1),
		math.clamp(color.B - amount, 0, 1)
	)
end

local function Lighten(color, amount)
	return Color3.new(
		math.clamp(color.R + amount, 0, 1),
		math.clamp(color.G + amount, 0, 1),
		math.clamp(color.B + amount, 0, 1)
	)
end

--============================================================
-- GUI ROOT
--============================================================

local ScreenGui = Create("ScreenGui", {
	Name = "NovaHub",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = true,
}, PlayerGui)

--============================================================
-- LOADING SCREEN
--============================================================

local Loading = Create("Frame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.fromRGB(10, 7, 12),
	BackgroundTransparency = 0,
	ZIndex = 100,
}, ScreenGui)

local LoadingGradient = Gradient(
	Loading,
	Color3.fromRGB(25, 10, 40),
	Color3.fromRGB(8, 20, 35),
	45
)

local LoadingTitle = Create("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.42),
	Size = UDim2.fromOffset(500, 60),
	BackgroundTransparency = 1,
	Text = "NOVA HUB",
	TextColor3 = CONFIG.Text,
	TextSize = 38,
	Font = Enum.Font.GothamBold,
	ZIndex = 101,
}, Loading)

local LoadingSub = Create("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.49),
	Size = UDim2.fromOffset(500, 30),
	BackgroundTransparency = 1,
	Text = "Инициализация интерфейса...",
	TextColor3 = CONFIG.SubText,
	TextSize = 15,
	Font = Enum.Font.Gotham,
	ZIndex = 101,
}, Loading)

local BarBackground = Create("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.57),
	Size = UDim2.fromOffset(360, 7),
	BackgroundColor3 = Color3.fromRGB(45, 35, 50),
	ZIndex = 101,
}, Loading)

Corner(BarBackground, 5)

local Bar = Create("Frame", {
	Size = UDim2.new(0, 0, 1, 0),
	BackgroundColor3 = CONFIG.Accent,
	ZIndex = 102,
}, BarBackground)

Corner(Bar, 5)

local BarGradient = Gradient(
	Bar,
	Color3.fromRGB(90, 255, 170),
	CONFIG.Accent,
	0
)

local LoadingStatus = Create("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.62),
	Size = UDim2.fromOffset(400, 25),
	BackgroundTransparency = 1,
	Text = "0%",
	TextColor3 = CONFIG.SubText,
	TextSize = 13,
	Font = Enum.Font.GothamMedium,
	ZIndex = 101,
}, Loading)

--============================================================
-- MAIN WINDOW
--============================================================

local Main = Create("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(900, 570),
	BackgroundColor3 = CONFIG.Background,
	BackgroundTransparency = CONFIG.Transparency,
	Visible = false,
}, ScreenGui)

Corner(Main, 18)
Stroke(Main, CONFIG.Accent, 0.7)

-- Scale
local UIScale = Create("UIScale", {
	Scale = CONFIG.Scale
}, Main)

--============================================================
-- TOP BAR
--============================================================

local TopBar = Create("Frame", {
	Size = UDim2.new(1, 0, 0, 70),
	BackgroundTransparency = 1,
}, Main)

local Logo = Create("Frame", {
	Position = UDim2.fromOffset(18, 14),
	Size = UDim2.fromOffset(42, 42),
	BackgroundColor3 = CONFIG.Accent,
}, TopBar)

Corner(12, Logo)
Gradient(Logo, Lighten(CONFIG.Accent, 0.12), Darken(CONFIG.Accent, 0.1), 45)

local LogoText = Create("TextLabel", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Text = "N",
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 23,
	Font = Enum.Font.GothamBold,
}, Logo)

local Title = Create("TextLabel", {
	Position = UDim2.fromOffset(75, 12),
	Size = UDim2.fromOffset(300, 28),
	BackgroundTransparency = 1,
	Text = CONFIG.Name,
	TextColor3 = CONFIG.Text,
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamBold,
}, TopBar)

local Version = Create("TextLabel", {
	Position = UDim2.fromOffset(75, 38),
	Size = UDim2.fromOffset(200, 20),
	BackgroundTransparency = 1,
	Text = "by Nova • Версия " .. CONFIG.Version,
	TextColor3 = CONFIG.SubText,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.Gotham,
}, TopBar)

-- Top buttons
local Minimize = Create("TextButton", {
	Position = UDim2.new(1, -125, 0, 20),
	Size = UDim2.fromOffset(36, 30),
	BackgroundColor3 = CONFIG.Panel,
	Text = "—",
	TextColor3 = CONFIG.SubText,
	TextSize = 18,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
}, TopBar)

Corner(Minimize, 8)

local Close = Create("TextButton", {
	Position = UDim2.new(1, -78, 0, 20),
	Size = UDim2.fromOffset(36, 30),
	BackgroundColor3 = CONFIG.Panel,
	Text = "×",
	TextColor3 = CONFIG.SubText,
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	AutoButtonColor = false,
}, TopBar)

Corner(Close, 8)

--============================================================
-- SIDEBAR
--============================================================

local Sidebar = Create("Frame", {
	Position = UDim2.fromOffset(12, 75),
	Size = UDim2.new(0, 205, 1, -87),
	BackgroundColor3 = CONFIG.Panel,
	BackgroundTransparency = 0.05,
}, Main)

Corner(Sidebar, 14)

local SidebarPadding = Create("UIPadding", {
	PaddingTop = UDim.new(0, 12),
	PaddingBottom = UDim.new(0, 12),
	PaddingLeft = UDim.new(0, 10),
	PaddingRight = UDim.new(0, 10),
}, Sidebar)

local SidebarLayout = Create("UIListLayout", {
	Padding = UDim.new(0, 6),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, Sidebar)

--============================================================
-- CONTENT
--============================================================

local Content = Create("Frame", {
	Position = UDim2.fromOffset(228, 75),
	Size = UDim2.new(1, -240, 1, -87),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
}, Main)

--============================================================
-- PAGES
--============================================================

local Pages = {}

local function CreatePage(name)
	local page = Create("ScrollingFrame", {
		Name = name,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = CONFIG.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
	}, Content)

	Create("UIPadding", {
		PaddingLeft = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
	}, page)

	Create("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, page)

	Pages[name] = page

	return page
end

--============================================================
-- UI COMPONENTS
--============================================================

local function Section(parent, text)
	local label = Create("TextLabel", {
		Size = UDim2.new(1, -5, 0, 28),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = CONFIG.Text,
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBold,
	}, parent)

	return label
end

local function Button(parent, text, callback)
	local button = Create("TextButton", {
		Size = UDim2.new(1, -5, 0, 52),
		BackgroundColor3 = CONFIG.Panel2,
		Text = "",
		AutoButtonColor = false,
	}, parent)

	Corner(button, 11)

	local label = Create("TextLabel", {
		Position = UDim2.fromOffset(16, 0),
		Size = UDim2.new(1, -32, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = CONFIG.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamMedium,
	}, button)

	button.MouseEnter:Connect(function()
		Tween(button, {
			BackgroundColor3 = Lighten(CONFIG.Panel2, 0.05)
		}, 0.15)
	end)

	button.MouseLeave:Connect(function()
		Tween(button, {
			BackgroundColor3 = CONFIG.Panel2
		}, 0.15)
	end)

	button.Activated:Connect(function()
		if callback then
			callback()
		end
	end)

	return button
end

local function Toggle(parent, text, default, callback)
	local holder = Create("Frame", {
		Size = UDim2.new(1, -5, 0, 58),
		BackgroundColor3 = CONFIG.Panel2,
	}, parent)

	Corner(holder, 11)

	local label = Create("TextLabel", {
		Position = UDim2.fromOffset(16, 0),
		Size = UDim2.new(1, -90, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = CONFIG.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamMedium,
	}, holder)

	local switch = Create("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(48, 25),
		BackgroundColor3 = Color3.fromRGB(65, 58, 70),
		Text = "",
		AutoButtonColor = false,
	}, holder)

	Corner(switch, 13)

	local knob = Create("Frame", {
		Position = UDim2.fromOffset(4, 4),
		Size = UDim2.fromOffset(17, 17),
		BackgroundColor3 = Color3.fromRGB(235, 235, 240),
	}, switch)

	Corner(knob, 50)

	local state = default == true

	local function Update()
		if state then
			Tween(switch, {
				BackgroundColor3 = CONFIG.Accent
			}, 0.2)

			Tween(knob, {
				Position = UDim2.new(1, -21, 0, 4)
			}, 0.2)
		else
			Tween(switch, {
				BackgroundColor3 = Color3.fromRGB(65, 58, 70)
			}, 0.2)

			Tween(knob, {
				Position = UDim2.fromOffset(4, 4)
			}, 0.2)
		end
	end

	Update()

	switch.Activated:Connect(function()
		state = not state
		Update()

		if callback then
			callback(state)
		end
	end)

	return holder, function()
		return state
	end
end

local function Slider(parent, text, min, max, default, callback)
	local holder = Create("Frame", {
		Size = UDim2.new(1, -5, 0, 72),
		BackgroundColor3 = CONFIG.Panel2,
	}, parent)

	Corner(holder, 11)

	local label = Create("TextLabel", {
		Position = UDim2.fromOffset(16, 8),
		Size = UDim2.new(1, -90, 0, 22),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = CONFIG.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamMedium,
	}, holder)

	local valueLabel = Create("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -16, 0, 8),
		Size = UDim2.fromOffset(60, 22),
		BackgroundTransparency = 1,
		Text = tostring(default),
		TextColor3 = CONFIG.Accent,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Right,
		Font = Enum.Font.GothamBold,
	}, holder)

	local bar = Create("Frame", {
		Position = UDim2.new(0, 16, 0, 43),
		Size = UDim2.new(1, -32, 0, 6),
		BackgroundColor3 = Color3.fromRGB(65, 55, 70),
	}, holder)

	Corner(bar, 5)

	local fill = Create("Frame", {
		Size = UDim2.new(
			(default - min) / (max - min),
			0,
			1,
			0
		),
		BackgroundColor3 = CONFIG.Accent,
	}, bar)

	Corner(fill, 5)

	local dragging = false

	local function SetFromX(x)
		local percentage = math.clamp(
			(x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
			0,
			1
		)

		local value = min + ((max - min) * percentage)

		Tween(fill, {
			Size = UDim2.new(percentage, 0, 1, 0)
		}, 0.08)

		valueLabel.Text = string.format("%.0f", value)

		if callback then
			callback(value)
		end
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			SetFromX(input.Position.X)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging then
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then

				SetFromX(input.Position.X)
			end
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = false
		end
	end)

	return holder
end

--============================================================
-- COLOR SYSTEM
--============================================================

local VisualColor = CONFIG.Accent

local function ApplyAccent(color)
	VisualColor = color

	CONFIG.Accent = color

	-- Logo
	Tween(Logo, {
		BackgroundColor3 = color
	}, 0.25)

	-- Stroke
	for _, object in ipairs(Main:GetDescendants()) do
		if object:IsA("UIStroke") then
			Tween(object, {
				Color = color
			}, 0.25)
		end
	end

	-- Buttons / accents
	for _, object in ipairs(Main:GetDescendants()) do
		if object:IsA("Frame") and object.Name == "AccentObject" then
			Tween(object, {
				BackgroundColor3 = color
			}, 0.25)
		end

		if object:IsA("TextLabel") and object.Name == "AccentText" then
			Tween(object, {
				TextColor3 = color
			}, 0.25)
		end
	end
end

--============================================================
-- CREATE PAGES
--============================================================

local CharacterPage = CreatePage("Персонаж")
local VisualPage = CreatePage("Визуал")
local EmotePage = CreatePage("Эмоции")
local OtherPage = CreatePage("Другое")
local SettingsPage = CreatePage("Настройки")
local InfoPage = CreatePage("Инфо")

--============================================================
-- CHARACTER
--============================================================

Section(CharacterPage, "Персонаж")

Toggle(CharacterPage, "Показывать информацию о персонаже", true, function(value)
	print("Character info:", value)
end)

Toggle(CharacterPage, "Автоматически обновлять интерфейс", true, function(value)
	print("Auto update:", value)
end)

Slider(CharacterPage, "Размер интерфейса", 70, 130, 100, function(value)
	UIScale.Scale = value / 100
end)

Button(CharacterPage, "Сбросить размер интерфейса", function()
	Tween(UIScale, {
		Scale = 1
	}, 0.25)
end)

--============================================================
-- VISUALS
--============================================================

Section(VisualPage, "Цвет визуалов")

local ColorHolder = Create("Frame", {
	Size = UDim2.new(1, -5, 0, 145),
	BackgroundColor3 = CONFIG.Panel2,
}, VisualPage)

Corner(ColorHolder, 12)

local ColorTitle = Create("TextLabel", {
	Position = UDim2.fromOffset(16, 12),
	Size = UDim2.new(1, -32, 0, 25),
	BackgroundTransparency = 1,
	Text = "Основной цвет",
	TextColor3 = CONFIG.Text,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamBold,
}, ColorHolder)

local ColorPreview = Create("Frame", {
	Position = UDim2.fromOffset(16, 48),
	Size = UDim2.fromOffset(50, 50),
	BackgroundColor3 = VisualColor,
}, ColorHolder)

Corner(ColorPreview, 10)

local ColorName = Create("TextLabel", {
	Position = UDim2.fromOffset(80, 52),
	Size = UDim2.new(1, -100, 0, 22),
	BackgroundTransparency = 1,
	Text = "Фиолетовый",
	TextColor3 = CONFIG.Text,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	Font = Enum.Font.GothamMedium,
}, ColorHolder)

local colorButtons = {
	{"Фиолетовый", Color3.fromRGB(125, 70, 255)},
	{"Красный", Color3.fromRGB(255, 70, 90)},
	{"Синий", Color3.fromRGB(55, 145, 255)},
	{"Зелёный", Color3.fromRGB(55, 225, 135)},
	{"Жёлтый", Color3.fromRGB(255, 195, 55)},
	{"Розовый", Color3.fromRGB(255, 75, 190)},
}

for index, data in ipairs(colorButtons) do
	local name = data[1]
	local color = data[2]

	local x = ((index - 1) % 3)
	local y = math.floor((index - 1) / 3)

	local button = Create("TextButton", {
		Position = UDim2.fromOffset(280 + x * 105, 42 + y * 43),
		Size = UDim2.fromOffset(95, 34),
		BackgroundColor3 = color,
		Text = name,
		TextColor3 = Color3.new(1, 1, 1),
		TextSize = 11,
		Font = Enum.Font.GothamBold,
		AutoButtonColor = false,
	}, ColorHolder)

	Corner(button, 8)

	button.Activated:Connect(function()
		VisualColor = color
		ColorPreview.BackgroundColor3 = color
		ColorName.Text = name

		if Settings.FollowVisualColor then
			ApplyAccent(color)
		end
	end)
end

Toggle(VisualPage, "Связать тему с цветом визуалов", true, function(value)
	Settings.FollowVisualColor = value

	if value then
		ApplyAccent(VisualColor)
	end
end)

Toggle(VisualPage, "RGB-переливание темы", false, function(value)
	Settings.RGBMode = value
end)

Toggle(VisualPage, "Показывать FPS", true, function(value)
	Settings.ShowFPS = value
end)

--============================================================
-- EMOTES
--============================================================

Section(EmotePage, "Эмоции")

Button(EmotePage, "Wave", function()
	local character = Player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")

		if animator then
			-- Здесь можно подключить AnimationId
			print("Wave")
		end
	end
end)

Button(EmotePage, "Dance", function()
	print("Dance")
end)

Button(EmotePage, "Laugh", function()
	print("Laugh")
end)

Button(EmotePage, "Stop Emote", function()
	local character = Player.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid then
			for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
				track:Stop()
			end
		end
	end
end)

--============================================================
-- OTHER
--============================================================

Section(OtherPage, "Утилиты")

Toggle(OtherPage, "Упрощённая графика", false, function(value)
	Settings.LowGraphics = value

	if value then
		Lighting.GlobalShadows = false
		Lighting.EnvironmentDiffuseScale = 0
		Lighting.EnvironmentSpecularScale = 0
	else
		Lighting.GlobalShadows = true
		Lighting.EnvironmentDiffuseScale = 1
		Lighting.EnvironmentSpecularScale = 1
	end
end)

Toggle(OtherPage, "Размытие меню", false, function(value)
	Settings.MenuBlur = value

	if value then
		local blur = Lighting:FindFirstChild("NovaMenuBlur")

		if not blur then
			blur = Instance.new("BlurEffect")
			blur.Name = "NovaMenuBlur"
			blur.Size = 8
			blur.Parent = Lighting
		end
	else
		local blur = Lighting:FindFirstChild("NovaMenuBlur")

		if blur then
			blur:Destroy()
		end
	end
end)

Toggle(OtherPage, "Компактный режим", false, function(value)
	Settings.CompactMode = value

	if value then
		Tween(Main, {
			Size = UDim2.fromOffset(760, 500)
		}, 0.3)
	else
		Tween(Main, {
			Size = UDim2.fromOffset(900, 570)
		}, 0.3)
	end
end)

Button(OtherPage, "Показать уведомление", function()
	print("Nova Hub работает!")
end)

--============================================================
-- SETTINGS
--============================================================

Section(SettingsPage, "Настройки интерфейса")

Toggle(SettingsPage, "Показывать уведомления", true, function(value)
	Settings.Notifications = value
end)

Slider(SettingsPage, "Прозрачность", 0, 40, 8, function(value)
	CONFIG.Transparency = value / 100

	Main.BackgroundTransparency = CONFIG.Transparency
end)

Toggle(SettingsPage, "Следовать цвету визуалов", true, function(value)
	Settings.FollowVisualColor = value

	if value then
		ApplyAccent(VisualColor)
	end
end)

Button(SettingsPage, "Фиолетовая тема", function()
	Settings.RGBMode = false
	ApplyAccent(Color3.fromRGB(125, 70, 255))
	ColorPreview.BackgroundColor3 = CONFIG.Accent
	ColorName.Text = "Фиолетовый"
end)

Button(SettingsPage, "Синяя тема", function()
	Settings.RGBMode = false
	ApplyAccent(Color3.fromRGB(55, 145, 255))
	ColorPreview.BackgroundColor3 = CONFIG.Accent
	ColorName.Text = "Синий"
end)

Button(SettingsPage, "Зелёная тема", function()
	Settings.RGBMode = false
	ApplyAccent(Color3.fromRGB(55, 225, 135))
	ColorPreview.BackgroundColor3 = CONFIG.Accent
	ColorName.Text = "Зелёный"
end)

Button(SettingsPage, "RGB Mode", function()
	Settings.RGBMode = not Settings.RGBMode
end)

Button(SettingsPage, "Сбросить настройки", function()
	Settings.RGBMode = false
	Settings.FollowVisualColor = true
	Settings.ShowFPS = true
	Settings.Notifications = true
	Settings.LowGraphics = false
	Settings.MenuBlur = false
	Settings.CompactMode = false

	UIScale.Scale = 1
	Main.Size = UDim2.fromOffset(900, 570)

	ApplyAccent(Color3.fromRGB(125, 70, 255))

	ColorPreview.BackgroundColor3 = CONFIG.Accent
	ColorName.Text = "Фиолетовый"
end)

--============================================================
-- INFO
--============================================================

Section(InfoPage, "Nova Hub")

local Info = Create("Frame", {
	Size = UDim2.new(1, -5, 0, 190),
	BackgroundColor3 = CONFIG.Panel2,
}, InfoPage)

Corner(Info, 12)

local InfoText = Create("TextLabel", {
	Position = UDim2.fromOffset(18, 15),
	Size = UDim2.new(1, -36, 1, -30),
	BackgroundTransparency = 1,

	Text =
		"Nova Hub\n\n" ..
		"Версия: " .. CONFIG.Version .. "\n" ..
		"Интерфейс: Dynamic UI\n" ..
		"Theme Engine: Enabled\n" ..
		"RGB Engine: Enabled\n\n" ..
		"Этот интерфейс предназначен для использования\n" ..
		"в собственном Roblox-проекте.",

	TextColor3 = CONFIG.SubText,
	TextSize = 14,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	Font = Enum.Font.Gotham,
}, Info)

--============================================================
-- SIDEBAR TABS
--============================================================

local Tabs = {
	{"Персонаж", "♙", CharacterPage},
	{"Визуал", "◉", VisualPage},
	{"Эмоции", "☺", EmotePage},
	{"Другое", "⚙", OtherPage},
	{"Настройки", "☼", SettingsPage},
	{"Инфо", "ⓘ", InfoPage},
}

local TabButtons = {}

local function SelectTab(index)
	for i, data in ipairs(Tabs) do
		local button = TabButtons[i]

		if button then
			if i == index then
				Tween(button, {
					BackgroundColor3 = CONFIG.Accent
				}, 0.2)
			else
				Tween(button, {
					BackgroundColor3 = CONFIG.Panel
				}, 0.2)
			end
		end

		data[3].Visible = (i == index)
	end
end

for index, data in ipairs(Tabs) do
	local button = Create("TextButton", {
		Size = UDim2.new(1, 0, 0, 45),
		BackgroundColor3 = CONFIG.Panel,
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = index,
	}, Sidebar)

	Corner(button, 9)

	local icon = Create("TextLabel", {
		Position = UDim2.fromOffset(13, 0),
		Size = UDim2.fromOffset(30, 45),
		BackgroundTransparency = 1,
		Text = data[2],
		TextColor3 = CONFIG.SubText,
		TextSize = 17,
		Font = Enum.Font.Gotham,
	}, button)

	local text = Create("TextLabel", {
		Position = UDim2.fromOffset(48, 0),
		Size = UDim2.new(1, -55, 1, 0),
		BackgroundTransparency = 1,
		Text = data[1],
		TextColor3 = CONFIG.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamMedium,
	}, button)

	button.MouseEnter:Connect(function()
		if data[3].Visible == false then
			Tween(button, {
				BackgroundColor3 = CONFIG.Panel2
			}, 0.15)
		end
	end)

	button.MouseLeave:Connect(function()
		if data[3].Visible == false then
			Tween(button, {
				BackgroundColor3 = CONFIG.Panel
			}, 0.15)
		end
	end)

	button.Activated:Connect(function()
		SelectTab(index)
	end)

	TabButtons[index] = button
end

SelectTab(1)

--============================================================
-- FPS COUNTER
--============================================================

local FPS = Create("TextLabel", {
	AnchorPoint = Vector2.new(1, 1),
	Position = UDim2.new(1, -20, 1, -15),
	Size = UDim2.fromOffset(100, 25),
	BackgroundTransparency = 1,
	Text = "FPS: --",
	TextColor3 = CONFIG.Accent,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Right,
	Font = Enum.Font.GothamBold,
	ZIndex = 10,
}, ScreenGui)

--============================================================
-- NOTIFICATION
--============================================================

local NotificationContainer = Create("Frame", {
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -20, 0, 20),
	Size = UDim2.fromOffset(300, 300),
	BackgroundTransparency = 1,
}, ScreenGui)

Create("UIListLayout", {
	Padding = UDim.new(0, 8),
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Top,
}, NotificationContainer)

local function Notify(title, message)
	if not Settings.Notifications then
		return
	end

	local notification = Create("Frame", {
		Size = UDim2.fromOffset(290, 70),
		BackgroundColor3 = CONFIG.Panel,
		BackgroundTransparency = 0.02,
	}, NotificationContainer)

	Corner(notification, 12)
	Stroke(notification, CONFIG.Accent, 0.65)

	local accent = Create("Frame", {
		Size = UDim2.new(0, 4, 1, 0),
		BackgroundColor3 = CONFIG.Accent,
		Name = "AccentObject",
	}, notification)

	Corner(accent, 4)

	local titleLabel = Create("TextLabel", {
		Position = UDim2.fromOffset(16, 10),
		Size = UDim2.new(1, -30, 0, 22),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = CONFIG.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.GothamBold,
	}, notification)

	local messageLabel = Create("TextLabel", {
		Position = UDim2.fromOffset(16, 34),
		Size = UDim2.new(1, -30, 0, 25),
		BackgroundTransparency = 1,
		Text = message,
		TextColor3 = CONFIG.SubText,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
	}, notification)

	notification.Position = UDim2.new(1, 30, 0, 0)

	Tween(notification, {
		Position = UDim2.new(0, 0, 0, 0)
	}, 0.35)

	task.delay(3, function()
		if notification then
			Tween(notification, {
				BackgroundTransparency = 1
			}, 0.25)

			task.wait(0.25)

			notification:Destroy()
		end
	end)
end

--============================================================
-- DRAGGING
--============================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging then
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			Main.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

--============================================================
-- MINIMIZE
--============================================================

local minimized = false

Minimize.Activated:Connect(function()
	minimized = not minimized

	if minimized then
		Tween(Main, {
			Size = UDim2.fromOffset(900, 70)
		}, 0.3)

		Sidebar.Visible = false
		Content.Visible = false
	else
		Tween(Main, {
			Size = UDim2.fromOffset(900, 570)
		}, 0.3)

		task.wait(0.15)

		Sidebar.Visible = true
		Content.Visible = true
	end
end)

--============================================================
-- CLOSE / OPEN BUTTON
--============================================================

local OpenButton = Create("TextButton", {
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, 15, 0.5, 0),
	Size = UDim2.fromOffset(48, 48),
	BackgroundColor3 = CONFIG.Accent,
	Text = "N",
	TextColor3 = Color3.new(1, 1, 1),
	TextSize = 20,
	Font = Enum.Font.GothamBold,
	Visible = false,
	AutoButtonColor = false,
}, ScreenGui)

Corner(OpenButton, 14)

Close.Activated:Connect(function()
	Tween(Main, {
		Size = UDim2.fromOffset(850, 0),
		BackgroundTransparency = 1
	}, 0.35)

	task.wait(0.35)

	Main.Visible = false
	OpenButton.Visible = true
end)

OpenButton.Activated:Connect(function()
	OpenButton.Visible = false

	Main.Visible = true
	Main.Size = UDim2.fromOffset(850, 0)
	Main.BackgroundTransparency = CONFIG.Transparency

	Tween(Main, {
		Size = UDim2.fromOffset(900, 570)
	}, 0.4)
end)

--============================================================
-- RGB ENGINE
--============================================================

local RGBHue = 0

RunService.RenderStepped:Connect(function(deltaTime)
	if Settings.RGBMode then
		RGBHue += deltaTime * 0.15

		if RGBHue > 1 then
			RGBHue = 0
		end

		local rgbColor = Color3.fromHSV(RGBHue, 0.8, 1)

		if Settings.FollowVisualColor then
			-- RGB becomes the interface accent
			ApplyAccent(rgbColor)
		end
	end
end)

--============================================================
-- FPS
--============================================================

local frames = 0
local fpsTimer = 0

RunService.RenderStepped:Connect(function(deltaTime)
	frames += 1
	fpsTimer += deltaTime

	if fpsTimer >= 1 then
		local currentFPS = math.floor(frames / fpsTimer)

		FPS.Text = "FPS: " .. currentFPS

		FPS.Visible = Settings.ShowFPS

		frames = 0
		fpsTimer = 0
	end
end)

--============================================================
-- RESPONSIVE UI
--============================================================

local function UpdateResponsive()
	local camera = workspace.CurrentCamera

	if not camera then
		return
	end

	local viewport = camera.ViewportSize

	if viewport.X < 700 then
		UIScale.Scale = math.clamp(viewport.X / 900, 0.65, 0.9)
	else
		if not Settings.CompactMode then
			UIScale.Scale = 1
		end
	end
end

if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(
		UpdateResponsive
	)
end

UpdateResponsive()

--============================================================
-- LOADING
--============================================================

task.spawn(function()

	local start = os.clock()

	while os.clock() - start < CONFIG.LoadingTime do
		local progress = math.clamp(
			(os.clock() - start) / CONFIG.LoadingTime,
			0,
			1
		)

		Bar.Size = UDim2.new(progress, 0, 1, 0)
		LoadingStatus.Text = math.floor(progress * 100) .. "%"

		if progress < 0.25 then
			LoadingSub.Text = "Запуск интерфейса..."
		elseif progress < 0.5 then
			LoadingSub.Text = "Загрузка модулей..."
		elseif progress < 0.75 then
			LoadingSub.Text = "Настройка темы..."
		else
			LoadingSub.Text = "Почти готово..."
		end

		task.wait()
	end

	Bar.Size = UDim2.new(1, 0, 1, 0)
	LoadingStatus.Text = "100%"
	LoadingSub.Text = "Готово!"

	task.wait(0.35)

	Tween(LoadingTitle, {
		TextTransparency = 1
	}, 0.4)

	Tween(LoadingSub, {
		TextTransparency = 1
	}, 0.4)

	Tween(LoadingStatus, {
		TextTransparency = 1
	}, 0.4)

	Tween(BarBackground, {
		BackgroundTransparency = 1
	}, 0.4)

	task.wait(0.4)

	Tween(Loading, {
		BackgroundTransparency = 1
	}, 0.5)

	task.wait(0.5)

	Loading:Destroy()

	Main.Visible = true

	Main.Size = UDim2.fromOffset(900, 0)
	Main.BackgroundTransparency = 1

	Tween(Main, {
		Size = UDim2.fromOffset(900, 570),
		BackgroundTransparency = CONFIG.Transparency
	}, 0.55)

	task.wait(0.6)

	Notify(
		"Nova Hub",
		"Интерфейс успешно загружен."
	)

	end
