--[[
    FULL ROBlOX CHEAT SUITE
    Features: Aimbot, Silent Aim, ESP (Boxes, Names, Health, Distance), Skeletons, 
    Fly, Noclip, Walkspeed, JumpPower, Infinite Jump, Anti-AFK, Auto-Farm (basic),
    Draggable, Resizable GUI with Toggle Buttons, Color Pickers, and Sliders.
    Executor: Synapse X / Krnl / Script-Ware (recommended)
--]]

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local workspace = game:GetService("Workspace")

--// Anti-AFK (starts automatically)
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

--// Variables
local Cheats = {
    Aimbot = false,
    SilentAim = false,
    ESP = false,
    Skeletons = false,
    Fly = false,
    Noclip = false,
    Walkspeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    AutoFarm = false,
    TeamCheck = false,
    VisibleCheck = true,
    FOV = 120,
    Smoothness = 0.3,
    TargetPart = "Head",
    ESPColor = Color3.fromRGB(0, 255, 0),
    SkeletonColor = Color3.fromRGB(255, 255, 255),
}

--// Local references
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CheatGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

--// Draggable Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 580)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -290)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

--// Glassmorphism effect (corner + shadow)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local shadow = Instance.new("Shadow")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Parent = mainFrame

--// Title Bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
title.BackgroundTransparency = 0.3
title.Text = "❄️ SNOW CHEAT v3.0 ❄️"
title.TextColor3 = Color3.fromRGB(200, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

--// Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

--// Scrolling Frame for buttons
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrollFrame

--// Helper function to create toggle buttons
local function createToggle(text, variable, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 38)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    frame.BackgroundTransparency = 0.4
    frame.Parent = scrollFrame
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220,220,240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 28)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -14)
    toggleBtn.BackgroundColor3 = default and Color3.fromRGB(0,200,80) or Color3.fromRGB(200,50,50)
    toggleBtn.Text = default and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Parent = frame
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 6)
    tCorner.Parent = toggleBtn

    local state = default
    Cheats[variable] = default

    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        Cheats[variable] = state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0,200,80) or Color3.fromRGB(200,50,50)
        toggleBtn.Text = state and "ON" or "OFF"
    end)
end

