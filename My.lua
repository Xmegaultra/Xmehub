--// Variáveis principais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")

--// Criando o GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCollectGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Painel principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 120)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "💰 Auto Collect"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Parent = MainFrame

-- Botão abrir (escondido inicialmente)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 100, 0, 30)
OpenBtn.Position = UDim2.new(0.5, -50, 0.5, -15)
OpenBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
OpenBtn.Text = "Abrir GUI"
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 18
OpenBtn.TextColor3 = Color3.fromRGB(255,255,255)
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui

-- Função fechar/abrir sem matar script
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

--// Auto collect do dinheiro
local function collectMoney()
    -- Aqui ele procura todos os "Buttons" verdes (ex: dinheiro)
    for i, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("TouchTransmitter") or obj:IsA("ClickDetector") then
            if obj.Parent and obj.Parent:FindFirstChild("BillboardGui") then
                local gui = obj.Parent.BillboardGui
                if gui.Frame and gui.Frame.BackgroundColor3 == Color3.fromRGB(0, 255, 0) then
                    -- Teleportar jogador pro botão rapidamente e ativar
                    player.Character.HumanoidRootPart.CFrame = obj.Parent.CFrame
                    if obj:IsA("ClickDetector") then
                        fireclickdetector(obj)
                    end
                end
            end
        end
    end
end

-- Loop infinito de coleta
RunService.RenderStepped:Connect(function()
    if MainFrame.Visible then
        collectMoney()
    end
end)
