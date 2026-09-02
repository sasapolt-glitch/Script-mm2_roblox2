-- Thunder Hub MM2 (Полностью рабочий скрипт со всеми вкладками и переливающейся темой)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThunderHubMM2"
ScreenGui.Parent = game.CoreGui

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Переливающийся градиент для темы
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 20, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 20, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 30))
})
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

-- Автоматическое переливание градиента
task.spawn(function()
    while true do
        local t1 = TweenService:Create(MainGradient, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 225})
        t1:Play()
        t1.Completed:Wait()
        local t2 = TweenService:Create(MainGradient, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 45})
        t2:Play()
        t2.Completed:Wait()
    end
end)

-- Левая панель
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 150, 1, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 14, 18)
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 10)
LeftCorner.Parent = LeftPanel

local FixLeft = Instance.new("Frame")
FixLeft.Size = UDim2.new(0, 10, 1, 0)
FixLeft.Position = UDim2.new(1, -10, 0, 0)
FixLeft.BackgroundColor3 = Color3.fromRGB(25, 14, 18)
FixLeft.BorderSizePixel = 0
FixLeft.Parent = LeftPanel

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
SubTitle.Text = "by Kavo [Full Work]"
SubTitle.TextColor3 = Color3.fromRGB(180, 120, 130)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = LeftPanel

-- Верхняя панель управления
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

-- Контейнеры для вкладок
local TabsContainer = {}
local function createTabContent(name)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, -160, 1, -50)
    sf.Position = UDim2.new(0, 160, 0, 45)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.CanvasSize = UDim2.new(0, 0, 0, 400)
    sf.ScrollBarThickness = 4
    sf.Visible = false
    sf.Parent = MainFrame
    TabsContainer[name] = sf
    return sf
end

local tabGrabber = createTabContent("Grabber")
local tabVisual = createTabContent("Визуал")
local tabCombat = createTabContent("Бой")
local tabTeleport = createTabContent("Телепорт")

tabGrabber.Visible = true -- Активна по умолчанию

-- Переключение вкладок
local function createTabButton(name, posY, targetTab)
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
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(TabsContainer) do t.Visible = false end
        targetTab.Visible = true
    end)
    return btn
end

createTabButton("Grabber", 60, tabGrabber)
createTabButton("Визуал & Тема", 95, tabVisual)
createTabButton("Бой & Фарм", 130, tabCombat)
createTabButton("Телепорт", 165, tabTeleport)

-- Профиль игрока
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 130, 0, 35)
ProfileFrame.Position = UDim2.new(0, 10, 1, -45)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = LeftPanel

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 30, 0, 30)
AvatarImg.Position = UDim2.new(0, 0, 0, 2)
AvatarImg.BackgroundColor3 = Color3.fromRGB(60, 30, 40)
AvatarImg.Image = ""
AvatarImg.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImg

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

-- Универсальная функция создания переключателей (Toggle)
local function createToggle(parent, name, posY, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 36)
    frame.Position = UDim2.new(0, 10, 0, posY)
    frame.BackgroundColor3 = Color3.fromRGB(45, 26, 33)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
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

-- ==================== ВКЛАДКА 1: GRABBER ====================
local s1 = Instance.new("TextLabel")
s1.Size = UDim2.new(1, -20, 0, 20)
s1.Position = UDim2.new(0, 10, 0, 5)
s1.BackgroundTransparency = 1
s1.Text = "Grabber (Управление оружием)"
s1.TextColor3 = Color3.fromRGB(200, 140, 150)
s1.TextSize = 13
s1.Font = Enum.Font.SourceSansBold
s1.TextXAlignment = Enum.TextXAlignment.Left
s1.Parent = tabGrabber

createToggle(tabGrabber, "Подобрать выпавший пистолет", 30, function(state)
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

_G.AutoGrab = false
createToggle(tabGrabber, "Автоподбор оружия (Цикл)", 72, function(state)
    _G.AutoGrab = state
    task.spawn(function()
        while _G.AutoGrab do
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

-- ==================== ВКЛАДКА 2: ВИЗУАЛ & ТЕМА ====================
local s2 = Instance.new("TextLabel")
s2.Size = UDim2.new(1, -20, 0, 20)
s2.Position = UDim2.new(0, 10, 0, 5)
s2.BackgroundTransparency = 1
s2.Text = "ESP и Настройка темы GUI"
s2.TextColor3 = Color3.fromRGB(200, 140, 150)
s2.TextSize = 13
s2.Font = Enum.Font.SourceSansBold
s2.TextXAlignment = Enum.TextXAlignment.Left
s2.Parent = tabVisual

-- Переливающаяся смена цветовых тем GUI
local themes = {
    {Color3.fromRGB(35, 20, 25), Color3.fromRGB(60, 20, 45), Color3.fromRGB(20, 10, 30)}, -- Бордовая (Тёмная страсть)
    {Color3.fromRGB(15, 25, 45), Color3.fromRGB(30, 80, 140), Color3.fromRGB(10, 15, 30)}, -- Неоновый синий (Киберпанк)
    {Color3.fromRGB(20, 40, 20), Color3.fromRGB(40, 120, 60), Color3.fromRGB(10, 25, 15)}, -- Изумрудный лес
    {Color3.fromRGB(45, 30, 15), Color3.fromRGB(140, 80, 20), Color3.fromRGB(25, 15, 10)}  -- Закатный огонь
}
local currentThemeIdx = 1

local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(1, -20, 0, 36)
themeBtn.Position = UDim2.new(0, 10, 0, 30)
themeBtn.BackgroundColor3 = Color3.fromRGB(65, 40, 50)
themeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
themeBtn.TextSize = 12
themeBtn.Font = Enum.Font.SourceSansBold
themeBtn.Text = "Сменить тему GUI (Переливающаяся)"
themeBtn.Parent = tabVisual

local tCorner = Instance.new("UICorner")
tCorner.CornerRadius = UDim.new(0, 8)
tCorner.Parent = themeBtn

themeBtn.MouseButton1Click:Connect(function()
    currentThemeIdx = currentThemeIdx + 1
    if currentThemeIdx > #themes then currentThemeIdx = 1 end
    local th = themes[currentThemeIdx]
    MainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, th[1]),
        ColorSequenceKeypoint.new(0.5, th[2]),
        ColorSequenceKeypoint.new(1, th[3])
    })
end)

