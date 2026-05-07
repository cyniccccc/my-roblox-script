-- Quest Auto-Accept UI (Draggable, Dropdown, Manual + Auto, Minimize + Delay)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "QuestAutoGUI"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false

-- Main Frame (Draggable)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 400)  -- a bit taller for delay slider
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
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
titleText.Text = "Quest Auto-Accept"
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

-- Container for all content (to be hidden on minimize)
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, 0, 1, -35)
contentContainer.Position = UDim2.new(0, 0, 0, 35)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- Dropdown Section
local yOffset = 10

local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(1, -20, 0, 25)
dropdownLabel.Position = UDim2.new(0, 10, 0, yOffset)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.Text = "Select Quest:"
dropdownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
dropdownLabel.TextSize = 12
dropdownLabel.Font = Enum.Font.GothamBold
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.Parent = contentContainer
yOffset = yOffset + 28

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, -20, 0, 35)
dropdownBtn.Position = UDim2.new(0, 10, 0, yOffset)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
dropdownBtn.BackgroundTransparency = 0.2
dropdownBtn.Text = "Select Quest"
dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownBtn.TextSize = 14
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.Parent = contentContainer
dropdownBtn.BorderSizePixel = 0

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 6)
dropdownCorner.Parent = dropdownBtn
yOffset = yOffset + 40

local dropdownContainer = Instance.new("Frame")
dropdownContainer.Size = UDim2.new(1, -20, 0, 120)
dropdownContainer.Position = UDim2.new(0, 10, 0, yOffset)
dropdownContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
dropdownContainer.BackgroundTransparency = 0.15
dropdownContainer.BorderSizePixel = 0
dropdownContainer.Visible = false
dropdownContainer.Parent = contentContainer
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

yOffset = yOffset + 125

-- Delay Slider Label
local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(1, -20, 0, 25)
delayLabel.Position = UDim2.new(0, 10, 0, yOffset)
delayLabel.BackgroundTransparency = 1
delayLabel.Text = "Auto Delay (seconds):"
delayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayLabel.TextSize = 12
delayLabel.Font = Enum.Font.GothamBold
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.Parent = contentContainer
yOffset = yOffset + 28

local delayValue = Instance.new("TextLabel")
delayValue.Size = UDim2.new(0, 40, 0, 25)
delayValue.Position = UDim2.new(1, -50, 0, yOffset-25)
delayValue.BackgroundTransparency = 1
delayValue.Text = "4"
delayValue.TextColor3 = Color3.fromRGB(255, 200, 100)
delayValue.TextSize = 12
delayValue.TextXAlignment = Enum.TextXAlignment.Right
delayValue.Font = Enum.Font.GothamBold
delayValue.Parent = contentContainer

local delaySlider = Instance.new("Frame")
delaySlider.Size = UDim2.new(1, -20, 0, 25)
delaySlider.Position = UDim2.new(0, 10, 0, yOffset)
delaySlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
delaySlider.BackgroundTransparency = 0.3
delaySlider.Parent = contentContainer

local delaySliderCorner = Instance.new("UICorner")
delaySliderCorner.CornerRadius = UDim.new(0, 4)
delaySliderCorner.Parent = delaySlider

local delayFill = Instance.new("Frame")
delayFill.Size = UDim2.new(0.3, 0, 1, 0)  -- 4/10 = 0.4, but default 4 sec
delayFill.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
delayFill.BackgroundTransparency = 0.2
delayFill.Parent = delaySlider

local delayButton = Instance.new("TextButton")
delayButton.Size = UDim2.new(0, 18, 0, 25)
delayButton.Position = UDim2.new(0.3, -9, 0, 0)  -- 3/10 = 0.3? Actually 4/10 = 0.4, we'll correct in update
delayButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
delayButton.Text = ""
delayButton.Parent = delaySlider
delayButton.AutoButtonColor = false

yOffset = yOffset + 32

