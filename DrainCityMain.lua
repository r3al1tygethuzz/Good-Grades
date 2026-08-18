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

-- Main container frame with modern rounded edges and gradient
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 520)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = true
MainFrame.ClipsDescendants = true

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 35)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local BorderFrame = Instance.new("Frame")
BorderFrame.Size = UDim2.new(1, -4, 1, -4)
BorderFrame.Position = UDim2.new(0, 2, 0, 2)
BorderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
BorderFrame.BackgroundTransparency = 0.8
BorderFrame.BorderSizePixel = 0
BorderFrame.Parent = MainFrame

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 18)
BorderCorner.Parent = BorderFrame

local BorderGradient = Instance.new("UIGradient")
BorderGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
}
BorderGradient.Rotation = 90
BorderGradient.Parent = BorderFrame

local InnerGlow = Instance.new("Frame")
InnerGlow.Size = UDim2.new(1, -8, 1, -8)
InnerGlow.Position = UDim2.new(0, 4, 0, 4)
InnerGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InnerGlow.BackgroundTransparency = 0.98
InnerGlow.BorderSizePixel = 0
InnerGlow.Parent = BorderFrame

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 16)
InnerCorner.Parent = InnerGlow

-- ===== DRAG GRABBER BUTTON =====
local GrabberButton = Instance.new("TextButton")
GrabberButton.Size = UDim2.new(0, 35, 0, 35)
GrabberButton.Position = UDim2.new(0, 10, 0, 10)
GrabberButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
GrabberButton.BackgroundTransparency = 0.3
GrabberButton.BorderSizePixel = 0
GrabberButton.Text = "⋮⋮"
GrabberButton.TextColor3 = Color3.fromRGB(150, 200, 255)
GrabberButton.TextScaled = true
GrabberButton.Font = Enum.Font.GothamBold
GrabberButton.Parent = MainFrame

local GrabberCorner = Instance.new("UICorner")
GrabberCorner.CornerRadius = UDim.new(0, 10)
GrabberCorner.Parent = GrabberButton

local GrabberGradient = Instance.new("UIGradient")
GrabberGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 70))
}
GrabberGradient.Parent = GrabberButton

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
Title.Size = UDim2.new(1, -60, 0, 35)
Title.Position = UDim2.new(0, 50, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "DrainWare- DrainCity"
Title.TextColor3 = Color3.fromRGB(200, 250, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(100, 150, 255)
TitleStroke.Thickness = 1
TitleStroke.Transparency = 0.7
TitleStroke.Parent = Title

-- Tab Buttons
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.BackgroundTransparency = 1
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local MainTabButton = Instance.new("TextButton")
MainTabButton.Size = UDim2.new(0, 85, 1, -6)
MainTabButton.Position = UDim2.new(0, 0, 0, 3)
MainTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
MainTabButton.BackgroundTransparency = 0.4
MainTabButton.BorderSizePixel = 0
MainTabButton.Text = "Main"
MainTabButton.TextColor3 = Color3.fromRGB(150, 200, 255)
MainTabButton.TextScaled = true
MainTabButton.Font = Enum.Font.GothamBold
MainTabButton.Parent = TabContainer

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 12)
MainTabCorner.Parent = MainTabButton

local MainTabGradient = Instance.new("UIGradient")
MainTabGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 80))
}
MainTabGradient.Parent = MainTabButton

local VisualsTabButton = Instance.new("TextButton")
VisualsTabButton.Size = UDim2.new(0, 85, 1, -6)
VisualsTabButton.Position = UDim2.new(0, 90, 0, 3)
VisualsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
VisualsTabButton.BackgroundTransparency = 0.6
VisualsTabButton.BorderSizePixel = 0
VisualsTabButton.Text = "Visuals"
VisualsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
VisualsTabButton.TextScaled = true
VisualsTabButton.Font = Enum.Font.GothamBold
VisualsTabButton.Parent = TabContainer

local VisualsTabCorner = Instance.new("UICorner")
VisualsTabCorner.CornerRadius = UDim.new(0, 12)
VisualsTabCorner.Parent = VisualsTabButton

local CharTabButton = Instance.new("TextButton")
CharTabButton.Size = UDim2.new(0, 85, 1, -6)
CharTabButton.Position = UDim2.new(0, 180, 0, 3)
CharTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
CharTabButton.BackgroundTransparency = 0.6
CharTabButton.BorderSizePixel = 0
CharTabButton.Text = "Character"
CharTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
CharTabButton.TextScaled = true
CharTabButton.Font = Enum.Font.GothamBold
CharTabButton.Parent = TabContainer

local CharTabCorner = Instance.new("UICorner")
CharTabCorner.CornerRadius = UDim.new(0, 12)
CharTabCorner.Parent = CharTabButton

local SettingsTabButton = Instance.new("TextButton")
SettingsTabButton.Size = UDim2.new(0, 85, 1, -6)
SettingsTabButton.Position = UDim2.new(0, 270, 0, 3)
SettingsTabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
SettingsTabButton.BackgroundTransparency = 0.6
SettingsTabButton.BorderSizePixel = 0
SettingsTabButton.Text = "Settings"
SettingsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
SettingsTabButton.TextScaled = true
SettingsTabButton.Font = Enum.Font.GothamBold
SettingsTabButton.Parent = TabContainer

local SettingsTabCorner = Instance.new("UICorner")
SettingsTabCorner.CornerRadius = UDim.new(0, 12)
SettingsTabCorner.Parent = SettingsTabButton