local function isMurderer(player)
    local bp = player:FindFirstChild("Backpack")
    local ch = player.Character
    return (bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("Axe"))) or (ch and (ch:FindFirstChild("Knife") or ch:FindFirstChild("Axe")))
end

local function isSheriff(player)
    local bp = player:FindFirstChild("Backpack")
    local ch = player.Character
    return (bp and bp:FindFirstChild("Gun")) or (ch and ch:FindFirstChild("Gun"))
end

_G.ESPEnabled = false
createToggle(tabVisual, "Включить ESP (Подсветка игроков)", 72, function(state)
    _G.ESPEnabled = state
    if not state then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("ThunderHighlight") then
                p.Character.ThunderHighlight:Destroy()
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.ESPEnabled then
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hl = p.Character:FindFirstChild("ThunderHighlight")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "ThunderHighlight"
                        hl.FillTransparency = 0.5
                        hl.Parent = p.Character
                    end
                    if isMurderer(p) then
                        hl.FillColor = Color3.fromRGB(255, 0, 0) -- Убийца (Красный)
                    elseif isSheriff(p) then
                        hl.FillColor = Color3.fromRGB(0, 0, 255) -- Шериф (Синий)
                    else
                        hl.FillColor = Color3.fromRGB(0, 255, 0) -- Мирный (Зеленый)
                    end
                end
            end
        end)
    end
end)

-- Объемные переливающиеся облака
createToggle(tabVisual, "Включить объемные облака (Шторм)", 114, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        local clouds = terrain:FindFirstChildOfClass("Clouds")
        if not clouds then
            clouds = Instance.new("Clouds")
            clouds.Parent = terrain
        end
        clouds.Enabled = state
        clouds.Density = 1.0
        clouds.Cover = 1.0
    end
end)

-- ==================== ВКЛАДКА 3: БОЙ & ФАРМ ====================
local s3 = Instance.new("TextLabel")
s3.Size = UDim2.new(1, -20, 0, 20)
s3.Position = UDim2.new(0, 10, 0, 5)
s3.BackgroundTransparency = 1
s3.Text = "Бой и Автофарм монет"
s3.TextColor3 = Color3.fromRGB(200, 140, 150)
s3.TextSize = 13
s3.Font = Enum.Font.SourceSansBold
s3.TextXAlignment = Enum.TextXAlignment.Left
s3.Parent = tabCombat

_G.AutoFarm = false
createToggle(tabCombat, "Автофарм монет", 30, function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
                if coins and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, coin in ipairs(coins:GetDescendants()) do
                        if coin:IsA("BasePart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
                            task.wait(0.05)
                            break
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

_G.AutoKill = false
createToggle(tabCombat, "Авто-убийство убийцы (за шерифа)", 72, function(state)
    _G.AutoKill = state
    task.spawn(function()
        while _G.AutoKill do
            pcall(function()
                local char = LocalPlayer.Character
                local gun = char and char:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
                if gun and char:FindFirstChildOfClass("Humanoid") then
                    if not char:FindFirstChild("Gun") then
                        char.Humanoid:EquipTool(gun)
                    end
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and isMurderer(p) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local remote = gun:FindFirstChild("RemoteEvent") or gun:FindFirstChild("Shoot")
                            if remote then
                                remote:FireServer(p.Character.HumanoidRootPart.Position, p.Character.HumanoidRootPart.Position)
                            end
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- ==================== ВКЛАДКА 4: ТЕЛЕПОРТ ====================
local s4 = Instance.new("TextLabel")
s4.Size = UDim2.new(1, -20, 0, 20)
s4.Position = UDim2.new(0, 10, 0, 5)
s4.BackgroundTransparency = 1
s4.Text = "Телепортация"
s4.TextColor3 = Color3.fromRGB(200, 140, 150)
s4.TextSize = 13
s4.Font = Enum.Font.SourceSansBold
s4.TextXAlignment = Enum.TextXAlignment.Left
s4.Parent = tabTeleport

createToggle(tabTeleport, "Телепорт к спавну карты", 30, function(state)
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
