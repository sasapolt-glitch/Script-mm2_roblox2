-- MM2 Custom Menu (Delta Executor) with Smooth Blue Gradient UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2CustomHub"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Переливающийся градиент для интерфейса
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 30, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 144, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Анимация переливания градиента
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

-- Функция создания кнопок-тумблеров
local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 35)
    btn.Position = UDim2.new(0.5, -90, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSans
    btn.Text = name .. ": OFF"
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    return btn
end

local EspBtn = createButton("ESP (Подсветка)", 55)
local CoinFarmBtn = createButton("Автофарм монет", 100)
local AutoKillBtn = createButton("Автоубийство", 145)
local GrabGunBtn = createButton("Автоподнятие пистолета", 190)

-- Переменные состояния
local espEnabled = false
local coinFarmEnabled = false
local autoKillEnabled = false
local grabGunEnabled = false

-- Логика подсветки (ESP)
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
                
                local backpack = player:FindFirstChild("Backpack")
                local character = player.Character
                local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or (character and character:FindFirstChild("Knife"))
                local hasGun = (backpack and backpack:FindFirstChild("Gun")) or (character and character:FindFirstChild("Gun"))
                
                if hasKnife then
                    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Убийца (красный)
                elseif hasGun then
                    highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Шериф (синий)
                else
                    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Мирный (зеленый)
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
    AutoKillBtn.Text = "Автоубийство: " .. (autoKillEnabled and "ON" or "OFF")
    AutoKillBtn.BackgroundColor3 = autoKillEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

GrabGunBtn.MouseButton1Click:Connect(function()
    grabGunEnabled = not grabGunEnabled
    GrabGunBtn.Text = "Автоподнятие пистолета: " .. (grabGunEnabled and "ON" or "OFF")
    GrabGunBtn.BackgroundColor3 = grabGunEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(20, 20, 35)
end)

-- Основной цикл работы функций
RunService.RenderStepped:Connect(function()
    if espEnabled then
        pcall(updateEsp)
    end
    
    -- Автофарм монет
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
    
    -- Автоподнятие пистолета
    if grabGunEnabled then
        pcall(function()
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "GunDrop" and obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                end
            end
        end)
    end
    
    -- Автоубийство убийцы
    if autoKillEnabled then
        pcall(function()
            local character = LocalPlayer.Character
            local hasGunEquipped = character and character:FindFirstChild("Gun")
            
            if hasGunEquipped then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local pBackpack = player:FindFirstChild("Backpack")
                        local pChar = player.Character
                        if (pBackpack and pBackpack:FindFirstChild("Knife")) or (pChar and pChar:FindFirstChild("Knife")) then
                            hasGunEquipped:FindFirstChild("RemoteEvent"):FireServer(player.Character.HumanoidRootPart.Position)
                        end
                    end
                end
            end
        end)
    end
end)
