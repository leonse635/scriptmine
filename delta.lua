local name = "scriptmine";
local ownerid = "hMEBirGNhJ";
local version = "1.0";

local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")
local CoreGui     = game:GetService("CoreGui")

local API_URL   = "https://keyauth.win/api/1.2/"
local sessionId = HttpService:GenerateGUID(false):gsub("-", "")

local function apiCall(params)
    params.sessionid = sessionId
    params.name      = name
    params.ownerid   = ownerid
    local body = {}
    for k, v in pairs(params) do
        body[#body+1] = tostring(k) .. "=" .. tostring(v)
    end
    local ok, res = pcall(function()
        return game:HttpGet(API_URL .. "?" .. table.concat(body, "&"))
    end)
    if not ok or not res then
        return { success = false, message = "Network error" }
    end
    local ok2, decoded = pcall(function() return HttpService:JSONDecode(res) end)
    if not ok2 or not decoded then
        return { success = false, message = "Invalid response" }
    end
    return decoded
end

apiCall({ type = "init", ver = version })

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

-- АВТОРИЗАЦИЯ
local authGui = createGui("ScriptMineKeyAuth")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 230)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -115)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = authGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "SCRIPTMINE — KeyAuth"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "v" .. version .. " • Secure License"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.Parent = mainFrame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 40)
box.Position = UDim2.new(0, 20, 0, 80)
box.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
box.BorderSizePixel = 0
box.Text = ""
box.PlaceholderText = "Введите лицензионный ключ..."
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
box.Font = Enum.Font.Gotham
box.TextSize = 15
box.ClearTextOnFocus = false
box.Parent = mainFrame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -40, 0, 42)
btn.Position = UDim2.new(0, 20, 0, 135)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.BorderSizePixel = 0
btn.Text = "Проверить ключ"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 15
btn.Parent = mainFrame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 30)
status.Position = UDim2.new(0, 20, 0, 188)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextWrapped = true
status.Parent = mainFrame

-- МЕНЮ
local function buildMenuGui()
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

    startBtn.MouseButton1Click:Connect(function()
        menuGui:Destroy()
        pcall(function()
            loadstring(game:HttpGet("https://scriptblox.com/raw/Build-A-Boat-For-Treasure-OP-ARBIX-HUB-KEYLESS-15-BUTTONS-AUTOFARM-GOLDS-AND-MORE-234117"))()
        end)
    end)

    return menuGui
end

-- ПРОВЕРКА
local checking = false
btn.MouseButton1Click:Connect(function()
    if checking then return end
    checking = true
    status.TextColor3 = Color3.fromRGB(255, 200, 80)
    status.Text = "Проверка ключа..."
    btn.Text = "Проверка..."

    task.spawn(function()
        local res = apiCall({
            type = "license",
            key  = box.Text,
            hwid = game:GetService("RbxAnalyticsService"):GetClientId(),
        })
        if res and res.success then
            status.TextColor3 = Color3.fromRGB(80, 255, 120)
            status.Text = "Ключ верный! Загрузка..."
            task.wait(0.6)
            authGui:Destroy()
            buildMenuGui()
        else
            status.TextColor3 = Color3.fromRGB(255, 70, 70)
            status.Text = (res and res.message) or "Invalid key! Please try again."
            btn.Text = "Проверить ключ"
        end
        checking = false
    end)
end)
