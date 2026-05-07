-- Complete Fixed Script: Quest Auto-Accept + Hotbar Auto-Equip (Slots 1-3, only items with Attack/Skill) + Auto Abilities (Z,X,C,V,F)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoQuestGUI"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 700, 0, 520)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
titleBar.BackgroundTransparency = 0.1
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -90, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Quest + Auto-Equip + Abilities"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 1, 0)
minBtn.Position = UDim2.new(1, -65, 0, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
minBtn.BackgroundTransparency = 0.2
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 18
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = titleBar
minBtn.BorderSizePixel = 0

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minBtn

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 1, 0)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Content Container
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, 0, 1, -35)
contentContainer.Position = UDim2.new(0, 0, 0, 35)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- ==================== LEFT COLUMN (Quest) ====================
local leftCol = Instance.new("Frame")
leftCol.Size = UDim2.new(0.4, -10, 1, -10)
leftCol.Position = UDim2.new(0, 10, 0, 5)
leftCol.BackgroundTransparency = 1
leftCol.Parent = contentContainer

-- Quest Dropdown
local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(1, 0, 0, 25)
dropdownLabel.Position = UDim2.new(0, 0, 0, 0)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.Text = "Select Quest:"
dropdownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
dropdownLabel.TextSize = 12
dropdownLabel.Font = Enum.Font.GothamBold
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.Parent = leftCol

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, 0, 0, 35)
dropdownBtn.Position = UDim2.new(0, 0, 0, 30)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
dropdownBtn.BackgroundTransparency = 0.2
dropdownBtn.Text = "Select Quest"
dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownBtn.TextSize = 14
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.Parent = leftCol
dropdownBtn.BorderSizePixel = 0

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 6)
dropdownCorner.Parent = dropdownBtn

local dropdownContainer = Instance.new("Frame")
dropdownContainer.Size = UDim2.new(1, 0, 0, 150)
dropdownContainer.Position = UDim2.new(0, 0, 0, 70)
dropdownContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
dropdownContainer.BackgroundTransparency = 0.15
dropdownContainer.BorderSizePixel = 0
dropdownContainer.Visible = false
dropdownContainer.Parent = leftCol
dropdownContainer.ClipsDescendants = true

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 6)
containerCorner.Parent = dropdownContainer

local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Size = UDim2.new(1, 0, 1, 0)
dropdownList.BackgroundTransparency = 1
dropdownList.ScrollBarThickness = 6
dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
dropdownList.Parent = dropdownContainer

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 2)
listLayout.Parent = dropdownList

-- Auto Delay Slider
local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(1, 0, 0, 25)
delayLabel.Position = UDim2.new(0, 0, 0, 230)
delayLabel.BackgroundTransparency = 1
delayLabel.Text = "Auto Delay (s):"
delayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayLabel.TextSize = 12
delayLabel.Font = Enum.Font.GothamBold
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.Parent = leftCol

local delayValue = Instance.new("TextLabel")
delayValue.Size = UDim2.new(0, 40, 0, 25)
delayValue.Position = UDim2.new(1, -50, 0, 230)
delayValue.BackgroundTransparency = 1
delayValue.Text = "4"
delayValue.TextColor3 = Color3.fromRGB(255, 200, 100)
delayValue.TextSize = 12
delayValue.Font = Enum.Font.GothamBold
delayValue.Parent = leftCol

local delaySlider = Instance.new("Frame")
delaySlider.Size = UDim2.new(1, 0, 0, 25)
delaySlider.Position = UDim2.new(0, 0, 0, 258)
delaySlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
delaySlider.BackgroundTransparency = 0.3
delaySlider.Parent = leftCol

local delaySliderCorner = Instance.new("UICorner")
delaySliderCorner.CornerRadius = UDim.new(0, 4)
delaySliderCorner.Parent = delaySlider

local delayFill = Instance.new("Frame")
delayFill.Size = UDim2.new(0.4, 0, 1, 0)
delayFill.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
delayFill.BackgroundTransparency = 0.2
delayFill.Parent = delaySlider

local delayButton = Instance.new("TextButton")
delayButton.Size = UDim2.new(0, 18, 0, 25)
delayButton.Position = UDim2.new(0.4, -9, 0, 0)
delayButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
delayButton.Text = ""
delayButton.Parent = delaySlider
delayButton.AutoButtonColor = false

-- Quest Action Buttons
local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(1, 0, 0, 40)
acceptBtn.Position = UDim2.new(0, 0, 0, 300)
acceptBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
acceptBtn.BackgroundTransparency = 0.2
acceptBtn.Text = "Accept Quest Now"
acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptBtn.TextSize = 14
acceptBtn.Font = Enum.Font.GothamBold
acceptBtn.Parent = leftCol
acceptBtn.BorderSizePixel = 0

