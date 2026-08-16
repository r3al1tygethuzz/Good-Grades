local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = game.Players.LocalPlayer

-- Wait for character to load
local function waitForCharacter()
    local char = LocalPlayer.Character
    if char then return char end
    repeat
        char = LocalPlayer.CharacterAdded:Wait()
    until char and char:FindFirstChild("HumanoidRootPart")
    return char
end

-- ===== CREATE GUI (INSTANT) =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernCheatGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main container frame with rounded edges (EXPANDED FOR MORE TABS)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 520)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = true
MainFrame.ClipsDescendants = true

-- Shadow effect
local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Shadow.BackgroundTransparency = 0.7
Shadow.ZIndex = -1
Shadow.Parent = MainFrame
local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 20)
ShadowCorner.Parent = Shadow

-- Rounded corners for main frame
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Subtle glow border
local BorderFrame = Instance.new("Frame")
BorderFrame.Size = UDim2.new(1, -2, 1, -2)
BorderFrame.Position = UDim2.new(0, 1, 0, 1)
BorderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
BorderFrame.BackgroundTransparency = 0.85
BorderFrame.BorderSizePixel = 1
BorderFrame.BorderColor3 = Color3.fromRGB(120, 120, 180)
BorderFrame.Parent = MainFrame
local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 14)
BorderCorner.Parent = BorderFrame

-- Gradient overlay
local GradientOverlay = Instance.new("Frame")
GradientOverlay.Size = UDim2.new(1, 0, 0, 30)
GradientOverlay.Position = UDim2.new(0, 0, 0, 0)
GradientOverlay.BackgroundTransparency = 1
GradientOverlay.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = GradientOverlay

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 180))
}
UIGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0.7),
    NumberSequenceKeypoint.new(1, 0.9)
}
UIGradient.Parent = GradientOverlay

-- ===== DRAG GRABBER BUTTON =====
local GrabberButton = Instance.new("TextButton")
GrabberButton.Size = UDim2.new(0, 30, 0, 30)
GrabberButton.Position = UDim2.new(0, 8, 0, 8)
GrabberButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
GrabberButton.BackgroundTransparency = 0.2
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
Title.Text = "MODERN CHEAT SUITE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Tab Buttons (EXPANDED FOR 4 TABS)
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local MainTabButton = Instance.new("TextButton")
MainTabButton.Size = UDim2.new(0, 80, 1, -4)
MainTabButton.Position = UDim2.new(0, 0, 0, 2)
MainTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
MainTabButton.BorderSizePixel = 0
MainTabButton.Text = "Main"
MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTabButton.TextScaled = true
MainTabButton.Font = Enum.Font.GothamBold
MainTabButton.Parent = TabContainer
local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 8)
MainTabCorner.Parent = MainTabButton

local VisualsTabButton = Instance.new("TextButton")
VisualsTabButton.Size = UDim2.new(0, 80, 1, -4)
VisualsTabButton.Position = UDim2.new(0, 85, 0, 2)
VisualsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
VisualsTabButton.BorderSizePixel = 0
VisualsTabButton.Text = "Visuals"
VisualsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
VisualsTabButton.TextScaled = true
VisualsTabButton.Font = Enum.Font.GothamBold
VisualsTabButton.Parent = TabContainer
local VisualsTabCorner = Instance.new("UICorner")
VisualsTabCorner.CornerRadius = UDim.new(0, 8)
VisualsTabCorner.Parent = VisualsTabButton

local CharTabButton = Instance.new("TextButton")
CharTabButton.Size = UDim2.new(0, 80, 1, -4)
CharTabButton.Position = UDim2.new(0, 170, 0, 2)
CharTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
CharTabButton.BorderSizePixel = 0
CharTabButton.Text = "Character"
CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CharTabButton.TextScaled = true
CharTabButton.Font = Enum.Font.GothamBold
CharTabButton.Parent = TabContainer
local CharTabCorner = Instance.new("UICorner")
CharTabCorner.CornerRadius = UDim.new(0, 8)
CharTabCorner.Parent = CharTabButton

