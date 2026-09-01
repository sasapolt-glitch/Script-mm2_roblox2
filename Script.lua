-- Delta MM2 GUI Script
-- Запуск через Delta Executor

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Переменные для состояния функций
local autoFarmCoins = false
local autoGrabGun = false
local autoKillMurderer = false

-- Создание графического интерфейса (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2DeltaGUI"
ScreenGui.ResetOnSpawn = false

-- Защита GUI от обнаружения (если поддерживает Delta)
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 280)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "MM2 Delta Hub"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Функция создания стилизованных кнопок
local function createButton(name, positionY, defaultText)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 40)
    btn.Position = UDim2.new(0, 20, 0, positionY)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = defaultText .. ": OFF"
    btn.Parent = MainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    return btn
end

-- Создаем кнопки согласно требованиям
local BtnAutoKill = createButton("AutoKill", 55, "Автоубийства (убийцы)")
local BtnGrabGun = createButton("GrabGun", 110, "Автоподнимание пистолета")
local BtnFarmCoins = createButton("FarmCoins", 165, "Автофарм монет")

-- Кнопка закрытия/скрытия меню
local ToggleUIBtn = Instance.new("TextButton")
ToggleUIBtn.Size = UDim2.new(0, 220, 0, 35)
ToggleUIBtn.Position = UDim2.new(0, 20, 0, 225)
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
ToggleUIBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleUIBtn.TextSize = 13
ToggleUIBtn.Font = Enum.Font.GothamBold
ToggleUIBtn.Text = "Скрыть / Закрыть"
ToggleUIBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleUIBtn

-- Логика переключения кнопок
BtnAutoKill.MouseButton1Click:Connect(function()
    autoKillMurderer = not autoKillMurderer
    BtnAutoKill.Text = "Автоубийства (убийцы): " .. (autoKillMurderer and "ON" or "OFF")
    BtnAutoKill.BackgroundColor3 = autoKillMurderer and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnGrabGun.MouseButton1Click:Connect(function()
    autoGrabGun = not autoGrabGun
    BtnGrabGun.Text = "Автоподнимание пистолета: " .. (autoGrabGun and "ON" or "OFF")
    BtnGrabGun.BackgroundColor3 = autoGrabGun and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnFarmCoins.MouseButton1Click:Connect(function()
    autoFarmCoins = not autoFarmCoins
    BtnFarmCoins.Text = "Автофарм монет: " .. (autoFarmCoins and "ON" or "OFF")
    BtnFarmCoins.BackgroundColor3 = autoFarmCoins and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

local visible = true
ToggleUIBtn.MouseButton1Click:Connect(function()
    visible = not visible
    MainFrame.Visible = visible
end)

-- Основной цикл функций (выполняется в фоновом режиме)
RunService.Stepped:Connect(function()
    -- 1. Автоподнимание пистолета (если шериф умер и пистолет упал на карту)
    if autoGrabGun then
        pcall(function()
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "GunDrop" and obj:FindFirstChild("Handle") then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.Handle.CFrame
                    end
                end
            end
        end)
    end

    -- 2. Автофарм монет (телепортация к монетам в контейнере CoinContainer)
    if autoFarmCoins then
        pcall(function()
            local coinContainer = Workspace:FindFirstChild("CoinContainer")
            if coinContainer then
                for _, coin in ipairs(coinContainer:GetChildren()) do
                    if coin:FindFirstChild("CoinVisual") and coin.CoinVisual.Transparency == 0 then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CoinVisual.CFrame
                            task.wait(0.1) -- задержка, чтобы игра засчитала подбор
                            break
                        end
                    end
                end
            end
        end)
    end

    -- 3. Автоубийства для роли Убийцы (Murderer)
    if autoKillMurderer then
        pcall(function()
            -- Проверяем, есть ли у нас нож (значит мы убийца)
            local character = LocalPlayer.Character
            if character and (character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")) then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        -- Телепортируемся к ближайшему игроку и атакуем
                        local enemyRoot = player.Character.HumanoidRootPart
                        character.HumanoidRootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 2.5)
                        
                        local knife = character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
                        if knife then
                            knife.Parent = character
                            knife:Activate()
                        end
                    end
                end
            end
        end)
    end
end)