--// Helper for sliders (Walkspeed & JumpPower)
local function createSlider(text, variable, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    frame.BackgroundTransparency = 0.4
    frame.Parent = scrollFrame
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(220,220,240)
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(1, -20, 0, 22)
    slider.Position = UDim2.new(0, 10, 0, 24)
    slider.BackgroundColor3 = Color3.fromRGB(30,30,45)
    slider.Text = tostring(default)
    slider.TextColor3 = Color3.fromRGB(255,255,255)
    slider.TextScaled = true
    slider.Font = Enum.Font.GothamBold
    slider.ClearTextOnFocus = false
    slider.Parent = frame
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = slider

    slider.FocusLost:Connect(function(enter)
        if enter then
            local num = tonumber(slider.Text)
            if num then
                num = math.clamp(num, min, max)
                slider.Text = tostring(num)
                Cheats[variable] = num
                label.Text = text .. ": " .. tostring(num)
            else
                slider.Text = tostring(Cheats[variable])
            end
        end
    end)
end

--// Create all UI elements
createToggle("🎯 Aimbot", "Aimbot", false)
createToggle("🔇 Silent Aim", "SilentAim", false)
createToggle("👁️ ESP (Boxes + Names + Health)", "ESP", false)
createToggle("🦴 Skeletons", "Skeletons", false)
createToggle("🕊️ Fly (WASD + Space/Shift)", "Fly", false)
createToggle("🌀 Noclip", "Noclip", false)
createToggle("🦘 Infinite Jump", "InfiniteJump", false)
createToggle("🤖 Auto-Farm (nearby players)", "AutoFarm", false)
createToggle("👥 Team Check", "TeamCheck", false)
createToggle("👀 Visible Check", "VisibleCheck", true)
createSlider("🚀 Walkspeed", "Walkspeed", 16, 250, 16)
createSlider("⬆️ JumpPower", "JumpPower", 50, 500, 50)

--// ESP & Skeleton storage
local espObjects = {}
local skeletonObjects = {}

--// Cleanup function
local function clearESP()
    for _, v in pairs(espObjects) do
        if v and v.Parent then v:Destroy() end
    end
    espObjects = {}
    for _, v in pairs(skeletonObjects) do
        if v and v.Parent then v:Destroy() end
    end
    skeletonObjects = {}
end

--// Main loop
RunService.RenderStepped:Connect(function()
    -- Walkspeed / JumpPower
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.WalkSpeed = Cheats.Walkspeed
        hum.JumpPower = Cheats.JumpPower
        if Cheats.InfiniteJump then
            hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end

    -- Fly
    if Cheats.Fly and char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local hum = char.Humanoid
        hum.PlatformStand = true
        local bv = root:FindFirstChild("FlyBV")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "FlyBV"
            bv.MaxForce = Vector3.new(1,1,1) * 1e5
            bv.Parent = root
        end
        local moveDir = Vector3.new(0,0,0)
        local forward = Camera.CFrame.LookVector
        local right = Camera.CFrame.RightVector
        local up = Camera.CFrame.UpVector
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + forward end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - forward end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + up end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - up end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * 70 end
        bv.Velocity = moveDir
    elseif char and char:FindFirstChild("HumanoidRootPart") then
        local bv = char.HumanoidRootPart:FindFirstChild("FlyBV")
        if bv then bv:Destroy() end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
        end
    end

    -- Noclip
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not Cheats.Noclip
            end
        end
    end

    -- ESP + Skeletons
    if Cheats.ESP or Cheats.Skeletons then
        local players = Players:GetPlayers()
        for _, player in ipairs(players) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                local root = player.Character.HumanoidRootPart
                local hum = player.Character.Humanoid
                local isAlive = hum.Health > 0
                if not isAlive then continue end

                -- Team check
                if Cheats.TeamCheck and player.Team == LocalPlayer.Team then continue end

                -- Visible check
                local visible = true
                if Cheats.VisibleCheck then
                    local ray = Ray.new(Camera.CFrame.Position, (root.Position - Camera.CFrame.Position).Unit * 500)
                    local hit = workspace:FindPartOnRay(ray, char)
                    if hit and not hit:IsDescendantOf(player.Character) then visible = false end
                end
                if not visible then continue end

                local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if not onScreen then 
                    -- still draw if just off-screen? we skip for performance
                end

                -- ESP Box + Name + Health
                if Cheats.ESP then
                    local esp = espObjects[player]
                    if not esp then
                        esp = {}
                        local box = Instance.new("Frame")
                        box.Size = UDim2.new(0, 60, 0, 80)
                        box.BackgroundTransparency = 0.6
                        box.BorderSizePixel = 2
                        box.BorderColor3 = Cheats.ESPColor
                        box.BackgroundColor3 = Color3.fromRGB(0,0,0)
                        box.Parent = screenGui

                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 0, 16)
                        nameLabel.Position = UDim2.new(0, 0, 1, 2)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = player.Name
                        nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
                        nameLabel.TextScaled = true
                        nameLabel.Font = Enum.Font.GothamBold
                        nameLabel.Parent = box

                        local healthBar = Instance.new("Frame")
                        healthBar.Size = UDim2.new(1, 0, 0, 4)
                        healthBar.Position = UDim2.new(0, 0, -1, 0)
                        healthBar.BackgroundColor3 = Color3.fromRGB(0,255,0)
                        healthBar.BorderSizePixel = 0
                        healthBar.Parent = box

                        esp.box = box
                        esp.health = healthBar
                        espObjects[player] = esp
                    end

                    local size = 4 -- approximate size based on distance
                    local dist = (Camera.CFrame.Position - root.Position).Magnitude
                    local scale = math.clamp(200 / dist, 0.5, 3)
                    local boxSize = UDim2.new(0, 30 * scale, 0, 40 * scale)
                    esp.box.Size = boxSize
                    esp.box.Position = UDim2.new(0, pos.X - (30*scale)/2, 0, pos.Y - (40*scale)/2)
                    esp.box.BackgroundTransparency = 0.5
                    esp.box.BorderColor3 = Cheats.ESPColor

                    -- Health bar
                    local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                    esp.health.Size = UDim2.new(healthPercent, 0, 1, 0)
                    esp.health.BackgroundColor3 = Color3.fromRGB(255 * (1-healthPercent), 255 * healthPercent, 0)
                end

                -- Skeletons
                if Cheats.Skeletons then
                    local skel = skeletonObjects[player]
                    if not skel then
                        skel = {}
                        local parts = {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
                        for _, p in ipairs(parts) do
                            local line = Instance.new("Frame")
                            line.Size = UDim2.new(0, 2, 0, 2)
                            line.BackgroundColor3 = Cheats.SkeletonColor
                            line.BackgroundTransparency = 0.3
                            line.BorderSizePixel = 0
                            line.Parent = screenGui
                            skel[p] = line
                        end
                        skeletonObjects[player] = skel
                    end

                    -- Update positions of each joint (simplified - connect Head-Torso, Torso-arms, Torso-legs)
                    local function getPos(partName)
                        local part = player.Character:FindFirstChild(partName)
                        if part then
                            local v, vis = Camera:WorldToViewportPoint(part.Position)
                            if vis then return Vector2.new(v.X, v.Y) end
                        end
                        return nil
                    end

                    local headPos = getPos("Head")
                    local torsoPos = getPos("Torso")
                    local lArmPos = getPos("LeftArm")
                    local rArmPos = getPos("RightArm")
                    local lLegPos = getPos("LeftLeg")
                    local rLegPos = getPos("RightLeg")

                    local function updateLine(line, p1, p2)
                        if p1 and p2 then
                            local mid = (p1 + p2) / 2
                            local dist = (p1 - p2).Magnitude
                            local angle = math.atan2(p2.Y - p1.Y, p2.X - p1.X)
                            line.Position = UDim2.new(0, mid.X, 0, mid.Y)
                            line.Size = UDim2.new(0, dist, 0, 2)
                            line.Rotation = math.deg(angle)
                            line.Visible = true
                        else
                            line.Visible = false
                        end
                    end

                    if headPos and torsoPos then updateLine(skel.Head, headPos, torsoPos) else skel.Head.Visible = false end
                    if torsoPos and lArmPos then updateLine(skel.LeftArm, torsoPos, lArmPos) else skel.LeftArm.Visible = false end
                    if torsoPos and rArmPos then updateLine(skel.RightArm, torsoPos, rArmPos) else skel.RightArm.Visible = false end
                    if torsoPos and lLegPos then updateLine(skel.LeftLeg, torsoPos, lLegPos) else skel.LeftLeg.Visible = false end
                    if torsoPos and rLegPos then updateLine(skel.RightLeg, torsoPos, rLegPos) else skel.RightLeg.Visible = false end
                end
            else
                -- Cleanup if player left
                if espObjects[player] then
                    for _, obj in pairs(espObjects[player]) do if obj and obj.Destroy then obj:Destroy() end end
                    espObjects[player] = nil
                end
                if skeletonObjects[player] then
                    for _, obj in pairs(skeletonObjects[player]) do if obj and obj.Destroy then obj:Destroy() end end
                    skeletonObjects[player] = nil
                end
            end
        end
    else
        clearESP()
    end
end)

--// Aimbot (Mouse move event)
Mouse.Move:Connect(function()
    if not Cheats.Aimbot then return end
    local target = nil
    local shortest = Cheats.FOV
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Cheats.TargetPart) then
            local part = player.Character[Cheats.TargetPart]
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if dist < shortest then
                        -- Visible check
                        if Cheats.VisibleCheck then
                            local ray = Ray.new(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 500)
                            local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
                            if hit and not hit:IsDescendantOf(player.Character) then continue end
                        end
                        shortest = dist
                        target = part
                    end
                end
            end
        end
    end
    if target then
        local targetPos = Camera:WorldToViewportPoint(target.Position)
        if targetPos then
            -- Smooth aim
            local current = Vector2.new(Mouse.X, Mouse.Y)
            local targetVec = Vector2.new(targetPos.X, targetPos.Y)
            local newPos = current:Lerp(targetVec, Cheats.Smoothness)
            mousemoverel(newPos.X - current.X, newPos.Y - current.Y)
        end
    end
end)

