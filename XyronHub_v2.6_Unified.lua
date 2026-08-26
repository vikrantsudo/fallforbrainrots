-- XYRON HUB - v2.6 (Tabs + Working Modules + Emotes)
-- Unified Tab System | Live Stats | Full Functional Commands

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local StartTime = tick()

-- ===================== SCREENGUI =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XyronHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

if gethui then
	ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
	ScreenGui.Parent = game:GetService("CoreGui")
else
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ===================== DRAGGING =====================
local function makeDraggable(handle, frameToMove)
	local dragging, dragStart, startPos, dragInput
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frameToMove.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frameToMove.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- ===================== MAIN FRAME =====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 390)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(35, 35, 42)
MainStroke.Thickness = 1

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local HeaderLine = Instance.new("Frame", TopBar)
HeaderLine.Size = UDim2.new(1, 0, 0, 2)
HeaderLine.Position = UDim2.new(0, 0, 1, -2)
HeaderLine.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
HeaderLine.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TopBar)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "[XYRON.SYS] | UNIFIED SYSTEM HUB"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.TextSize = 11
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local ButtonContainer = Instance.new("Frame", TopBar)
ButtonContainer.Size = UDim2.new(0, 50, 1, 0)
ButtonContainer.Position = UDim2.new(1, -54, 0, 0)
ButtonContainer.BackgroundTransparency = 1

local UIListLayoutButtons = Instance.new("UIListLayout", ButtonContainer)
UIListLayoutButtons.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutButtons.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayoutButtons.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayoutButtons.Padding = UDim.new(0, 4)

local MinimizeBtn = Instance.new("TextButton", ButtonContainer)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.Code
MinimizeBtn.TextSize = 12
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 3)

local CloseBtn = Instance.new("TextButton", ButtonContainer)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 35, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.Code
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 3)

-- ===================== SEARCH + TABS ROW =====================
local SearchRow = Instance.new("Frame", MainFrame)
SearchRow.Name = "SearchRow"
SearchRow.Size = UDim2.new(1, -16, 0, 28)
SearchRow.Position = UDim2.new(0, 8, 0, 36)
SearchRow.BackgroundTransparency = 1

-- Tabs
local TabCmds = Instance.new("TextButton", SearchRow)
TabCmds.Name = "TabCmds"
TabCmds.Size = UDim2.new(0, 70, 0, 24)
TabCmds.Position = UDim2.new(0, 0, 0, 2)
TabCmds.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
TabCmds.Text = "CMDS"
TabCmds.TextColor3 = Color3.fromRGB(255, 255, 255)
TabCmds.Font = Enum.Font.Code
TabCmds.TextSize = 11
Instance.new("UICorner", TabCmds).CornerRadius = UDim.new(0, 4)

local TabEmotes = Instance.new("TextButton", SearchRow)
TabEmotes.Name = "TabEmotes"
TabEmotes.Size = UDim2.new(0, 70, 0, 24)
TabEmotes.Position = UDim2.new(0, 76, 0, 2)
TabEmotes.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
TabEmotes.Text = "EMOTES"
TabEmotes.TextColor3 = Color3.fromRGB(180, 180, 180)
TabEmotes.Font = Enum.Font.Code
TabEmotes.TextSize = 11
Instance.new("UICorner", TabEmotes).CornerRadius = UDim.new(0, 4)

-- Search
local SearchFrame = Instance.new("Frame", SearchRow)
SearchFrame.Name = "SearchFrame"
SearchFrame.Size = UDim2.new(1, -156, 0, 24)
SearchFrame.Position = UDim2.new(0, 156, 0, 2)
SearchFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
SearchFrame.BorderSizePixel = 0
Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 4)

local SearchStroke = Instance.new("UIStroke", SearchFrame)
SearchStroke.Color = Color3.fromRGB(38, 38, 46)

local SearchIcon = Instance.new("TextLabel", SearchFrame)
SearchIcon.Size = UDim2.new(0, 24, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextSize = 10
SearchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)