-- ===== SCROLLING FRAME =====
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -15, 1, -105)
ScrollingFrame.Position = UDim2.new(0, 7, 0, 95)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 900)
ScrollingFrame.Parent = MainFrame

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
CharContent.Visible = false
CharContent.Parent = ScrollingFrame

local SettingsContent = Instance.new("Frame")
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.BackgroundTransparency = 1
SettingsContent.BorderSizePixel = 0
SettingsContent.Visible = false
SettingsContent.Parent = ScrollingFrame

-- ===== TAB SWITCHING (FIXED) =====
local function switchTab(tab)
	if tab == "Main" then
		MainContent.Visible = true
		VisualsContent.Visible = false
		CharContent.Visible = false
		SettingsContent.Visible = false
		MainTabButton.BackgroundTransparency = 0.2
		MainTabButton.TextColor3 = Color3.fromRGB(200, 250, 255)
		VisualsTabButton.BackgroundTransparency = 0.6
		VisualsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		CharTabButton.BackgroundTransparency = 0.6
		CharTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		SettingsTabButton.BackgroundTransparency = 0.6
		SettingsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
	elseif tab == "Visuals" then
		MainContent.Visible = false
		VisualsContent.Visible = true
		CharContent.Visible = false
		SettingsContent.Visible = false
		VisualsTabButton.BackgroundTransparency = 0.2
		VisualsTabButton.TextColor3 = Color3.fromRGB(200, 250, 255)
		MainTabButton.BackgroundTransparency = 0.6
		MainTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		CharTabButton.BackgroundTransparency = 0.6
		CharTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		SettingsTabButton.BackgroundTransparency = 0.6
		SettingsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
	elseif tab == "Character" then
		MainContent.Visible = false
		VisualsContent.Visible = false
		CharContent.Visible = true
		SettingsContent.Visible = false
		CharTabButton.BackgroundTransparency = 0.2
		CharTabButton.TextColor3 = Color3.fromRGB(200, 250, 255)
		MainTabButton.BackgroundTransparency = 0.6
		MainTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		VisualsTabButton.BackgroundTransparency = 0.6
		VisualsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		SettingsTabButton.BackgroundTransparency = 0.6
		SettingsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
	else -- Settings
		MainContent.Visible = false
		VisualsContent.Visible = false
		CharContent.Visible = false
		SettingsContent.Visible = true
		SettingsTabButton.BackgroundTransparency = 0.2
		SettingsTabButton.TextColor3 = Color3.fromRGB(200, 250, 255)
		MainTabButton.BackgroundTransparency = 0.6
		MainTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		VisualsTabButton.BackgroundTransparency = 0.6
		VisualsTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		CharTabButton.BackgroundTransparency = 0.6
		CharTabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 250)
		ScrollingFrame.CanvasPosition = Vector2.new(0, 0)
	end
end

MainTabButton.MouseButton1Click:Connect(function()
	switchTab("Main")
end)
VisualsTabButton.MouseButton1Click:Connect(function()
	switchTab("Visuals")
end)
CharTabButton.MouseButton1Click:Connect(function()
	switchTab("Character")
end)
SettingsTabButton.MouseButton1Click:Connect(function()
	switchTab("Settings")
end)

-- ============================================
-- ===== UI HELPER FUNCTIONS =====
-- ============================================

local function createStyledButton(text, position, parent, width, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, width or 140, 0, 32)
	btn.Position = position
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	btn.BackgroundTransparency = 0.4
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamMedium
	btn.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = btn

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 100)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 70))
	}
	gradient.Parent = btn

	local hoverTween = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = Color3.fromRGB(150, 200, 255)})
	local leaveTween = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.4, TextColor3 = Color3.fromRGB(220, 220, 220)})

	btn.MouseEnter:Connect(function()
		hoverTween:Play()
	end)

	btn.MouseLeave:Connect(function()
		leaveTween:Play()
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
	lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
	lbl.TextScaled = true
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = parent
	return lbl
end

local function createSlider(labelText, yPos, parent, minVal, maxVal, defaultVal, callback, fillColor)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 45)
	container.Position = UDim2.new(0, 0, 0, yPos)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 150, 0, 20)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText .. ": " .. tostring(defaultVal)
	label.TextColor3 = Color3.fromRGB(200, 200, 220)
	label.TextScaled = true
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(0, 180, 0, 10)
	sliderBg.Position = UDim2.new(0, 165, 0, 8)
	sliderBg.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container

	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(1, 0)
	bgCorner.Parent = sliderBg

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
	fill.BackgroundColor3 = fillColor or Color3.fromRGB(100, 150, 255)
	fill.BorderSizePixel = 0
	fill.Parent = sliderBg

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local fillGradient = Instance.new("UIGradient")
	fillGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, fillColor or Color3.fromRGB(100, 150, 255)),
		ColorSequenceKeypoint.new(1, (fillColor or Color3.fromRGB(100, 150, 255)):Lerp(Color3.new(1, 1, 1), 0.3))
	}
	fillGradient.Parent = fill

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

local UIToggleLabel = createStyledLabel("UI Toggle Key:", UDim2.new(0, 10, 0, 5), SettingsContent, 100)
local UIToggleButton = createStyledButton("K", UDim2.new(0, 130, 0, 5), SettingsContent, 100)
UIToggleButton.Size = UDim2.new(0, 100, 0, 32)

local SettingsInfo = Instance.new("TextLabel")
SettingsInfo.Size = UDim2.new(1, -20, 0, 60)
SettingsInfo.Position = UDim2.new(0, 10, 0, 45)
SettingsInfo.BackgroundTransparency = 1
SettingsInfo.Text = "Customize your keybinds and settings.\nClick the keybind button to change it."
SettingsInfo.TextColor3 = Color3.fromRGB(160, 160, 180)
SettingsInfo.TextScaled = true
SettingsInfo.Font = Enum.Font.GothamMedium
SettingsInfo.TextXAlignment = Enum.TextXAlignment.Left
SettingsInfo.Parent = SettingsContent

