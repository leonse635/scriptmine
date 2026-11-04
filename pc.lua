local name = "scriptmine";
local ownerid = "hMEBirGNhJ";
local version = "1.0";

local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")
local CoreGui     = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return gui
end

-- =========================================================
-- GUI АВТОРИЗАЦИИ
-- =========================================================
local authGui = createGui("ScriptMineKeyAuth")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 250)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = authGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 42)
title.BackgroundTransparency = 1
title.Text = "SCRIPTMINE — KeyAuth"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 21
title.Parent = mainFrame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 42)
subtitle.BackgroundTransparency = 1
subtitle.Text = "v" .. version .. "  •  Secure License"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.Parent = mainFrame

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -48, 0, 42)
box.Position = UDim2.new(0, 24, 0, 80)
box.BackgroundColor3 = Color3.fromRGB(48, 48, 63)
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
local boxStroke = Instance.new("UIStroke", box)
boxStroke.Color = Color3.fromRGB(70, 70, 90)
boxStroke.Thickness = 1

box.Focused:Connect(function()
    TweenService:Create(boxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 200, 255)}):Play()
end)
box.FocusLost:Connect(function()
    TweenService:Create(boxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 70, 90)}):Play()
end)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -48, 0, 44)
btn.Position = UDim2.new(0, 24, 0, 138)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.BorderSizePixel = 0
btn.Text = "Проверить ключ"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 15
btn.AutoButtonColor = false
btn.Parent = mainFrame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
end)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -48, 0, 30)
status.Position = UDim2.new(0, 24, 0, 192)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextWrapped = true
status.Parent = mainFrame

local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(1, 0, 0, 18)
hint.Position = UDim2.new(0, 0, 1, -22)
hint.BackgroundTransparency = 1
hint.Text = "Enter — проверить  •  перетаскивай мышью  •  Escape — закрыть"
hint.TextColor3 = Color3.fromRGB(100, 100, 120)
hint.Font = Enum.Font.Gotham
hint.TextSize = 11
hint.Parent = mainFrame

-- =========================================================
-- GUI МЕНЮ
-- =========================================================
local function buildMenuGui()
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

    return menuGui
end

-- =========================================================
-- ПРОВЕРКА
-- =========================================================
local checking = false

local function tryKey()
    if checking then return end
    checking = true
    status.TextColor3 = Color3.fromRGB(255, 200, 80)
    status.Text = "Проверка ключа на сервере..."
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
            btn.Text = "OK"
            task.wait(0.6)
            authGui:Destroy()
            buildMenuGui()
        else
            local msg = (res and res.message) or "Invalid key! Please try again."
            status.TextColor3 = Color3.fromRGB(255, 70, 70)
            status.Text = msg
            btn.Text = "Проверить ключ"

            -- тряска окна
            local orig = mainFrame.Position
            for i = 1, 4 do
                mainFrame.Position = orig + UDim2.new(0, (i % 2 == 0 and 8 or -8), 0, 0)
                task.wait(0.04)
            end
            mainFrame.Position = orig

            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "ScriptMine",
                    Text = "Invalid key detected!",
                    Duration = 3,
                })
            end)
        end
        checking = false
    end)
end

btn.MouseButton1Click:Connect(tryKey)

box.FocusLost:Connect(function(enterPressed)
    if enterPressed then tryKey() end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Escape then
        if authGui and authGui.Parent then authGui:Destroy() end
    end
end)
