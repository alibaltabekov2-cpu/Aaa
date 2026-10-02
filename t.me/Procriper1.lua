-- ==========================================================
--   BRAINROT MERGE | CLEAN AUTO MERGE & BASE TP
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

if PlayerGui:FindFirstChild("BrainRotMergeClean") then
    PlayerGui.BrainRotMergeClean:Destroy()
end

local AutoMergeEnabled = false

-- Создание мини-интерфейса
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BrainRotMergeClean"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 260, 0, 110)
main.Position = UDim2.new(0.5, -130, 0.4, -55)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(160, 32, 240)
stroke.Thickness = 1.5
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 <font color='#a020f0'>AUTO MERGE HUB</font>"
title.RichText = true
title.TextColor3 = Color3.fromRGB(240, 240, 255)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.Parent = main

-- Кнопка включения/выключения
local tglBtn = Instance.new("TextButton")
tglBtn.Size = UDim2.new(1, -20, 0, 42)
tglBtn.Position = UDim2.new(0, 10, 0, 48)
tglBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
tglBtn.Text = "Auto Merge: OFF"
tglBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
tglBtn.TextSize = 13
tglBtn.Font = Enum.Font.GothamBold
tglBtn.Parent = main
Instance.new("UICorner", tglBtn).CornerRadius = UDim.new(0, 8)

tglBtn.MouseButton1Click:Connect(function()
    AutoMergeEnabled = not AutoMergeEnabled
    if AutoMergeEnabled then
        tglBtn.BackgroundColor3 = Color3.fromRGB(160, 32, 240)
        tglBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tglBtn.Text = "Auto Merge: ON"
    else
        tglBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
        tglBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
        tglBtn.Text = "Auto Merge: OFF"
    end
end)

-- Функция телепорта на базу
local function teleportToBase()
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    local tpDone = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if not tpDone and (obj:IsA("ObjectValue") or obj:IsA("StringValue")) then
            if obj.Name == "Owner" and tostring(obj.Value) == LocalPlayer.Name then
                local base = obj.Parent
                local tpPart = base:FindFirstChild("Spawn") or base:FindFirstChild("Floor") or base:FindFirstChildOfClass("BasePart")
                if tpPart then
                    myHrp.CFrame = tpPart.CFrame * CFrame.new(0, 5, 0)
                    tpDone = true
                end
            end
        end
    end
    
    if not tpDone then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find(LocalPlayer.Name:lower()) or obj.Name:lower():find("tycoon")) then
                local tpPart = obj:FindFirstChild("Spawn") or obj:FindFirstChildOfClass("BasePart")
                if tpPart then
                    myHrp.CFrame = tpPart.CFrame * CFrame.new(0, 5, 0)
                    break
                end
            end
        end
    end
end

-- Логика Авто-объединения с возвратом на базу при завершении
task.spawn(function()
    local hasTeleportedBack = false

    while true do
        if AutoMergeEnabled then
            pcall(function()
                local pairsToMerge = {}
                
                -- Собираем юнитов на карте
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
                        -- Игнорируем игроков
                        if not Players:GetPlayerFromCharacter(obj) then
                            local name = obj.Name
                            if not pairsToMerge[name] then pairsToMerge[name] = {} end
                            table.insert(pairsToMerge[name], obj)
                        end
                    end
                end

                local foundPair = false

                -- Ищем первую попавшуюся пару для слияния
                for name, list in pairs(pairsToMerge) do
                    if #list >= 2 then
                        foundPair = true
                        hasTeleportedBack = false -- сбрасываем флаг, раз появились новые пары
                        
                        local p1 = list[1]:FindFirstChild("HumanoidRootPart")
                        local p2 = list[2]:FindFirstChild("HumanoidRootPart")
                        
                        if p1 and p2 then
                            -- Плавное и не спамящее перемещение одной пары за раз
                            p1.CFrame = p2.CFrame
                            task.wait(0.6) -- задержка, чтобы сервер не лагал и фиксировал слияние
                        end
                        break
                    end
                end

                -- Если пары закончились (всё объединилось до упора)
                if not foundPair then
                    if not hasTeleportedBack then
                        teleportToBase() -- телепортируемся на базу
                        hasTeleportedBack = true
                    end
                    -- Просто стоим и ждём новые брайнроты
                    task.wait(1.5)
                end
            end)
        else
            hasTeleportedBack = false
            task.wait(0.5)
        end
        task.wait(0.2)
    end
end)
