local name    = "scriptmine";
local ownerid = "hMEBirGNhJ";
local version = "1.0";

local Players          = game:GetService("Players")
local CoreGui          = game:GetService("CoreGui")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- =========================================================
-- КОНФИГ КЛЮЧА
-- =========================================================
local VALID_KEY    = "vaz"
local KEY_DAYS     = 30
local STORAGE_FILE = "scriptmine_key.txt"

-- =========================================================
-- ФАЙЛОВОЕ ХРАНИЛИЩЕ
-- =========================================================
local function fileExists(path)
    if isfile then return isfile(path) end
    return false
end

local function readFile(path)
    if readfile and fileExists(path) then
        local ok, data = pcall(readfile, path)
        if ok then return data end
    end
    return nil
end

local function writeFile(path, data)
    if writefile then pcall(writefile, path, data) end
end

-- =========================================================
-- ЛОГИКА СРОКА
-- =========================================================
local function getActivationTime()
    local data = readFile(STORAGE_FILE)
    if not data or data == "" then return nil end
    return tonumber(data)
end

local function saveActivationTime()
    writeFile(STORAGE_FILE, tostring(os.time()))
end

local function getDaysLeft()
    local activated = getActivationTime()
    if not activated then return nil end
    local elapsed = os.time() - activated
    return KEY_DAYS - math.floor(elapsed / 86400)
end

local function isExpired()
    local left = getDaysLeft()
    if left == nil then return false end
    return left <= 0
end

-- =========================================================
-- GUI
-- =========================================================
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
-- МЕНЮ
-- =========================================================
local function buildMenuGui()
    local menuGui = createGui("ScriptMineMenu")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 250)
    frame.Position = UDim2.new(0.5, -200, 0.5, -125)
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

    local daysLeft = getDaysLeft()
    local daysText = daysLeft and ("Осталось дней: " .. daysLeft) or "Ключ активен"
    local daysLabel = Instance.new("TextLabel", frame)
    daysLabel.Size = UDim2.new(1, 0, 0, 18)
    daysLabel.Position = UDim2.new(0, 0, 0, 70)
    daysLabel.BackgroundTransparency = 1
    daysLabel.Text = daysText
    daysLabel.TextColor3 = Color3.fromRGB(0, 220, 130)
    daysLabel.Font = Enum.Font.Gotham
    daysLabel.TextSize = 13

    local startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1, -48, 0, 54)
    startBtn.Position = UDim2.new(0, 24, 0, 100)
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

    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(1, -48, 0, 18)
    info.Position = UDim2.new(0, 24, 0, 162)
    info.BackgroundTransparency = 1
    info.Text = "Нажми кнопку, чтобы загрузить скрипт"
    info.TextColor3 = Color3.fromRGB(140, 140, 160)
    info.Font = Enum.Font.Gotham
    info.TextSize = 12

    local closeBtn = Instance.new("TextButton", frame)
    closeBtn.Size = UDim2.new(1, -48, 0, 22)
    closeBtn.Position = UDim2.new(0, 24, 0, 190)
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
-- АВТОРИЗАЦИЯ
-- =========================================================
local function buildAuthGui()
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
    title.Text = "SCRIPTMINE — License"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 21
    title.Parent = mainFrame

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 42)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "v" .. version .. "  •  30 days license"
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
    box.PlaceholderText = "Введите ключ..."
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

    local checking = false

    local function tryKey()
        if checking then return end
        checking = true

        status.TextColor3 = Color3.fromRGB(255, 200, 80)
        status.Text = "Проверка ключа..."
        btn.Text = "Проверка..."

        task.wait(0.3)

        local input = (box.Text or ""):gsub("%s+", "")

        if input ~= VALID_KEY then
            status.TextColor3 = Color3.fromRGB(255, 70, 70)
            status.Text = "Invalid key! Please try again."
            btn.Text = "Проверить ключ"

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

            checking = false
            return
        end

        if isExpired() then
            status.TextColor3 = Color3.fromRGB(255, 70, 70)
            status.Text = "License expired! (30 days passed)"
            btn.Text = "Проверить ключ"
            checking = false
            return
        end

        if getActivationTime() == nil then
            saveActivationTime()
        end

        status.TextColor3 = Color3.fromRGB(80, 255, 120)
        status.Text = "Ключ верный! Загрузка..."
        btn.Text = "OK"

        task.wait(0.6)
        authGui:Destroy()
        buildMenuGui()
        checking = false
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
end

-- =========================================================
-- СТАРТ
-- =========================================================
if getActivationTime() ~= nil and not isExpired() then
    buildMenuGui()
else
    buildAuthGui()
end