local SettingsTabButton = Instance.new("TextButton")
SettingsTabButton.Size = UDim2.new(0, 80, 1, -4)
SettingsTabButton.Position = UDim2.new(0, 255, 0, 2)
SettingsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
SettingsTabButton.BorderSizePixel = 0
SettingsTabButton.Text = "Settings"
SettingsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SettingsTabButton.TextScaled = true
SettingsTabButton.Font = Enum.Font.GothamBold
SettingsTabButton.Parent = TabContainer
local SettingsTabCorner = Instance.new("UICorner")
SettingsTabCorner.CornerRadius = UDim.new(0, 8)
SettingsTabCorner.Parent = SettingsTabButton

-- ===== SCROLLING FRAME =====
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -10, 1, -100)
ScrollingFrame.Position = UDim2.new(0, 5, 0, 85)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 150)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 900)
ScrollingFrame.Parent = MainFrame

-- Content containers for tabs
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.BackgroundTransparency = 1
MainContent.BorderSizePixel = 0
MainContent.Parent = ScrollingFrame

local VisualsContent = Instance.new("Frame")
VisualsContent.Size = UDim2.new(1, 0, 1, 0)
VisualsContent.BackgroundTransparency = 1
VisualsContent.BorderSizePixel = 0
VisualsContent.Visible = false
VisualsContent.Parent = ScrollingFrame

local CharContent = Instance.new("Frame")
CharContent.Size = UDim2.new(1, 0, 1, 0)
CharContent.BackgroundTransparency = 1
CharContent.BorderSizePixel = 0
VisualsContent.Visible = false
CharContent.Parent = ScrollingFrame

local SettingsContent = Instance.new("Frame")
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.BackgroundTransparency = 1
SettingsContent.BorderSizePixel = 0
SettingsContent.Visible = false
SettingsContent.Parent = ScrollingFrame

-- ===== TAB SWITCHING =====
local function switchTab(tab)
    if tab == "Main" then
        MainContent.Visible = true
        VisualsContent.Visible = false
        CharContent.Visible = false
        SettingsContent.Visible = false
        MainTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
        MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        VisualsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        VisualsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        CharTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        SettingsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        SettingsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    elseif tab == "Visuals" then
        MainContent.Visible = false
        VisualsContent.Visible = true
        CharContent.Visible = false
        SettingsContent.Visible = false
        VisualsTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
        VisualsTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        CharTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        SettingsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        SettingsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
    elseif tab == "Character" then
        MainContent.Visible = false
        VisualsContent.Visible = false
        CharContent.Visible = true
        SettingsContent.Visible = false
        CharTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
        CharTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        VisualsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        VisualsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        SettingsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        SettingsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 320)
    else -- Settings
        MainContent.Visible = false
        VisualsContent.Visible = false
        CharContent.Visible = false
        SettingsContent.Visible = true
        SettingsTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
        SettingsTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        MainTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        VisualsTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        VisualsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        CharTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        CharTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
    end
end

MainTabButton.MouseButton1Click:Connect(function() switchTab("Main") end)
VisualsTabButton.MouseButton1Click:Connect(function() switchTab("Visuals") end)
CharTabButton.MouseButton1Click:Connect(function() switchTab("Character") end)
SettingsTabButton.MouseButton1Click:Connect(function() switchTab("Settings") end)

-- ============================================
-- ===== UI HELPER FUNCTIONS =====
-- ============================================

local function createStyledButton(text, position, parent, width, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width or 140, 0, 30)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.2
    end)
    
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
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
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
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 170, 0, 8)
    sliderBg.Position = UDim2.new(0, 170, 0, 6)
    sliderBg.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
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
-- ===== SETTINGS TAB CONTENT =====
-- ============================================

-- Row 1: UI Toggle Keybind (y=5)
local UIToggleLabel = createStyledLabel("UI Toggle Key:", UDim2.new(0, 10, 0, 5), SettingsContent, 100)
local UIToggleButton = createStyledButton("K", UDim2.new(0, 130, 0, 5), SettingsContent, 100)
UIToggleButton.Size = UDim2.new(0, 100, 0, 28)

-- Row 2: Info Label (y=40)
local SettingsInfo = Instance.new("TextLabel")
SettingsInfo.Size = UDim2.new(1, -20, 0, 60)
SettingsInfo.Position = UDim2.new(0, 10, 0, 45)
SettingsInfo.BackgroundTransparency = 1
SettingsInfo.Text = "Customize your keybinds and settings.\nClick the keybind button to change it."
SettingsInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
SettingsInfo.TextScaled = true
SettingsInfo.Font = Enum.Font.Gotham
SettingsInfo.TextXAlignment = Enum.TextXAlignment.Left
SettingsInfo.Parent = SettingsContent

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

