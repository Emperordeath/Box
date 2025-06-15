--[[
  ██████╗ ███████╗ █████╗ ████████╗██╗  ██╗████████╗███████╗ █████╗ ███╗   ███╗
  ██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║  ██║╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
  ██║  ██║█████╗  ███████║   ██║   ███████║   ██║   █████╗  ███████║██╔████╔██║
  ██║  ██║██╔══╝  ██╔══██║   ██║   ██╔══██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║
  ██████╔╝███████╗██║  ██║   ██║   ██║  ██║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
  ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
  DeathTeam Hitbox Expander | By: IamEmperorDeath
]]

-- ==================== CONFIGURAÇÃO INICIAL ====================
local LocalPlayer = game:GetService("Players").LocalPlayer
local AllowedUsers = {
    8433408926,  -- Usuário 1
    8589764157,  -- Usuário 2
    8622229549,  -- Usuário 3
    2664466417,  -- Usuário 4
    7262974919   -- Usuário 5
}

-- Verificação de permissão
if not table.find(AllowedUsers, LocalPlayer.UserId) then
    LocalPlayer:Kick("🔒 Acesso Negado | DeathTeam | By: IamEmperorDeath")
    return
end

-- ==================== INTERFACE RAYFIELD ====================
local Rayfield = loadstring(game:HttpGet('https://sirius.com/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "DeathTeam | Hitbox Expander",
    LoadingTitle = "DeathTeam Loading...",
    LoadingSubtitle = "By: IamEmperorDeath",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeathTeamConfigs",
        FileName = "HitboxSettings"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false
})

-- Notificação de boas-vindas
Rayfield:Notify({
    Title = "DeathTeam Iniciado",
    Content = "Bem-vindo! Script carregado com sucesso.\nBy: IamEmperorDeath",
    Duration = 6.5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "OK",
            Callback = function() end
        }
    }
})

-- ==================== ABA INÍCIO ====================
local HomeTab = Window:CreateTab("Início", 4483362457)
HomeTab:CreateSection("🔰 Sobre o Script")
HomeTab:CreateLabel("Criado por: IamEmperorDeath")
HomeTab:CreateLabel("Versão: 3.0 | DeathTeam Edition")
HomeTab:CreateLabel("Atualizações frequentes!")
HomeTab:CreateSection("⚠️ Avisos Importantes")
HomeTab:CreateLabel("⚠️ Risco de detecção em alguns jogos")
HomeTab:CreateLabel("⚠️ Use por sua conta e risco")
HomeTab:CreateLabel("🛡️ Sistema de bypass em desenvolvimento")

-- ==================== ABA SCRIPTS ====================
local ScriptsTab = Window:CreateTab("Scripts", 4483362458)

-- Variáveis
local HitboxSize = 10
local EnableHitbox = false
local PullPlayers = false
local LimitDistance = false
local TargetSpecific = false
local TargetPlayer = nil
local OriginalSizes = {}
local AffectedPlayers = 0
local AffectedLabel = ScriptsTab:CreateLabel("Jogadores Afetados: 0")

-- Função de reset
local function ResetHitboxes()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and OriginalSizes[player.Name] then
            for partName, originalSize in pairs(OriginalSizes[player.Name]) do
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
    OriginalSizes = {}
    AffectedPlayers = 0
    AffectedLabel:Set("Jogadores Afetados: " .. AffectedPlayers)
end

-- Controles
ScriptsTab:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {2, 130},
    Increment = 1,
    Suffix = "x",
    CurrentValue = HitboxSize,
    Callback = function(value)
        HitboxSize = value
    end
})

-- Sistema de seleção de jogadores
local function GetPlayerList()
    local list = {"Todos"}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(list, player.Name)
        end
    end
    return list
end

local PlayerDropdown = ScriptsTab:CreateDropdown({
    Name = "Selecionar Jogador Alvo",
    Options = GetPlayerList(),
    CurrentOption = "Todos",
    Callback = function(option)
        TargetSpecific = (option ~= "Todos")
        TargetPlayer = (TargetSpecific and option) or nil
    end
})

-- Atualização dinâmica
game.Players.PlayerAdded:Connect(function()
    PlayerDropdown:Refresh(GetPlayerList(), true)
end)

game.Players.PlayerRemoving:Connect(function()
    PlayerDropdown:Refresh(GetPlayerList(), true)
end)

