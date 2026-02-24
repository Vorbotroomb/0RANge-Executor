-- [[ 0RANge Executor - Particle Maker Edition ]] --
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

if CoreGui:FindFirstChild("0RANge_System") then CoreGui:FindFirstChild("0RANge_System"):Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "0RANge_System"

-- MAIN WINDOW
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

-- SIDEBAR BUTTON (HUB)
local SideBtn = Instance.new("TextButton", Main)
SideBtn.Size = UDim2.new(0, 30, 0, 100)
SideBtn.Position = UDim2.new(1, 2, 0.3, 0)
SideBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideBtn.Text = "H\nU\nB"
SideBtn.TextColor3 = Color3.fromRGB(255, 165, 0)
SideBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SideBtn)

-- SCRIPT HUB PANEL
local HubFrame = Instance.new("Frame", Main)
HubFrame.Size = UDim2.new(0, 180, 0, 280)
HubFrame.Position = UDim2.new(1, 35, 0, 0)
HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
HubFrame.BackgroundTransparency = 0.2
HubFrame.Visible = false
Instance.new("UIStroke", HubFrame).Color = Color3.fromRGB(255, 165, 0)
Instance.new("UICorner", HubFrame)

local HubTitle = Instance.new("TextLabel", HubFrame)
HubTitle.Size = UDim2.new(1, 0, 0, 30)
HubTitle.Text = "0RANge HUB"
HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HubTitle.BackgroundTransparency = 1
HubTitle.Font = Enum.Font.GothamBold

-- PARTICLE MAKER UI (Inside Hub)
local PartColor = Color3.fromRGB(255, 165, 0)

local function addHubBtn(name, pos, callback)
    local b = Instance.new("TextButton", HubFrame)
    b.Size = UDim2.new(0.9, 0, 0, 25)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", b)
end

-- External Scripts
addHubBtn("c00lgui", UDim2.new(0.05, 0, 0, 40), function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-c00lgui-official-85084"))()
end)

addHubBtn("Ro-Xploit", UDim2.new(0.05, 0, 0, 70), function()
    loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-RoXploit-by-KrystalTeam-9328"))()
end)

-- Particle Settings
local PTitle = Instance.new("TextLabel", HubFrame)
PTitle.Text = "-- Particle Maker --"
PTitle.Size = UDim2.new(1,0,0,20)
PTitle.Position = UDim2.new(0,0,0,110)
PTitle.BackgroundTransparency = 1
PTitle.TextColor3 = Color3.fromRGB(255,165,0)
PTitle.Font = Enum.Font.Code

local PSize = Instance.new("TextBox", HubFrame)
PSize.PlaceholderText = "Size (ex: 2)"
PSize.Size = UDim2.new(0.9,0,0,25)
PSize.Position = UDim2.new(0.05,0,0,135)
PSize.BackgroundColor3 = Color3.fromRGB(5,5,5)
PSize.TextColor3 = Color3.white

addHubBtn("Set Color: Rainbow", UDim2.new(0.05, 0, 0, 165), function() PartColor = "Rainbow" end)
addHubBtn("Set Color: Orange", UDim2.new(0.05, 0, 0, 195), function() PartColor = Color3.fromRGB(255,165,0) end)

addHubBtn("SPAWN ON ALL", UDim2.new(0.05, 0, 0, 230), function()
    local size = tonumber(PSize.Text) or 1
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pe = Instance.new("ParticleEmitter", p.Character.HumanoidRootPart)
            pe.Size = NumberSequence.new(size)
            pe.Rate = 50
            pe.Lifetime = NumberRange.new(1, 2)
            pe.VelocityResistance = 0.5
            if PartColor == "Rainbow" then
                spawn(function()
                    while pe do
                        pe.Color = ColorSequence.new(Color3.fromHSV(tick() % 5 / 5, 1, 1))
                        task.wait(0.1)
                    end
                end)
            else
                pe.Color = ColorSequence.new(PartColor)
            end
        end
    end
end)

-- TOGGLE HUB
SideBtn.MouseButton1Click:Connect(function() HubFrame.Visible = not HubFrame.Visible end)

-- TITLE BAR & CLOSE
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.5
local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "  0RANge Executor"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.white
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.white

-- EDITOR & BUTTONS (Scan, Execute, Clear)
local Editor = Instance.new("TextBox", Main)
Editor.Size = UDim2.new(0.94, 0, 0.5, 0)
Editor.Position = UDim2.new(0.03, 0, 0.18, 0)
Editor.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Editor.BackgroundTransparency = 0.4
Editor.Text = ""
Editor.PlaceholderText = "-- Paste your custom script here..."
Editor.TextColor3 = Color3.white
Editor.MultiLine = true
Editor.Font = Enum.Font.Code

local function createMainBtn(text, pos, color)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    return btn
end

local Scan = createMainBtn("SCAN", UDim2.new(0.05, 0, 0.8, 0), Color3.fromRGB(40, 40, 80))
local Execute = createMainBtn("EXECUTE", UDim2.new(0.38, 0, 0.8, 0), Color3.fromRGB(30, 80, 30))
local Clear = createMainBtn("CLEAR", UDim2.new(0.71, 0, 0.8, 0), Color3.fromRGB(80, 50, 20))

-- NOTIFICATION
local function ShowBadge(hasBackdoor)
    local BadgeFrame = Instance.new("Frame", Screen)
    BadgeFrame.Size = UDim2.new(0, 300, 0, 80)
    BadgeFrame.Position = UDim2.new(1, 5, 0.8, 0)
    BadgeFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", BadgeFrame)
    local Icon = Instance.new("ImageLabel", BadgeFrame)
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0, 10, 0, 10)
    Icon.Image = hasBackdoor and "rbxassetid://5314809914" or "rbxassetid://17650278331"
    Icon.BackgroundTransparency = 1
    local Msg = Instance.new("TextLabel", BadgeFrame)
    Msg.Size = UDim2.new(0, 210, 0, 60)
    Msg.Position = UDim2.new(0, 80, 0, 10)
    Msg.BackgroundTransparency = 1
    Msg.TextColor3 = Color3.white
    Msg.Text = hasBackdoor and "YES!!! theres a backdoor in the game and you can hack FE" or "No backdoor in the game..."
    Msg.TextWrapped = true
    BadgeFrame:TweenPosition(UDim2.new(1, -310, 0.8, 0), "Out", "Back", 0.5)
    task.wait(4)
    BadgeFrame:TweenPosition(UDim2.new(1, 5, 0.8, 0), "In", "Quad", 0.5)
    task.delay(0.6, function() BadgeFrame:Destroy() end)
end

Scan.MouseButton1Click:Connect(function()
    local detected = game.ReplicatedStorage:FindFirstChild("Handshake") or false
    ShowBadge(detected)
end)

Execute.MouseButton1Click:Connect(function() loadstring(Editor.Text)() end)
Clear.MouseButton1Click:Connect(function() Editor.Text = "" end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    local Reopen = Instance.new("TextButton", Screen)
    Reopen.Size = UDim2.new(0, 50, 0, 50)
    Reopen.Position = UDim2.new(0, 10, 0.5, 0)
    Reopen.Text = "0R"
    Reopen.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Reopen.TextColor3 = Color3.fromRGB(255, 165, 0)
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
