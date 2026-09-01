-- MM2 Custom Menu (Delta Executor) - Адаптивный размер под экран 16.5 / Любое разрешение
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2CustomHub"
ScreenGui.Parent = game.CoreGui

-- ЭКРАН ЗАГРУЗКИ (Адаптированный)
local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 220, 0, 85)
LoadFrame.Position = UDim2.new(0.5, -110, 0.5, -42)
LoadFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = ScreenGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 10)
LoadCorner.Parent = LoadFrame

local LoadGradient = Instance.new("UIGradient")
LoadGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 144, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
})
LoadGradient.Rotation = 45
LoadGradient.Parent = LoadFrame

local LoadText = Instance.new("TextLabel")
LoadText.Size = UDim2.new(1, 0, 0, 35)
LoadText.Position = UDim2.new(0, 0, 0, 12)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Загрузка скрипта..."
LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadText.TextSize = 14
LoadText.Font = Enum.Font.SourceSansBold
LoadText.Parent = LoadFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 180, 0, 8)
BarBg.Position = UDim2.new(0.5, -90, 0, 55)
BarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoadFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 0, 8)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 191, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(1, 0)
BarFillCorner.Parent = BarFill

TweenService:Create(BarFill, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 8)}):Play()
task.wait(1.6)

TweenService:Create(LoadFrame, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
for _, child in ipairs(LoadFrame:GetDescendants()) do
    if child:IsA("TextLabel") or child:IsA("Frame") then
        TweenService:Create(child, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {BackgroundTransparency = 1}):Play()
        if child:IsA("TextLabel") then
            TweenService:Create(child, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {TextTransparency = 1}):Play()
        end
    end
end
task.wait(0.4)
LoadFrame:Destroy()

-- КРУГЛАЯ КНОПКА (Открыть/Закрыть)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "MM2"
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleGradient = Instance.new("UIGradient")
ToggleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
})
ToggleGradient.Parent = ToggleButton

