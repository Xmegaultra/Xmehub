--// AUTO COLLECT MY MARKET - KRNL

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCollectGUI"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 180, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "ON / OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ToggleButton.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 20)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Parent = MainFrame

-- Abrir/fechar GUI
local guiOpen = true
CloseButton.MouseButton1Click:Connect(function()
    guiOpen = not guiOpen
    MainFrame.Visible = guiOpen
end)

-- Toggle Auto Collect
local autoCollect = false
ToggleButton.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    ToggleButton.Text = autoCollect and "ON" or "OFF"
end)

--// Função Auto Collect
local function collectMoney()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            -- Detecta dinheiro verde chamativo
            if obj.Size.Magnitude < 5 and obj.BrickColor == BrickColor.new("Bright green") then
                pcall(function()
                    -- Teleporta rapidinho o player sobre o money button
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                end)
            end
        end
    end
end

-- Loop para coletar automaticamente
RunService.RenderStepped:Connect(function()
    if autoCollect then
        collectMoney()
    end
end)