local SearchBox = Instance.new("TextBox", SearchFrame)
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -30, 1, 0)
SearchBox.Position = UDim2.new(0, 26, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search commands / emotes..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
SearchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
SearchBox.Font = Enum.Font.Code
SearchBox.TextSize = 10
SearchBox.TextXAlignment = Enum.TextXAlignment.Left

-- Minimized Icon
local MinIcon = Instance.new("TextButton", ScreenGui)
MinIcon.Name = "MinIcon"
MinIcon.Size = UDim2.new(0, 260, 0, 30)
MinIcon.Position = UDim2.new(0.05, 0, 0.1, 0)
MinIcon.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
MinIcon.Text = "[XYRON.SYS]"
MinIcon.TextColor3 = Color3.fromRGB(220, 220, 220)
MinIcon.Font = Enum.Font.Code
MinIcon.TextSize = 11
MinIcon.Visible = false
MinIcon.Active = true
Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(0, 4)
local MinIconStroke = Instance.new("UIStroke", MinIcon)
MinIconStroke.Color = Color3.fromRGB(220, 35, 35)

makeDraggable(TopBar, MainFrame)
makeDraggable(MinIcon, MinIcon)

-- ===================== CONTENT CONTAINERS =====================
local CmdsContainer = Instance.new("ScrollingFrame", MainFrame)
CmdsContainer.Name = "CmdsContainer"
CmdsContainer.Size = UDim2.new(1, -16, 1, -72)
CmdsContainer.Position = UDim2.new(0, 8, 0, 68)
CmdsContainer.BackgroundTransparency = 1
CmdsContainer.BorderSizePixel = 0
CmdsContainer.ScrollBarThickness = 3
CmdsContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 35, 35)
CmdsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
CmdsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
CmdsContainer.Visible = true

local CmdsLayout = Instance.new("UIListLayout", CmdsContainer)
CmdsLayout.SortOrder = Enum.SortOrder.LayoutOrder
CmdsLayout.Padding = UDim.new(0, 8)

local EmotesContainer = Instance.new("ScrollingFrame", MainFrame)
EmotesContainer.Name = "EmotesContainer"
EmotesContainer.Size = UDim2.new(1, -16, 1, -72)
EmotesContainer.Position = UDim2.new(0, 8, 0, 68)
EmotesContainer.BackgroundTransparency = 1
EmotesContainer.BorderSizePixel = 0
EmotesContainer.ScrollBarThickness = 3
EmotesContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 35, 35)
EmotesContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
EmotesContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
EmotesContainer.Visible = false

local EmotesLayout = Instance.new("UIListLayout", EmotesContainer)
EmotesLayout.SortOrder = Enum.SortOrder.LayoutOrder
EmotesLayout.Padding = UDim.new(0, 6)

-- ===================== INFO CARD (CMDS) =====================
local InfoCard = Instance.new("Frame", CmdsContainer)
InfoCard.Name = "InfoCard"
InfoCard.LayoutOrder = 1
InfoCard.Size = UDim2.new(1, 0, 0, 70)
InfoCard.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
InfoCard.BorderSizePixel = 0
Instance.new("UICorner", InfoCard).CornerRadius = UDim.new(0, 4)

local InfoStroke = Instance.new("UIStroke", InfoCard)
InfoStroke.Color = Color3.fromRGB(38, 38, 46)

local InfoAccent = Instance.new("Frame", InfoCard)
InfoAccent.Size = UDim2.new(0, 3, 1, -12)
InfoAccent.Position = UDim2.new(0, 5, 0, 6)
InfoAccent.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
InfoAccent.BorderSizePixel = 0
Instance.new("UICorner", InfoAccent).CornerRadius = UDim.new(1, 0)