-- ============================================
-- ===== MAIN TAB CONTENT =====
-- ============================================

local KeybindLabel = createStyledLabel("Aim Key:", UDim2.new(0, 10, 0, 5), MainContent, 100)
local KeybindButton = createStyledButton("RMB", UDim2.new(0, 130, 0, 5), MainContent, 100)
KeybindButton.Size = UDim2.new(0, 100, 0, 32)

local AimModeLabel = createStyledLabel("Aim Mode:", UDim2.new(0, 10, 0, 45), MainContent, 100)
local AimModeButton = createStyledButton("Mouse Lock", UDim2.new(0, 130, 0, 45), MainContent, 130)
AimModeButton.Size = UDim2.new(0, 130, 0, 32)

local AimbotToggle = createStyledButton("Aimbot: OFF", UDim2.new(0, 10, 0, 80), MainContent, 155)
AimbotToggle.Size = UDim2.new(0, 155, 0, 35)

local AimPartLabel = createStyledLabel("Aim Part:", UDim2.new(0, 10, 0, 125), MainContent, 100)
local AimPartButton = createStyledButton("Head", UDim2.new(0, 130, 0, 125), MainContent, 130)
AimPartButton.Size = UDim2.new(0, 130, 0, 32)

local FOVToggle = createStyledButton("FOV: ON", UDim2.new(0, 10, 0, 165), MainContent, 155)
FOVToggle.Size = UDim2.new(0, 155, 0, 35)

local aimRadiusSlider = createSlider("Aim Radius", 210, MainContent, 10, 300, 100, function(val)
	aimRadius = val
	if fovEnabled then
		updateFOVPosition()
	end
end, Color3.fromRGB(100, 150, 255))

local smoothnessSlider = createSlider("Smoothness", 260, MainContent, 1, 20, 5, function(val)
	smoothness = val
end, Color3.fromRGB(255, 150, 100))

-- ============================================
-- ===== VISUALS TAB CONTENT =====
-- ============================================

local ESPToggle = createStyledButton("ESP: OFF", UDim2.new(0, 10, 0, 5), VisualsContent, 155)
ESPToggle.Size = UDim2.new(0, 155, 0, 35)

local ESPNameToggle = createStyledButton("Name Tags: ON", UDim2.new(0, 10, 0, 50), VisualsContent, 155)
ESPNameToggle.Size = UDim2.new(0, 155, 0, 32)

local ESPHealthToggle = createStyledButton("Health Bar: ON", UDim2.new(0, 185, 0, 50), VisualsContent, 155)
ESPHealthToggle.Size = UDim2.new(0, 155, 0, 32)

local ESPBoxToggle = createStyledButton("Box: ON", UDim2.new(0, 10, 0, 90), VisualsContent, 155)
ESPBoxToggle.Size = UDim2.new(0, 155, 0, 32)

local ESPGlowToggle = createStyledButton("Glow: ON", UDim2.new(0, 185, 0, 90), VisualsContent, 155)
ESPGlowToggle.Size = UDim2.new(0, 155, 0, 32)

local ESPTracerToggle = createStyledButton("Tracers: ON", UDim2.new(0, 10, 0, 130), VisualsContent, 155)
ESPTracerToggle.Size = UDim2.new(0, 155, 0, 32)

local ESPDistanceToggle = createStyledButton("Distance: ON", UDim2.new(0, 185, 0, 130), VisualsContent, 155)
ESPDistanceToggle.Size = UDim2.new(0, 155, 0, 32)

local VisualsInfo = Instance.new("TextLabel")
VisualsInfo.Size = UDim2.new(1, -20, 0, 60)
VisualsInfo.Position = UDim2.new(0, 10, 0, 170)
VisualsInfo.BackgroundTransparency = 1
VisualsInfo.Text = "ESP settings for player visualization.\nToggle individual elements on/off."
VisualsInfo.TextColor3 = Color3.fromRGB(160, 160, 180)
VisualsInfo.TextScaled = true
VisualsInfo.Font = Enum.Font.GothamMedium
VisualsInfo.TextXAlignment = Enum.TextXAlignment.Left
VisualsInfo.Parent = VisualsContent

-- ============================================
-- ===== CHARACTER TAB CONTENT =====
-- ============================================

local NoclipLabel = createStyledLabel("Noclip [N]:", UDim2.new(0, 10, 0, 5), CharContent, 100)
local NoclipToggle = createStyledButton("OFF", UDim2.new(0, 130, 0, 5), CharContent, 100)
NoclipToggle.Size = UDim2.new(0, 100, 0, 32)

local FlyLabel = createStyledLabel("Fly [F]:", UDim2.new(0, 10, 0, 45), CharContent, 100)
local FlyToggle = createStyledButton("OFF", UDim2.new(0, 130, 0, 45), CharContent, 100)
FlyToggle.Size = UDim2.new(0, 100, 0, 32)

local flySpeedSlider = createSlider("Fly Speed", 80, CharContent, 1, 20, 5, function(val)
	FLY_SPEED = val
	print("Fly speed set to: " .. val)
end, Color3.fromRGB(255, 200, 100))

local noclipThresholdSlider = createSlider("Noclip Threshold", 125, CharContent, 1, 10, 3, function(val)
	NOCLIP_THRESHOLD = val
	print("Noclip threshold set to: " .. val .. " studs")
end, Color3.fromRGB(100, 200, 255))

