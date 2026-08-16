--[[
    Advanced Aimbot + ESP GUI Script for Roblox
    Features:
    - Modern UI with curved edges
    - Instant loading
    - Tab system (Main & Character)
    - Smooth Noclip with anti-spam
    - Fly mode with camera direction control
    - Keybinds for Noclip (N) and Fly (F)
    - Toggleable Aimbot (customizable keybind)
    - Mouse Lock OR Camera Lock mode
    - FOV Circle PERFECTLY FOLLOWS CURSOR
    - ESP with toggleable features (FIXED)
    - Smooth aiming with adjustable smoothness
    - Adjustable aim radius
    - Resizable and draggable GUI
    - Press "K" to toggle GUI visibility
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer
local Mouse = game.Players.LocalPlayer:GetMouse()

-- ===== CREATE GUI (INSTANT) =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernCheatGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main container frame with rounded edges
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 480)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.08
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = true
MainFrame.ClipsDescendants = true

-- Rounded corners for main frame
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Subtle glow border
local BorderFrame = Instance.new("Frame")
BorderFrame.Size = UDim2.new(1, -2, 1, -2)
BorderFrame.Position = UDim2.new(0, 1, 0, 1)
BorderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
BorderFrame.BackgroundTransparency = 0.9
BorderFrame.BorderSizePixel = 2
BorderFrame.BorderColor3 = Color3.fromRGB(100, 100, 150)
BorderFrame.Parent = MainFrame
local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 14)
BorderCorner.Parent = BorderFrame

-- ===== DRAG GRABBER BUTTON =====
local GrabberButton = Instance.new("TextButton")
GrabberButton.Size = UDim2.new(0, 30, 0, 30)
GrabberButton.Position = UDim2.new(0, 8, 0, 8)
GrabberButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
GrabberButton.BackgroundTransparency = 0.3
GrabberButton.BorderSizePixel = 0
GrabberButton.Text = "≡"
GrabberButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GrabberButton.TextScaled = true
GrabberButton.Font = Enum.Font.GothamBold
GrabberButton.Parent = MainFrame
local GrabberCorner = Instance.new("UICorner")
GrabberCorner.CornerRadius = UDim.new(0, 8)
GrabberCorner.Parent = GrabberButton

local function makeGrabberDraggable(grabber, frame)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    
    grabber.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    grabber.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeGrabberDraggable(GrabberButton, MainFrame)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 30)
Title.Position = UDim2.new(0, 45, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "Moneys Cheats [K]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Tab Buttons
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local MainTabButton = Instance.new("TextButton")
MainTabButton.Size = UDim2.new(0, 120, 1, -4)
MainTabButton.Position = UDim2.new(0, 0, 0, 2)
MainTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MainTabButton.BorderSizePixel = 0
MainTabButton.Text = "Main"
MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabButton.TextScaled = true
MainTabButton.Font = Enum.Font.GothamBold
MainTabButton.Parent = TabContainer
local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 8)
MainTabCorner.Parent = MainTabButton

local CharTabButton = Instance.new("TextButton")
CharTabButton.Size = UDim2.new(0, 120, 1, -4)
CharTabButton.Position = UDim2.new(0, 125, 0, 2)
CharTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
CharTabButton.BorderSizePixel = 0
CharTabButton.Text = "Character"
CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CharTabButton.TextScaled = true
CharTabButton.Font = Enum.Font.GothamBold
CharTabButton.Parent = TabContainer
local CharTabCorner = Instance.new("UICorner")
CharTabCorner.CornerRadius = UDim.new(0, 8)
CharTabCorner.Parent = CharTabButton

-- ===== SCROLLING FRAME =====
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -100)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 85)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 680)
ScrollingFrame.Parent = MainFrame

-- Content containers for tabs
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.BackgroundTransparency = 1
MainContent.BorderSizePixel = 0
MainContent.Parent = ScrollingFrame

local CharContent = Instance.new("Frame")
CharContent.Size = UDim2.new(1, 0, 1, 0)
CharContent.BackgroundTransparency = 1
CharContent.BorderSizePixel = 0
CharContent.Visible = false
CharContent.Parent = ScrollingFrame

-- ===== TAB SWITCHING =====
local function switchTab(tab)
    if tab == "Main" then
        MainContent.Visible = true
        CharContent.Visible = false
        MainTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CharTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 680)
    else
        MainContent.Visible = false
        CharContent.Visible = true
        CharTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        CharTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
    end