local InfoText = Instance.new("TextLabel", InfoCard)
InfoText.Name = "InfoText"
InfoText.Size = UDim2.new(1, -18, 1, -10)
InfoText.Position = UDim2.new(0, 14, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Code
InfoText.TextSize = 10
InfoText.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.TextWrapped = true

-- FPS + Position
local FrameCount, LastFpsCheck, CurrentFps = 0, tick(), 0
RunService.RenderStepped:Connect(function()
	FrameCount = FrameCount + 1
	local now = tick()
	if now - LastFpsCheck >= 1 then
		CurrentFps = math.floor(FrameCount / (now - LastFpsCheck))
		FrameCount = 0
		LastFpsCheck = now
	end

	local posStr = "0, 0, 0"
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local pos = LocalPlayer.Character.HumanoidRootPart.Position
		posStr = string.format("%.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
	end

	InfoText.Text = string.format(
		"USER  : %s (ID: %d)\nSERVER: Place %d\nPOS   : %s\nFPS   : %d FPS",
		LocalPlayer.Name,
		LocalPlayer.UserId,
		game.PlaceId,
		posStr,
		CurrentFps
	)
end)

-- ===================== GRID FOR MODULE CARDS =====================
local CardGridFrame = Instance.new("Frame", CmdsContainer)
CardGridFrame.Name = "CardGridFrame"
CardGridFrame.LayoutOrder = 2
CardGridFrame.Size = UDim2.new(1, 0, 0, 0)
CardGridFrame.BackgroundTransparency = 1
CardGridFrame.AutomaticSize = Enum.AutomaticSize.Y

local Grid = Instance.new("UIGridLayout", CardGridFrame)
Grid.CellSize = UDim2.new(0, 148, 0, 40)
Grid.CellPadding = UDim2.new(0, 6, 0, 6)
Grid.SortOrder = Enum.SortOrder.LayoutOrder

-- ===================== UI HELPERS =====================
local moduleCards = {} -- for search

local function createBoxContainer(commandName, order)
	local box = Instance.new("Frame", CardGridFrame)
	box.Name = "Card_" .. (commandName or "Box")
	box.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
	box.BorderSizePixel = 0
	box.LayoutOrder = order or 0
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
	local stroke = Instance.new("UIStroke", box)
	stroke.Color = Color3.fromRGB(38, 38, 46)

	local accent = Instance.new("Frame", box)
	accent.Size = UDim2.new(0, 3, 1, -12)
	accent.Position = UDim2.new(0, 5, 0, 6)
	accent.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
	accent.BorderSizePixel = 0
	Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

	if commandName then
		table.insert(moduleCards, {Box = box, Name = commandName})
	end
	return box
end

local function createOriginalToggle(parent)
	local toggle = Instance.new("TextButton", parent)
	toggle.Size = UDim2.new(0, 42, 0, 22)
	toggle.Position = UDim2.new(1, -47, 0.5, -11)
	toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	toggle.Text = "[OFF]"
	toggle.TextColor3 = Color3.fromRGB(160, 160, 160)
	toggle.Font = Enum.Font.Code
	toggle.TextSize = 10
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 2)

	local state = false
	local function setToggleState(newState)
		state = newState
		if state then
			toggle.Text = "[ON]"
			toggle.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
			toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			toggle.Text = "[OFF]"
			toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			toggle.TextColor3 = Color3.fromRGB(160, 160, 160)
		end
	end

	toggle.MouseButton1Click:Connect(function() setToggleState(not state) end)
	return toggle, function() return state end, setToggleState
end

local function createDropdown(parent, defaultText, getItemsCallback, onSelectCallback)
	local dropdownBtn = Instance.new("TextButton", parent)
	dropdownBtn.Size = UDim2.new(0, 85, 0, 22)
	dropdownBtn.Position = UDim2.new(1, -90, 0.5, -11)
	dropdownBtn.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	dropdownBtn.Text = defaultText
	dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	dropdownBtn.Font = Enum.Font.Code
	dropdownBtn.TextSize = 8
	dropdownBtn.ClipsDescendants = false
	Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 3)

	local listFrame = Instance.new("ScrollingFrame", ScreenGui)
	listFrame.Size = UDim2.new(0, 130, 0, 120)
	listFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	listFrame.BorderSizePixel = 0
	listFrame.Visible = false
	listFrame.ZIndex = 50
	listFrame.ScrollBarThickness = 2
	listFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 4)
	local listStroke = Instance.new("UIStroke", listFrame)
	listStroke.Color = Color3.fromRGB(50, 50, 60)

	local layout = Instance.new("UIListLayout", listFrame)
	layout.Padding = UDim.new(0, 2)

	local isOpen = false
	dropdownBtn.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		listFrame.Visible = isOpen
		if isOpen then
			for _, v in ipairs(listFrame:GetChildren()) do
				if v:IsA("TextButton") then v:Destroy() end
			end
			local absPos = dropdownBtn.AbsolutePosition
			listFrame.Position = UDim2.new(0, absPos.X, 0, absPos.Y + 26)

			local items = getItemsCallback()
			for _, name in ipairs(items) do
				local itemBtn = Instance.new("TextButton", listFrame)
				itemBtn.Size = UDim2.new(1, 0, 0, 20)
				itemBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
				itemBtn.Text = name
				itemBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
				itemBtn.Font = Enum.Font.Code
				itemBtn.TextSize = 9
				itemBtn.ZIndex = 51
				itemBtn.MouseButton1Click:Connect(function()
					dropdownBtn.Text = name
					isOpen = false
					listFrame.Visible = false
					onSelectCallback(name)
				end)
			end
		end
	end)

	-- Close when clicking elsewhere
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
			local abs = listFrame.AbsolutePosition
			local size = listFrame.AbsoluteSize
			local mouse = UserInputService:GetMouseLocation()
			if mouse.X < abs.X or mouse.X > abs.X + size.X or mouse.Y < abs.Y or mouse.Y > abs.Y + size.Y then
				isOpen = false
				listFrame.Visible = false
			end
		end
	end)

	return dropdownBtn
