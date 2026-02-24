local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

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

-- SIDEBAR BUTTON
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
HubFrame.Size = UDim2.new(0, 150, 0, 250)
HubFrame.Position = UDim2.new(1, 35, 0, 10)
HubFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
HubFrame.BackgroundTransparency = 0.3
HubFrame.Visible = false
Instance.new("UIStroke", HubFrame).Color = Color3.fromRGB(255, 165, 0)

local HubTitle = Instance.new("TextLabel", HubFrame)
HubTitle.Size = UDim2.new(1, 0, 0, 30)
HubTitle.Text = "SCRIPT HUB"
HubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HubTitle.BackgroundTransparency = 1
HubTitle.Font = Enum.Font.GothamBold

-- FUNCTIONS FOR HUB BUTTONS
local function addHubBtn(name, callback)
    local currentButtons = 0
    for _, v in pairs(HubFrame:GetChildren()) do
        if v:IsA("TextButton") then currentButtons = currentButtons + 1 end
    end
    
    local b = Instance.new("TextButton", HubFrame)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0,
