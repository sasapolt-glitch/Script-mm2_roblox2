-- Delta MM2 GUI Script (С соотношением сторон 16:5 / Вытянутый и компактный макет)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Состояния функций
local autoFarmCoins = false
local autoGrabGun = false
local autoKillMurderer = false
local autoKillSheriff = false
local autoKillInnocents = false

-- Создание графического интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2Delta16_5GUI"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Адаптация под формат 16:5 (широкое горизонтальное или компактно-вытянутое окно)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 150)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Верхняя панель (Шапка)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.Text = "MM2 Delta Hub [16:5 Layout]"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

local CloseCircleBtn = Instance.new("TextButton")
CloseCircleBtn.Size = UDim2.new(0, 20, 0, 20)
CloseCircleBtn.Position = UDim2.new(1, -25, 0, 5)
CloseCircleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseCircleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCircleBtn.TextSize = 10
CloseCircleBtn.Font = Enum.Font.GothamBold
CloseCircleBtn.Text = "X"
CloseCircleBtn.Parent = Title

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseCircleBtn

-- Функция создания колонок (подгрупп) для широкого экрана
local function createColumn(posX, titleText)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 145, 0, 105)
    container.Position = UDim2.new(0, posX, 0, 38)
    container.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    container.BorderSizePixel = 0
    container.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(150, 150, 255)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText
    lbl.Parent = container

    return container
end

-- Функция создания кнопки внутри колонки
local function createColumnButton(parent, posY, defaultText)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 135, 0, 24)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = defaultText .. ": OFF"
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    return btn
end

-- === РАСПРЕДЕЛЕНИЕ ПО КОЛОНКАМ (ФОРМАТ 16:5) ===

-- Колонка 1: Автофарм
local Col1 = createColumn(10, "📦 Автофарм")
local BtnFarmCoins = createColumnButton(Col1, 26, "Монеты")
local BtnGrabGun = createColumnButton(Col1, 54, "Пистолет")

-- Колонка 2: Убийства (Убийца / Шериф)
local Col2 = createColumn(165, "⚔️ Убийства")
local BtnAutoKillMurderer = createColumnButton(Col2, 26, "Убийцы")
local BtnAutoKillSheriff = createColumnButton(Col2, 54, "Шерифа")

-- Колонка 3: Мирные (Доп. цели)
local Col3 = createColumn(320, "🎯 Мирные")
local BtnAutoKillInnocents = createColumnButton(Col3, 26, "Мирных")

-- Кнопка сворачивания меню
local OpenCircleBtn = Instance.new("TextButton")
OpenCircleBtn.Size = UDim2.new(0, 50, 0, 50)
OpenCircleBtn.Position = UDim2.new(0, 30, 0, 30)
OpenCircleBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 255)
OpenCircleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCircleBtn.TextSize = 14
OpenCircleBtn.Font = Enum.Font.GothamBold
OpenCircleBtn.Text = "MM2"
OpenCircleBtn.Visible = false
OpenCircleBtn.Active = true
OpenCircleBtn.Draggable = true
OpenCircleBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenCircleBtn

-- Обработчики нажатий
BtnFarmCoins.MouseButton1Click:Connect(function()
    autoFarmCoins = not autoFarmCoins
    BtnFarmCoins.Text = "Монеты: " .. (autoFarmCoins and "ON" or "OFF")
    BtnFarmCoins.BackgroundColor3 = autoFarmCoins and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnGrabGun.MouseButton1Click:Connect(function()
    autoGrabGun = not autoGrabGun
    BtnGrabGun.Text = "Пистолет: " .. (autoGrabGun and "ON" or "OFF")
    BtnGrabGun.BackgroundColor3 = autoGrabGun and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnAutoKillMurderer.MouseButton1Click:Connect(function()
    autoKillMurderer = not autoKillMurderer
    BtnAutoKillMurderer.Text = "Убийцы: " .. (autoKillMurderer and "ON" or "OFF")
    BtnAutoKillMurderer.BackgroundColor3 = autoKillMurderer and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnAutoKillSheriff.MouseButton1Click:Connect(function()
    autoKillSheriff = not autoKillSheriff
    BtnAutoKillSheriff.Text = "Шерифа: " .. (autoKillSheriff and "ON" or "OFF")
    BtnAutoKillSheriff.BackgroundColor3 = autoKillSheriff and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

BtnAutoKillInnocents.MouseButton1Click:Connect(function()
    autoKillInnocents = not autoKillInnocents
    BtnAutoKillInnocents.Text = "Мирных: " .. (autoKillInnocents and "ON" or "OFF")
    BtnAutoKillInnocents.BackgroundColor3 = autoKillInnocents and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(60, 60, 60)
end)

CloseCircleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenCircleBtn.Visible = true
end)

OpenCircleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenCircleBtn.Visible = false
end)

-- Игровой цикл выполнения скрипта
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart

    -- 1. Автоподнимание пистолета
    if autoGrabGun then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v.Name == "GunDrop" then
                    local handle = v:FindFirstChild("Handle") or (v:IsA("BasePart") and v)
                    if handle then
                        rootPart.CFrame = handle.CFrame
                    end
                end
            end
        end)
    end

    -- 2. Автофарм монет
    if autoFarmCoins then
        pcall(function()
            for _, folder in ipairs(Workspace:GetChildren()) do
                if folder.Name:lower():find("coin") or folder.Name == "CoinContainer" or folder.Name == "Normal" then
                    for _, coin in ipairs(folder:GetChildren()) do
                        local visual = coin:FindFirstChild("CoinVisual") or coin:FindFirstChild("Handle") or coin
                        if coin:IsA("BasePart") or visual:IsA("BasePart") then
                            local targetPart = coin:IsA("BasePart") and coin or visual
                            if targetPart.Transparency == 0 then
                                rootPart.CFrame = targetPart.CFrame
                                task.wait(0.15)
                                break
                            end
                        end
                    end
                end
            end
        end)
    end

    -- 3. Автоубийства по ролям
    pcall(function()
        local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
        if knife then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemyChar = player.Character
                    local enemyRoot = enemyChar.HumanoidRootPart
                    
                    local isMurderer = enemyChar:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
                    local isSheriff = enemyChar:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
                    local isInnocent = not isMurderer and not isSheriff

                    local targetAllowed = false
                    if autoKillMurderer and isMurderer then targetAllowed = true end
                    if autoKillSheriff and isSheriff then targetAllowed = true end
                    if autoKillInnocents and isInnocent then targetAllowed = true end

                    if targetAllowed then
                        rootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 2)
                        knife.Parent = char
                        knife:Activate()
                    end
                end
            end
        end
    end)
end)