end

-- ===================== MODULE STATES =====================
local EspEnabled = false
local FlyEnabled = false
local SpeedEnabled = false
local NoclipEnabled = false
local TracersEnabled = false
local GravityEnabled = false
local SpectateTarget = nil
local FlySpeed = 50
local WalkSpeedValue = 32
local OriginalGravity = workspace.Gravity

-- ESP Drawing
local EspObjects = {}
local function clearESP()
	for _, v in pairs(EspObjects) do
		if v then pcall(function() v:Remove() end) end
	end
	EspObjects = {}
end

local function createESP(player)
	if player == LocalPlayer then return end
	local box = Drawing.new("Square")
	box.Visible = false
	box.Color = Color3.fromRGB(220, 35, 35)
	box.Thickness = 1
	box.Filled = false
	box.Transparency = 1

	local name = Drawing.new("Text")
	name.Visible = false
	name.Color = Color3.fromRGB(255, 255, 255)
	name.Size = 13
	name.Center = true
	name.Outline = true

	EspObjects[player] = {Box = box, Name = name}
end

local function updateESP()
	if not EspEnabled then
		clearESP()
		return
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			if not EspObjects[player] then createESP(player) end
			local obj = EspObjects[player]
			local hrp = player.Character.HumanoidRootPart
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				local size = Vector2.new(40, 60)
				obj.Box.Size = size
				obj.Box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
				obj.Box.Visible = true
				obj.Name.Text = player.Name
				obj.Name.Position = Vector2.new(pos.X, pos.Y - size.Y/2 - 14)
				obj.Name.Visible = true
			else
				obj.Box.Visible = false
				obj.Name.Visible = false
			end
		end
	end
end

-- Tracers
local TracerLines = {}
local function clearTracers()
	for _, v in pairs(TracerLines) do
		if v then pcall(function() v:Remove() end) end
	end
	TracerLines = {}
end

local function updateTracers()
	if not TracersEnabled then
		clearTracers()
		return
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			if not TracerLines[player] then
				local line = Drawing.new("Line")
				line.Visible = false
				line.Color = Color3.fromRGB(220, 35, 35)
				line.Thickness = 1
				line.Transparency = 1
				TracerLines[player] = line
			end
			local line = TracerLines[player]
			local hrp = player.Character.HumanoidRootPart
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
				line.To = Vector2.new(pos.X, pos.Y)
				line.Visible = true
			else
				line.Visible = false
			end
		end
	end
end

-- Fly
local FlyBV, FlyBG
local function enableFly()
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
	local hrp = LocalPlayer.Character.HumanoidRootPart
	FlyBV = Instance.new("BodyVelocity")
	FlyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	FlyBV.Velocity = Vector3.zero
	FlyBV.Parent = hrp

	FlyBG = Instance.new("BodyGyro")
	FlyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	FlyBG.P = 9e4
	FlyBG.Parent = hrp
