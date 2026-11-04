-- // Конфиг
local localName = "scriptmine"
local ownerId   = "hMEBirGNhJ"
local version   = "1.0"

-- // Список валидных ключей (можешь добавить свои)
local validKeys = {
    ["SCRIPTMINE-2024-XXXX"] = true,
    ["PREMIUM-KEY-1234"]     = true,
    ["TEST-KEY-0000"]        = true,
}

-- // Основная проверка
local function validateKey(key)
    if not key or key == "" then return false end
    key = tostring(key):gsub("%s+", "") -- убираем пробелы
    return validKeys[key] == true
end

-- // Создаём GUI
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local function createGui(name)
    local gui = Instance.new("ScreenGui")
    gui.Name = name
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    -- Delta не всегда даёт CoreGui → пробуем PlayerGui
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    return gui
end

-- // --- GUI АВТОРИЗАЦИИ ---
local authGui = createGui("ScriptMineKeyAuth")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 220)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = authGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "SCRIPTMINE — KeyAuth"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

-- Подзаголовок
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "v" .. version .. " • owner: " .. ownerId
subtitle.TextColor3 = Color3.fromRGB(150, 150, 170)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.Parent = mainFrame

-- Поле ввода
local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 40)
box.Position = UDim2.new(0, 20, 0, 75)
box.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
box.BorderSizePixel = 0
box.Text = ""
box.PlaceholderText = "Введите ключ..."
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
box.Font = Enum.Font.Gotham
box.TextSize = 15
box.ClearTextOnFocus = false
box.Parent = mainFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = box

-- Кнопка
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -40, 0, 40)
btn.Position = UDim2.new(0, 20, 0, 130)
btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
btn.BorderSizePixel = 0
btn.Text = "Проверить ключ"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 15
btn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn

-- Статус
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 25)
status.Position = UDim2.new(0, 20, 0, 180)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 80, 80)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.Parent = mainFrame

-- // --- GUI МЕНЮ (после успешной проверки) ---
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

    -- hover-эффект
    startBtn.MouseEnter:Connect(function()
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
    end)
    startBtn.MouseLeave:Connect(function()
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 190, 110)
    end)

    local info = Instance.new("TextLabel", frame)
    info.Size = UDim2.new(1, -40, 0, 20)
    info.Position = UDim2.new(0, 20, 0, 145)
    info.BackgroundTransparency = 1
    info.Text = "Нажми кнопку, чтобы загрузить скрипт"
    info.TextColor3 = Color3.fromRGB(140, 140, 160)
    info.Font = Enum.Font.Gotham
    info.TextSize = 12

    startBtn.MouseButton1Click:Connect(function()
        -- закрываем меню
        menuGui:Destroy()
        -- запускаем скрипт
        pcall(function()
            loadstring(game:HttpGet("https://scriptblox.com/raw/Build-A-Boat-For-Treasure-OP-ARBIX-HUB-KEYLESS-15-BUTTONS-AUTOFARM-GOLDS-AND-MORE-234117"))()
        end)
    end)

    return menuGui
end

-- // Логика кнопки проверки
btn.MouseButton1Click:Connect(function()
    status.TextColor3 = Color3.fromRGB(255, 200, 80)
    status.Text = "Проверка ключа..."

    task.wait(0.3)

    local key = box.Text

    if validateKey(key) then
        -- УСПЕХ
        status.TextColor3 = Color3.fromRGB(80, 255, 120)
        status.Text = "Ключ верный! Загрузка..."

        task.wait(0.6)

        -- Закрываем GUI с ключом
        authGui:Destroy()

        -- Открываем GUI меню
        buildMenuGui()
    else
        -- ОШИБКА
        status.TextColor3 = Color3.fromRGB(255, 70, 70)
        status.Text = "Invalid key! Please try again."

        -- Оповещение игроку
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ScriptMine",
            Text = "Invalid key detected!",
            Duration = 3,
        })
    end
end)
