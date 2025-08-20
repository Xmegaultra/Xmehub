--// Hub Meu Mercado! //--

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MeuMercadoHub"

-- Painel principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
frame.Visible = false

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Meu Mercado Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

-- Botão fechar
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 2)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

-- Botão abrir/fechar painel
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 120, 0, 40)
toggleBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
toggleBtn.Text = "Abrir Hub"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
	if frame.Visible then
		toggleBtn.Text = "Fechar Hub"
	else
		toggleBtn.Text = "Abrir Hub"
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	toggleBtn.Text = "Abrir Hub"
end)

-- Status Auto Collect
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -10, 0, 30)
status.Position = UDim2.new(0, 5, 0, 40)
status.Text = "Auto Collect: OFF"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.BackgroundTransparency = 1

-- Botão Auto Collect
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(0, 160, 0, 40)
autoBtn.Position = UDim2.new(0.5, -80, 0, 90)
autoBtn.Text = "Ativar Auto Collect"
autoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Lógica Auto Collect
local farming = false
autoBtn.MouseButton1Click:Connect(function()
	farming = not farming
	if farming then
		autoBtn.Text = "Desativar Auto Collect"
		autoBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		status.Text = "Auto Collect: ON"
	else
		autoBtn.Text = "Ativar Auto Collect"
		autoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		status.Text = "Auto Collect: OFF"
	end
end)

-- Loop de coleta
task.spawn(function()
	while task.wait(1) do
		if farming then
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("ProximityPrompt") and v.Parent.Name == "Collect" then
					pcall(function()
						fireproximityprompt(v)
					end)
				end
			end
		end
	end
end)