end

local function disableFly()
	if FlyBV then FlyBV:Destroy() FlyBV = nil end
	if FlyBG then FlyBG:Destroy() FlyBG = nil end
end

-- Noclip
local NoclipConn
local function setNoclip(state)
	if NoclipConn then NoclipConn:Disconnect() NoclipConn = nil end
	if state then
		NoclipConn = RunService.Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	end
end

-- Speed
local function applySpeed()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = SpeedEnabled and WalkSpeedValue or 16
	end
end

-- Spectate
local function startSpectate(targetName)
	local target = Players:FindFirstChild(targetName)
	if target and target.Character and target.Character:FindFirstChild("Humanoid") then
		SpectateTarget = target
		Camera.CameraSubject = target.Character.Humanoid
	end
end

local function stopSpectate()
	SpectateTarget = nil
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		Camera.CameraSubject = LocalPlayer.Character.Humanoid
	end
end

-- Main Loop
RunService.RenderStepped:Connect(function()
	updateESP()
	updateTracers()

	-- Fly movement
	if FlyEnabled and FlyBV and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = LocalPlayer.Character.HumanoidRootPart
		local camCF = Camera.CFrame
		local move = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - camCF.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + camCF.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
		FlyBV.Velocity = move.Unit * FlySpeed
		if move.Magnitude == 0 then FlyBV.Velocity = Vector3.zero end
		if FlyBG then FlyBG.CFrame = camCF end
	end

	-- Keep speed applied
	if SpeedEnabled then applySpeed() end
end)

-- Character respawn handling
LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.5)
	if EspEnabled then clearESP() end
	if TracersEnabled then clearTracers() end
	if FlyEnabled then enableFly() end
	if NoclipEnabled then setNoclip(true) end
	if SpeedEnabled then applySpeed() end
	if GravityEnabled then workspace.Gravity = 0 end
	stopSpectate()
end)

Players.PlayerRemoving:Connect(function(p)
	if EspObjects[p] then
		pcall(function() EspObjects[p].Box:Remove() EspObjects[p].Name:Remove() end)
		EspObjects[p] = nil
	end
	if TracerLines[p] then
		pcall(function() TracerLines[p]:Remove() end)
		TracerLines[p] = nil
	end
	if SpectateTarget == p then stopSpectate() end
end)

-- ===================== CREATE ALL MODULE CARDS =====================

-- 1. ESP
local EspBox = createBoxContainer("ESP SYS//ESP", 1)
local EspLabel = Instance.new("TextLabel", EspBox)
EspLabel.Size = UDim2.new(0.5, 0, 1, 0)
EspLabel.Position = UDim2.new(0, 12, 0, 0)
EspLabel.BackgroundTransparency = 1
EspLabel.Text = "SYS//ESP"
EspLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
EspLabel.Font = Enum.Font.Code
EspLabel.TextSize = 10
EspLabel.TextXAlignment = Enum.TextXAlignment.Left
local EspToggle, getEsp, setEsp = createOriginalToggle(EspBox)
EspToggle.MouseButton1Click:Connect(function()
	EspEnabled = getEsp()
	if not EspEnabled then clearESP() end
end)

-- 2. FLY
local FlyBox = createBoxContainer("FLY SYS//FLY", 2)
local FlyLabel = Instance.new("TextLabel", FlyBox)
FlyLabel.Size = UDim2.new(0.32, 0, 1, 0)
FlyLabel.Position = UDim2.new(0, 12, 0, 0)
FlyLabel.BackgroundTransparency = 1
FlyLabel.Text = "SYS//FLY"
FlyLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
FlyLabel.Font = Enum.Font.Code
FlyLabel.TextSize = 10
FlyLabel.TextXAlignment = Enum.TextXAlignment.Left