-- ============================================
-- ===== VISUALS TAB CONTENT =====
-- ============================================

-- Row 1: ESP Toggle (y=5)
local ESPToggle = createStyledButton("ESP: OFF", UDim2.new(0, 10, 0, 5), VisualsContent, 155)
ESPToggle.Size = UDim2.new(0, 155, 0, 32)

-- Row 2: ESP Name Toggle (y=45)
local ESPNameToggle = createStyledButton("Name Tags: ON", UDim2.new(0, 10, 0, 45), VisualsContent, 155)
ESPNameToggle.Size = UDim2.new(0, 155, 0, 28)

-- Row 2b: ESP Health Toggle (y=45, right side)
local ESPHealthToggle = createStyledButton("Health Bar: ON", UDim2.new(0, 185, 0, 45), VisualsContent, 155)
ESPHealthToggle.Size = UDim2.new(0, 155, 0, 28)

-- Row 3: ESP Box Toggle (y=80)
local ESPBoxToggle = createStyledButton("Box: ON", UDim2.new(0, 10, 0, 80), VisualsContent, 155)
ESPBoxToggle.Size = UDim2.new(0, 155, 0, 28)

-- Row 3b: ESP Glow Toggle (y=80, right side)
local ESPGlowToggle = createStyledButton("Glow: ON", UDim2.new(0, 185, 0, 80), VisualsContent, 155)
ESPGlowToggle.Size = UDim2.new(0, 155, 0, 28)

-- Info Label for Visuals (y=120)
local VisualsInfo = Instance.new("TextLabel")
VisualsInfo.Size = UDim2.new(1, -20, 0, 60)
VisualsInfo.Position = UDim2.new(0, 10, 0, 120)
VisualsInfo.BackgroundTransparency = 1
VisualsInfo.Text = "ESP settings for player visualization.\nToggle individual elements on/off."
VisualsInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
VisualsInfo.TextScaled = true
VisualsInfo.Font = Enum.Font.Gotham
VisualsInfo.TextXAlignment = Enum.TextXAlignment.Left
VisualsInfo.Parent = VisualsContent

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

-- Row 3: Fly Speed Slider (y=75) - NOW WORKING
local flySpeedSlider = createSlider("Fly Speed", 75, CharContent, 1, 20, 5, function(val)
    FLY_SPEED = val
    print("Fly speed set to: " .. val)
end, Color3.fromRGB(255, 200, 0))

-- Info Label (y=120)
local CharInfo = Instance.new("TextLabel")
CharInfo.Size = UDim2.new(1, -20, 0, 100)
CharInfo.Position = UDim2.new(0, 10, 0, 120)
CharInfo.BackgroundTransparency = 1
CharInfo.Text = "Noclip: Phase through walls (Press N)\nFly: Invisible platforms spawn under you (Press F)\nW=Forward | S=Backward | A=Left | D=Right\nR=Up | LeftControl=Down\nSpeed slider adjusts movement speed"
CharInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
CharInfo.TextScaled = true
CharInfo.Font = Enum.Font.Gotham
CharInfo.TextXAlignment = Enum.TextXAlignment.Left
CharInfo.Parent = CharContent

-- ============================================
-- ===== UI TOGGLE KEYBIND VARIABLES =====
-- ============================================
local uiToggleKeybind = "K"
local isWaitingForUIToggle = false

-- ============================================
-- ===== STATES =====
-- ============================================
local aimbotEnabled = false
local espEnabled = false
local espNameEnabled = true
local espHealthEnabled = true
local espBoxEnabled = true
local espGlowEnabled = true
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
local lockedTarget = nil

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
-- ===== FLY VARIABLES (PLATFORM BASED) =====
-- ============================================
local flyEnabled = false
local flyConnection = nil
local flyPlatforms = {}
local FLY_SPEED = 5
local PLATFORM_LIFETIME = 0.5