local DeSyncLabel = createStyledLabel("DeSync:", UDim2.new(0, 10, 0, 170), CharContent, 100)
local DeSyncToggle = createStyledButton("OFF", UDim2.new(0, 130, 0, 170), CharContent, 100)
DeSyncToggle.Size = UDim2.new(0, 100, 0, 32)

local FlyControlsInfo = Instance.new("TextLabel")
FlyControlsInfo.Size = UDim2.new(1, -20, 0, 45)
FlyControlsInfo.Position = UDim2.new(0, 10, 0, 210)
FlyControlsInfo.BackgroundTransparency = 1
FlyControlsInfo.Text = "W=Forward | S=Backward | A=Left | D=Right\nR=Up | LeftControl=Down"
FlyControlsInfo.TextColor3 = Color3.fromRGB(180, 180, 200)
FlyControlsInfo.TextScaled = true
FlyControlsInfo.Font = Enum.Font.GothamMedium
FlyControlsInfo.TextXAlignment = Enum.TextXAlignment.Left
FlyControlsInfo.Parent = CharContent

local CharInfo = Instance.new("TextLabel")
CharInfo.Size = UDim2.new(1, -20, 0, 120)
CharInfo.Position = UDim2.new(0, 10, 0, 260)
CharInfo.BackgroundTransparency = 1
CharInfo.Text = "Noclip: Phase through walls (Press N)\nFly: Invisible platforms spawn under you (Press F)\nUse the above controls to move while flying\nSpeed slider adjusts movement speed\nThreshold slider adjusts noclip teleport distance\nDeSync: Local free movement, server visual frozen at start position"
CharInfo.TextColor3 = Color3.fromRGB(160, 160, 180)
CharInfo.TextScaled = true
CharInfo.Font = Enum.Font.GothamMedium
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
local espTracerEnabled = true
local espDistanceEnabled = true
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
local NOCLIP_THRESHOLD = 3

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
local flyPlatforms = {}
local FLY_SPEED = 5
local PLATFORM_LIFETIME = 0.5