end

MainTabButton.MouseButton1Click:Connect(function() switchTab("Main") end)
CharTabButton.MouseButton1Click:Connect(function() switchTab("Character") end)

-- ============================================
-- ===== UI HELPER FUNCTIONS =====
-- ============================================

local function createStyledButton(text, position, parent, width, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width or 140, 0, 30)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    return btn
end

local function createStyledLabel(text, position, parent, width)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, width or 120, 0, 25)
    lbl.Position = position
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

local function createSlider(labelText, yPos, parent, minVal, maxVal, defaultVal, callback, fillColor)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.Position = UDim2.new(0, 0, 0, yPos)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText .. ": " .. tostring(defaultVal)
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 170, 0, 8)
    sliderBg.Position = UDim2.new(0, 170, 0, 6)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = container
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = sliderBg
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = fillColor or Color3.fromRGB(0, 150, 255)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBg
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local dragging = false
    local value = defaultVal
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position
            local sliderPos = sliderBg.AbsolutePosition
            local sliderSize = sliderBg.AbsoluteSize
            
            local percent = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
            value = math.floor(percent * (maxVal - minVal) + minVal)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            label.Text = labelText .. ": " .. tostring(value)
            
            if callback then
                callback(value)
            end
        end
    end)
    
    return {container = container, getValue = function() return value end}
end

-- ============================================
-- ===== MAIN TAB CONTENT =====
-- ============================================

-- Row 1: Keybind (y=5)
local KeybindLabel = createStyledLabel("Aim Key:", UDim2.new(0, 10, 0, 5), MainContent, 100)
local KeybindButton = createStyledButton("RMB", UDim2.new(0, 130, 0, 5), MainContent, 100)
KeybindButton.Size = UDim2.new(0, 100, 0, 28)

-- Row 2: Aim Mode (y=40)
local AimModeLabel = createStyledLabel("Aim Mode:", UDim2.new(0, 10, 0, 40), MainContent, 100)
local AimModeButton = createStyledButton("Mouse Lock", UDim2.new(0, 130, 0, 40), MainContent, 130)
AimModeButton.Size = UDim2.new(0, 130, 0, 28)

-- Row 3: Aimbot Toggle (y=75)
local AimbotToggle = createStyledButton("Aimbot: OFF", UDim2.new(0, 10, 0, 75), MainContent, 155)
AimbotToggle.Size = UDim2.new(0, 155, 0, 32)

-- Row 3b: ESP Toggle (y=75, right side)
local ESPToggle = createStyledButton("ESP: OFF", UDim2.new(0, 185, 0, 75), MainContent, 155)
ESPToggle.Size = UDim2.new(0, 155, 0, 32)

-- Row 4: Aim Part (y=115)
local AimPartLabel = createStyledLabel("Aim Part:", UDim2.new(0, 10, 0, 115), MainContent, 100)
local AimPartButton = createStyledButton("Head", UDim2.new(0, 130, 0, 115), MainContent, 130)
AimPartButton.Size = UDim2.new(0, 130, 0, 28)

-- Row 5: FOV Toggle (y=150)
local FOVToggle = createStyledButton("FOV: ON", UDim2.new(0, 10, 0, 150), MainContent, 155)
FOVToggle.Size = UDim2.new(0, 155, 0, 28)

-- Row 6: Aim Radius Slider (y=190)
local aimRadiusSlider = createSlider("Aim Radius", 190, MainContent, 10, 300, 100, function(val)
    aimRadius = val
    if fovEnabled then
        updateFOVPosition()
    end
end, Color3.fromRGB(0, 150, 255))

-- Row 7: Smoothness Slider (y=230)
local smoothnessSlider = createSlider("Smoothness", 230, MainContent, 1, 20, 5, function(val)
    smoothness = val
end, Color3.fromRGB(255, 150, 0))

-- Row 8: ESP Name Toggle (y=275)
local ESPNameToggle = createStyledButton("Name Tags: ON", UDim2.new(0, 10, 0, 275), MainContent, 155)
ESPNameToggle.Size = UDim2.new(0, 155, 0, 28)

-- Row 8b: ESP Health Toggle (y=275, right side)
local ESPHealthToggle = createStyledButton("Health Bar: ON", UDim2.new(0, 185, 0, 275), MainContent, 155)
ESPHealthToggle.Size = UDim2.new(0, 155, 0, 28)

