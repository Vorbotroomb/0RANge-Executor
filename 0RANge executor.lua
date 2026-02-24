-- [[ 0RANge Executor - Official Version ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Limpa execuções anteriores
if CoreGui:FindFirstChild("0RANge_System") then CoreGui:FindFirstChild("0RANge_System"):Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "0RANge_System"

-- Janela Principal
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BackgroundTransparency = 0.2
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Borda RGB Superior (Dá o efeito de contorno)
local Border = Instance.new("UIStroke", Main)
Border.Thickness = 2.5
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Barra de Título
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.5
TitleBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "  0RANge Executor"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO X (CANTO SUPERIOR DIREITO)
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0

-- Editor de Texto (Script Box)
local Editor = Instance.new("TextBox", Main)
Editor.Size = UDim2.new(0.94, 0, 0.6, 0)
Editor.Position = UDim2.new(0.03, 0, 0.15, 0)
Editor.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Editor.BackgroundTransparency = 0.4
Editor.Text = ""
Editor.PlaceholderText = "-- Cole seu script aqui..."
Editor.TextColor3 = Color3.fromRGB(255, 165, 0) -- Texto cor Laranja
Editor.Font = Enum.Font.Code
Editor.MultiLine = true
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.TextXAlignment = Enum.TextXAlignment.Left

-- Container para os botões de baixo
local BtnHolder = Instance.new("Frame", Main)
BtnHolder.Size = UDim2.new(1, 0, 0, 50)
BtnHolder.Position = UDim2.new(0, 0, 0.8, 0)
BtnHolder.BackgroundTransparency = 1

local function createBtn(name, text, pos, color)
    local btn = Instance.new("TextButton", BtnHolder)
    btn.Size = UDim2.new(0, 100, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 4)
    return btn
end

local Inject = createBtn("Inject", "INJECT", UDim2.new(0.05, 0, 0, 0), Color3.fromRGB(40, 40, 40))
local Execute = createBtn("Execute", "EXECUTE", UDim2.new(0.38, 0, 0, 0), Color3.fromRGB(30, 80, 30))
local Clear = createBtn("Clear", "CLEAR", UDim2.new(0.71, 0, 0, 0), Color3.fromRGB(80, 50, 20))

-- [[ LÓGICA ]] --

-- Botão de Minimizar/Fechar
CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local Reopen = Instance.new("TextButton", Screen)
    Reopen.Size = UDim2.new(0, 45, 0, 45)
    Reopen.Position = UDim2.new(0, 10, 0.8, 0)
    Reopen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Reopen.Text = "0R"
    Reopen.TextColor3 = Color3.fromRGB(255, 165, 0)
    Reopen.Font = Enum.Font.GothamBold
    local c = Instance.new("UICorner", Reopen) c.CornerRadius = UDim.new(1, 0)
    local s = Instance.new("UIStroke", Reopen) s.Thickness = 2 s.Color = Color3.fromRGB(255, 165, 0)
    
    Reopen.MouseButton1Click:Connect(function()
        Main.Visible = true
        Reopen:Destroy()
    end)
end)

-- Botões de Ação
Execute.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(Editor.Text)()
    end)
    if not success then warn("0RANge Erro: " .. err) end
end)

Clear.MouseButton1Click:Connect(function() Editor.Text = "" end)

Inject.MouseButton1Click:Connect(function()
    print("0RANge: Delta Detectado. Pronto para execução.")
end)

-- LOOP RGB (Borda e Título)
spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            local color = Color3.fromHSV(i, 0.8, 1)
            Border.Color = color
            Title.TextColor3 = color
            task.wait(0.01)
        end
    end
end)
