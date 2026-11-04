local name = "scriptmine";
local ownerid = "hMEBirGNhJ";
local version = "1.0";

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function createGui(n)
    local gui = Instance.new("ScreenGui")
    gui.Name = n
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return gui
end

local menuGui = createGui("ScriptMineMenu")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 230)
frame.Position = UDim2.new(0.5, -200, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = menuGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
local st = Instance.new("UIStroke", frame)
st.Color = Color3.fromRGB(0, 200, 120)
st.Thickness = 2

local t = Instance.new("TextLabel", frame)
t.Size = UDim2.new(1, 0, 0, 50)
t.BackgroundTransparency = 1
t.Text = "SCRIPTMINE"
t.TextColor3 = Color3.fromRGB(0, 220, 130)
t.Font = Enum.Font.GothamBlack
t.TextSize = 26

local sub = Instance.new("TextLabel", frame)
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 50)
sub.BackgroundTransparency = 1
sub.Text = "Build A Boat For Treasure  •  v" .. version
sub.TextColor3 = Color3.fromRGB(160, 160, 180)
sub.Font = Enum.Font.Gotham
sub.TextSize = 13

local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(1, -48, 0, 54)
startBtn.Position = UDim2.new(0, 24, 0, 95)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 190, 110)
startBtn.BorderSizePixel = 0
startBtn.Text = "▶  Включить скрипт"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 17
startBtn.AutoButtonColor = false
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

startBtn.MouseEnter:Connect(function()
    TweenService:Create(startBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 220, 130)}):Play()
end)
startBtn.MouseLeave:Connect(function()
    TweenService:Create(startBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 190, 110)}):Play()
end)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(1, -48, 0, 22)
closeBtn.Position = UDim2.new(0, 24, 0, 165)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "Закрыть меню"
closeBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
closeBtn.Font = Enum.Font.Gotham
closeBtn.TextSize = 12

closeBtn.MouseButton1Click:Connect(function()
    menuGui:Destroy()
end)

startBtn.MouseButton1Click:Connect(function()
    menuGui:Destroy()
    pcall(function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Build-A-Boat-For-Treasure-OP-ARBIX-HUB-KEYLESS-15-BUTTONS-AUTOFARM-GOLDS-AND-MORE-234117"))()
    end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
        if menuGui and menuGui.Parent then menuGui:Destroy() end
    end
end)