-- ============================================
-- ===== CHARACTER TAB CONTENT =====
-- ============================================

-- Row 1: Noclip Toggle (y=5)
local NoclipLabel = createStyledLabel("Noclip [N]:", UDim2.new(0, 10, 0, 5), CharContent, 100)
local NoclipToggle = createStyledButton("OFF", UDim2.new(0, 130, 0, 5), CharContent, 100)
NoclipToggle.Size = UDim2.new(0, 100, 0, 28)

-- Row 2: Fly Toggle (y=40)
local FlyLabel = createStyledLabel("Fly [F]:", UDim2.new(0, 10, 0, 40), CharContent, 100)
local FlyToggle = createStyledButton("OFF", UDim2.new(0, 130, 0, 40), CharContent, 100)
FlyToggle.Size = UDim2.new(0, 100, 0, 28)

-- Info Label (y=80)
local CharInfo = Instance.new("TextLabel")
CharInfo.Size = UDim2.new(1, -20, 0, 100)
CharInfo.Position = UDim2.new(0, 10, 0, 80)
CharInfo.BackgroundTransparency = 1
CharInfo.Text = "Noclip: Phase through walls (Press N)\nFly: Fly in the direction you're looking (Press F)\nFly moves 5 studs per second in camera direction"
CharInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
CharInfo.TextScaled = true
CharInfo.Font = Enum.Font.Gotham
CharInfo.TextXAlignment = Enum.TextXAlignment.Left
CharInfo.Parent = CharContent

-- ============================================
-- ===== STATES =====
-- ============================================
local aimbotEnabled = false
local espEnabled = false
local espNameEnabled = true
local espHealthEnabled = true
local selectedAimPart = "Head"
local aimRadius = 100
local smoothness = 5
local guiVisible = true
local isAiming = false
local isWaitingForKeybind = false
local aimMode = "Mouse Lock"
local currentCameraCFrame = nil
local targetPlayer = nil
local fovEnabled = true

local aimParts = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "LeftFoot", "RightFoot", "LeftHand", "RightHand"}
local aimModes = {"Mouse Lock", "Camera Lock"}
local keybindOptions = {
    "RMB", "LMB", "MMB", "Q", "E", "R", "T", "Y", "F", "G", "Z", "X", "C", "V", "B",
    "LeftShift", "LeftControl", "LeftAlt", "RightShift", "RightControl", "RightAlt"
}
local selectedKeybind = "RMB"

-- ============================================
-- ===== NOCLIP VARIABLES =====
-- ============================================
local noclipEnabled = false
local noclipConnection = nil
local lastTeleportTime = 0
local TELEPORT_COOLDOWN = 0.5
local teleportQueue = {}
local isProcessingQueue = false

-- ============================================
-- ===== FLY VARIABLES =====
-- ============================================
local flyEnabled = false
local flyConnection = nil
local FLY_SPEED = 5

-- ============================================
-- ===== KEYBINDS FOR NOCLIP AND FLY =====
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.N then
        toggleNoclip()
    end
    
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)

-- ============================================
-- ===== DROPDOWN MENUS =====
-- ============================================
local activeDropdown = nil
local dropdownFrame = nil

local function createDropdown(options, currentValue, button, parent, callback)
    if activeDropdown then
        activeDropdown:Destroy()
        activeDropdown = nil
        dropdownFrame = nil
        return
    end
    
    dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(0, 130, 0, #options * 28)
    dropdownFrame.Position = button.Position + UDim2.new(0, 0, 0, 30)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    dropdownFrame.BorderSizePixel = 1
    dropdownFrame.BorderColor3 = Color3.fromRGB(50, 50, 70)
    dropdownFrame.Parent = parent
    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 8)
    dCorner.Parent = dropdownFrame
    activeDropdown = dropdownFrame
    
    for i, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
        btn.BackgroundColor3 = (option == currentValue) and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 40, 50)
        btn.BorderSizePixel = 0
        btn.Text = option
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = dropdownFrame
        
        btn.MouseButton1Click:Connect(function()
            callback(option)
            if activeDropdown then
                activeDropdown:Destroy()
                activeDropdown = nil
                dropdownFrame = nil
            end
        end)
    end
end