local FlyInput = Instance.new("TextBox", FlyBox)
FlyInput.Size = UDim2.new(0, 24, 0, 18)
FlyInput.Position = UDim2.new(1, -78, 0.5, -9)
FlyInput.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
FlyInput.Text = "50"
FlyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyInput.Font = Enum.Font.Code
FlyInput.TextSize = 9
Instance.new("UICorner", FlyInput).CornerRadius = UDim.new(0, 3)
FlyInput.FocusLost:Connect(function()
	local n = tonumber(FlyInput.Text)
	if n then FlySpeed = math.clamp(n, 1, 500) end
end)

local FlyToggle, getFly, setFly = createOriginalToggle(FlyBox)
FlyToggle.MouseButton1Click:Connect(function()
	FlyEnabled = getFly()
	if FlyEnabled then enableFly() else disableFly() end
end)

-- 3. SPEED
local SpeedBox = createBoxContainer("SPEED SPD SYS//SPD", 3)
local SpeedLabel = Instance.new("TextLabel", SpeedBox)
SpeedLabel.Size = UDim2.new(0.32, 0, 1, 0)
SpeedLabel.Position = UDim2.new(0, 12, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "SYS//SPD"
SpeedLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
SpeedLabel.Font = Enum.Font.Code
SpeedLabel.TextSize = 10
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox", SpeedBox)
SpeedInput.Size = UDim2.new(0, 24, 0, 18)
SpeedInput.Position = UDim2.new(1, -78, 0.5, -9)
SpeedInput.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
SpeedInput.Text = "32"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.Code
SpeedInput.TextSize = 9
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 3)
SpeedInput.FocusLost:Connect(function()
	local n = tonumber(SpeedInput.Text)
	if n then WalkSpeedValue = math.clamp(n, 1, 500) applySpeed() end
end)

local SpeedToggle, getSpeed, setSpeed = createOriginalToggle(SpeedBox)
SpeedToggle.MouseButton1Click:Connect(function()
	SpeedEnabled = getSpeed()
	applySpeed()
end)

-- 4. NOCLIP
local NoclipBox = createBoxContainer("NOCLIP SYS//CLIP", 4)
local NoclipLabel = Instance.new("TextLabel", NoclipBox)
NoclipLabel.Size = UDim2.new(0.5, 0, 1, 0)
NoclipLabel.Position = UDim2.new(0, 12, 0, 0)
NoclipLabel.BackgroundTransparency = 1
NoclipLabel.Text = "SYS//CLIP"
NoclipLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
NoclipLabel.Font = Enum.Font.Code
NoclipLabel.TextSize = 10
NoclipLabel.TextXAlignment = Enum.TextXAlignment.Left
local NoclipToggle, getNoclip, setNoclipUI = createOriginalToggle(NoclipBox)
NoclipToggle.MouseButton1Click:Connect(function()
	NoclipEnabled = getNoclip()
	setNoclip(NoclipEnabled)
end)

-- 5. TRACERS
local TracersBox = createBoxContainer("TRACERS SYS//TRACE", 5)
local TracersLabel = Instance.new("TextLabel", TracersBox)
TracersLabel.Size = UDim2.new(0.5, 0, 1, 0)
TracersLabel.Position = UDim2.new(0, 12, 0, 0)
TracersLabel.BackgroundTransparency = 1
TracersLabel.Text = "SYS//TRACE"
TracersLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
TracersLabel.Font = Enum.Font.Code
TracersLabel.TextSize = 10
TracersLabel.TextXAlignment = Enum.TextXAlignment.Left
local TracersToggle, getTracers, setTracers = createOriginalToggle(TracersBox)
TracersToggle.MouseButton1Click:Connect(function()
	TracersEnabled = getTracers()
	if not TracersEnabled then clearTracers() end
end)

-- 6. GRAVITY
local GravityBox = createBoxContainer("GRAVITY SYS//GRAV", 6)
local GravityLabel = Instance.new("TextLabel", GravityBox)
GravityLabel.Size = UDim2.new(0.5, 0, 1, 0)
GravityLabel.Position = UDim2.new(0, 12, 0, 0)
GravityLabel.BackgroundTransparency = 1
GravityLabel.Text = "SYS//GRAV"
GravityLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
GravityLabel.Font = Enum.Font.Code
GravityLabel.TextSize = 10
GravityLabel.TextXAlignment = Enum.TextXAlignment.Left
local GravityToggle, getGravity, setGravityUI = createOriginalToggle(GravityBox)
GravityToggle.MouseButton1Click:Connect(function()
	GravityEnabled = getGravity()
	workspace.Gravity = GravityEnabled and 0 or OriginalGravity
end)

