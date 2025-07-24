-- Xmehub - Criado por Lucas
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")
local rs = game:GetService("RunService")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "Xmehub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 230, 0, 300)
frame.Position = UDim2.new(0, 20, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -35, 0, 35)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Xmehub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

local function CreateBtn(text, order, func)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 32)
	btn.Position = UDim2.new(0.05, 0, 0, 45 + order * 37)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.AutoButtonColor = true
	btn.Name = text
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	func(btn)
end

-- Variável para controle
local autoDungeonAtivo = false
local dungeonLoop

CreateBtn("Auto Dungeon", 0, function(btn)
	btn.Text = "Auto Dungeon: OFF"
	btn.MouseButton1Click:Connect(function()
		autoDungeonAtivo = not autoDungeonAtivo
		btn.Text = autoDungeonAtivo and "Auto Dungeon: ON" or "Auto Dungeon: OFF"

		if autoDungeonAtivo then
			dungeonLoop = task.spawn(function()
				while autoDungeonAtivo do
					local char = player.Character or player.CharacterAdded:Wait()
					local humanoid = char:FindFirstChild("Humanoid")

					for _, mob in pairs(workspace:GetDescendants()) do
						if not autoDungeonAtivo then break end
						if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 and mob.Name ~= player.Name then
							
							-- Aproxima do inimigo
							humanoid:MoveTo(mob.HumanoidRootPart.Position + Vector3.new(0,2,0))
							wait(0.5)

							-- Troca pra espada
							local sword = player.Backpack:FindFirstChild("Combat") or player.Backpack:FindFirstChildWhichIsA("Tool")
							if sword then
								sword.Parent = player.Character
								wait(0.3)
								vim:SendKeyEvent(true, "Z", false, game); wait(0.2)
								vim:SendKeyEvent(true, "X", false, game); wait(0.2)
								vim:SendKeyEvent(true, "C", false, game); wait(0.2)
								vim:SendKeyEvent(true, "V", false, game); wait(0.2)
							end

							wait(0.4)

							-- Troca pra fruta
							local fruit = player.Backpack:FindFirstChildWhichIsA("Tool")
							if fruit and fruit.Name ~= (sword and sword.Name or "") then
								fruit.Parent = player.Character
								wait(0.3)
								vim:SendKeyEvent(true, "Z", false, game); wait(0.2)
								vim:SendKeyEvent(true, "X", false, game); wait(0.2)
								vim:SendKeyEvent(true, "C", false, game); wait(0.2)
								vim:SendKeyEvent(true, "V", false, game); wait(0.2)
							end

							-- Ativa cliques básicos
							mouse1click()

							-- Se tiver com menos de 50% de vida, ativa tecla R (raça)
							if humanoid.Health / humanoid.MaxHealth < 0.5 then
								vim:SendKeyEvent(true, "R", false, game)
								wait(0.2)
								vim:SendKeyEvent(false, "R", false, game)
							end

							wait(1)
						end
					end
					wait(0.5)
				end
			end)
		else
			if dungeonLoop then
				task.cancel(dungeonLoop)
			end
		end
	end)
end)
