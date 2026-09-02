-- Thunder Hub MM2 (Style UI) for Delta Executor
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThunderHubMM2"
ScreenGui.Parent = game.CoreGui

-- Главное окно в стиле Kavo/Thunder Hub (темно-бордовая тема с закруглениями)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Левая панель с вкладками
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 150, 1, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 14, 18)
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 10)
LeftCorner.Parent = LeftPanel

-- Тень/исправление углов левой панели
local FixLeft = Instance.new("Frame")
FixLeft.Size = UDim2.new(0, 10, 1, 0)
FixLeft.Position = UDim2.new(1, -10, 0, 0)
FixLeft.BackgroundColor3 = Color3.fromRGB(25, 14, 18)
FixLeft.BorderSizePixel = 0
FixLeft.Parent = LeftPanel

-- Заголовок хаба
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 130, 0, 30)
TitleLabel.Position = UDim2.new(0, 10, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Thunder Hub MM2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = LeftPanel

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 130, 0, 15)
SubTitle.Position = UDim2.new(0, 10, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "by Kavo"
SubTitle.TextColor3 = Color3.fromRGB(180, 120, 130)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = LeftPanel

-- Правая область контента
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -160, 1, -50)
ContentFrame.Position = UDim2.new(0, 160, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 320)
ContentFrame.ScrollBarThickness = 4
ContentFrame.Parent = MainFrame

-- Верхняя панель (Версия + Кнопка закрытия)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, -160, 0, 40)
TopBar.Position = UDim2.new(0, 160, 0, 0)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local VersionBadge = Instance.new("TextButton")
VersionBadge.Size = UDim2.new(0, 80, 0, 24)
VersionBadge.Position = UDim2.new(0, 10, 0, 8)
VersionBadge.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
VersionBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
VersionBadge.TextSize = 12
VersionBadge.Font = Enum.Font.SourceSansBold
VersionBadge.Text = "Версия 6.1"
VersionBadge.Parent = TopBar

local VerCorner = Instance.new("UICorner")
VerCorner.CornerRadius = UDim.new(0, 6)
VerCorner.Parent = VersionBadge

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0, 8)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 150, 150)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TopBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Функция создания элементов вкладок слева
local function createTabButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 130, 0, 28)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 22, 28)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.fromRGB(200, 160, 170)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = "   " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = LeftPanel
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

createTabButton("Персонаж", 60)
local TeleportTab = createTabButton("Телепорт", 95)
createTabButton("Бой", 130)
createTabButton("Троллинг", 165)
createTabButton("Валлхак", 200)
createTabButton("Визуал", 235)
createTabButton("Другое", 270)

-- Профиль внизу слева
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 130, 0, 35)
ProfileFrame.Position = UDim2.new(0, 10, 1, -45)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = LeftPanel

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 30, 0, 30)
AvatarImg.Position = UDim2.new(0, 0, 0, 2)
AvatarImg.BackgroundColor3 = Color3.fromRGB(60, 30, 40)
AvatarImg.Image = "rbxassetid://0"
AvatarImg.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImg

-- Пытаемся загрузить иконку игрока
pcall(function()
    AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(0, 90, 0, 30)
UsernameLabel.Position = UDim2.new(0, 38, 0, 2)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextSize = 11
UsernameLabel.Font = Enum.Font.SourceSansBold
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Parent = ProfileFrame

-- Функция для создания элементов управления (Toggle / Кнопки как на скриншоте)
local function createToggle(name, posY, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 36)
    frame.Position = UDim2.new(0, 10, 0, posY)
    frame.BackgroundColor3 = Color3.fromRGB(45, 26, 33)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 200, 205)
    label.TextSize = 12
    label.Font = Enum.Font.SourceSansSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 36, 0, 20)
    toggleBtn.Position = UDim2.new(1, -46, 0.5, -10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(65, 40, 50)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(200, 150, 160)
    circle.Parent = toggleBtn
    
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle
    
    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 70, 90)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 40, 50)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200, 150, 160)}):Play()
        end
        if callback then callback(enabled) end
    end)
end

-- Секция Grabber (как на картинке)
local SectionTitle = Instance.new("TextLabel")
SectionTitle.Size = UDim2.new(1, -20, 0, 20)
SectionTitle.Position = UDim2.new(0, 10, 0, 5)
SectionTitle.BackgroundTransparency = 1
SectionTitle.Text = "Grabber"
SectionTitle.TextColor3 = Color3.fromRGB(200, 140, 150)
SectionTitle.TextSize = 13
SectionTitle.Font = Enum.Font.SourceSansBold
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle.Parent = ContentFrame

createToggle("Подобрать оружие", 30, function(state)
    if state then
        pcall(function()
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "GunDrop" or obj.Name == "Drop" then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                    end
                end
            end
        end)
    end
end)

createToggle("Вкл/Выкл клавишу подбора оружия", 72, function(state)
    print("Клавиша подбора:", state)
end)

createToggle("Автоподбор оружия [нестабильно]", 114, function(state)
    _G.AutoGrabGun = state
    task.spawn(function()
        while _G.AutoGrabGun do
            pcall(function()
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name == "GunDrop" or obj.Name == "Drop" then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        end
                    end
                end
            end)
            task.wait(0.2)
        end
    end)
end)

-- Вторая секция Teleport To Coordinate
local SectionTitle2 = Instance.new("TextLabel")
SectionTitle2.Size = UDim2.new(1, -20, 0, 20)
SectionTitle2.Position = UDim2.new(0, 10, 0, 160)
SectionTitle2.BackgroundTransparency = 1
SectionTitle2.Text = "Teleport To Coordinate"
SectionTitle2.TextColor3 = Color3.fromRGB(200, 140, 150)
SectionTitle2.TextSize = 13
SectionTitle2.Font = Enum.Font.SourceSansBold
SectionTitle2.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle2.Parent = ContentFrame

createToggle("Телепорт к карте", 185, function(state)
    if state then
        pcall(function()
            for _, child in ipairs(Workspace:GetChildren()) do
                if child:FindFirstChild("SpawnLocation") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = child.SpawnLocation.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end)
    end
end)