-- 7. TELEPORT TO PLAYER
local SelectedPlayerName = ""
local TpPlayerBox = createBoxContainer("TELEPORT PLAYER TP//PLYR", 7)
local TpLabel = Instance.new("TextLabel", TpPlayerBox)
TpLabel.Size = UDim2.new(0.3, 0, 1, 0)
TpLabel.Position = UDim2.new(0, 12, 0, 0)
TpLabel.BackgroundTransparency = 1
TpLabel.Text = "TP//PLYR"
TpLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
TpLabel.Font = Enum.Font.Code
TpLabel.TextSize = 10
TpLabel.TextXAlignment = Enum.TextXAlignment.Left

createDropdown(TpPlayerBox, "SELECT", function()
	local names = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then table.insert(names, p.Name) end
	end
	table.sort(names)
	return names
end, function(selected)
	SelectedPlayerName = selected
	local target = Players:FindFirstChild(selected)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
	end
end)

-- 8. SPECTATE (fixed working)
local SpectateBox = createBoxContainer("SPECTATE SYS//SPEC", 8)
local SpecLabel = Instance.new("TextLabel", SpectateBox)
SpecLabel.Size = UDim2.new(0.3, 0, 1, 0)
SpecLabel.Position = UDim2.new(0, 12, 0, 0)
SpecLabel.BackgroundTransparency = 1
SpecLabel.Text = "SYS//SPEC"
SpecLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
SpecLabel.Font = Enum.Font.Code
SpecLabel.TextSize = 10
SpecLabel.TextXAlignment = Enum.TextXAlignment.Left

createDropdown(SpectateBox, "SELECT", function()
	local names = {"[STOP]"}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then table.insert(names, p.Name) end
	end
	table.sort(names)
	return names
end, function(selected)
	if selected == "[STOP]" then
		stopSpectate()
	else
		startSpectate(selected)
	end
end)

-- 9. TELEPORT TO PART
local TpPartBox = createBoxContainer("TELEPORT PART TP//PART", 9)
local TpPartLabel = Instance.new("TextLabel", TpPartBox)
TpPartLabel.Size = UDim2.new(0.3, 0, 1, 0)
TpPartLabel.Position = UDim2.new(0, 12, 0, 0)
TpPartLabel.BackgroundTransparency = 1
TpPartLabel.Text = "TP//PART"
TpPartLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
TpPartLabel.Font = Enum.Font.Code
TpPartLabel.TextSize = 10
TpPartLabel.TextXAlignment = Enum.TextXAlignment.Left

local PartInput = Instance.new("TextBox", TpPartBox)
PartInput.Size = UDim2.new(0, 85, 0, 22)
PartInput.Position = UDim2.new(1, -90, 0.5, -11)
PartInput.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
PartInput.Text = "PartName"
PartInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PartInput.Font = Enum.Font.Code
PartInput.TextSize = 8
Instance.new("UICorner", PartInput).CornerRadius = UDim.new(0, 3)

PartInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local targetPart = workspace:FindFirstChild(PartInput.Text, true)
		if targetPart and targetPart:IsA("BasePart")
			and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame * CFrame.new(0, 3, 0)
		end
	end
end)

-- 10. REJOIN
local RejoinBox = createBoxContainer("REJOIN SYS//REJOIN", 10)
local RejoinLabel = Instance.new("TextLabel", RejoinBox)
RejoinLabel.Size = UDim2.new(0.55, 0, 1, 0)
RejoinLabel.Position = UDim2.new(0, 12, 0, 0)
RejoinLabel.BackgroundTransparency = 1
RejoinLabel.Text = "SYS//REJOIN"
RejoinLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
RejoinLabel.Font = Enum.Font.Code
RejoinLabel.TextSize = 10
RejoinLabel.TextXAlignment = Enum.TextXAlignment.Left

