-- Xmehub - Auto Dungeon King Legacy (estilo OMG Hub) -- Criado por Lucas

local Players = game:GetService("Players") local RunService = game:GetService("RunService") local VirtualInputManager = game:GetService("VirtualInputManager") local TweenService = game:GetService("TweenService") local UserInputService = game:GetService("UserInputService") local player = Players.LocalPlayer local char = player.Character or player.CharacterAdded:Wait() local humanoidRootPart = char:WaitForChild("HumanoidRootPart")

local enabled = false local guiVisible = true local distanceAbove = 8 local tweenSpeed = 100

-- Interface do Hub local gui = Instance.new("ScreenGui", game.CoreGui) gui.Name = "Xmehub"

-- Janela principal local frame = Instance.new("Frame", gui) frame.Size = UDim2.new(0, 200, 0, 100) frame.Position = UDim2.new(0, 10, 0, 10) frame.BackgroundColor3 = Color3.new(0, 0, 0) frame.BorderSizePixel = 0 dragging = false

-- Título local title = Instance.new("TextLabel", frame) title.Size = UDim2.new(1, 0, 0, 30) title.Text = "Xmehub - Auto Dungeon" title.TextColor3 = Color3.new(1, 1, 1) title.BackgroundTransparency = 1

-- Botão Toggle ON/OFF local toggle = Instance.new("TextButton", frame) toggle.Size = UDim2.new(1, -20, 0, 40) toggle.Position = UDim2.new(0, 10, 0, 40) toggle.Text = "[ OFF ]" toggle.TextColor3 = Color3.new(1, 1, 1) toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) toggle.BorderSizePixel = 0

-- Botão abrir interface local openButton = Instance.new("TextButton", gui) openButton.Size = UDim2.new(0, 80, 0, 30) openButton.Position = UDim2.new(0, 10, 0, 120) openButton.Text = "Abrir Hub" openButton.TextColor3 = Color3.new(1, 1, 1) openButton.BackgroundColor3 = Color3.new(0, 0, 0) openButton.BorderSizePixel = 0 openButton.Visible = false

openButton.MouseButton1Click:Connect(function() frame.Visible = true guiVisible = true openButton.Visible = false end)

-- Arrastar a interface frame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = frame.Position end end)

frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then local delta = input.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

-- Tecla fechar interface (F) UserInputService.InputBegan:Connect(function(input, gameProcessed) if input.KeyCode == Enum.KeyCode.F and not gameProcessed then guiVisible = not guiVisible frame.Visible = guiVisible openButton.Visible = not guiVisible end end)

-- Função de ataque usando teclas local function usarSkills() for _, key in ipairs({"Z", "X", "C", "V"}) do VirtualInputManager:SendKeyEvent(true, key, false, game) task.wait(0.1) VirtualInputManager:SendKeyEvent(false, key, false, game) end end

-- Ativa a Raça (quando vida abaixo de 50%) local function ativarRaca() local humanoid = char:FindFirstChildOfClass("Humanoid") if humanoid and humanoid.Health / humanoid.MaxHealth < 0.5 then VirtualInputManager:SendKeyEvent(true, "R", false, game) task.wait(0.1) VirtualInputManager:SendKeyEvent(false, "R", false, game) end end

-- Alterna entre espada e fruta (se existirem) local function alternarEstilos() local mochila = player.Backpack for _, item in ipairs(mochila:GetChildren()) do if item:IsA("Tool") and (item.Name:lower():find("sword") or item.Name:lower():find("fruit")) then player.Character.Humanoid:EquipTool(item) usarSkills() task.wait(0.2) end end end

-- Loop principal RunService.RenderStepped:Connect(function() if not enabled then return end local inimigos = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Enemy") if inimigos then for _, npc in ipairs(inimigos:GetChildren()) do if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 and npc:FindFirstChild("HumanoidRootPart") then local alvo = npc.HumanoidRootPart local destino = alvo.Position + Vector3.new(0, distanceAbove, 0) local tween = TweenService:Create(humanoidRootPart, TweenInfo.new((humanoidRootPart.Position - destino).Magnitude / tweenSpeed, Enum.EasingStyle.Linear), {Position = destino}) tween:Play() tween.Completed:Wait() alternarEstilos() ativarRaca() end end end end)

-- Botão ON/OFF local function atualizarBotao() toggle.Text = enabled and "[ ON ]" or "[ OFF ]" toggle.BackgroundColor3 = enabled and Color3.new(0, 0.6, 0) or Color3.new(0.2, 0.2, 0.2) end

toggle.MouseButton1Click:Connect(function() enabled = not enabled atualizarBotao() end)

atualizarBotao()


