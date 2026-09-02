

local P = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CS = game:GetService("CollectionService")

local gui = Instance.new("ScreenGui", P:WaitForChild("PlayerGui"))
gui.Name = "MiniHub"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(620, 400)
main.Position = UDim2.new(.5,-310,.5,-200)
main.BackgroundColor3 = Color3.fromRGB(35,20,30)
main.Active = true
main.Draggable = true
Instance.new("UICorner",main).CornerRadius = UDim.new(0,18)

local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,55)
title.Text = "⚡ Thunder Mini Hub"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 23
title.BackgroundTransparency = 1

local tabs = Instance.new("Frame",main)
tabs.Position = UDim2.fromOffset(10,60)
tabs.Size = UDim2.new(0,150,1,-70)
tabs.BackgroundTransparency = 1

local page = Instance.new("Frame",main)
page.Position = UDim2.fromOffset(170,65)
page.Size = UDim2.new(1,-185,1,-80)
page.BackgroundTransparency = 1

local function clear()
	for _,v in ipairs(page:GetChildren()) do v:Destroy() end
end

local function button(text,y,callback)
	local b=Instance.new("TextButton",page)
	b.Size=UDim2.new(1,0,0,45)
	b.Position=UDim2.fromOffset(0,y)
	b.Text=text
	b.TextSize=17
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=Color3.fromRGB(75,35,55)
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
	b.MouseButton1Click:Connect(callback)
	return b
end

local function tab(text,y,callback)
	local b=Instance.new("TextButton",tabs)
	b.Size=UDim2.new(1,0,0,45)
	b.Position=UDim2.fromOffset(0,y)
	b.Text=text
	b.TextSize=16
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=Color3.fromRGB(50,25,40)
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
	b.MouseButton1Click:Connect(callback)
end

local function character()
	clear()

	local speed=false
	local jump=false

	button("🏃 Скорость: OFF",10,function()
		speed=not speed
		local h=P.Character and P.Character:FindFirstChildOfClass("Humanoid")
		if h then h.WalkSpeed=speed and 28 or 16 end
	end)

	button("🦘 Высокий прыжок: OFF",65,function()
		jump=not jump
		local h=P.Character and P.Character:FindFirstChildOfClass("Humanoid")
		if h then h.JumpPower=jump and 80 or 50 end
	end)

	button("🔄 Персонаж",120,function()
		P:LoadCharacter()
	end)
end

local function teleport()
	clear()

	local function weapon()
		local c=P.Character
		local root=c and c:FindFirstChild("HumanoidRootPart")
		if not root then return end

		local best,dist
		for _,v in ipairs(CS:GetTagged("Weapon")) do
			local p=v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
			if p then
				local d=(p.Position-root.Position).Magnitude
				if not dist or d<dist then best,dist=p,d end
			end
		end

		if best then
			root.CFrame=best.CFrame+Vector3.new(0,3,0)
		end
	end

	button("📍 Телепорт к оружию",10,weapon)

	local auto=false
	local b=button("🔫 Автоподбор: OFF",65,function()
		auto=not auto
		b.Text="🔫 Автоподбор: "..(auto and "ON" or "OFF")
	end)

	task.spawn(function()
		while gui.Parent do
			task.wait(.7)
			if auto then weapon() end
		end
	end)
end

local function combat()
	clear()
	button("⚔️ Режим боя",10,function()
		print("Боевой режим включён")
	end)
	button("🎯 Сбросить режим",65,function()
		print("Боевой режим выключен")
	end)
end

local function visual()
	clear()
	button("👁️ Показать подсказку",10,function()
		print("Визуальные функции твоей игры")
	end)
	button("🔄 Обновить",65,function()
		print("Обновлено")
	end)
end

tab("👤 Персонаж",5,character)
tab("📍 Телепорт",55,teleport)
tab("⚔️ Бой",105,combat)
tab("👁️ Визуал",155,visual)

local close=Instance.new("TextButton",main)
close.Size=UDim2.fromOffset(35,35)
close.Position=UDim2.new(1,-45,0,10)
close.Text="×"
close.TextSize=25
close.TextColor3=Color3.new(1,1,1)
close.BackgroundTransparency=1
close.MouseButton1Click:Connect(function()
	gui.Enabled=false
end)

UIS.InputBegan:Connect(function(input,gp)
	if not gp and input.KeyCode==Enum.KeyCode.RightShift then
		gui.Enabled=not gui.Enabled
	end
end)

character()