-- ============================================
-- ===== FLY PLATFORM FUNCTIONS =====
-- ============================================
local function createFlyPlatform(position)
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(6, 0.5, 6)
    platform.Position = position
    platform.Anchored = true
    platform.CanCollide = true
    platform.Transparency = 1
    platform.Material = Enum.Material.SmoothPlastic
    platform.Name = "FlyPlatform"
    platform.Parent = workspace
    
    platform.LocalTransparencyModifier = 1
    
    table.insert(flyPlatforms, {
        Part = platform,
        Created = tick()
    })
    
    cleanupFlyPlatforms()
end

local function cleanupFlyPlatforms()
    local currentTime = tick()
    for i = #flyPlatforms, 1, -1 do
        local data = flyPlatforms[i]
        if currentTime - data.Created > PLATFORM_LIFETIME then
            if data.Part and data.Part.Parent then
                data.Part:Destroy()
            end
            table.remove(flyPlatforms, i)
        end
    end
end

local function clearAllFlyPlatforms()
    for _, data in pairs(flyPlatforms) do
        if data.Part and data.Part.Parent then
            data.Part:Destroy()
        end
    end
    flyPlatforms = {}
end

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
    
    -- UI Toggle Keybind
    if isWaitingForUIToggle then
        local keyName = nil
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            keyName = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
            uiToggleKeybind = keyName
            UIToggleButton.Text = keyName
            isWaitingForUIToggle = false
            UIToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            UIToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            print("UI Toggle keybind set to: " .. keyName)
            return
        end
        return
    end
    
    -- UI Toggle (uses customizable keybind)
    local keyCode = Enum.KeyCode[uiToggleKeybind]
    if input.KeyCode == keyCode then
        guiVisible = not guiVisible
        MainFrame.Visible = guiVisible
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
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    dropdownFrame.BorderSizePixel = 1
    dropdownFrame.BorderColor3 = Color3.fromRGB(60, 60, 90)
    dropdownFrame.Parent = parent
    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 8)
    dCorner.Parent = dropdownFrame
    activeDropdown = dropdownFrame
    
    for i, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
        btn.BackgroundColor3 = (option == currentValue) and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(45, 45, 60)
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

-- ===== UI TOGGLE KEYBIND LISTENER =====
UIToggleButton.MouseButton1Click:Connect(function()
    isWaitingForUIToggle = true
    UIToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    UIToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    UIToggleButton.Text = "Press Key..."
    print("Press any key to set as UI toggle keybind...")
end)

local function getKeyCodeFromString(keyString)
    if keyString == "RMB" then return Enum.UserInputType.MouseButton2
    elseif keyString == "LMB" then return Enum.UserInputType.MouseButton1
    elseif keyString == "MMB" then return Enum.UserInputType.MouseButton3
    else return Enum.KeyCode[keyString] end
end

-- ============================================
-- ===== MAIN KEYBIND LISTENER (AIMBOT) =====
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if isWaitingForKeybind then
        local keyName = nil
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            keyName = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
            for _, option in ipairs(keybindOptions) do
                if option == keyName then
                    selectedKeybind = keyName
                    KeybindButton.Text = keyName
                    isWaitingForKeybind = false
                    KeybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
                    print("Keybind set to: " .. keyName)
                    return
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            selectedKeybind = "LMB"
            KeybindButton.Text = "LMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            print("Keybind set to: LMB")
            return
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            selectedKeybind = "RMB"
            KeybindButton.Text = "RMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            print("Keybind set to: RMB")
            return
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            selectedKeybind = "MMB"
            KeybindButton.Text = "MMB"
            isWaitingForKeybind = false
            KeybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
            print("Keybind set to: MMB")
            return
        end
        return
    end
    
    if aimbotEnabled then
        local keyCode = getKeyCodeFromString(selectedKeybind)
        local isKeyPressed = false
        
        if selectedKeybind == "RMB" and input.UserInputType == Enum.UserInputType.MouseButton2 then
            isKeyPressed = true
        elseif selectedKeybind == "LMB" and input.UserInputType == Enum.UserInputType.MouseButton1 then
            isKeyPressed = true
        elseif selectedKeybind == "MMB" and input.UserInputType == Enum.UserInputType.MouseButton3 then
            isKeyPressed = true
        elseif input.KeyCode == keyCode and keyCode ~= Enum.KeyCode.Unknown then
            isKeyPressed = true
        end
        
        if isKeyPressed then
            isAiming = true
            local target = getClosestPlayer()
            if target then
                lockedTarget = target
                targetPlayer = target
                if aimMode == "Camera Lock" then
                    currentCameraCFrame = Camera.CFrame
                end
                print("Locked onto: " .. target.Name)
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if aimbotEnabled then
        local keyCode = getKeyCodeFromString(selectedKeybind)
        local isKeyReleased = false
        
        if selectedKeybind == "RMB" and input.UserInputType == Enum.UserInputType.MouseButton2 then
            isKeyReleased = true
        elseif selectedKeybind == "LMB" and input.UserInputType == Enum.UserInputType.MouseButton1 then
            isKeyReleased = true
        elseif selectedKeybind == "MMB" and input.UserInputType == Enum.UserInputType.MouseButton3 then
            isKeyReleased = true
        elseif input.KeyCode == keyCode and keyCode ~= Enum.KeyCode.Unknown then
            isKeyReleased = true
        end
        
        if isKeyReleased then
            isAiming = false
            lockedTarget = nil
            targetPlayer = nil
            currentCameraCFrame = nil
            print("Aim released")
        end
    end