-- ===== DROPDOWN TRIGGERS =====
AimModeButton.MouseButton1Click:Connect(function()
    createDropdown(aimModes, aimMode, AimModeButton, MainContent, function(option)
        aimMode = option
        AimModeButton.Text = option
        print("Aim Mode set to: " .. option)
    end)
end)

AimPartButton.MouseButton1Click:Connect(function()
    createDropdown(aimParts, selectedAimPart, AimPartButton, MainContent, function(option)
        selectedAimPart = option
        AimPartButton.Text = option
        print("Aim Part set to: " .. option)
    end)
end)

-- Close dropdowns when clicking elsewhere
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if activeDropdown and dropdownFrame then
            local mousePos = input.Position
            local framePos = dropdownFrame.AbsolutePosition
            local frameSize = dropdownFrame.AbsoluteSize
            if not (mousePos.X >= framePos.X and mousePos.X <= framePos.X + frameSize.X and
                    mousePos.Y >= framePos.Y and mousePos.Y <= framePos.Y + frameSize.Y) then
                activeDropdown:Destroy()
                activeDropdown = nil
                dropdownFrame = nil
            end
        end
    end
end)

-- ===== KEYBIND LISTENER =====
KeybindButton.MouseButton1Click:Connect(function()
    isWaitingForKeybind = true
    KeybindButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    KeybindButton.Text = "Press Key..."
    print("Press any key to set as aimbot keybind...")
end)

local function getKeyCodeFromString(keyString)
    if keyString == "RMB" then return Enum.UserInputType.MouseButton2
    elseif keyString == "LMB" then return Enum.UserInputType.MouseButton1
    elseif keyString == "MMB" then return Enum.UserInputType.MouseButton3
    else return Enum.KeyCode[keyString] end
end

-- ===== MAIN KEYBIND LISTENER =====
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        guiVisible = not guiVisible
        MainFrame.Visible = guiVisible
    end
    
    if isWaitingForKeybind then
        local keyName = nil
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            keyName = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
            for _, option in ipairs(keybindOptions) do
                if option == keyName then
                    selectedKeybind = keyName
                    KeybindButton.Text = keyName
                    isWaitingForKeybind = false
                    KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                    print("Keybind set to: " .. keyName)
                    return
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectedKeybind = "LMB"
            KeybindButton.Text = "LMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            print("Keybind set to: LMB")
            return
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            selectedKeybind = "RMB"
            KeybindButton.Text = "RMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            print("Keybind set to: RMB")
            return
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            selectedKeybind = "MMB"
            KeybindButton.Text = "MMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            print("Keybind set to: MMB")
            return
        end
        return
    end
    
    if aimbotEnabled then
        local keyCode = getKeyCodeFromString(selectedKeybind)
        if selectedKeybind == "RMB" and input.UserInputType == Enum.UserInputType.MouseButton2 then
            isAiming = true
            targetPlayer = getClosestPlayer()
            if aimMode == "Camera Lock" then currentCameraCFrame = Camera.CFrame end
        elseif selectedKeybind == "LMB" and input.UserInputType == Enum.UserInputType.MouseButton1 then
            isAiming = true
            targetPlayer = getClosestPlayer()
            if aimMode == "Camera Lock" then currentCameraCFrame = Camera.CFrame end
        elseif selectedKeybind == "MMB" and input.UserInputType == Enum.UserInputType.MouseButton3 then
            isAiming = true
            targetPlayer = getClosestPlayer()
            if aimMode == "Camera Lock" then currentCameraCFrame = Camera.CFrame end
        elseif input.KeyCode == keyCode and keyCode ~= Enum.KeyCode.Unknown then
            isAiming = true
            targetPlayer = getClosestPlayer()
            if aimMode == "Camera Lock" then currentCameraCFrame = Camera.CFrame end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if aimbotEnabled then
        local keyCode = getKeyCodeFromString(selectedKeybind)
        if selectedKeybind == "RMB" and input.UserInputType == Enum.UserInputType.MouseButton2 then
            isAiming = false; targetPlayer = nil; currentCameraCFrame = nil
        elseif selectedKeybind == "LMB" and input.UserInputType == Enum.UserInputType.MouseButton1 then
            isAiming = false; targetPlayer = nil; currentCameraCFrame = nil
        elseif selectedKeybind == "MMB" and input.UserInputType == Enum.UserInputType.MouseButton3 then
            isAiming = false; targetPlayer = nil; currentCameraCFrame = nil
        elseif input.KeyCode == keyCode and keyCode ~= Enum.KeyCode.Unknown then
            isAiming = false; targetPlayer = nil; currentCameraCFrame = nil
        end
    end