-- ============================================
-- ===== DESYNC VARIABLES =====
-- ============================================
local desyncEnabled = false
local desyncConnection = nil
local serverCFrame = nil          -- Frozen CFrame at the moment desync was enabled
local ghostModel = nil            -- Magenta = local position
local espCham = nil               -- Cyan = frozen server position

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
-- ===== DESYNC FUNCTIONS (FIXED) =====
-- ============================================
local function createGhostModel(character)
	if ghostModel then ghostModel:Destroy() end
	ghostModel = character:Clone()
	ghostModel.Name = "GhostModel"
	ghostModel.Parent = workspace

	for _, part in pairs(ghostModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 0.45
			part.Color = Color3.fromRGB(255, 0, 255) -- Magenta = local
			part.Material = Enum.Material.ForceField
		elseif part:IsA("Accessory") or part:IsA("Humanoid") then
			part:Destroy()
		end
	end
end

local function createESPCham(character, freezeCF)
	if espCham then espCham:Destroy() end
	espCham = character:Clone()
	espCham.Name = "ESPCham"
	espCham.Parent = workspace

	for _, part in pairs(espCham:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 0.55
			part.Color = Color3.fromRGB(0, 255, 255) -- Cyan = server freeze
			part.Material = Enum.Material.ForceField
		elseif part:IsA("Accessory") or part:IsA("Humanoid") then
			part:Destroy()
		end
	end

	-- Place the whole model at the freeze CFrame
	if espCham:FindFirstChild("HumanoidRootPart") then
		espCham:PivotTo(freezeCF)
	end
end

local function toggleDeSync()
	desyncEnabled = not desyncEnabled
	DeSyncToggle.Text = desyncEnabled and "ON" or "OFF"
	DeSyncToggle.BackgroundColor3 = desyncEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	local character = LocalPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then
		warn("No character found for DeSync")
		desyncEnabled = false
		DeSyncToggle.Text = "OFF"
		DeSyncToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
		return
	end

	if desyncEnabled then
		-- Disable conflicting features
		if noclipEnabled then toggleNoclip() end
		if flyEnabled then toggleFly() end

		-- Record the exact CFrame at the moment desync starts (this is what the server visual will stay at)
		serverCFrame = character.HumanoidRootPart.CFrame
		print("DeSync enabled – server visual frozen at current position. You can move freely.")

		-- Create visuals
		createGhostModel(character)
		createESPCham(character, serverCFrame)

		-- Heartbeat only updates the two visual models. Real character is left completely free.
		desyncConnection = RunService.Heartbeat:Connect(function()
			if not desyncEnabled then return end
			local char = LocalPlayer.Character
			if not char or not char:FindFirstChild("HumanoidRootPart") then return end

			-- Magenta ghost follows real local character
			if ghostModel and ghostModel.Parent then
				pcall(function()
					ghostModel:PivotTo(char:GetPivot())
				end)
			end

			-- Cyan model stays locked at the original freeze CFrame
			if espCham and espCham.Parent and serverCFrame then
				pcall(function()
					espCham:PivotTo(serverCFrame)
				end)
			end
		end)
	else
		print("DeSync disabled")

		if desyncConnection then
			desyncConnection:Disconnect()
			desyncConnection = nil
		end

		if ghostModel then
			ghostModel:Destroy()
			ghostModel = nil
		end
		if espCham then
			espCham:Destroy()
			espCham = nil
		end

		serverCFrame = nil
	end
end

DeSyncToggle.MouseButton1Click:Connect(toggleDeSync)

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
			UIToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
			UIToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
			print("UI Toggle keybind set to: " .. keyName)
			return
		end
		return
	end

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
	dropdownFrame.Size = UDim2.new(0, 130, 0, #options * 32)
	dropdownFrame.Position = button.Position + UDim2.new(0, 0, 0, 35)
	dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	dropdownFrame.BackgroundTransparency = 0.2
	dropdownFrame.BorderSizePixel = 2
	dropdownFrame.BorderColor3 = Color3.fromRGB(100, 150, 255)
	dropdownFrame.Parent = parent

	local dCorner = Instance.new("UICorner")
	dCorner.CornerRadius = UDim.new(0, 10)
	dCorner.Parent = dropdownFrame

	local dGradient = Instance.new("UIGradient")
	dGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
	}
	dGradient.Parent = dropdownFrame

	activeDropdown = dropdownFrame

	for i, option in ipairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 32)
		btn.Position = UDim2.new(0, 0, 0, (i-1) * 32)
		btn.BackgroundColor3 = (option == currentValue) and Color3.fromRGB(60, 60, 100) or Color3.fromRGB(40, 40, 65)
		btn.BackgroundTransparency = 0.3
		btn.BorderSizePixel = 0
		btn.Text = option
		btn.TextColor3 = Color3.fromRGB(220, 220, 220)
		btn.TextScaled = true
		btn.Font = Enum.Font.GothamMedium
		btn.Parent = dropdownFrame

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 8)
		btnCorner.Parent = btn

		btn.MouseEnter:Connect(function()
			btn.BackgroundTransparency = 0.1
			btn.TextColor3 = Color3.fromRGB(150, 200, 255)
		end)

		btn.MouseLeave:Connect(function()
			btn.BackgroundTransparency = (option == currentValue) and 0.3 or 0.4
			btn.TextColor3 = Color3.fromRGB(220, 220, 220)
		end)

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
					KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
					print("Keybind set to: " .. keyName)
					return
				end
			end
		elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
			selectedKeybind = "LMB"
			KeybindButton.Text = "LMB"
			isWaitingForKeybind = false
			KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
			print("Keybind set to: LMB")
			return
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			selectedKeybind = "RMB"
			KeybindButton.Text = "RMB"
			isWaitingForKeybind = false
			KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
			print("Keybind set to: RMB")
			return
		elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
			selectedKeybind = "MMB"
			KeybindButton.Text = "MMB"
			isWaitingForKeybind = false
			KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
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

	local rayResult = workspace:Raycast(origin, direction * NOCLIP_THRESHOLD, raycastParams)

	if rayResult then
		local newPos = rootPart.Position + (rootPart.CFrame.LookVector * (NOCLIP_THRESHOLD + 1))

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
	NoclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

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
				for i = 1, NOCLIP_THRESHOLD do
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
	FlyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

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

				local cameraCFrame = Camera.CFrame
				local lookVector = cameraCFrame.LookVector
				local rightVector = cameraCFrame.RightVector

				local wPressed = UserInputService:IsKeyDown(Enum.KeyCode.W)
				local sPressed = UserInputService:IsKeyDown(Enum.KeyCode.S)
				local aPressed = UserInputService:IsKeyDown(Enum.KeyCode.A)
				local dPressed = UserInputService:IsKeyDown(Enum.KeyCode.D)
				local rPressed = UserInputService:IsKeyDown(Enum.KeyCode.R)
				local downPressed = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)

				local moveDirection = Vector3.new(0, 0, 0)
				local moving = false

				if wPressed then
					moveDirection = moveDirection + lookVector
					moving = true
				end
				if sPressed then
					moveDirection = moveDirection - lookVector
					moving = true
				end
				if aPressed then
					moveDirection = moveDirection - rightVector
					moving = true
				end
				if dPressed then
					moveDirection = moveDirection + rightVector
					moving = true
				end
				if rPressed then
					moveDirection = moveDirection + Vector3.new(0, 1, 0)
					moving = true
				end
				if downPressed then
					moveDirection = moveDirection - Vector3.new(0, 1, 0)
					moving = true
				end

				if moving then
					moveDirection = moveDirection.Unit
				end

				local currentPos = rootPart.Position
				local newPos = currentPos

				if moving then
					newPos = currentPos + (moveDirection * FLY_SPEED * 0.1)
				end

				local platformPos = newPos + Vector3.new(0, -3, 0)
				createFlyPlatform(platformPos)
				createFlyPlatform(platformPos + Vector3.new(3, 0, 0))
				createFlyPlatform(platformPos + Vector3.new(-3, 0, 0))
				createFlyPlatform(platformPos + Vector3.new(0, 0, 3))
				createFlyPlatform(platformPos + Vector3.new(0, 0, -3))

				if moving then
					local newCFrame = CFrame.new(newPos, newPos + lookVector)

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
	fovCircle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	fovCircle.BorderSizePixel = 2
	fovCircle.BorderColor3 = Color3.fromRGB(100, 150, 255)
	fovCircle.ZIndex = 999
	fovCircle.Parent = ScreenGui
	fovCircle.Visible = fovEnabled

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = fovCircle

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255))
	}
	gradient.Parent = fovCircle

	fovInner = Instance.new("Frame")
	fovInner.Size = UDim2.new(0.98, 0, 0.98, 0)
	fovInner.Position = UDim2.new(0.01, 0, 0.01, 0)
	fovInner.BackgroundTransparency = 0.95
	fovInner.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
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