end)

-- ============================================
-- ===== NOCLIP FUNCTIONS =====
-- ============================================
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    NoclipToggle.Text = noclipEnabled and "ON" or "OFF"
    NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
    
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
-- ===== FLY FUNCTIONS (PLATFORM BASED - FIXED) =====
-- ============================================
local function toggleFly()
    flyEnabled = not flyEnabled
    FlyToggle.Text = flyEnabled and "ON" or "OFF"
    FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
    
    if flyEnabled and noclipEnabled then
        toggleNoclip()
    end
    
    if flyEnabled then
        print("Fly enabled - Invisible platforms will spawn under you!")
        print("W=Forward | S=Backward | A=Left | D=Right | R=Up | LeftControl=Down")
        clearAllFlyPlatforms()
        
        if not flyConnection then
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyEnabled then return end
                
                local character = LocalPlayer.Character
                if not character then return end
                
                local humanoid = character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.Health <= 0 then return end
                
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                
                -- Get camera direction
                local cameraCFrame = Camera.CFrame
                local lookVector = cameraCFrame.LookVector
                local rightVector = cameraCFrame.RightVector
                local upVector = cameraCFrame.UpVector
                
                -- Check for movement keys
                local wPressed = UserInputService:IsKeyDown(Enum.KeyCode.W)
                local sPressed = UserInputService:IsKeyDown(Enum.KeyCode.S)
                local aPressed = UserInputService:IsKeyDown(Enum.KeyCode.A)
                local dPressed = UserInputService:IsKeyDown(Enum.KeyCode.D)
                local rPressed = UserInputService:IsKeyDown(Enum.KeyCode.R)  -- R for UP
                local downPressed = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)  -- LeftControl for DOWN
                
                -- Calculate movement direction
                local moveDirection = Vector3.new(0, 0, 0)
                local moving = false
                
                -- W: Move forward (in look direction)
                if wPressed then
                    moveDirection = moveDirection + lookVector
                    moving = true
                end
                
                -- S: Move backward
                if sPressed then
                    moveDirection = moveDirection - lookVector
                    moving = true
                end
                
                -- A: Move left
                if aPressed then
                    moveDirection = moveDirection - rightVector
                    moving = true
                end
                
                -- D: Move right
                if dPressed then
                    moveDirection = moveDirection + rightVector
                    moving = true
                end
                
                -- R: Move UP (straight up, regardless of where you look)
                if rPressed then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    moving = true
                end
                
                -- LeftControl: Move DOWN (straight down, regardless of where you look)
                if downPressed then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    moving = true
                end
                
                -- Normalize movement vector for consistent speed in all directions
                if moving then
                    moveDirection = moveDirection.Unit
                end
                
                -- Get current position
                local currentPos = rootPart.Position
                local newPos = currentPos
                
                -- If moving, calculate new position
                if moving then
                    newPos = currentPos + (moveDirection * FLY_SPEED * 0.1)
                end
                
                -- Create platform under the player (at their feet)
                local platformPos = newPos + Vector3.new(0, -3, 0)
                createFlyPlatform(platformPos)
                
                -- Also create platforms around the player for stability
                createFlyPlatform(platformPos + Vector3.new(3, 0, 0))
                createFlyPlatform(platformPos + Vector3.new(-3, 0, 0))
                createFlyPlatform(platformPos + Vector3.new(0, 0, 3))
                createFlyPlatform(platformPos + Vector3.new(0, 0, -3))
                
                -- If moving, smoothly move the character
                if moving then
                    -- Move the character
                    local newCFrame = CFrame.new(newPos, newPos + lookVector)
                    
                    rootPart.Velocity = Vector3.new(0, 0, 0) -- Reset velocity to prevent physics conflicts
                    rootPart.CFrame = newCFrame
                end
            end)
        end
    else
        print("Fly disabled")
        clearAllFlyPlatforms()
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
    fovCircle.BackgroundTransparency = 0.9
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
    fovInner.BackgroundTransparency = 0.95
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
    
    local mouseLocation = UserInputService:GetMouseLocation()
    local mouseX = mouseLocation.X
    local mouseY = mouseLocation.Y
    
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
    FOVToggle.BackgroundColor3 = fovEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
    if not fovEnabled and fovCircle then
        fovCircle.Visible = false
    end