end)

-- ============================================
-- ===== NOCLIP FUNCTIONS =====
-- ============================================
local function performTeleport()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
    if not torso then return end
    
    local origin = torso.Position
    local direction = rootPart.CFrame.LookVector
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {character, LocalPlayer}
    raycastParams.IgnoreWater = true
    
    local rayResult = workspace:Raycast(origin, direction * 3, raycastParams)
    
    if rayResult then
        local newPos = rootPart.Position + (rootPart.CFrame.LookVector * 4)
        
        local checkRay = workspace:Raycast(newPos, Vector3.new(0, -0.5, 0), raycastParams)
        if not checkRay then
            local newCFrame = CFrame.new(newPos)
            
            local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = newCFrame})
            tween:Play()
            
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part ~= rootPart then
                    local offset = rootPart.CFrame:ToObjectSpace(part.CFrame)
                    local partTween = TweenService:Create(part, tweenInfo, {CFrame = newCFrame * offset})
                    partTween:Play()
                end
            end
            
            for _, child in pairs(character:GetChildren()) do
                if child:IsA("Accessory") and child:FindFirstChild("Handle") then
                    local handle = child.Handle
                    if handle:IsA("BasePart") then
                        local offset = rootPart.CFrame:ToObjectSpace(handle.CFrame)
                        local handleTween = TweenService:Create(handle, tweenInfo, {CFrame = newCFrame * offset})
                        handleTween:Play()
                    end
                end
            end
        end
    end
end

local function processTeleportQueue()
    if isProcessingQueue then return end
    if #teleportQueue == 0 then return end
    
    isProcessingQueue = true
    
    while #teleportQueue > 0 do
        local currentTime = tick()
        if currentTime - lastTeleportTime >= TELEPORT_COOLDOWN then
            local data = table.remove(teleportQueue, 1)
            performTeleport()
            lastTeleportTime = currentTime
        else
            task.wait(0.05)
        end
    end
    
    isProcessingQueue = false
end

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    NoclipToggle.Text = noclipEnabled and "ON" or "OFF"
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    
    if noclipEnabled and flyEnabled then
        toggleFly()
    end
    
    if noclipEnabled then
        print("Noclip enabled - Press N to toggle")
        if not noclipConnection then
            lastTeleportTime = 0
            teleportQueue = {}
            isProcessingQueue = false
            
            noclipConnection = RunService.Heartbeat:Connect(function()
                if not noclipEnabled then return end
                
                local character = LocalPlayer.Character
                if not character then return end
                
                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then return end
                
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                
                local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
                if not torso then return end
                
                local origin = torso.Position
                local direction = rootPart.CFrame.LookVector
                
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.FilterDescendantsInstances = {character, LocalPlayer}
                raycastParams.IgnoreWater = true
                
                local hitWall = false
                for i = 1, 3 do
                    local checkPos = origin + (direction * (i * 1.5))
                    local rayResult = workspace:Raycast(checkPos, direction * 1.5, raycastParams)
                    if rayResult then
                        hitWall = true
                        break
                    end
                end
                
                if hitWall then
                    table.insert(teleportQueue, {time = tick()})
                    processTeleportQueue()
                end
            end)
        end
    else
        print("Noclip disabled")
        teleportQueue = {}
        isProcessingQueue = false
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

NoclipToggle.MouseButton1Click:Connect(toggleNoclip)