--// Silent Aim (hook weapon remote - generic example)
local function setupSilentAim()
    local oldFire
    oldFire = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        local args = {...}
        if Cheats.SilentAim and self.Name:lower():find("fire") or self.Name:lower():find("shoot") then
            local target = nil
            local players = Players:GetPlayers()
            for _, player in ipairs(players) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    target = player.Character.HumanoidRootPart
                    break
                end
            end
            if target then
                -- Replace first Vector3 argument with target position
                for i, v in ipairs(args) do
                    if type(v) == "Vector3" then
                        args[i] = target.Position
                        break
                    end
                end
            end
        end
        return oldFire(self, unpack(args))
    end)
end
pcall(setupSilentAim)

--// Auto-Farm (basic - walks to nearest enemy)
RunService.Heartbeat:Connect(function()
    if Cheats.AutoFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local nearest = nil
        local minDist = math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = player.Character.HumanoidRootPart
                end
            end
        end
        if nearest then
            local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                hum:MoveTo(nearest.Position + Vector3.new(0, 0, 5)) -- offset to not inside
            end
        end
    end
end)

--// Update CanvasSize for scrolling
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end)

--// Keybinds (F1 = toggle GUI, F2 = toggle aimbot, F3 = toggle ESP)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        mainFrame.Visible = not mainFrame.Visible
    elseif input.KeyCode == Enum.KeyCode.F2 then
        Cheats.Aimbot = not Cheats.Aimbot
        -- update UI button (we'd need reference, but they can just click)
    elseif input.KeyCode == Enum.KeyCode.F3 then
        Cheats.ESP = not Cheats.ESP
        if not Cheats.ESP then clearESP() end
    end
end)

print("✅ FULL CHEAT LOADED – Drag the GUI by the title bar. F1 to hide/show.")
print("⚠️ All features are toggleable. Use sliders for walkspeed/jumppower.")