-- Manual Accept Button
local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(1, -20, 0, 40)
acceptBtn.Position = UDim2.new(0, 10, 0, yOffset)
acceptBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
acceptBtn.BackgroundTransparency = 0.2
acceptBtn.Text = "Accept Quest Now"
acceptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptBtn.TextSize = 15
acceptBtn.Font = Enum.Font.GothamBold
acceptBtn.Parent = contentContainer
acceptBtn.BorderSizePixel = 0

local acceptCorner = Instance.new("UICorner")
acceptCorner.CornerRadius = UDim.new(0, 6)
acceptCorner.Parent = acceptBtn
yOffset = yOffset + 48

-- Auto Toggle Button
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(1, -20, 0, 40)
autoBtn.Position = UDim2.new(0, 10, 0, yOffset)
autoBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 120)
autoBtn.BackgroundTransparency = 0.2
autoBtn.Text = "Auto Quest: OFF"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.TextSize = 15
autoBtn.Font = Enum.Font.GothamBold
autoBtn.Parent = contentContainer
autoBtn.BorderSizePixel = 0

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 6)
autoCorner.Parent = autoBtn
yOffset = yOffset + 48

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 40)
statusLabel.Position = UDim2.new(0, 10, 0, yOffset)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Ready"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 11
statusLabel.TextWrapped = true
statusLabel.Parent = contentContainer

-- ======================== SCRIPT LOGIC ========================

local questList = {}
local selectedQuest = nil
local autoActive = false
local autoTask = nil
local autoDelay = 4  -- seconds, default

-- Slider functions for delay
local isSliding = false
local function updateDelaySlider(input)
    local width = delaySlider.AbsoluteSize.X
    if width <= 0 then return end
    local pos = input and (input.Position.X - delaySlider.AbsolutePosition.X) or (delayButton.AbsolutePosition.X - delaySlider.AbsolutePosition.X + 9)
    local percent = math.clamp(pos / width, 0, 1)
    autoDelay = math.floor(percent * 9) + 1  -- range 1 to 10 seconds
    delayValue.Text = tostring(autoDelay)
    delayButton.Position = UDim2.new(0, percent * (width - 18), 0, 0)
    delayFill.Size = UDim2.new(percent, 0, 1, 0)
end

delaySlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliding = true
        updateDelaySlider(i)
    end
end)
delaySlider.InputChanged:Connect(function(i)
    if isSliding and i.UserInputType == Enum.UserInputType.MouseMovement then
        updateDelaySlider(i)
    end
end)
delayButton.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliding = true
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        isSliding = false
    end
end)

-- Helper: get NPC position
local function getNPCForQuest(questName)
    local questFolder = workspace.Map_.NPC_.Quest:FindFirstChild(questName)
    if not questFolder then return nil end
    local npcPart = questFolder:FindFirstChild("HumanoidRootPart") or questFolder:FindFirstChild("Head") or questFolder:FindFirstChild("Torso")
    if npcPart then return npcPart end
    return questFolder
end

-- Accept Quest Function
local function acceptQuest(questName)
    if not questName then
        statusLabel.Text = "No quest selected"
        return false
    end
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        statusLabel.Text = "Character not loaded"
        return false
    end
    local npc = getNPCForQuest(questName)
    if not npc then
        statusLabel.Text = "NPC not found for " .. questName
        return false
    end
    local originalCFrame = rootPart.CFrame
    local targetCFrame
    if npc:IsA("BasePart") then
        targetCFrame = npc.CFrame + Vector3.new(0, 0, 5)
    else
        targetCFrame = npc:GetPivot() + Vector3.new(0, 0, 5)
    end
    rootPart.CFrame = targetCFrame
    wait(0.6)
    local ePressed = false
    pcall(function()
        local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(true, "E", false, game)
        wait(0.05)
        VIM:SendKeyEvent(false, "E", false, game)
        ePressed = true
    end)
    if not ePressed then
        pcall(function()
            keypress(0x45)
            wait(0.05)
            keyrelease(0x45)
            ePressed = true
        end)
    end
    wait(0.5)
    rootPart.CFrame = originalCFrame
    if ePressed then
        statusLabel.Text = "Accepted " .. questName
        print("Accepted:", questName)
        return true
    else
        statusLabel.Text = "Failed to press E"
        print("Failed to press E for", questName)
        return false
    end