local acceptCorner = Instance.new("UICorner")
acceptCorner.CornerRadius = UDim.new(0, 6)
acceptCorner.Parent = acceptBtn

local autoQuestBtn = Instance.new("TextButton")
autoQuestBtn.Size = UDim2.new(1, 0, 0, 40)
autoQuestBtn.Position = UDim2.new(0, 0, 0, 350)
autoQuestBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 120)
autoQuestBtn.BackgroundTransparency = 0.2
autoQuestBtn.Text = "Auto Quest: OFF"
autoQuestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoQuestBtn.TextSize = 14
autoQuestBtn.Font = Enum.Font.GothamBold
autoQuestBtn.Parent = leftCol
autoQuestBtn.BorderSizePixel = 0

local autoQuestCorner = Instance.new("UICorner")
autoQuestCorner.CornerRadius = UDim.new(0, 6)
autoQuestCorner.Parent = autoQuestBtn

-- ==================== RIGHT COLUMN (Hotbar + Abilities) ====================
local rightCol = Instance.new("Frame")
rightCol.Size = UDim2.new(0.6, -10, 1, -10)
rightCol.Position = UDim2.new(0.4, 5, 0, 5)
rightCol.BackgroundTransparency = 1
rightCol.Parent = contentContainer

-- Hotbar Section
local hotbarLabel = Instance.new("TextLabel")
hotbarLabel.Size = UDim2.new(1, 0, 0, 25)
hotbarLabel.Position = UDim2.new(0, 0, 0, 0)
hotbarLabel.BackgroundTransparency = 1
hotbarLabel.Text = "Hotbar (Slots 1-3, only items with Attack/Skill):"
hotbarLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
hotbarLabel.TextSize = 12
hotbarLabel.Font = Enum.Font.GothamBold
hotbarLabel.TextXAlignment = Enum.TextXAlignment.Left
hotbarLabel.Parent = rightCol

local hotbarFrame = Instance.new("Frame")
hotbarFrame.Size = UDim2.new(1, 0, 0, 80)
hotbarFrame.Position = UDim2.new(0, 0, 0, 30)
hotbarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
hotbarFrame.BackgroundTransparency = 0.3
hotbarFrame.BorderSizePixel = 0
hotbarFrame.Parent = rightCol

local hotbarCorner = Instance.new("UICorner")
hotbarCorner.CornerRadius = UDim.new(0, 6)
hotbarCorner.Parent = hotbarFrame

local hotbarLayout = Instance.new("UIListLayout")
hotbarLayout.Padding = UDim.new(0, 8)
hotbarLayout.FillDirection = Enum.FillDirection.Horizontal
hotbarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
hotbarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
hotbarLayout.Parent = hotbarFrame

-- Refresh Hotbar Button
local refreshHotbarBtn = Instance.new("TextButton")
refreshHotbarBtn.Size = UDim2.new(1, 0, 0, 30)
refreshHotbarBtn.Position = UDim2.new(0, 0, 0, 115)
refreshHotbarBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
refreshHotbarBtn.BackgroundTransparency = 0.2
refreshHotbarBtn.Text = "⟳ Refresh Hotbar"
refreshHotbarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshHotbarBtn.TextSize = 13
refreshHotbarBtn.Font = Enum.Font.GothamBold
refreshHotbarBtn.Parent = rightCol
refreshHotbarBtn.BorderSizePixel = 0

local refreshCorner = Instance.new("UICorner")
refreshCorner.CornerRadius = UDim.new(0, 6)
refreshCorner.Parent = refreshHotbarBtn

-- Auto Equip Toggle
local autoEquipBtn = Instance.new("TextButton")
autoEquipBtn.Size = UDim2.new(1, 0, 0, 40)
autoEquipBtn.Position = UDim2.new(0, 0, 0, 155)
autoEquipBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
autoEquipBtn.BackgroundTransparency = 0.2
autoEquipBtn.Text = "Auto Equip: OFF"
autoEquipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoEquipBtn.TextSize = 14
autoEquipBtn.Font = Enum.Font.GothamBold
autoEquipBtn.Parent = rightCol
autoEquipBtn.BorderSizePixel = 0

local autoEquipCorner = Instance.new("UICorner")
autoEquipCorner.CornerRadius = UDim.new(0, 6)
autoEquipCorner.Parent = autoEquipBtn