local RejoinBtn = Instance.new("TextButton", RejoinBox)
RejoinBtn.Size = UDim2.new(0, 50, 0, 22)
RejoinBtn.Position = UDim2.new(1, -55, 0.5, -11)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
RejoinBtn.Text = "GO"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.Font = Enum.Font.Code
RejoinBtn.TextSize = 10
Instance.new("UICorner", RejoinBtn).CornerRadius = UDim.new(0, 3)
RejoinBtn.MouseButton1Click:Connect(function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- ===================== EMOTES TAB =====================
local emotes = {
	["Take and Hold The L"] = 95465599788325,
	["Zen Floating"] = 77118838608242,
	["Godly Aura Fly Pose Idle"] = 76361248833307,
	["Accurate House Box Glitch"] = 93552301087938,
	["Michael Jackson"] = 140440735589603,
	["Dropkick"] = 127764273000599,
	["Show Dem Wrists KSI"] = 7202898984,
	["Floss Dance"] = 5917570207,
}

local emoteButtons = {}

for emoteName, emoteId in pairs(emotes) do
	local btn = Instance.new("TextButton", EmotesContainer)
	btn.Size = UDim2.new(1, 0, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
	btn.Text = "  " .. emoteName
	btn.TextColor3 = Color3.fromRGB(230, 230, 230)
	btn.TextSize = 12
	btn.Font = Enum.Font.Code
	btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(38, 38, 46)

	local accent = Instance.new("Frame", btn)
	accent.Size = UDim2.new(0, 3, 1, -10)
	accent.Position = UDim2.new(0, 5, 0, 5)
	accent.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
	accent.BorderSizePixel = 0
	Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

	btn.MouseButton1Click:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum then return end
		local desc = hum:FindFirstChildOfClass("HumanoidDescription") or Instance.new("HumanoidDescription")
		pcall(function()
			desc:AddEmote(emoteName, emoteId)
			hum:PlayEmoteAsync(emoteName)
		end)
	end)

	table.insert(emoteButtons, {Button = btn, Name = emoteName})
end

-- ===================== TAB SWITCHING =====================
local currentTab = "Cmds"

local function switchTab(tab)
	currentTab = tab
	if tab == "Cmds" then
		CmdsContainer.Visible = true
		EmotesContainer.Visible = false
		TabCmds.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
		TabCmds.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabEmotes.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
		TabEmotes.TextColor3 = Color3.fromRGB(180, 180, 180)
	else
		CmdsContainer.Visible = false
		EmotesContainer.Visible = true
		TabEmotes.BackgroundColor3 = Color3.fromRGB(220, 35, 35)
		TabEmotes.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabCmds.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
		TabCmds.TextColor3 = Color3.fromRGB(180, 180, 180)
	end
	SearchBox.Text = "" -- reset search on switch
end

TabCmds.MouseButton1Click:Connect(function() switchTab("Cmds") end)
TabEmotes.MouseButton1Click:Connect(function() switchTab("Emotes") end)

-- ===================== SEARCH =====================
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = string.lower(SearchBox.Text)
	if currentTab == "Cmds" then
		for _, cardData in ipairs(moduleCards) do
			local box = cardData.Box
			local name = string.lower(cardData.Name)
			box.Visible = (query == "" or string.find(name, query, 1, true) ~= nil)
		end
	else
		for _, data in ipairs(emoteButtons) do
			local name = string.lower(data.Name)
			data.Button.Visible = (query == "" or string.find(name, query, 1, true) ~= nil)
		end
	end
end)

-- ===================== MINIMIZE / CLOSE =====================
local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	MainFrame.Visible = not isMinimized
	MinIcon.Visible = isMinimized
end)

MinIcon.MouseButton1Click:Connect(function()
	isMinimized = false
	MainFrame.Visible = true
	MinIcon.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
	clearESP()
	clearTracers()
	disableFly()
	setNoclip(false)
	stopSpectate()
	if GravityEnabled then workspace.Gravity = OriginalGravity end
	ScreenGui:Destroy()
end)

print("[XYRON.SYS] v2.6 loaded | Tabs: CMDS + EMOTES | All modules functional")
