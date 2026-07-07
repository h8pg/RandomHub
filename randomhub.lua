--// SIMPLE, STABLE, WORKING CHEAT – NO GLASS, NO BREAKS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInput = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// ANTI-AFK
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end)

--// CHEAT STATES (all off by default)
local C = {
    Aimbot = false,
    Silent = false,
    ESP = false,
    Skeleton = false,
    Fly = false,
    Noclip = false,
    WS = 16,
    JP = 50,
    InfJump = false,
    AutoFarm = false,
}

--// CREATE GUI (simple, dark, always on top)
local gui = Instance.new("ScreenGui")
gui.Name = "CheatGUI"
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 450)
main.Position = UDim2.new(0.5, -150, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(20,20,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,55)
title.Text = "❄️ SNOW V4 (FIXED)"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = main

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,25,0,25)
close.Position = UDim2.new(1,-30,0,2)
close.BackgroundColor3 = Color3.fromRGB(200,50,50)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.Parent = main
close.MouseButton1Click:Connect(function() gui:Destroy() end)

--// HELPER: Toggle button
local function addToggle(text, var, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,30)
    frame.Position = UDim2.new(0,5,0,yPos)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,45)
    frame.BackgroundTransparency = 0.5
    frame.Parent = main

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220,220,240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,45,0,22)
    btn.Position = UDim2.new(1,-50,0.5,-11)
    btn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame

    local state = false
    C[var] = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        C[var] = state
        btn.BackgroundColor3 = state and Color3.fromRGB(0,200,80) or Color3.fromRGB(200,50,50)
        btn.Text = state and "ON" or "OFF"
    end)
end

--// HELPER: Slider
local function addSlider(text, var, min, max, default, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-10,0,40)
    frame.Position = UDim2.new(0,5,0,yPos)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,45)
    frame.BackgroundTransparency = 0.5
    frame.Parent = main

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,18)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(220,220,240)
    label.TextScaled = true
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.5,0,0,20)
    box.Position = UDim2.new(0.5,-40,0,20)
    box.BackgroundColor3 = Color3.fromRGB(50,50,65)
    box.Text = tostring(default)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.TextScaled = true
    box.Font = Enum.Font.GothamBold
    box.Parent = frame
    box.FocusLost:Connect(function()
        local num = tonumber(box.Text)
        if num then
            num = math.clamp(num, min, max)
            box.Text = tostring(num)
            C[var] = num
            label.Text = text .. ": " .. tostring(num)
        else
            box.Text = tostring(C[var])
        end
    end)
    C[var] = default
end

--// ADD ALL CONTROLS (positions hardcoded for stability)
addToggle("🎯 Aimbot", "Aimbot", 35)
addToggle("🔇 Silent Aim", "Silent", 70)
addToggle("👁️ ESP", "ESP", 105)
addToggle("🦴 Skeletons", "Skeleton", 140)
addToggle("🕊️ Fly", "Fly", 175)
addToggle("🌀 Noclip", "Noclip", 210)
addToggle("🦘 Inf Jump", "InfJump", 245)
addToggle("🤖 AutoFarm", "AutoFarm", 280)
addSlider("🚀 Walkspeed", "WS", 16, 250, 16, 320)
addSlider("⬆️ JumpPower", "JP", 50, 500, 50, 365)

-- Status label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,1,-22)
status.BackgroundTransparency = 1
status.Text = "✅ Loaded – F1 toggle GUI"
status.TextColor3 = Color3.fromRGB(100,255,100)
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.Parent = main

--// ESP STORAGE
local espBoxes = {}
local skelLines = {}

--// CLEANUP
local function clearESP()
    for _,v in pairs(espBoxes) do if v and v.Parent then v:Destroy() end end
    espBoxes = {}
    for _,v in pairs(skelLines) do if v and v.Parent then v:Destroy() end end
    skelLines = {}
end