end

-- Scan all quests
local function scanQuests()
    local questParent = workspace.Map_.NPC_.Quest
    if not questParent then
        statusLabel.Text = "Quest folder not found"
        return
    end
    questList = {}
    for _, child in pairs(questParent:GetChildren()) do
        if child.Name:match("^Quest%d+") then
            table.insert(questList, child.Name)
        end
    end
    table.sort(questList, function(a,b)
        local na = tonumber(a:match("%d+")) or 0
        local nb = tonumber(b:match("%d+")) or 0
        return na < nb
    end)
    for _, child in pairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
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
            statusLabel.Text = "Selected: " .. qName
        end)
    end
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, height)
    statusLabel.Text = "Found " .. #questList .. " quests"
end

-- Auto loop
local function startAutoLoop()
    if autoTask then task.cancel(autoTask) end
    autoTask = task.spawn(function()
        while autoActive and selectedQuest do
            acceptQuest(selectedQuest)
            wait(autoDelay)
        end
        autoTask = nil
    end)
end

-- Minimize logic
local minimized = false
local originalSize = mainFrame.Size
local originalContentVisible = true
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        contentContainer.Visible = false
        mainFrame.Size = UDim2.new(0, 320, 0, 35)
        minBtn.Text = "+"
    else
        contentContainer.Visible = true
        mainFrame.Size = originalSize
        minBtn.Text = "−"
    end
end)

-- Button events
local dropdownOpen = false

closeBtn.MouseButton1Click:Connect(function()
    if autoActive then
        autoActive = false
        if autoTask then task.cancel(autoTask) end
    end
    screenGui:Destroy()
end)

dropdownBtn.MouseButton1Click:Connect(function()
    if autoActive then
        statusLabel.Text = "Turn off Auto first"
        return
    end
    dropdownOpen = not dropdownOpen
    dropdownContainer.Visible = dropdownOpen
    if dropdownOpen then scanQuests() end
end)

acceptBtn.MouseButton1Click:Connect(function()
    if autoActive then
        statusLabel.Text = "Stop Auto before manual accept"
        return
    end
    if selectedQuest then
        task.spawn(acceptQuest, selectedQuest)
    else
        statusLabel.Text = "Select a quest first"
    end
end)

autoBtn.MouseButton1Click:Connect(function()
    if not selectedQuest then
        statusLabel.Text = "Select a quest first"
        return
    end
    autoActive = not autoActive
    if autoActive then
        autoBtn.Text = "Auto Quest: ON"
        autoBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
        statusLabel.Text = "Auto ON for " .. selectedQuest .. " (delay " .. autoDelay .. "s)"
        startAutoLoop()
    else
        autoBtn.Text = "Auto Quest: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 120)
        statusLabel.Text = "Auto OFF"
        if autoTask then task.cancel(autoTask); autoTask = nil end
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
        local hitBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and
                       mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
        local hitContainer = mousePos.X >= containerPos.X and mousePos.X <= containerPos.X + containerSize.X and
                             mousePos.Y >= containerPos.Y and mousePos.Y <= containerPos.Y + containerSize.Y
        if not hitBtn and not hitContainer then
            dropdownContainer.Visible = false
            dropdownOpen = false
        end
    end
end)

-- Initial scan
scanQuests()
-- Set initial delay slider position to 4 seconds (40%)
task.wait(0.1)
updateDelaySlider()  -- set visual position
print("Quest Auto-Accept UI loaded. Minimize with '−', set delay slider, select a quest, and turn on Auto.")