-- Toggle principal
ScriptsTab:CreateToggle({
    Name = "Ativar Hitbox Expandida",
    CurrentValue = false,
    Callback = function(value)
        EnableHitbox = value
        if EnableHitbox then
            coroutine.wrap(function()
                while EnableHitbox do
                    local count = 0
                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if (not TargetSpecific or player.Name == TargetPlayer) and
                           player ~= LocalPlayer and player.Character then
                            for _, partName in ipairs({"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}) do
                                local part = player.Character:FindFirstChild(partName)
                                if part and part:IsA("BasePart") then
                                    if not OriginalSizes[player.Name] then OriginalSizes[player.Name] = {} end
                                    if not OriginalSizes[player.Name][partName] then
                                        OriginalSizes[player.Name][partName] = part.Size
                                    end
                                    
                                    part.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                                    part.Transparency = 0.9
                                    part.Material = Enum.Material.ForceField
                                    part.CanCollide = false
                                    count = count + 1
                                end
                            end
                        end
                    end
                    AffectedPlayers = math.floor(count / 4)
                    AffectedLabel:Set("Jogadores Afetados: " .. AffectedPlayers)
                    task.wait(0.5)
                end
                ResetHitboxes()
            end)()
        else
            ResetHitboxes()
        end
    end
})

-- Funções extras
ScriptsTab:CreateToggle({
    Name = "Limitar a 800 Studs",
    CurrentValue = false,
    Callback = function(value)
        LimitDistance = value
    end
})

ScriptsTab:CreateSection("Controle de Jogadores")

ScriptsTab:CreateToggle({
    Name = "Puxar Jogadores pra Frente",
    CurrentValue = false,
    Callback = function(value)
        PullPlayers = value
        if PullPlayers then
            coroutine.wrap(function()
                while PullPlayers do
                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if (not TargetSpecific or player.Name == TargetPlayer) and
                           player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
                           LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            player.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)
                        end
                    end
                    task.wait(0.2)
                end
            end)()
        end
    end
})

ScriptsTab:CreateButton({
    Name = "Ativar Fly Hack",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Emperordeath/Add.fly/main/Add.fly.lua'))()
        Rayfield:Notify({
            Title = "Fly Ativado",
            Content = "Fly hack carregado com sucesso!\nBy: IamEmperorDeath",
            Duration = 5,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "OK",
                    Callback = function() end
                }
            }
        })
    end
})

-- ==================== ABA TEAM ====================
local TeamTab = Window:CreateTab("Hitbox (Team)", 4483362460)
local EnemyHitboxSize = 10
local EnableEnemyHitbox = false
local EnemyAffectedLabel = TeamTab:CreateLabel("Inimigos Afetados: 0")

-- Função para verificar inimigos
local function IsEnemy(player)
    if LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    else
        return player ~= LocalPlayer
    end
end

TeamTab:CreateToggle({
    Name = "Ativar Hitbox para Inimigos",
    CurrentValue = false,
    Callback = function(value)
        EnableEnemyHitbox = value
        -- Implementação similar à hitbox normal
    end
})

-- ==================== ABA OWNERS ====================
local OwnersTab = Window:CreateTab("Owners", 4483362458)
OwnersTab:CreateSection("Acesso Exclusivo")
OwnersTab:CreateInput({
    Name = "Insira a Chave",
    PlaceholderText = "Chave: C2",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        if input == "C2" then
            Rayfield:Notify({
                Title = "ACESSO CONCEDIDO",
                Content = "Script exclusivo liberado!",
                Duration = 5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "OK",
                        Callback = function() end
                    }
                }
            })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"))()
        else
            Rayfield:Notify({
                Title = "CHAVE INCORRETA",
                Content = "Tente novamente!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})

-- ==================== ABA AJUDA ====================
local HelpTab = Window:CreateTab("Ajuda", 4483362459)
HelpTab:CreateSection("📌 Instruções")
HelpTab:CreateLabel("1. Ajuste o tamanho da hitbox no slider")
HelpTab:CreateLabel("2. Selecione 'Todos' ou um jogador específico")
HelpTab:CreateLabel("3. Ative/Desative com o toggle principal")
HelpTab:CreateButton({
    Name = "Ver Código Fonte",
    Callback = function()
        setclipboard("https://github.com/Emperordeath/DeathTeam-Hitbox")
        Rayfield:Notify({
            Title = "Link Copiado!",
            Content = "URL do GitHub copiada para sua área de transferência.",
            Duration = 5
        })
    end
})

-- ==================== FIM DO SCRIPT ====================
Rayfield:Notify({
    Title = "DeathTeam Pronto",
    Content = "Todas as funções foram carregadas!\nBy: IamEmperorDeath",
    Duration = 6,
    Image = 4483362458
})