-- ОСНОВНОЕ МЕНЮ (Используем UIScale для точной адаптации без поломок)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 190, 0, 380)
MainFrame.Position = UDim2.new(0.5, -95, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Масштабирование под экраны (включая устройства с нестандартными пропорциями)
local UiScale = Instance.new("UIScale")
UiScale.Scale = 1.05
UiScale.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 144, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

task.spawn(function()
    while true do
        local t1 = TweenService:Create(UIGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 225})
        t1:Play()
        t1.Completed:Wait()
        local t2 = TweenService:Create(UIGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 45})
        t2:Play()
        t2.Completed:Wait()
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0, 4)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 166, 0, 30)
    btn.Position = UDim2.new(0.5, -83, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSans
    btn.Text = name .. ": OFF"
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

local function createSkyButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 166, 0, 30)
    btn.Position = UDim2.new(0.5, -83, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

local EspBtn = createButton("ESP", 40)
local CoinFarmBtn = createButton("Автофарм", 75)
local AutoKillBtn = createButton("Авто-убийство", 110)
local GrabGunBtn = createButton("Взять пистолет", 145)
local KillerAimBtn = createButton("Наводка", 180)
local SkyBtn = createSkyButton("Небо: Стандарт", 215)
local CloudsBtn = createSkyButton("Облака: Шторм", 250)
local GroupBtn = createSkyButton("Группа / Дискорд", 285)
local SkyOffBtn = createSkyButton("Сбросить всё", 320)

local espEnabled = false
local coinFarmEnabled = false
local autoKillEnabled = false
local grabGunEnabled = false
local killerAimEnabled = false
local skyMode = 0
local cloudsEnabled = false

local function isMurderer(player)
    local bp = player:FindFirstChild("Backpack")
    local ch = player.Character
    return (bp and bp:FindFirstChild("Knife")) or (ch and ch:FindFirstChild("Knife"))
end

local function isSheriff(player)
    local bp = player:FindFirstChild("Backpack")
    local ch = player.Character
    return (bp and bp:FindFirstChild("Gun")) or (ch and ch:FindFirstChild("Gun"))
end

local function toggleClouds(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain and terrain:FindFirstChildOfClass("Clouds") then
        terrain.Clouds.Enabled = state
        if state then
            terrain.Clouds.Density = 0.9
            terrain.Clouds.Cover = 1.0
        end
    else
        if state then
            local clouds = Instance.new("Clouds")
            clouds.Enabled = true
            clouds.Density = 0.9
            clouds.Cover = 1.0
            clouds.Parent = terrain
        end
    end
end

local function changeSky(mode)
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") or obj:IsA("Atmosphere") then
            obj:Destroy()
        end
    end
    
    if mode == 1 then
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxassetid://826021201"
        sky.SkyboxDn = "rbxassetid://826021430"
        sky.SkyboxFt = "rbxassetid://826021614"
        sky.SkyboxLf = "rbxassetid://826021816"
        sky.SkyboxRt = "rbxassetid://826022060"
        sky.SkyboxUp = "rbxassetid://826022294"
        sky.Parent = Lighting
        Lighting.ClockTime = 0
    elseif mode == 2 then
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxassetid://156811421"
        sky.SkyboxDn = "rbxassetid://156811433"
        sky.SkyboxFt = "rbxassetid://156811449"
        sky.SkyboxLf = "rbxassetid://156811466"
        sky.SkyboxRt = "rbxassetid://156811486"
        sky.SkyboxUp = "rbxassetid://156811504"
        sky.Parent = Lighting
        Lighting.ClockTime = 18
    elseif mode == 3 then
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxassetid://626463363"
        sky.SkyboxDn = "rbxassetid://626463283"
        sky.SkyboxFt = "rbxassetid://626463462"
        sky.SkyboxLf = "rbxassetid://626463581"
        sky.SkyboxRt = "rbxassetid://626463724"
        sky.SkyboxUp = "rbxassetid://626463851"
        sky.Parent = Lighting
        Lighting.ClockTime = 17.5
    end
end

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspBtn.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    EspBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
    if not espEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("MM2Highlight") then
                p.Character.MM2Highlight:Destroy()
            end
        end
    end
end)

CoinFarmBtn.MouseButton1Click:Connect(function()
    coinFarmEnabled = not coinFarmEnabled
    CoinFarmBtn.Text = "Автофарм: " .. (coinFarmEnabled and "ON" or "OFF")
    CoinFarmBtn.BackgroundColor3 = coinFarmEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

AutoKillBtn.MouseButton1Click:Connect(function()
    autoKillEnabled = not autoKillEnabled
    AutoKillBtn.Text = "Авто-убийство: " .. (autoKillEnabled and "ON" or "OFF")
    AutoKillBtn.BackgroundColor3 = autoKillEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

GrabGunBtn.MouseButton1Click:Connect(function()
    grabGunEnabled = not grabGunEnabled
    GrabGunBtn.Text = "Взять пистолет: " .. (grabGunEnabled and "ON" or "OFF")
    GrabGunBtn.BackgroundColor3 = grabGunEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

KillerAimBtn.MouseButton1Click:Connect(function()
    killerAimEnabled = not killerAimEnabled
    KillerAimBtn.Text = "Наводка: " .. (killerAimEnabled and "ON" or "OFF")
    KillerAimBtn.BackgroundColor3 = killerAimEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

SkyBtn.MouseButton1Click:Connect(function()
    skyMode = skyMode + 1
    if skyMode > 3 then skyMode = 1 end
    if skyMode == 1 then SkyBtn.Text = "Небо: Космос"; changeSky(1)
    elseif skyMode == 2 then SkyBtn.Text = "Небо: Пурпур"; changeSky(2)
    elseif skyMode == 3 then SkyBtn.Text = "Небо: Закат"; changeSky(3) end
end)

CloudsBtn.MouseButton1Click:Connect(function()
    cloudsEnabled = not cloudsEnabled
    toggleClouds(cloudsEnabled)
    CloudsBtn.Text = cloudsEnabled and "Облака: Вкл" or "Облака: Шторм"
end)

GroupBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://roblox.com/groups/yourgroup")
            GroupBtn.Text = "Скопировано!"
            task.wait(1.5)
            GroupBtn.Text = "Группа / Дискорд"
        end
    end)
end)

SkyOffBtn.MouseButton1Click:Connect(function()
    skyMode = 0
    cloudsEnabled = false
    SkyBtn.Text = "Небо: Стандарт"
    CloudsBtn.Text = "Облака: Шторм"
    toggleClouds(false)
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    Lighting.ClockTime = 14
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hl = p.Character:FindFirstChild("MM2Highlight")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "MM2Highlight"
                        hl.FillTransparency = 0.5
                        hl.Parent = p.Character
                    end
                    if isMurderer(p) then hl.FillColor = Color3.fromRGB(255, 0, 0)
                    elseif isSheriff(p) then hl.FillColor = Color3.fromRGB(0, 0, 255)
                    else hl.FillColor = Color3.fromRGB(0, 255, 0) end
                end
            end
        end)
    end
    
    if coinFarmEnabled then
        pcall(function()
            local cc = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
            if cc and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, c in ipairs(cc:GetChildren()) do
                    if c:IsA("BasePart") or c:FindFirstChild("TouchInterest") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = c.CFrame
                        task.wait(0.1)
                        break
                    end
                end
            end
        end)
    end
    
    if grabGunEnabled then
        pcall(function()
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "GunDrop" and obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                end
            end
        end)
    end
    
    if autoKillEnabled then
        pcall(function()
            local ch = LocalPlayer.Character
            local gun = ch and ch:FindFirstChild("Gun")
            if gun then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if isMurderer(p) then
                            gun:FindFirstChild("RemoteEvent"):FireServer(p.Character.HumanoidRootPart.Position)
                        end
                    end
                end
            end
        end)
    end

    if killerAimEnabled then
        pcall(function()
            local ch = LocalPlayer.Character
            if isMurderer(LocalPlayer) and ch and ch:FindFirstChild("HumanoidRootPart") then
                local target, dist = nil, math.huge
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not isMurderer(p) then
                            local hm = p.Character:FindFirstChildOfClass("Humanoid")
                            if hm and hm.Health > 0 then
                                local d = (ch.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                                if d < dist then dist = d; target = p end
                            end
                        end
                    end
                end
                if target and target.Character:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
                end
            end
        end)
    end
end)