-- ============================================
-- ===== FLY FUNCTIONS =====
-- ============================================
local function toggleFly()
    flyEnabled = not flyEnabled
    FlyToggle.Text = flyEnabled and "ON" or "OFF"
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    
    if flyEnabled and noclipEnabled then
        toggleNoclip()
    end
    
    if flyEnabled then
        print("Fly enabled - Press F to toggle")
        if not flyConnection then
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled then return end
                
                local character = LocalPlayer.Character
                if not character then return end
                
                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then return end
                
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                
                local cameraCFrame = Camera.CFrame
                local lookVector = cameraCFrame.LookVector
                local moveDirection = lookVector
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = lookVector
                elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = -lookVector
                elseif UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = -cameraCFrame.RightVector
                elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = cameraCFrame.RightVector
                else
                    moveDirection = lookVector
                end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = cameraCFrame.UpVector
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = -cameraCFrame.UpVector
                end
                
                local newPos = rootPart.Position + (moveDirection * FLY_SPEED * 0.1)
                
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.FilterDescendantsInstances = {character, LocalPlayer}
                raycastParams.IgnoreWater = true
                
                local checkRay = workspace:Raycast(newPos, Vector3.new(0, -0.5, 0), raycastParams)
                
                if not checkRay then
                    local newCFrame = CFrame.new(newPos)
                    
                    local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = newCFrame})
                    tween:Play()
                    
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") and part ~= rootPart then
                            local offset = rootPart.CFrame:ToObjectSpace(part.CFrame)
                            local partTween = TweenService:Create(part, tweenInfo, {CFrame = newCFrame * offset})
                            partTween:Play()
                        end
                    end
                    
                    for _, child in pairs(character:GetChildren()) do
                        if child:IsA("Accessory") and child:FindFirstChild("Handle") then
                            local handle = child.Handle
                            if handle:IsA("BasePart") then
                                local offset = rootPart.CFrame:ToObjectSpace(handle.CFrame)
                                local handleTween = TweenService:Create(handle, tweenInfo, {CFrame = newCFrame * offset})
                                handleTween:Play()
                            end
                        end
                    end
                end
            end)
        end
    else
        print("Fly disabled")
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
    end
end

FlyToggle.MouseButton1Click:Connect(toggleFly)

-- ============================================
-- ===== FOV CIRCLE =====
-- ============================================
local espObjects = {}
local fovCircle = nil
local fovInner = nil

local function createFOVCircle()
    if fovCircle then 
        fovCircle:Destroy() 
        fovCircle = nil 
    end
    
    fovCircle = Instance.new("Frame")
    fovCircle.Size = UDim2.new(0, aimRadius * 2, 0, aimRadius * 2)
    fovCircle.Position = UDim2.new(0, 0, 0, 0)
    fovCircle.BackgroundTransparency = 0.85
    fovCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fovCircle.BorderSizePixel = 2
    fovCircle.BorderColor3 = Color3.fromRGB(0, 255, 0)
    fovCircle.ZIndex = 999
    fovCircle.Parent = ScreenGui
    fovCircle.Visible = fovEnabled
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = fovCircle
    
    fovInner = Instance.new("Frame")
    fovInner.Size = UDim2.new(0.98, 0, 0.98, 0)
    fovInner.Position = UDim2.new(0.01, 0, 0.01, 0)
    fovInner.BackgroundTransparency = 0.9
    fovInner.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fovInner.BorderSizePixel = 0
    fovInner.Parent = fovCircle
    local innerCorner = Instance.new("UICorner")
    innerCorner.CornerRadius = UDim.new(1, 0)
    innerCorner.Parent = fovInner
end
createFOVCircle()

local function updateFOVPosition()
    if not fovCircle or not fovEnabled then
        if fovCircle then fovCircle.Visible = false end
        return
    end
    
    local mouseX = Mouse.X
    local mouseY = Mouse.Y
    
    local xPos = mouseX - aimRadius
    local yPos = mouseY - aimRadius
    
    fovCircle.Position = UDim2.new(0, xPos, 0, yPos)
    fovCircle.Size = UDim2.new(0, aimRadius * 2, 0, aimRadius * 2)
    fovCircle.Visible = true
    
    if fovInner then
        fovInner.Size = UDim2.new(0.98, 0, 0.98, 0)
        fovInner.Position = UDim2.new(0.01, 0, 0.01, 0)
    end
end

local function updateFOVSize()
    if not fovCircle then return end
    fovCircle.Size = UDim2.new(0, aimRadius * 2, 0, aimRadius * 2)
    if fovEnabled then
        updateFOVPosition()
    end
end

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if fovEnabled and fovCircle then
            updateFOVPosition()
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if fovEnabled and fovCircle then
        updateFOVPosition()
    end
end)

-- ===== FOV TOGGLE =====
local function toggleFOV()
    fovEnabled = not fovEnabled
    FOVToggle.Text = fovEnabled and "FOV: ON" or "FOV: OFF"
    FOVToggle.BackgroundColor3 = fovEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    if fovEnabled then
        updateFOVPosition()
    else
        if fovCircle then fovCircle.Visible = false end
    end
end