-- Auto Abilities Section
local abilityLabel = Instance.new("TextLabel")
abilityLabel.Size = UDim2.new(1, 0, 0, 25)
abilityLabel.Position = UDim2.new(0, 0, 0, 205)
abilityLabel.BackgroundTransparency = 1
abilityLabel.Text = "Auto Abilities (Loop):"
abilityLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
abilityLabel.TextSize = 12
abilityLabel.Font = Enum.Font.GothamBold
abilityLabel.TextXAlignment = Enum.TextXAlignment.Left
abilityLabel.Parent = rightCol

local abilityFrame = Instance.new("Frame")
abilityFrame.Size = UDim2.new(1, 0, 0, 200)
abilityFrame.Position = UDim2.new(0, 0, 0, 235)
abilityFrame.BackgroundTransparency = 1
abilityFrame.Parent = rightCol

local abilityLayout = Instance.new("UIListLayout")
abilityLayout.Padding = UDim.new(0, 8)
abilityLayout.FillDirection = Enum.FillDirection.Vertical
abilityLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
abilityLayout.Parent = abilityFrame

-- Ability Toggle Buttons
local abilityKeys = {"Z", "X", "C", "V", "F"}
local abilityActive = {}

for _, key in ipairs(abilityKeys) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
    btn.BackgroundTransparency = 0.2
    btn.Text = "Auto " .. key .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = abilityFrame
    btn.BorderSizePixel = 0
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    abilityActive[key] = false

    btn.MouseButton1Click:Connect(function()
        abilityActive[key] = not abilityActive[key]
        if abilityActive[key] then
            btn.Text = "Auto " .. key .. ": ON"
            btn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
        else
            btn.Text = "Auto " .. key .. ": OFF"
            btn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
        end
    end)
end

-- Global Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 1, -35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 11
statusLabel.TextWrapped = true
statusLabel.Parent = contentContainer

-- ======================== SCRIPT LOGIC ========================

local questList = {}
local selectedQuest = nil
local autoQuestActive = false
local autoQuestTask = nil
local autoDelay = 4

local hotbarItems = {}      -- only slots 1-3 that have Attack/Skill
local selectedItem = nil
local autoEquipActive = false
local autoEquipTask = nil

-- Helper: check if a tool has Attack or Skill descendant
local function hasAttackOrSkill(tool)
    if not tool then return false end
    -- Search through tool and its descendants
    for _, child in pairs(tool:GetDescendants()) do
        if child.Name == "Attack" or child.Name == "Skill" then
            return true
        end
    end
    return false
end

-- Helper: press a key
local function pressKey(key)
    local success, _ = pcall(function()
        VirtualInput:SendKeyEvent(true, key, false, game)
        wait(0.05)
        VirtualInput:SendKeyEvent(false, key, false, game)
    end)
    if not success then
        pcall(function()
            local k = string.byte(key)
            keypress(k)
            wait(0.05)
            keyrelease(k)
        end)
    end
end

-- Auto ability loop (runs continuously)
local abilityLoopTask = nil
local function startAbilityLoop()
    if abilityLoopTask then task.cancel(abilityLoopTask) end
    abilityLoopTask = task.spawn(function()
        while true do
            for _, key in ipairs(abilityKeys) do
                if abilityActive[key] then
                    pressKey(key)
                    wait(0.1)
                end
            end
            wait(0.5)
        end
    end)
end

-- Slider logic
local isSliding = false
local function updateDelaySlider(input)
    local width = delaySlider.AbsoluteSize.X
    if width <= 0 then return end
    local pos = input and (input.Position.X - delaySlider.AbsolutePosition.X) or (delayButton.AbsolutePosition.X - delaySlider.AbsolutePosition.X + 9)
    local percent = math.clamp(pos / width, 0, 1)
    autoDelay = math.floor(percent * 9) + 1
    delayValue.Text = tostring(autoDelay)
    delayButton.Position = UDim2.new(0, percent * (width - 18), 0, 0)
    delayFill.Size = UDim2.new(percent, 0, 1, 0)
end

delaySlider.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true; updateDelaySlider(i) end end)
delaySlider.InputChanged:Connect(function(i) if isSliding and i.UserInputType == Enum.UserInputType.MouseMovement then updateDelaySlider(i) end end)
delayButton.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = false end end)

-- Get NPC for quest
local function getNPCForQuest(questName)
    local questFolder = workspace.Map_.NPC_.Quest:FindFirstChild(questName)
    if not questFolder then return nil end
    local npcPart = questFolder:FindFirstChild("HumanoidRootPart") or questFolder:FindFirstChild("Head") or questFolder:FindFirstChild("Torso")
    if npcPart then return npcPart end
    return questFolder
end

