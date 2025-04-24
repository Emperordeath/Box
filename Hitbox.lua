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

Tab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {2, 30},
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
                        if player ~= game.Players.LocalPlayer and player.Character then
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
                                    part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                    part.Transparency = 0.6
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

            for _, player in ipairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and originalSizes[player.Name] then
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
            originalSizes = {} -- limpa geral depois de restaurar
        end
    end,
})