FOVToggle.MouseButton1Click:Connect(toggleFOV)

-- ===== AIMBOT FUNCTIONS =====
local function getClosestPlayer()
    local closest = nil
    local shortestDist = aimRadius
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local aimPart = player.Character:FindFirstChild(selectedAimPart)
            if aimPart then
                local partPos = aimPart.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(partPos)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closest = player
                    end
                end
            end
        end
    end
    return closest
end

local function smoothAim(currentCF, targetCF, smoothFactor)
    local currentPos = currentCF.Position
    local targetPos = targetCF.Position
    local newPos = currentPos:Lerp(targetPos, 1 / smoothFactor)
    local currentLook = currentCF.LookVector
    local targetLook = targetCF.LookVector
    local newLook = currentLook:Lerp(targetLook, 1 / smoothFactor)
    return CFrame.lookAt(newPos, newPos + newLook)
end

-- ============================================
-- ===== ESP FUNCTIONS (FIXED) =====
-- ============================================

local function createESP(player)
    if espObjects[player] then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    -- Name label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 200, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = ScreenGui
    nameLabel.Visible = espEnabled and espNameEnabled
    nameLabel.ZIndex = 100
    
    -- Distance label
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(0, 100, 0, 16)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = ScreenGui
    distLabel.Visible = espEnabled and espNameEnabled
    distLabel.ZIndex = 100
    
    -- Health bar background
    local healthBg = Instance.new("Frame")
    healthBg.Size = UDim2.new(0, 50, 0, 6)
    healthBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    healthBg.BorderSizePixel = 1
    healthBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
    healthBg.Parent = ScreenGui
    healthBg.Visible = espEnabled and espHealthEnabled
    healthBg.ZIndex = 100
    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0, 3)
    hCorner.Parent = healthBg
    
    -- Health bar fill
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBg
    healthFill.ZIndex = 101
    local hfCorner = Instance.new("UICorner")
    hfCorner.CornerRadius = UDim.new(0, 3)
    hfCorner.Parent = healthFill
    
    -- Box lines (4 lines for cleaner look)
    local boxLines = {}
    for i = 1, 4 do
        local line = Instance.new("Frame")
        line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        line.BackgroundTransparency = 0.3
        line.BorderSizePixel = 0
        line.Parent = ScreenGui
        line.Visible = espEnabled
        line.ZIndex = 99
        boxLines[i] = line
    end
    
    espObjects[player] = {
        nameLabel = nameLabel,
        distLabel = distLabel,
        healthBg = healthBg,
        healthFill = healthFill,
        boxLines = boxLines,
        character = character
    }
end

local function removeESP(player)
    local data = espObjects[player]
    if data then
        data.nameLabel:Destroy()
        data.distLabel:Destroy()
        data.healthBg:Destroy()
        for _, line in ipairs(data.boxLines) do
            line:Destroy()
        end
        espObjects[player] = nil
    end
end

local function clearAllESP()
    for player, data in pairs(espObjects) do
        data.nameLabel:Destroy()
        data.distLabel:Destroy()
        data.healthBg:Destroy()
        for _, line in ipairs(data.boxLines) do
            line:Destroy()
        end
    end
    espObjects = {}
end