-- Accept Quest (teleport -> E -> return)
local function acceptQuest(questName)
    if not questName then return false end
    local char = LocalPlayer.Character
    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    local npc = getNPCForQuest(questName)
    if not npc then
        statusLabel.Text = "NPC not found"
        return false
    end
    local originalCFrame = rootPart.CFrame
    local targetCFrame = npc:IsA("BasePart") and (npc.CFrame + Vector3.new(0,0,5)) or (npc:GetPivot() + Vector3.new(0,0,5))
    rootPart.CFrame = targetCFrame
    wait(0.6)
    pressKey("E")
    wait(0.5)
    rootPart.CFrame = originalCFrame
    statusLabel.Text = "Accepted " .. questName
    return true
end

-- Auto quest loop
local function startAutoQuest()
    if autoQuestTask then task.cancel(autoQuestTask) end
    autoQuestTask = task.spawn(function()
        while autoQuestActive and selectedQuest do
            acceptQuest(selectedQuest)
            wait(autoDelay)
        end
        autoQuestTask = nil
    end)
end

-- **FIXED HOTBAR SCANNING – ONLY FIRST 3 BACKPACK ITEMS THAT HAVE Attack OR Skill**
local function scanHotbar()
    -- Clear existing buttons
    for _, child in pairs(hotbarFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    hotbarItems = {}
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then
        statusLabel.Text = "No backpack found"
        return
    end

    -- Collect tools from Backpack in order, but only those with Attack or Skill
    local validTools = {}
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and hasAttackOrSkill(tool) then
            table.insert(validTools, tool)
        end
    end

    -- Take ONLY first 3 valid tools (slots 1,2,3)
    for i = 1, math.min(3, #validTools) do
        local tool = validTools[i]
        table.insert(hotbarItems, {Name = tool.Name, Tool = tool})
    end

    -- Create buttons for each item
    for _, item in pairs(hotbarItems) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 90, 0, 60)
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        btn.Text = item.Name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
        btn.TextWrapped = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = hotbarFrame
        btn.BorderSizePixel = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            selectedItem = item
            statusLabel.Text = "Selected item: " .. item.Name
        end)
    end

    -- If no valid items, show placeholder
    if #hotbarItems == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 1, 0)
        empty.BackgroundTransparency = 1
        empty.Text = "No valid items (missing Attack/Skill)"
        empty.TextColor3 = Color3.fromRGB(150, 150, 150)
        empty.TextSize = 12
        empty.Parent = hotbarFrame
    end

    statusLabel.Text = "Hotbar slots 1-3 (valid): " .. #hotbarItems .. " items"
    -- Debug to console
    print("=== Hotbar Slots 1-3 (only items with Attack/Skill) ===")
    for i, item in ipairs(hotbarItems) do
        print("Slot " .. i .. ": " .. item.Name)
    end
end

-- **FIXED AUTO-EQUIP – STOPS IMMEDIATELY WHEN TOGGLED OFF**
local function startAutoEquip()
    -- Cancel any existing task
    if autoEquipTask then
        task.cancel(autoEquipTask)
        autoEquipTask = nil
    end
    -- Only start a new one if autoEquipActive is true
    if not autoEquipActive then return end

    autoEquipTask = task.spawn(function()
        while autoEquipActive and selectedItem do
            local char = LocalPlayer.Character
            if char then
                local current = char:FindFirstChildOfClass("Tool")
                -- If nothing equipped or equipped item is not the selected one
                if not current or current.Name ~= selectedItem.Name then
                    -- Unequip current
                    if current then
                        current.Parent = LocalPlayer.Backpack
                    end
                    -- Find the tool in backpack and equip it
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    if backpack then
                        local tool = backpack:FindFirstChild(selectedItem.Name)
                        if tool then
                            tool.Parent = char
                            statusLabel.Text = "Auto-equipped: " .. selectedItem.Name
                        end
                    end
                end
            end
            wait(1) -- check every second
        end
        autoEquipTask = nil
    end)
end

-- Scan quests from workspace
local function scanQuests()
    local questParent = workspace.Map_.NPC_.Quest
    if not questParent then statusLabel.Text = "Quest folder not found" return end
    questList = {}
    for _, child in pairs(questParent:GetChildren()) do
        if child.Name:match("^Quest%d+") then table.insert(questList, child.Name) end
    end
    table.sort(questList, function(a,b) return (tonumber(a:match("%d+")) or 0) < (tonumber(b:match("%d+")) or 0) end)
    for _, child in pairs(dropdownList:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local height = 0
    for _, qName in pairs(questList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -5, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
        btn.Text = qName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.Parent = dropdownList
        btn.BorderSizePixel = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 3)
        corner.Parent = btn
        height = height + 32
        btn.MouseButton1Click:Connect(function()
            selectedQuest = qName
            dropdownBtn.Text = qName
            dropdownContainer.Visible = false
            dropdownOpen = false
            statusLabel.Text = "Selected quest: " .. qName
        end)
    end
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, height)
    statusLabel.Text = "Found " .. #questList .. " quests"
