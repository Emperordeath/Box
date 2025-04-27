local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Death Hub | Hitbox",
    LoadingTitle = "Death Hub",
    LoadingSubtitle = "By IamEmperorDeath",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeathHubConfigs",
        FileName = "HitboxConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
})

local Tab = Window:CreateTab("Hitbox", 4483362458)

local hitboxSize = 10
local hitboxAtivo = false
local originalSizes = {}
local localPlayer = game.Players.LocalPlayer

local function resetHitboxes()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and originalSizes[player.Name] then
            for partName, originalSize in pairs(originalSizes[player.Name]) do
                local part = player.Character:FindFirstChild(partName)
                if part and part:IsA("BasePart") then
                    part.Size = originalSize
                    part.Transparency = 0
                    part.Material = Enum.Material.Plastic
                    part.CanCollide = true
                end
            end
        end
    end
    originalSizes = {}
end

Tab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {2, 50},
    Increment = 1,
    Suffix = "x",
    CurrentValue = hitboxSize,
    Callback = function(Value)
        hitboxSize = Value
    end,
})

Tab:CreateToggle({
    Name = "Ativar Hitbox Expandida",
    CurrentValue = false,
    Callback = function(Value)
        hitboxAtivo = Value

        if hitboxAtivo then
            Rayfield:Notify({
                Title = "Hitbox Ativada",
                Content = "Inimigos com hitbox gigante",
                Duration = 3
            })

            task.spawn(function()
                while hitboxAtivo do
                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                            local parts = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
                            for _, partName in ipairs(parts) do
                                local part = player.Character:FindFirstChild(partName)
                                if part and part:IsA("BasePart") then
                                    if not originalSizes[player.Name] then
                                        originalSizes[player.Name] = {}
                                    end
                                    if not originalSizes[player.Name][partName] then
                                        originalSizes[player.Name][partName] = part.Size
                                    end
                                    if part.Size ~= Vector3.new(hitboxSize, hitboxSize, hitboxSize) then
                                        part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                    end
                                    part.Transparency = 0.90
                                    part.Material = Enum.Material.ForceField
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Hitbox Desativada",
                Content = "Voltando ao normal...",
                Duration = 3
            })
            resetHitboxes()
        end
    end,
})

-- BOTÃO DE PUXAR TODO MUNDO
Tab:CreateButton({
    Name = "Puxar Todos pra Mim",
    Callback = function()
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local offset = 5 -- Espaçamento entre cada player

        local count = 0
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local enemyHRP = player.Character.HumanoidRootPart

                -- Deixa travado no ar
                enemyHRP.Anchored = true

                -- Organiza eles na frente
                local positionOffset = Vector3.new((count % 5) * offset, 0, math.floor(count / 5) * offset)
                enemyHRP.CFrame = hrp.CFrame * CFrame.new(positionOffset.X, 0, -10 - positionOffset.Z)

                count = count + 1
            end
        end

        Rayfield:Notify({
            Title = "Puxados com Sucesso",
            Content = "Todos reunidos pra execução!",
            Duration = 3
        })
    end,
})
