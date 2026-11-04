local name = "scriptmine";
local ownerid = "hMEBirGNhJ";
local version = "1.0";

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function createGui(n)
    local gui = Instance.new("ScreenGui")
    gui.Name = n
    gui.ResetOnSpawn = false
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return gui
end

-- МЕНЮ
local menuGui = createGui("ScriptMineMenu")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 200)
frame.Position = UDim2.new(0.5, -170, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = menuGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local st = Instance.new("UIStroke", frame)
st.Color = Color3.fromRGB(0, 200, 120)
st.Thickness = 2

local t = Instance.new("TextLabel", frame)
t.Size = UDim2.new(1, 0, 0, 45)
t.BackgroundTransparency = 1
t.Text = "SCRIPTMINE"
t.TextColor3 = Color3.fromRGB(0, 220, 130)
t.Font = Enum.Font.GothamBlack
t.TextSize = 24

local sub = Instance.new("TextLabel", frame)
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 45)
sub.BackgroundTransparency = 1
sub.Text = "Build A Boat For Treasure • v" .. version
sub.TextColor3 = Color3.fromRGB(160, 160, 180)
sub.Font = Enum.Font.Gotham
sub.TextSize = 12

local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(1, -40, 0, 50)
startBtn.Position = UDim2.new(0, 20, 0, 85)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 190, 110)
startBtn.BorderSizePixel = 0
startBtn.Text = "▶ Включить скрипт"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 17
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1, -40, 0, 20)
info.Position = UDim2.new(0, 20, 0, 145)
info.BackgroundTransparency = 1
info.Text = "Нажми кнопку, чтобы загрузить скрипт"
info.TextColor3 = Color3.fromRGB(140, 140, 160)
info.Font = Enum.Font.Gotham
info.TextSize = 12

startBtn.MouseButton1Click:Connect(function()
    menuGui:Destroy()
    pcall(function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Build-A-Boat-For-Treasure-OP-ARBIX-HUB-KEYLESS-15-BUTTONS-AUTOFARM-GOLDS-AND-MORE-234117"))()
    end)
end)