end

FOVToggle.MouseButton1Click:Connect(toggleFOV)

-- ============================================
-- ===== ESP SYSTEM (IMPROVED) =====
-- ============================================

local function getPlayerBoundingBox(player)
    local character = player.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end
    
    local head = character:FindFirstChild("Head")
    if not head then return nil end
    
    -- Get positions in world space
    local rootPos = rootPart.Position
    local headPos = head.Position
    
    -- Calculate height and width
    local height = (headPos.Y - rootPos.Y) * 2
    local width = height * 0.6
    
    -- Convert to screen space
    local rootScreenPos, rootVisible = Camera:WorldToViewportPoint(rootPos)
    local headScreenPos, headVisible = Camera:WorldToViewportPoint(headPos)
    
    if not rootVisible or not headVisible then
        return nil
    end
    
    local x = rootScreenPos.X - width/2
    local y = headScreenPos.Y
    local topRight = Vector2.new(x + width, y)
    local bottomLeft = Vector2.new(x, y + height)
    
    return {
        Position = Vector2.new(x, y),
        Size = Vector2.new(width, height),
        TopLeft = Vector2.new(x, y),
        TopRight = topRight,
        BottomLeft = bottomLeft,
        BottomRight = Vector2.new(x + width, y + height)
    }
end

local function createESPBox(player)
    if espObjects[player] then
        espObjects[player].Box:Destroy()
        espObjects[player].NameTag:Destroy()
        espObjects[player] = nil
    end
    
    local espBox = Instance.new("Frame")
    espBox.BackgroundTransparency = 1
    espBox.BorderSizePixel = 2
    espBox.BorderColor3 = Color3.fromRGB(0, 255, 0)
    espBox.ZIndex = 10
    espBox.Parent = ScreenGui
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 100, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.ZIndex = 10
    nameLabel.Parent = ScreenGui
    
    espObjects[player] = {
        Box = espBox,
        NameTag = nameLabel
    }
end

local function updateESP()
    if not espEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local boundingBox = getPlayerBoundingBox(player)
            
            if boundingBox then
                if not espObjects[player] then
                    createESPBox(player)
                end
                
                local espData = espObjects[player]
                if espData then
                    -- Update box position and size
                    espData.Box.Position = UDim2.new(0, boundingBox.TopLeft.X, 0, boundingBox.TopLeft.Y)
                    espData.Box.Size = UDim2.new(0, boundingBox.Size.X, 0, boundingBox.Size.Y)
                    espData.Box.Visible = espBoxEnabled
                    
                    -- Update name tag position
                    espData.NameTag.Position = UDim2.new(0, boundingBox.TopLeft.X, 0, boundingBox.TopLeft.Y - 20)
                    espData.NameTag.Visible = espNameEnabled
                end
            else
                -- Remove ESP if player is off-screen
                if espObjects[player] then
                    espObjects[player].Box:Destroy()
                    espObjects[player].NameTag:Destroy()
                    espObjects[player] = nil
                end
            end
        end
    end
    
    -- Clean up ESP for players who left
    for player in pairs(espObjects) do
        if not player or not player.Character or player == LocalPlayer then
            if espObjects[player] then
                espObjects[player].Box:Destroy()
                espObjects[player].NameTag:Destroy()
                espObjects[player] = nil
            end
        end
    end
end