local function toggleFOV()
	fovEnabled = not fovEnabled
	FOVToggle.Text = fovEnabled and "FOV: ON" or "FOV: OFF"
	FOVToggle.BackgroundColor3 = fovEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)
	if fovEnabled then
		updateFOVPosition()
	else
		if fovCircle then fovCircle.Visible = false end
	end
end

FOVToggle.MouseButton1Click:Connect(toggleFOV)

-- ============================================
-- ===== AIMBOT FUNCTIONS =====
-- ============================================
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

local function isTargetValid(target)
	if not target then return false end
	if not target.Character then return false end
	local humanoid = target.Character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return false end

	local aimPart = target.Character:FindFirstChild(selectedAimPart)
	if not aimPart then return false end

	local screenPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
	if not onScreen then return false end

	local mousePos = UserInputService:GetMouseLocation()
	local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude

	return dist < aimRadius * 1.5
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
-- ===== ESP FUNCTIONS =====
-- ============================================

local function createESP(player)
	if espObjects[player] then return end

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	local head = character:FindFirstChild("Head")
	if not head then return end

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
	nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	nameLabel.TextStrokeTransparency = 0.5

	local distLabel = Instance.new("TextLabel")
	distLabel.Size = UDim2.new(0, 100, 0, 16)
	distLabel.BackgroundTransparency = 1
	distLabel.Text = ""
	distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	distLabel.TextScaled = true
	distLabel.Font = Enum.Font.Gotham
	distLabel.Parent = ScreenGui
	distLabel.Visible = espEnabled and espDistanceEnabled
	distLabel.ZIndex = 100
	distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	distLabel.TextStrokeTransparency = 0.5

	local healthBg = Instance.new("Frame")
	healthBg.Size = UDim2.new(0, 50, 0, 6)
	healthBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	healthBg.BorderSizePixel = 0
	healthBg.Parent = ScreenGui
	healthBg.Visible = espEnabled and espHealthEnabled
	healthBg.ZIndex = 100

	local hCorner = Instance.new("UICorner")
	hCorner.CornerRadius = UDim.new(0, 3)
	hCorner.Parent = healthBg

	local healthFill = Instance.new("Frame")
	healthFill.Size = UDim2.new(1, 0, 1, 0)
	healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	healthFill.BorderSizePixel = 0
	healthFill.Parent = healthBg
	healthFill.ZIndex = 101

	local hfCorner = Instance.new("UICorner")
	hfCorner.CornerRadius = UDim.new(0, 3)
	hfCorner.Parent = healthFill

	local box = Instance.new("Frame")
	box.Size = UDim2.new(0, 50, 0, 100)
	box.BackgroundTransparency = 0.9
	box.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	box.BorderSizePixel = 0
	box.Parent = ScreenGui
	box.Visible = espEnabled and espBoxEnabled
	box.ZIndex = 99

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = box

	local boxLines = {}
	for i = 1, 4 do
		local line = Instance.new("Frame")
		line.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
		line.BackgroundTransparency = 0.2
		line.BorderSizePixel = 0
		line.Parent = ScreenGui
		line.Visible = espEnabled and espBoxEnabled
		line.ZIndex = 98
		boxLines[i] = line
	end

	local glowBox = Instance.new("Frame")
	glowBox.Size = UDim2.new(0, 50, 0, 100)
	glowBox.BackgroundTransparency = 0.95
	glowBox.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
	glowBox.BorderSizePixel = 3
	glowBox.BorderColor3 = Color3.fromRGB(100, 150, 255)
	glowBox.Parent = ScreenGui
	glowBox.Visible = espEnabled and espGlowEnabled
	glowBox.ZIndex = 97

	local glowCorner = Instance.new("UICorner")
	glowCorner.CornerRadius = UDim.new(0, 6)
	glowCorner.Parent = glowBox

	local tracerLine = Drawing.new("Line")
	tracerLine.Visible = espEnabled and espTracerEnabled
	tracerLine.Color = Color3.fromRGB(100, 150, 255)
	tracerLine.Thickness = 1
	tracerLine.Transparency = 0.8

	espObjects[player] = {
		nameLabel = nameLabel,
		distLabel = distLabel,
		healthBg = healthBg,
		healthFill = healthFill,
		box = box,
		glowBox = glowBox,
		boxLines = boxLines,
		tracerLine = tracerLine,
		character = character
	}
end

local function removeESP(player)
	local data = espObjects[player]
	if data then
		data.nameLabel:Destroy()
		data.distLabel:Destroy()
		data.healthBg:Destroy()
		data.box:Destroy()
		data.glowBox:Destroy()
		for _, line in ipairs(data.boxLines) do
			line:Destroy()
		end
		if data.tracerLine then
			data.tracerLine:Remove()
		end
		espObjects[player] = nil
	end
end

