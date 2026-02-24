-- [[ 0RANge Executor - Backdoor & Particles Edition ]] --
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Limpa execuções anteriores
if CoreGui:FindFirstChild("0RANge_System") then CoreGui:FindFirstChild("0RANge_System"):Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "0RANge_System"

-- JANELA PRINCIPAL
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BackgroundTransparency = 0.2
Main.Active = true
Main.Draggable = true

local Border = Instance.new("UIStroke", Main)
Border.Thickness = 2.5
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- BARRA DE TÍTULO
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.5

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "  0RANge Executor | FE Particle Ready"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO X (FECHAR/MINIMIZAR) NO CANTO SUPERIOR DIREITO
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BorderSizePixel = 0

-- EDITOR
local Editor = Instance.new("TextBox", Main)
Editor.Size = UDim2.new(0.94, 0, 0.6, 0)
Editor.Position = UDim2.new(0.03, 0, 0.15, 0)
Editor.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Editor.BackgroundTransparency = 0.4
Editor.Text = ""
Editor.PlaceholderText = "-- Cole seu script de partículas aqui..."
Editor.TextColor3 = Color3.fromRGB(255, 165, 0)
Editor.Font = Enum.Font.Code
Editor.MultiLine = true
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÕES INFERIORES
local function createBtn(name, text, pos, color)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Inject = createBtn("Inject", "INJECT", UDim2.new(0.05, 0, 0.82, 0), Color3.fromRGB(40, 40, 40))
local Execute = createBtn("Execute", "EXECUTE", UDim2.new(0.38, 0, 0.82, 0), Color3.fromRGB(30, 80, 30))
local Clear = createBtn("Clear", "CLEAR", UDim2.new(0.71, 0, 0.82, 0), Color3.fromRGB(80, 50, 20))

--- LÓGICA ---

-- O QUE O INJECT FAZ (BUSCA DE BACKDOOR/PARTICULA FE)
Inject.MouseButton1Click:Connect(function()
    print("[0RANge]: Escaneando Remotes para Partículas FE...")
    local found = 0
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("particle") or v.Name:lower():find("effect")) then
            found = found + 1
            print("[0RANge]: Possível vulnerabilidade FE encontrada em: " .. v.Name)
        end
    end
    if found == 0 then
        print("[0RANge]: Nenhum Remote direto de partícula achado. Usando modo de simulação.")
    end
    print("[0RANge]: Injetado e Pronto!")
end)

Execute.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(Editor.Text)()
    end)
    if not success then warn("Erro: " .. err) end
end)

Clear.MouseButton1Click:Connect(function() Editor.Text = "" end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local Reopen = Instance.new("TextButton", Screen)
    Reopen.Size = UDim2.new(0, 50, 0, 50)
    Reopen.Position = UDim2.new(0, 15, 0.5, 0)
    Reopen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Reopen.Text = "0R"
    Reopen.TextColor3 = Color3.fromRGB(255, 165, 0)
    Reopen.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Reopen).CornerRadius = UDim.new(1, 0)
    local s = Instance.new("UIStroke", Reopen) s.Thickness = 2 s.Color = Color3.fromRGB(255, 165, 0)
    
    Reopen.MouseButton1Click:Connect(function()
        Main.Visible = true
        Reopen:Destroy()
    end)
end)

-- LOOP RGB
spawn(function()
    while true do
        for i = 0, 1, 0.005 do
            local color = Color3.fromHSV(i, 1, 1)
            Border.Color = color
            Title.TextColor3 = color
            task.wait(0.01)
        end
    end
end)
