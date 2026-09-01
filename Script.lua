-- Обновленный Delta MM2 GUI Script (Исправленный)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local autoFarmCoins = false
local autoGrabGun = false
local autoKillMurderer = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2DeltaGUIFixed"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 240)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "MM2 Delta Hub [Fixed]"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

local CloseCircleBtn = Instance.new("TextButton")
CloseCircleBtn.Size = UDim2.new(0, 26, 0, 26)
CloseCircleBtn.Position = UDim2.new(1, -33, 0, 7)
CloseCircleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseCircleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseCircleBtn.TextSize = 12
CloseCircleBtn.Font = Enum.Font.GothamBold
CloseCircleBtn.Text = "X"
CloseCircleBtn.Parent = Title

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseCircleBtn

local function createButton(positionY, defaultText)
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

local BtnAutoKill = createButton(55, "Автоубийства (убийцы)")
local BtnGrabGun = createButton(110, "Автоподнимание пистолета")
local BtnFarmCoins = createButton(165, "Автофарм монет")

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

CloseCircleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenCircleBtn.Visible = true
end)

OpenCircleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenCircleBtn.Visible = false
end)

-- Улучшенный цикл выполнения логики
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart

    -- 1. Улучшенный поиск пистолета (проверяет весь Workspace на наличие dropped Gun)
    if autoGrabGun then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v.Name == "GunDrop" then
                    local handle = v:FindFirstChild("Handle") or v:IsA("BasePart") and v
                    if handle then
                        rootPart.CFrame = handle.CFrame
                    end
                end
            end
        end)
    end

    -- 2. Улучшенный фарм монет (ищет папки с монетами динамически)
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

    -- 3. Автоубийства
    if autoKillMurderer then
        pcall(function()
            if char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife") then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local enemyRoot = player.Character.HumanoidRootPart
                        rootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, 2)
                        
                        local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
                        if knife then
                            knife.Parent = char
                            knife:Activate()
                        end
                    end
                end
            end
        end)
    end
end)