-- ===== ESP TOGGLES =====
local function toggleESP()
    espEnabled = not espEnabled
    ESPToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
    
    if not espEnabled then
        for _, espObject in pairs(espObjects) do
            if espObject.Box and espObject.Box.Parent then
                espObject.Box:Destroy()
            end
            if espObject.NameTag and espObject.NameTag.Parent then
                espObject.NameTag:Destroy()
            end
        end
        espObjects = {}
    end
end

local function toggleESPNames()
    espNameEnabled = not espNameEnabled
    ESPNameToggle.Text = espNameEnabled and "Name Tags: ON" or "Name Tags: OFF"
    ESPNameToggle.BackgroundColor3 = espNameEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
end

local function toggleESPHealth()
    espHealthEnabled = not espHealthEnabled
    ESPHealthToggle.Text = espHealthEnabled and "Health Bar: ON" or "Health Bar: OFF"
    ESPHealthToggle.BackgroundColor3 = espHealthEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
end

local function toggleESPBox()
    espBoxEnabled = not espBoxEnabled
    ESPBoxToggle.Text = espBoxEnabled and "Box: ON" or "Box: OFF"
    ESPBoxToggle.BackgroundColor3 = espBoxEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
end

local function toggleESPGlow()
    espGlowEnabled = not espGlowEnabled
    ESPGlowToggle.Text = espGlowEnabled and "Glow: ON" or "Glow: OFF"
    ESPGlowToggle.BackgroundColor3 = espGlowEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
end

ESPToggle.MouseButton1Click:Connect(toggleESP)
ESPNameToggle.MouseButton1Click:Connect(toggleESPNames)
ESPHealthToggle.MouseButton1Click:Connect(toggleESPHealth)
ESPBoxToggle.MouseButton1Click:Connect(toggleESPBox)
ESPGlowToggle.MouseButton1Click:Connect(toggleESPGlow)

-- ============================================
-- ===== AIMBOT TARGETING =====
-- ============================================

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = aimRadius
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetPart = player.Character:FindFirstChild(selectedAimPart)
            if targetPart then
                local screenPoint, isVisible = Camera:WorldToViewportPoint(targetPart.Position)
                if isVisible then
                    local mouseLocation = UserInputService:GetMouseLocation()
                    local mousePos = Vector2.new(mouseLocation.X, mouseLocation.Y)
                    local targetPos = Vector2.new(screenPoint.X, screenPoint.Y)
                    local distance = (targetPos - mousePos).Magnitude
                    
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

-- ============================================
-- ===== AIMBOT LOCK SYSTEM =====
-- ============================================

local aimConnection = nil

local function startAimbot()
    if aimConnection then aimConnection:Disconnect() end
    
    aimConnection = RunService.RenderStepped:Connect(function()
        if not aimbotEnabled or not lockedTarget or not lockedTarget.Character then
            return
        end
        
        local targetPart = lockedTarget.Character:FindFirstChild(selectedAimPart)
        if not targetPart then
            lockedTarget = nil
            return
        end
        
        if aimMode == "Mouse Lock" then
            local targetPos = Camera:WorldToViewportPoint(targetPart.Position)
            mousemoveabs(targetPos.X, targetPos.Y)
        elseif aimMode == "Camera Lock" then
            local camPos = Camera.CFrame.Position
            Camera.CFrame = CFrame.new(camPos, targetPart.Position)
        end
    end)
end

local function stopAimbot()
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
end

startAimbot() -- Start the aimbot loop

-- ===== AIMBOT TOGGLE =====
local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 90)
    
    if not aimbotEnabled then
        lockedTarget = nil
        targetPlayer = nil
        currentCameraCFrame = nil
        print("Aimbot disabled")
    else
        print("Aimbot enabled")
    end
end

AimbotToggle.MouseButton1Click:Connect(toggleAimbot)

-- ============================================
-- ===== MAIN LOOP =====
-- ============================================

spawn(function()
    while true do
        updateESP()
        wait(0.016) -- ~60 FPS
    end
end)

print("Advanced Aimbot + ESP GUI Loaded Successfully!")
print("Controls:")
print("- UI Toggle: K (customizable)")
print("- Aimbot Key: RMB (customizable)")
print("- Noclip: N")
print("- Fly: F")
print("- Fly Controls: WASD (Move), R (Up), LeftControl (Down)")

switchTab("Main") -- Set initial tab