end

-- Minimize logic
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        contentContainer.Visible = false
        mainFrame.Size = UDim2.new(0, 700, 0, 35)
        minBtn.Text = "+"
    else
        contentContainer.Visible = true
        mainFrame.Size = UDim2.new(0, 700, 0, 520)
        minBtn.Text = "−"
    end
end)

-- Button events
local dropdownOpen = false

closeBtn.MouseButton1Click:Connect(function()
    if autoQuestActive then autoQuestActive = false; if autoQuestTask then task.cancel(autoQuestTask) end end
    if autoEquipActive then autoEquipActive = false; if autoEquipTask then task.cancel(autoEquipTask) end end
    screenGui:Destroy()
end)

dropdownBtn.MouseButton1Click:Connect(function()
    if autoQuestActive then statusLabel.Text = "Turn off Auto Quest first" return end
    dropdownOpen = not dropdownOpen
    dropdownContainer.Visible = dropdownOpen
    if dropdownOpen then scanQuests() end
end)

acceptBtn.MouseButton1Click:Connect(function()
    if autoQuestActive then statusLabel.Text = "Stop Auto Quest first" return end
    if selectedQuest then task.spawn(acceptQuest, selectedQuest) else statusLabel.Text = "Select a quest" end
end)

autoQuestBtn.MouseButton1Click:Connect(function()
    if not selectedQuest then statusLabel.Text = "Select a quest first" return end
    autoQuestActive = not autoQuestActive
    if autoQuestActive then
        autoQuestBtn.Text = "Auto Quest: ON"
        autoQuestBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
        statusLabel.Text = "Auto Quest ON for " .. selectedQuest .. " (delay " .. autoDelay .. "s)"
        startAutoQuest()
    else
        autoQuestBtn.Text = "Auto Quest: OFF"
        autoQuestBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 120)
        statusLabel.Text = "Auto Quest OFF"
        if autoQuestTask then task.cancel(autoQuestTask); autoQuestTask = nil end
    end
end)

refreshHotbarBtn.MouseButton1Click:Connect(function()
    scanHotbar()
    statusLabel.Text = "Hotbar refreshed"
end)

autoEquipBtn.MouseButton1Click:Connect(function()
    if not selectedItem then
        statusLabel.Text = "Select an item from hotbar first"
        return
    end
    autoEquipActive = not autoEquipActive
    if autoEquipActive then
        autoEquipBtn.Text = "Auto Equip: ON"
        autoEquipBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
        statusLabel.Text = "Auto Equip ON for " .. selectedItem.Name
        startAutoEquip()
    else
        autoEquipBtn.Text = "Auto Equip: OFF"
        autoEquipBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
        statusLabel.Text = "Auto Equip OFF"
        -- Cancel the task immediately
        if autoEquipTask then
            task.cancel(autoEquipTask)
            autoEquipTask = nil
        end
    end
end)

-- Close dropdown when clicking outside
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
        local mousePos = Vector2.new(input.Position.X, input.Position.Y)
        local btnPos = Vector2.new(dropdownBtn.AbsolutePosition.X, dropdownBtn.AbsolutePosition.Y)
        local btnSize = Vector2.new(dropdownBtn.AbsoluteSize.X, dropdownBtn.AbsoluteSize.Y)
        local containerPos = Vector2.new(dropdownContainer.AbsolutePosition.X, dropdownContainer.AbsolutePosition.Y)
        local containerSize = Vector2.new(dropdownContainer.AbsoluteSize.X, dropdownContainer.AbsoluteSize.Y)
        local hitBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        local hitContainer = mousePos.X >= containerPos.X and mousePos.X <= containerPos.X + containerSize.X and mousePos.Y >= containerPos.Y and mousePos.Y <= containerPos.Y + containerSize.Y
        if not hitBtn and not hitContainer then
            dropdownContainer.Visible = false
            dropdownOpen = false
        end
    end
end)

-- Start ability loop (runs until GUI is destroyed)
startAbilityLoop()

-- Initial scans
scanQuests()
scanHotbar()
task.wait(0.1)
updateDelaySlider()
print("Script loaded – Hotbar shows ONLY slots 1-3 that contain 'Attack' or 'Skill'. Auto-equip stops immediately when toggled OFF.")
