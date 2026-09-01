-- MM2 Custom Menu (Delta Executor) with Group, Clouds, Toggle UI, and Blue Gradient
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

-- Круглая кнопка для открытия/закрытия меню на экране
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
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

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 440)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Переливающийся синий градиент интерфейса
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
        local tween1 = TweenService:Create(UIGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 225})
        tween1:Play()
        tween1.Completed:Wait()
        local tween2 = TweenService:Create(UIGradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 45})
        tween2:Play()
        tween2.Completed:Wait()
    end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Custom Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Кнопка закрытия внутри самого меню (крестик)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Функция создания обычных кнопок-тумблеров
local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 35)
    btn.Position = UDim2.new(0.5, -90, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSans
    btn.Text = name .. ": OFF"
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

-- Функция создания кнопок для неба/облаков
local function createSkyButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 35)
    btn.Position = UDim2.new(0.5, -90, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

local EspBtn = createButton("ESP (Подсветка)", 50)
local CoinFarmBtn = createButton("Автофарм монет", 90)
local AutoKillBtn = createButton("Автоубийство (Шериф)", 130)
local GrabGunBtn = createButton("Автоподнятие пистолета", 170)
local KillerAimBtn = createButton("Автонаводка (Убийца)", 210)
local SkyBtn = createSkyButton("Небо: Обычное", 255)
local CloudsBtn = createSkyButton("Облака: Много (Шторм)", 295)

-- Кнопка для открытия группы/сообщества (например, скопировать ссылку или открыть)
local GroupBtn = createSkyButton("Наша Группа / Discord", 335)
local SkyOffBtn = createSkyButton("Сбросить всё (Стандарт)", 375)

-- Переменные состояния
local espEnabled = false
local coinFarmEnabled = false
local autoKillEnabled = false
local grabGunEnabled = false
local killerAimEnabled = false
local skyMode = 0
local cloudsEnabled = false

local function isMurderer(player)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    return (backpack and backpack:FindFirstChild("Knife")) or (character and character:FindFirstChild("Knife"))
end

local function isSheriff(player)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    return (backpack and backpack:FindFirstChild("Gun")) or (character and character:FindFirstChild("Gun"))
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
        sky.Name = "CustomSky"
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
        sky.Name = "CustomSky"
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
        sky.Name = "CustomSky"
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

local function updateEsp()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("MM2Highlight")
            if espEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "MM2Highlight"
                    highlight.FillTransparency = 0.5
                    highlight.Parent = player.Character
                end
                
                if isMurderer(player) then
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                elseif isSheriff(player) then
                    highlight.FillColor = Color3.fromRGB(0, 0, 255)
                else
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                end
            else
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspBtn.Text = "ESP (Подсветка): " .. (espEnabled and "ON" or "OFF")
    EspBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
    if not espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("MM2Highlight") then
                player.Character.MM2Highlight:Destroy()
            end
        end
    end
end)

CoinFarmBtn.MouseButton1Click:Connect(function()
    coinFarmEnabled = not coinFarmEnabled
    CoinFarmBtn.Text = "Автофарм монет: " .. (coinFarmEnabled and "ON" or "OFF")
    CoinFarmBtn.BackgroundColor3 = coinFarmEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

AutoKillBtn.MouseButton1Click:Connect(function()
    autoKillEnabled = not autoKillEnabled
    AutoKillBtn.Text = "Автоубийство (Шериф): " .. (autoKillEnabled and "ON" or "OFF")
    AutoKillBtn.BackgroundColor3 = autoKillEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

GrabGunBtn.MouseButton1Click:Connect(function()
    grabGunEnabled = not grabGunEnabled
    GrabGunBtn.Text = "Автоподнятие пистолета: " .. (grabGunEnabled and "ON" or "OFF")
    GrabGunBtn.BackgroundColor3 = grabGunEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

KillerAimBtn.MouseButton1Click:Connect(function()
    killerAimEnabled = not killerAimEnabled
    KillerAimBtn.Text = "Автонаводка (Убийца): " .. (killerAimEnabled and "ON" or "OFF")
    KillerAimBtn.BackgroundColor3 = killerAimEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

SkyBtn.MouseButton1Click:Connect(function()
    skyMode = skyMode + 1
    if skyMode > 3 then skyMode = 1 end
    
    if skyMode == 1 then
        SkyBtn.Text = "Небо: Космос"
        changeSky(1)
    elseif skyMode == 2 then
        SkyBtn.Text = "Небо: Пурпурное"
        changeSky(2)
    elseif skyMode == 3 then
        SkyBtn.Text = "Небо: Золотой Закат"
        changeSky(3)
    end
end)

CloudsBtn.MouseButton1Click:Connect(function()
    cloudsEnabled = not cloudsEnabled
    toggleClouds(cloudsEnabled)
    CloudsBtn.Text = cloudsEnabled and "Облака: Включены (Много)" or "Облака: Выключены"
end)

-- Действие при нажатии на кнопку группы
GroupBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://roblox.com/groups/yourgroup") -- Ссылка на вашу группу или Discord
            GroupBtn.Text = "Ссылка скопирована!"
            task.wait(2)
            GroupBtn.Text = "Наша Группа / Discord"
        end
    end)
end)

SkyOffBtn.MouseButton1Click:Connect(function()
    skyMode = 0
    cloudsEnabled = false
    SkyBtn.Text = "Небо: Обычное"
    CloudsBtn.Text = "Облака: Много (Шторм)"
    toggleClouds(false)
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end
    Lighting.ClockTime = 14
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        pcall(updateEsp)
    end
    
    if coinFarmEnabled then
        pcall(function()
            local coinContainer = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
            if coinContainer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                for _, coin in ipairs(coinContainer:GetChildren()) do
                    if coin:IsA("BasePart") or coin:FindFirstChild("TouchInterest") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
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
            local character = LocalPlayer.Character
            local hasGunEquipped = character and character:FindFirstChild("Gun")
            
            if hasGunEquipped then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if isMurderer(player) then
                            hasGunEquipped:FindFirstChild("RemoteEvent"):FireServer(player.Character.HumanoidRootPart.Position)
                        end
                    end
                end
            end
        end)
    end

    if killerAimEnabled then
        pcall(function()
            local character = LocalPlayer.Character
            if isMurderer(LocalPlayer) and character and character:FindFirstChild("HumanoidRootPart") then
                local closestPlayer = nil
                local shortestDistance = math.huge
                
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        if not isMurderer(player) then
                            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid and humanoid.Health > 0 then
                                local distance = (character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                                if distance < shortestDistance then
                                    shortestDistance = distance
                                    closestPlayer = player
                                end
                            end
                        end
                    end
                end
                
                if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
                    local targetHead = closestPlayer.Character.Head
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHead.Position)
                end
            end
        end)
    end
end)