local function clearAllESP()
	for player, data in pairs(espObjects) do
		data.nameLabel:Destroy()
		data.distLabel:Destroy()
		data.healthBg:Destroy()
		data.box:Destroy()
		data.glowBox:Destroy()
		for _, line in ipairs(data.boxLines) do
			line:Destroy()
		end
		if data.tracerLine then
			data.tracerLine:Remove()
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

		local _, boundingBoxSize = character:GetBoundingBox()
		local center = character:GetPivot().Position
		local size = boundingBoxSize

		size = Vector3.new(math.max(size.X, 2), math.max(size.Y, 4), math.max(size.Z, 2))

		local screenCenter, onScreen = Camera:WorldToViewportPoint(center)
		if not onScreen then
			data.nameLabel.Visible = false
			data.distLabel.Visible = false
			data.healthBg.Visible = false
			data.box.Visible = false
			data.glowBox.Visible = false
			for _, line in ipairs(data.boxLines) do
				line.Visible = false
			end
			if data.tracerLine then
				data.tracerLine.Visible = false
			end
			continue
		end

		local topLeft = Camera:WorldToViewportPoint(center + Vector3.new(-size.X/2, size.Y/2, 0))
		local topRight = Camera:WorldToViewportPoint(center + Vector3.new(size.X/2, size.Y/2, 0))
		local bottomLeft = Camera:WorldToViewportPoint(center + Vector3.new(-size.X/2, -size.Y/2, 0))
		local bottomRight = Camera:WorldToViewportPoint(center + Vector3.new(size.X/2, -size.Y/2, 0))

		local width = math.abs(topRight.X - topLeft.X)
		local height = math.abs(topLeft.Y - bottomLeft.Y)
		local x = math.min(topLeft.X, topRight.X, bottomLeft.X, bottomRight.X)
		local y = math.min(topLeft.Y, topRight.Y, bottomLeft.Y, bottomRight.Y)

		width = math.max(width, 20)
		height = math.max(height, 40)

		data.nameLabel.Visible = espEnabled and espNameEnabled
		data.distLabel.Visible = espEnabled and espDistanceEnabled
		data.healthBg.Visible = espEnabled and espHealthEnabled
		data.box.Visible = espEnabled and espBoxEnabled
		data.glowBox.Visible = espEnabled and espGlowEnabled

		for _, line in ipairs(data.boxLines) do
			line.Visible = espEnabled and espBoxEnabled
		end

		if data.tracerLine then
			data.tracerLine.Visible = espEnabled and espTracerEnabled
		end

		local health = character.Humanoid.Health / character.Humanoid.MaxHealth
		local healthColor = Color3.fromRGB(255 * (1 - health), 255 * health, 0)

		if espNameEnabled then
			data.nameLabel.Position = UDim2.new(0, x, 0, y - 25)
			data.nameLabel.Size = UDim2.new(0, width * 1.5, 0, 20)

			local dist = (center - Camera.CFrame.Position).Magnitude
			data.distLabel.Text = string.format("%.0f studs", dist)
			data.distLabel.Position = UDim2.new(0, x, 0, y + height + 20)
			data.distLabel.Size = UDim2.new(0, width * 1.5, 0, 16)
		end

		if espHealthEnabled then
			local healthOffset = espNameEnabled and 8 or 0
			data.healthBg.Position = UDim2.new(0, x, 0, y + height + healthOffset)
			data.healthBg.Size = UDim2.new(0, width, 0, 6)
			data.healthFill.Size = UDim2.new(health, 0, 1, 0)
			data.healthFill.BackgroundColor3 = healthColor
		end

		if espBoxEnabled then
			data.box.Position = UDim2.new(0, x, 0, y)
			data.box.Size = UDim2.new(0, width, 0, height)
			data.box.BackgroundColor3 = healthColor

			local thickness = 2
			local lineLength = width * 0.25

			data.boxLines[1].Position = UDim2.new(0, x + width/2 - lineLength/2, 0, y)
			data.boxLines[1].Size = UDim2.new(0, lineLength, 0, thickness)
			data.boxLines[1].BackgroundColor3 = healthColor

			data.boxLines[2].Position = UDim2.new(0, x + width/2 - lineLength/2, 0, y + height)
			data.boxLines[2].Size = UDim2.new(0, lineLength, 0, thickness)
			data.boxLines[2].BackgroundColor3 = healthColor

			data.boxLines[3].Position = UDim2.new(0, x, 0, y + height/2 - lineLength/2)
			data.boxLines[3].Size = UDim2.new(0, thickness, 0, lineLength)
			data.boxLines[3].BackgroundColor3 = healthColor

			data.boxLines[4].Position = UDim2.new(0, x + width, 0, y + height/2 - lineLength/2)
			data.boxLines[4].Size = UDim2.new(0, thickness, 0, lineLength)
			data.boxLines[4].BackgroundColor3 = healthColor
		end

		if espGlowEnabled then
			data.glowBox.Position = UDim2.new(0, x - 2, 0, y - 2)
			data.glowBox.Size = UDim2.new(0, width + 4, 0, height + 4)
			data.glowBox.BorderColor3 = healthColor
			data.glowBox.BackgroundColor3 = healthColor
		end

		if espTracerEnabled and data.tracerLine then
			local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
			if headOnScreen then
				data.tracerLine.From = Vector2.new(Camera.ViewportSize.X/2, 0)
				data.tracerLine.To = Vector2.new(headPos.X, headPos.Y)
				data.tracerLine.Visible = true
			else
				data.tracerLine.Visible = false
			end
		end
	end
end

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

-- ============================================
-- ===== TOGGLE FUNCTIONS =====
-- ============================================
local function toggleAimbot()
	aimbotEnabled = not aimbotEnabled
	AimbotToggle.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
	AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)
	if aimbotEnabled then
		if fovEnabled then updateFOVPosition() end
		print("Aimbot enabled! Hold " .. selectedKeybind .. " to aim (STICKY)")
	else
		if fovCircle then fovCircle.Visible = false end
		isAiming = false
		lockedTarget = nil
		targetPlayer = nil
		currentCameraCFrame = nil
		print("Aimbot disabled")
	end
end

local function toggleESP()
	espEnabled = not espEnabled
	ESPToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
	ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	if espEnabled then
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
	ESPNameToggle.BackgroundColor3 = espNameEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		data.nameLabel.Visible = espEnabled and espNameEnabled
	end
end

