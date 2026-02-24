-- [[ 0RANge Executor - Backdoor Scanner Edition ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Cleanup
if CoreGui:FindFirstChild("0RANge_System") then CoreGui:FindFirstChild("0RANge_System"):Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "0RANge_System"

-- MAIN FRAME
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BackgroundTransparency = 0.2
Main.Active = true
Main.Draggable = true

local Border = Instance.new("UIStroke", Main)
Border.Thickness = 3
Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- TITLE BAR
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.5

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "  0RANge Executor | v1.2"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE BUTTON (X)
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0

-- EDITOR
local Editor = Instance.new("TextBox", Main)
Editor.Size = UDim2.new(0.94, 0, 0.55, 0)
Editor.Position = UDim2.new(0.03, 0, 0.18, 0)
Editor.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Editor.BackgroundTransparency = 0.4
Editor.Text = ""
Editor.PlaceholderText = "-- Paste your script here..."
Editor.TextColor3 = Color3.fromRGB(255, 255, 255)
Editor.Font = Enum.Font.Code
Editor.MultiLine = true
Editor.TextYAlignment = Enum.TextYAlignment.Top
Editor.TextXAlignment = Enum.TextXAlignment.Left

-- BUTTONS
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

local Scan = createBtn("Scan", "SCAN", UDim2.new(0.05, 0, 0.8, 0), Color3.fromRGB(40, 40, 80))
local Execute = createBtn("Execute", "EXECUTE", UDim2.new(0.38, 0, 0.8, 0), Color3.fromRGB(30, 80, 30))
local Clear = createBtn("Clear", "CLEAR", UDim2.new(0.71, 0, 0.8, 0), Color3.fromRGB(80, 50, 20))

-- [[ NOTIFICATION SYSTEM (BADGE STYLE) ]] --
local function ShowBadge(hasBackdoor)
    local BadgeFrame = Instance.new("Frame", Screen)
    BadgeFrame.Size = UDim2.new(0, 300, 0, 80)
    BadgeFrame.Position = UDim2.new(1, 5, 0.8, 0) -- Starts off-screen
    BadgeFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", BadgeFrame)
    Instance.new("UIStroke", BadgeFrame).Color = Color3.fromRGB(255, 165, 0)

    local Icon = Instance.new("ImageLabel", BadgeFrame)
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0, 10, 0, 10)
    Icon.Image = hasBackdoor and "rbxassetid://5314809914" or "rbxassetid://17650278331"
    Icon.BackgroundTransparency = 1

    local Msg = Instance.new("TextLabel", BadgeFrame)
    Msg.Size = UDim2.new(0, 210, 0, 60)
    Msg.Position = UDim2.new(0, 80, 0, 10)
    Msg.BackgroundTransparency = 1
    Msg.TextColor3 = Color3.fromRGB(255, 255, 255)
    Msg.TextWrapped = true
    Msg.Font = Enum.Font.GothamMedium
    Msg.TextSize = 12
    Msg.Text = hasBackdoor and "YES!!! theres a backdoor in the game and you can hack FE" or "No backdoor in the game..."

    -- Animation (Slide in then out)
    BadgeFrame:TweenPosition(UDim2.new(1, -310, 0.8, 0), "Out", "Back", 0.5)
    task.wait(4)
    BadgeFrame:TweenPosition(UDim2.new(1, 5, 0.8, 0), "In", "Quad", 0.5)
    task.delay(0.6, function() BadgeFrame:Destroy() end)
end

-- [[ LOGIC ]] --
Scan.MouseButton1Click:Connect(function()
    print("[0RANge]: Scanning for backdoors...")
    local detected = false
    
    -- Real scan logic for common backdoors
    local targets = {game.ReplicatedStorage, game.JointsService}
    for _, folder in pairs(targets) do
        for _, v in pairs(folder:GetDescendants()) do
            if v:IsA("RemoteEvent") and (v.Name == "Handshake" or v.Name == "Midas" or v.Name:find("Backdoor")) then
                detected = true
            end
        end
    end
    
    ShowBadge(detected)
end)

Execute.MouseButton1Click:Connect(function()
    local success, err = pcall(function() loadstring(Editor.Text)() end)
    if not success then warn("Error: "..err) end
end)

Clear.MouseButton1Click:Connect(function() Editor.Text = "" end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local Reopen = Instance.new("TextButton", Screen)
    Reopen.Size = UDim2.new(0, 50, 0, 50)
    Reopen.Position = UDim2.new(0, 10, 0.5, 0)
    Reopen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Reopen.Text = "0R"
    Reopen.TextColor3 = Color3.fromRGB(255, 165, 0)
    Reopen.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Reopen).CornerRadius = UDim.new(1, 0)
    
    Reopen.MouseButton1Click:Connect(function()
        Main.Visible = true
        Reopen:Destroy()
    end)
end)

-- RGB LOOP
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
