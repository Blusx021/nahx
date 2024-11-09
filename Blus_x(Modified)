loadstring([[
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local activeTornado = false
local activeCluster = false
local Forces = {}

-- Função para exibir uma mensagem azul
local function showMessage(text)
    local screenGui = Instance.new("ScreenGui")
    local textLabel = Instance.new("TextLabel")

    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    textLabel.Parent = screenGui
    textLabel.Text = text
    textLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
    textLabel.Position = UDim2.new(0.35, 0, 0.9, 0)
    textLabel.TextColor3 = Color3.fromRGB(0, 102, 255)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextScaled = true

    task.delay(2, function()
        screenGui:Destroy()
    end)
end

-- Função para mover e agrupar os objetos ao redor da direção da mira (efeito de aglomerado)
local function moveAroundLookDirection()
    local updatedForces = {}
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false and not part:IsDescendantOf(player.Character) then
            local existingForces = part:FindFirstChildWhichIsA("BodyPosition")
            if existingForces then
                existingForces:Destroy()
            end

            local forceInstance = Instance.new("BodyPosition")
            forceInstance.Parent = part
            forceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            forceInstance.D = 1000
            forceInstance.P = 10000
            table.insert(updatedForces, forceInstance)
        end
    end
    Forces = updatedForces

    local distance = 30
    local centerOffset = Vector3.new(0, 10, 0)
    local rotationAngle = 0
    local rotationSpeed = 0.05

    RunService.Heartbeat:Connect(function()
        if activeCluster then
            local cameraPosition = camera.CFrame.Position
            local lookVector = camera.CFrame.LookVector
            local targetPosition = cameraPosition + lookVector * distance

            local angleOffset = 0
            for _, forceInstance in pairs(Forces) do
                local offset = Vector3.new(
                    math.cos(rotationAngle + angleOffset) * 5,
                    math.sin(rotationAngle + angleOffset) * 5,
                    math.sin(rotationAngle + angleOffset) * 5
                )

                forceInstance.Position = targetPosition + centerOffset + offset
                angleOffset = angleOffset + math.pi / 6
            end
        end
    end)
end

-- Função para mover e girar os objetos ao redor da direção da mira (efeito tornado)
local function moveAroundLookDirectionTornado()
    local updatedForces = {}
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false and not part:IsDescendantOf(player.Character) then
            local existingForces = part:FindFirstChildWhichIsA("BodyPosition")
            if existingForces then
                existingForces:Destroy()
            end

            local forceInstance = Instance.new("BodyPosition")
            forceInstance.Parent = part
            forceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            forceInstance.D = 1000
            forceInstance.P = 10000
            table.insert(updatedForces, forceInstance)
        end
    end
    Forces = updatedForces

    local rotationAngle = 0
    local rotationSpeed = 0.05
    local distance = 50
    local separationAngle = math.pi / 8

    RunService.Heartbeat:Connect(function()
        if activeTornado then
            local cameraPosition = camera.CFrame.Position
            local lookVector = camera.CFrame.LookVector
            local targetPosition = cameraPosition + lookVector * distance

            rotationAngle = rotationAngle + rotationSpeed
            local angleOffset = 0
            for _, forceInstance in pairs(Forces) do
                local offset = Vector3.new(
                    math.cos(rotationAngle + angleOffset) * distance,
                    math.sin(rotationAngle + angleOffset) * 10,
                    math.sin(rotationAngle + angleOffset) * distance
                )

                forceInstance.Position = targetPosition + offset
                angleOffset = angleOffset + separationAngle
            end
        end
    end)
end

-- Função para ativar/desativar o efeito de aglomerado com a tecla 'V'
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.V then
        if not activeTornado then  -- Impede que o aglomerado e o tornado sejam ativados ao mesmo tempo
            activeCluster = not activeCluster
            if activeCluster then
                showMessage("Aglomerado ativado")
                moveAroundLookDirection()
            else
                showMessage("Aglomerado desativado")
                for _, forceInstance in pairs(Forces) do
                    if forceInstance.Parent then
                        forceInstance:Destroy()
                    end
                end
                Forces = {}
            end
        end
    end
end)

-- Função para ativar/desativar o efeito tornado com a tecla 'X'
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if not isProcessed and input.KeyCode == Enum.KeyCode.X then
        if not activeCluster then  -- Impede que o aglomerado e o tornado sejam ativados ao mesmo tempo
            activeTornado = not activeTornado
            if activeTornado then
                showMessage("Tornado ativado")
                moveAroundLookDirectionTornado()
            else
                showMessage("Tornado desativado")
                for _, forceInstance in pairs(Forces) do
                    if forceInstance.Parent then
                        forceInstance:Destroy()
                    end
                end
                Forces = {}
            end
        end
    end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP%20(Modified).lua"))()
]])()