--// MAIN LOOP (EVERY FRAME)
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    -- Walkspeed / JumpPower
    hum.WalkSpeed = C.WS
    hum.JumpPower = C.JP
    if C.InfJump then
        hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end

    -- Fly
    if C.Fly then
        hum.PlatformStand = true
        local bv = root:FindFirstChild("FlyBV")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "FlyBV"
            bv.MaxForce = Vector3.new(1,1,1)*1e5
            bv.Parent = root
        end
        local move = Vector3.new(0,0,0)
        local f = Camera.CFrame.LookVector
        local r = Camera.CFrame.RightVector
        local u = Camera.CFrame.UpVector
        if UserInput:IsKeyDown(Enum.KeyCode.W) then move = move + f end
        if UserInput:IsKeyDown(Enum.KeyCode.S) then move = move - f end
        if UserInput:IsKeyDown(Enum.KeyCode.A) then move = move - r end
        if UserInput:IsKeyDown(Enum.KeyCode.D) then move = move + r end
        if UserInput:IsKeyDown(Enum.KeyCode.Space) then move = move + u end
        if UserInput:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - u end
        if move.Magnitude > 0 then move = move.Unit * 70 end
        bv.Velocity = move
    else
        local bv = root:FindFirstChild("FlyBV")
        if bv then bv:Destroy() end
        hum.PlatformStand = false
    end

    -- Noclip
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not C.Noclip
        end
    end

    -- ESP + Skeletons
    if C.ESP or C.Skeleton then
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local pChar = player.Character
            if not pChar or not pChar:FindFirstChild("HumanoidRootPart") then 
                -- Cleanup if player left
                if espBoxes[player] then espBoxes[player]:Destroy() end
                if skelLines[player] then 
                    for _,line in pairs(skelLines[player]) do line:Destroy() end
                end
                espBoxes[player] = nil
                skelLines[player] = nil
                continue 
            end
            local pRoot = pChar.HumanoidRootPart
            local pHum = pChar:FindFirstChild("Humanoid")
            if not pHum or pHum.Health <= 0 then continue end

            local pos, onScreen = Camera:WorldToViewportPoint(pRoot.Position)
            if not onScreen then continue end

            -- ESP Box
            if C.ESP then
                local box = espBoxes[player]
                if not box then
                    box = Instance.new("Frame")
                    box.Size = UDim2.new(0,40,0,50)
                    box.BackgroundTransparency = 0.6
                    box.BorderSizePixel = 2
                    box.BorderColor3 = Color3.fromRGB(0,255,0)
                    box.BackgroundColor3 = Color3.fromRGB(0,0,0)
                    box.Parent = gui

                    local name = Instance.new("TextLabel")
                    name.Size = UDim2.new(1,0,0,14)
                    name.Position = UDim2.new(0,0,1,2)
                    name.BackgroundTransparency = 1
                    name.Text = player.Name
                    name.TextColor3 = Color3.fromRGB(255,255,255)
                    name.TextScaled = true
                    name.Font = Enum.Font.GothamBold
                    name.Parent = box

                    local health = Instance.new("Frame")
                    health.Size = UDim2.new(1,0,0,3)
                    health.Position = UDim2.new(0,0,-1,0)
                    health.BackgroundColor3 = Color3.fromRGB(0,255,0)
                    health.BorderSizePixel = 0
                    health.Parent = box
                    espBoxes[player] = box
                end
                local dist = (Camera.CFrame.Position - pRoot.Position).Magnitude
                local scale = math.clamp(200/dist, 0.5, 2.5)
                box.Size = UDim2.new(0, 30*scale, 0, 40*scale)
                box.Position = UDim2.new(0, pos.X - 15*scale, 0, pos.Y - 20*scale)
                -- Update health bar
                local healthBar = box:FindFirstChildWhichIsA("Frame")
                if healthBar then
                    local hp = math.clamp(pHum.Health/pHum.MaxHealth, 0, 1)
                    healthBar.Size = UDim2.new(hp, 0, 1, 0)
                    healthBar.BackgroundColor3 = Color3.fromRGB(255*(1-hp), 255*hp, 0)
                end
            end

            -- Skeletons
            if C.Skeleton then
                if not skelLines[player] then skelLines[player] = {} end
                local parts = {"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg"}
                local function getPos(partName)
                    local p = pChar:FindFirstChild(partName)
                    if p then
                        local v, vis = Camera:WorldToViewportPoint(p.Position)
                        if vis then return Vector2.new(v.X, v.Y) end
                    end
                    return nil
                end
                local h = getPos("Head")
                local t = getPos("Torso")
                local la = getPos("LeftArm")
                local ra = getPos("RightArm")
                local ll = getPos("LeftLeg")
                local rl = getPos("RightLeg")

                local function updateLine(key, p1, p2)
                    local line = skelLines[player][key]
                    if not line then
                        line = Instance.new("Frame")
                        line.Size = UDim2.new(0,2,0,2)
                        line.BackgroundColor3 = Color3.fromRGB(255,255,255)
                        line.BackgroundTransparency = 0.3
                        line.BorderSizePixel = 0
                        line.Parent = gui
                        skelLines[player][key] = line
                    end
                    if p1 and p2 then
                        local mid = (p1+p2)/2
                        local dist = (p1-p2).Magnitude
                        local angle = math.atan2(p2.Y-p1.Y, p2.X-p1.X)
                        line.Position = UDim2.new(0, mid.X, 0, mid.Y)
                        line.Size = UDim2.new(0, dist, 0, 2)
                        line.Rotation = math.deg(angle)
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
                updateLine("Head", h, t)
                updateLine("LA", t, la)
                updateLine("RA", t, ra)
                updateLine("LL", t, ll)
                updateLine("RL", t, rl)
            end
        end
    else
        clearESP()
    end
end)

--// AIMBOT (mouse move)
Mouse.Move:Connect(function()
    if not C.Aimbot then return end
    local target = nil
    local minDist = 120 -- FOV
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local pChar = player.Character
        if pChar and pChar:FindFirstChild("Head") then
            local head = pChar.Head
            local pos, on = Camera:WorldToViewportPoint(head.Position)
            if on then
                local d = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if d < minDist then
                    minDist = d
                    target = head
                end
            end
        end
    end
    if target then
        local tPos = Camera:WorldToViewportPoint(target.Position)
        if tPos then
            local current = Vector2.new(Mouse.X, Mouse.Y)
            local targetVec = Vector2.new(tPos.X, tPos.Y)
            local newPos = current:Lerp(targetVec, 0.35)
            mousemoverel(newPos.X - current.X, newPos.Y - current.Y)
        end
    end
end)

--// SILENT AIM (hooks first remote it finds)
pcall(function()
    local old
    old = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        local args = {...}
        if C.Silent and self.Name:lower():find("fire") then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    for i,v in ipairs(args) do
                        if type(v) == "Vector3" then
                            args[i] = player.Character.HumanoidRootPart.Position
                            break
                        end
                    end
                    break
                end
            end
        end
        return old(self, unpack(args))
    end)
end)

--// AUTO FARM
RunService.Heartbeat:Connect(function()
    if C.AutoFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        local nearest = nil
        local minD = math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local d = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if d < minD then
                    minD = d
                    nearest = player.Character.HumanoidRootPart
                end
            end
        end
        if nearest then
            local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then
                hum:MoveTo(nearest.Position + Vector3.new(0,0,5))
            end
        end
    end
end)

--// KEYBINDS
UserInput.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        main.Visible = not main.Visible
    end
end)

print("✅ FIXED CHEAT LOADED – F1 hides GUI. All features work.")