local function toggleESPHealth()
	espHealthEnabled = not espHealthEnabled
	ESPHealthToggle.Text = espHealthEnabled and "Health Bar: ON" or "Health Bar: OFF"
	ESPHealthToggle.BackgroundColor3 = espHealthEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		data.healthBg.Visible = espEnabled and espHealthEnabled
	end
end

local function toggleESPBox()
	espBoxEnabled = not espBoxEnabled
	ESPBoxToggle.Text = espBoxEnabled and "Box: ON" or "Box: OFF"
	ESPBoxToggle.BackgroundColor3 = espBoxEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		data.box.Visible = espEnabled and espBoxEnabled
		for _, line in ipairs(data.boxLines) do
			line.Visible = espEnabled and espBoxEnabled
		end
	end
end

local function toggleESPGlow()
	espGlowEnabled = not espGlowEnabled
	ESPGlowToggle.Text = espGlowEnabled and "Glow: ON" or "Glow: OFF"
	ESPGlowToggle.BackgroundColor3 = espGlowEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		data.glowBox.Visible = espEnabled and espGlowEnabled
	end
end

local function toggleESPTracer()
	espTracerEnabled = not espTracerEnabled
	ESPTracerToggle.Text = espTracerEnabled and "Tracers: ON" or "Tracers: OFF"
	ESPTracerToggle.BackgroundColor3 = espTracerEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		if data.tracerLine then
			data.tracerLine.Visible = espEnabled and espTracerEnabled
		end
	end
end

local function toggleESPDistance()
	espDistanceEnabled = not espDistanceEnabled
	ESPDistanceToggle.Text = espDistanceEnabled and "Distance: ON" or "Distance: OFF"
	ESPDistanceToggle.BackgroundColor3 = espDistanceEnabled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(50, 50, 80)

	for player, data in pairs(espObjects) do
		data.distLabel.Visible = espEnabled and espDistanceEnabled
	end
end

AimbotToggle.MouseButton1Click:Connect(toggleAimbot)
ESPToggle.MouseButton1Click:Connect(toggleESP)
ESPNameToggle.MouseButton1Click:Connect(toggleESPName)
ESPHealthToggle.MouseButton1Click:Connect(toggleESPHealth)
ESPBoxToggle.MouseButton1Click:Connect(toggleESPBox)
ESPGlowToggle.MouseButton1Click:Connect(toggleESPGlow)
ESPTracerToggle.MouseButton1Click:Connect(toggleESPTracer)
ESPDistanceToggle.MouseButton1Click:Connect(toggleESPDistance)

-- ============================================
-- ===== MAIN LOOP =====
-- ============================================
RunService.RenderStepped:Connect(function()
	-- STICKY AIMBOT
	if aimbotEnabled and isAiming then
		local target = nil

		if lockedTarget and isTargetValid(lockedTarget) then
			target = lockedTarget
		else
			target = getClosestPlayer()
			if target then
				lockedTarget = target
				targetPlayer = target
				print("New target locked: " .. target.Name)
			else
				lockedTarget = nil
				targetPlayer = nil
			end
		end

		if target and target.Character then
			local aimPart = target.Character:FindFirstChild(selectedAimPart)
			if aimPart then
				local partPos = aimPart.Position

				if aimMode == "Mouse Lock" then
					local screenPos, onScreen = Camera:WorldToViewportPoint(partPos)
					if onScreen then
						local targetX = (screenPos.X - Mouse.X) / smoothness
						local targetY = (screenPos.Y - Mouse.Y) / smoothness

						if smoothness <= 1 then
							Mouse.Move(Vector2.new(screenPos.X, screenPos.Y))
						else
							Mouse.Move(Vector2.new(Mouse.X + targetX, Mouse.Y + targetY))
						end
					end
				else
					local targetCF = CFrame.lookAt(Camera.CFrame.Position, partPos)

					if currentCameraCFrame then
						local smoothFactor = math.max(smoothness, 1)
						local newCF = smoothAim(currentCameraCFrame, targetCF, smoothFactor)
						Camera.CFrame = newCF
						currentCameraCFrame = newCF
					else
						Camera.CFrame = targetCF
						currentCameraCFrame = targetCF
					end
				end
			end
		end
	end

	-- ESP
	if espEnabled then
		updateESP()
	end
end)

-- ===== CLEANUP =====
LocalPlayer.CharacterAdded:Connect(function(character)
	if espEnabled then
		clearAllESP()
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				createESP(player)
			end
		end
	end

	-- Reset DeSync on character respawn
	if desyncEnabled then
		toggleDeSync()
	end
end)

LocalPlayer:WaitForChild("PlayerGui").ChildRemoved:Connect(function(child)
	if child == ScreenGui then
		clearAllESP()
		if fovCircle then fovCircle:Destroy(); fovCircle = nil end
		if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
		if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
		if desyncConnection then desyncConnection:Disconnect(); desyncConnection = nil end
		clearAllFlyPlatforms()
		teleportQueue = {}
		isProcessingQueue = false
		if ghostModel then ghostModel:Destroy() end
		if espCham then espCham:Destroy() end
	end
end)

print("DrainWare- DrainCity loaded!")
print("Tabs: Main | Visuals | Character | Settings")
print("Press " .. uiToggleKeybind .. " to toggle GUI")
print("Aimbot: Press RMB (or custom key) to aim (STICKY)")
print("Noclip: Press N to toggle")
print("Fly: Press F to toggle | W=Forward | S=Backward | A=Left | D=Right | R=Up | LeftControl=Down")
print("ESP: Toggle in the Visuals tab")
print("DeSync: Toggle in Character tab – local free movement, cyan = frozen server position")