local function updateESP()
    for player, data in pairs(espObjects) do
        local character = player.Character
        if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
            removeESP(player)
            continue
        end
        
        local head = character:FindFirstChild("Head")
        local root = character:FindFirstChild("HumanoidRootPart")
        if not head or not root then
            removeESP(player)
            continue
        end
        
        local headPos = head.Position
        local rootPos = root.Position
        local screenHead, onScreen = Camera:WorldToViewportPoint(headPos)
        local screenRoot, _ = Camera:WorldToViewportPoint(rootPos)
        
        if not onScreen then
            data.nameLabel.Visible = false
            data.distLabel.Visible = false
            data.healthBg.Visible = false
            for _, line in ipairs(data.boxLines) do
                line.Visible = false
            end
            continue
        end
        
        -- Update visibility based on toggles
        data.nameLabel.Visible = espEnabled and espNameEnabled
        data.distLabel.Visible = espEnabled and espNameEnabled
        data.healthBg.Visible = espEnabled and espHealthEnabled
        
        for _, line in ipairs(data.boxLines) do
            line.Visible = espEnabled
        end
        
        -- Calculate box size based on character
        local height = math.abs(screenRoot.Y - screenHead.Y) * 1.8
        local width = height * 0.4
        local x = screenHead.X - width / 2
        local y = screenHead.Y - 5
        
        -- Update name label (above head)
        if espNameEnabled then
            data.nameLabel.Position = UDim2.new(0, x, 0, y - 25)
            data.nameLabel.Size = UDim2.new(0, width * 1.5, 0, 20)
            
            -- Update distance label (below feet)
            local dist = (headPos - Camera.CFrame.Position).Magnitude
            data.distLabel.Text = string.format("%.0f studs", dist)
            data.distLabel.Position = UDim2.new(0, x, 0, y + height + 20)
            data.distLabel.Size = UDim2.new(0, width * 1.5, 0, 16)
        end
        
        -- Update health bar (below feet, above distance)
        if espHealthEnabled then
            local healthOffset = espNameEnabled and 8 or 0
            data.healthBg.Position = UDim2.new(0, x, 0, y + height + healthOffset)
            data.healthBg.Size = UDim2.new(0, width, 0, 6)
            
            local health = character.Humanoid.Health / character.Humanoid.MaxHealth
            data.healthFill.Size = UDim2.new(health, 0, 1, 0)
            data.healthFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - health), 255 * health, 0)
        end
        
        -- Draw box lines (top, bottom, left, right)
        local thickness = 2
        local lineLength = width * 0.2
        
        -- Top line
        data.boxLines[1].Position = UDim2.new(0, x + width/2 - lineLength/2, 0, y)
        data.boxLines[1].Size = UDim2.new(0, lineLength, 0, thickness)
        
        -- Bottom line
        data.boxLines[2].Position = UDim2.new(0, x + width/2 - lineLength/2, 0, y + height)
        data.boxLines[2].Size = UDim2.new(0, lineLength, 0, thickness)
        
        -- Left line
        data.boxLines[3].Position = UDim2.new(0, x, 0, y + height/2 - lineLength/2)
        data.boxLines[3].Size = UDim2.new(0, thickness, 0, lineLength)
        
        -- Right line
        data.boxLines[4].Position = UDim2.new(0, x + width, 0, y + height/2 - lineLength/2)
        data.boxLines[4].Size = UDim2.new(0, thickness, 0, lineLength)
        
        -- Color based on health
        local health = character.Humanoid.Health / character.Humanoid.MaxHealth
        local boxColor = Color3.fromRGB(255 * (1 - health), 255 * health, 0)
        for _, line in ipairs(data.boxLines) do
            line.BackgroundColor3 = boxColor
        end
    end
end

-- ===== CONNECTION FOR PLAYER ADD/REMOVE =====
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            createESP(player)
        end
    end)
    if espEnabled and player ~= LocalPlayer then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- ===== TOGGLE FUNCTIONS =====
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    if aimbotEnabled then 
        if fovEnabled then updateFOVPosition() end
    else 
        if fovCircle then fovCircle.Visible = false end
        isAiming = false
        targetPlayer = nil
        currentCameraCFrame = nil
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    ESPToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    
    if espEnabled then
        -- Create ESP for all existing players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESP(player)
            end
        end
    else
        clearAllESP()
    end
end

local function toggleESPName()
    espNameEnabled = not espNameEnabled
    ESPNameToggle.Text = espNameEnabled and "Name Tags: ON" or "Name Tags: OFF"
    ESPNameToggle.BackgroundColor3 = espNameEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    
    -- Update visibility for all existing ESP objects
    for player, data in pairs(espObjects) do
        data.nameLabel.Visible = espEnabled and espNameEnabled
        data.distLabel.Visible = espEnabled and espNameEnabled
    end
end

local function toggleESPHealth()
    espHealthEnabled = not espHealthEnabled
    ESPHealthToggle.Text = espHealthEnabled and "Health Bar: ON" or "Health Bar: OFF"
    ESPHealthToggle.BackgroundColor3 = espHealthEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 70)
    
    -- Update visibility for all existing ESP objects
    for player, data in pairs(espObjects) do
        data.healthBg.Visible = espEnabled and espHealthEnabled
    end
end

AimbotToggle.MouseButton1Click:Connect(toggleAimbot)
ESPToggle.MouseButton1Click:Connect(toggleESP)
ESPNameToggle.MouseButton1Click:Connect(toggleESPName)
ESPHealthToggle.MouseButton1Click:C... (3 KB left)
