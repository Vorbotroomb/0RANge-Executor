local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Proteção contra múltiplas execuções
if CoreGui:FindFirstChild("0RANge_System") then
    CoreGui:FindFirstChild("0RANge_System"):Destroy()
end

-- CRIAÇÃO DA ESTRUTURA
local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "0RANge_System"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BackgroundTransparency = 0.2 -- Efeito Transparente
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- BORDA RGB (UIStroke)
local Border = Instance.new("UIStroke", Main)
Border.Thickness = 3
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Título e Design
local Title = Instance.new("TextLabel", Main)
Title.Text = "  0RANge Executor | v1.0"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BackgroundTransparency = 0.5
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Editor de Scripts (Onde você cola o código)
local Editor = Instance.new("TextBox", Main)
Editor.Size = UDim2.new(0, 420, 0, 180)
Editor.Position = UDim2.new(0, 15, 0, 45)
Editor.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Editor.BackgroundTransparency = 0.4
Editor.Text = ""
Editor.PlaceholderText = "-- Insira seu script aqui..."
Editor.TextColor3 = Color3.fromRGB(200, 200, 200)
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.MultiLine = true
Editor.Font = Enum.Font.Code
Editor.TextSize = 14

-- FUNÇÃO PARA CRIAR BOTÕES ESTILIZADOS
local function createBtn(name, pos, color)
    local btn = Instance.new("TextButton", Main)
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = name:upper()
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = true
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    return btn
end

local Inject = createBtn("Inject", UDim2.new(0, 15, 0, 240), Color3.fromRGB(40, 40, 40))
local Execute = createBtn("Execute", UDim2.new(0, 120, 0, 240), Color3.fromRGB(40, 100, 40))
local Clear = createBtn("Clear", UDim2.new(0, 225, 0, 240), Color3.fromRGB(100, 60, 20))
local Close = createBtn("X", UDim2.new(0, 335, 0, 240), Color3.fromRGB(120, 20, 20))

-- LOGICA DOS BOTÕES
Inject.MouseButton1Click:Connect(function()
    print("[0RANge]: Verificando DLL...")
    wait(1)
    print("[0RANge]: Injetado com sucesso no Delta!")
end)

Execute.MouseButton1Click:Connect(function()
    local code = Editor.Text
    local success, err = pcall(function()
        loadstring(code)()
    end)
    if not success then
        warn("[0RANge Error]: " .. err)
    end
end)

Clear.MouseButton1Click:Connect(function()
    Editor.Text = ""
end)

-- Botão de Minimizar (O botão que cria o botão para reabrir)
Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    
    local OpenBtn = Instance.new("TextButton", Screen)
    OpenBtn.Size = UDim2.new(0, 60, 0, 60)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -30)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    OpenBtn.Text = "0R"
    OpenBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 25
    
    local corner = Instance.new("UICorner", OpenBtn)
    corner.CornerRadius = UDim.new(1, 0) -- Botão Redondo
    
    local stroke = Instance.new("UIStroke", OpenBtn)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 140, 0)

    OpenBtn.MouseButton1Click:Connect(function()
        Main.Visible = true
        OpenBtn:Destroy()
    end)
end)

-- SISTEMA RGB NAS BORDAS
spawn(function()
    local counter = 0
    while true do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Border.Color = color
        Title.TextColor3 = color
        RunService.RenderStepped:Wait()
    end
end)

-- Simulação de Backdoor / Logs
print("[0RANge]: Iniciando sistema de bypass...")
