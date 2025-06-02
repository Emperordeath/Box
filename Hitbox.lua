local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
Name = "Death Hub | Hitbox",
LoadingTitle = "Death Hub",
LoadingSubtitle = "By: DeathBringer|IamEmperorDeath",
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

-- Primeira Aba: Home / Informações
local HomeTab = Window:CreateTab("Início", 4483362457)

HomeTab:CreateSection("Sobre o Script")

HomeTab:CreateLabel("Criado por: Deathbringer 🇮🇹")
HomeTab:CreateLabel("Este script será atualizado frequentemente!")
HomeTab:CreateLabel("Fique atento às novas funções e melhorias.")

HomeTab:CreateSection("⚠️ Avisos Importantes")

HomeTab:CreateLabel("⚠️ Muitos jogos podem detectar alterações de hitbox.")
HomeTab:CreateLabel("⚠️ Existe risco de expulsão ou banimento.")
HomeTab:CreateLabel("⚙️ Um sistema de bypass está em desenvolvimento e será adicionado em futuras atualizações.")

-- Segunda Aba: Hitbox
local Tab = Window:CreateTab("Scripts", 4483362458)

Tab:CreateSection("Configurações de Hitbox")

local hitboxSize = 10
local hitboxAtivo = false
local puxarJogadores = false
local limitarDistancia = false
local alvoEspecifico = false
local jogadorAlvo = nil
local originalSizes = {}
local localPlayer = game.Players.LocalPlayer
local PlayersAfetados = 0

local PlayersLabel = Tab:CreateLabel("Jogadores Afetados: 0")

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
PlayersAfetados = 0
PlayersLabel:Set("Jogadores Afetados: "..PlayersAfetados)
end

Tab:CreateSlider({
Name = "Tamanho da Hitbox",
Range = {2, 130},
Increment = 1,
Suffix = "x",
CurrentValue = hitboxSize,
Callback = function(Value)
hitboxSize = Value
end,
})

-- Função para obter lista atualizada de jogadores
local function getPlayerList()
local playerNames = {"Todos"}
for _, player in ipairs(game.Players:GetPlayers()) do
if player ~= localPlayer then
table.insert(playerNames, player.Name)
end
end
return playerNames
end

-- Criar dropdown após a janela estar pronta
local Dropdown
task.spawn(function()
while not Dropdown do
Dropdown = Tab:CreateDropdown({
Name = "Selecionar Jogador Alvo",
Options = getPlayerList(),
CurrentOption = "Todos",
Callback = function(Option)
if Option == "Todos" then
alvoEspecifico = false
jogadorAlvo = nil
else
alvoEspecifico = true
jogadorAlvo = Option
end
end,
})
wait(1)
end
end)

-- Atualizar lista de jogadores periodicamente
task.spawn(function()
while task.wait(5) do
if Dropdown then
Dropdown:Refresh(getPlayerList(), true)
end
end
end)

-- Conectar evento para atualizar quando um jogador entrar/sair
game.Players.PlayerAdded:Connect(function()
if Dropdown then
Dropdown:Refresh(getPlayerList(), true)
end
end)

game.Players.PlayerRemoving:Connect(function()
if Dropdown then
Dropdown:Refresh(getPlayerList(), true)
end
end)

Tab:CreateToggle({
Name = "Ativar Hitbox Expandida",
CurrentValue = false,
Callback = function(Value)
hitboxAtivo = Value

if hitboxAtivo then  
        task.spawn(function()  
            while hitboxAtivo do  
                local count = 0  
                for _, player in ipairs(game.Players:GetPlayers()) do  
                    -- Verificar se é para afetar todos ou apenas o alvo específico  
                    if (not alvoEspecifico or (alvoEspecifico and player.Name == jogadorAlvo)) and   
                       player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then  
                          
                        local root = player.Character:FindFirstChild("HumanoidRootPart")  
                        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")  
                        if root and myRoot then  
                            local distance = (root.Position - myRoot.Position).Magnitude  
                            if not limitarDistancia or distance <= 800 then  
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
                                        part.Transparency = 0.90  
                                        part.Material = Enum.Material.ForceField  
                                        part.CanCollide = false  
                                        count = count + 1  
                                    end  
                                end  
                            else  
                                if originalSizes[player.Name] then  
                                    for partName, originalSize in pairs(originalSizes[player.Name]) do  
                                        local part = player.Character:FindFirstChild(partName)  
                                        if part and part:IsA("BasePart") then  
                                            part.Size = originalSize  
                                            part.Transparency = 0  
                                            part.Material = Enum.Material.Plastic  
                                            part.CanCollide = true  
                                        end  
                                    end  
                                    originalSizes[player.Name] = nil  
                                end  
                            end  
                        end  
                    end  
                end  
                PlayersAfetados = math.floor(count/4)  
                PlayersLabel:Set("Jogadores Afetados: "..PlayersAfetados)  
                task.wait(1)  
            end  
        end)  
    else  
        resetHitboxes()  
    end  
end,

})

Tab:CreateToggle({
Name = "Limitar Hitbox a 800 Studs",
CurrentValue = false,
Callback = function(Value)
limitarDistancia = Value
end,
})

Tab:CreateSection("Controle de Jogadores")

Tab:CreateToggle({
Name = "Puxar Jogadores pra Frente",
CurrentValue = false,
Callback = function(Value)
puxarJogadores = Value

if puxarJogadores then  
        task.spawn(function()  
            while puxarJogadores do  
                for _, player in ipairs(game.Players:GetPlayers()) do  
                    if (not alvoEspecifico or (alvoEspecifico and player.Name == jogadorAlvo)) and   
                       player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and   
                       localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then  
                        player.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)  
                    end  
                end  
                task.wait(0.2)  
            end  
        end)  
    end  
end,

})

-- Terceira Aba: Hitbox (Team)
local TeamTab = Window:CreateTab("Hitbox (Team)", 4483362460)

TeamTab:CreateSection("Configurações de Hitbox por Time")

local teamHitboxSize = 10
local teamHitboxAtivo = false
local puxarInimigos = false
local teamOriginalSizes = {}
local teamPlayersAfetados = 0

local TeamPlayersLabel = TeamTab:CreateLabel("Inimigos Afetados: 0")

local function isEnemy(player)
-- Verifica se o jogador é do time inimigo
if game:GetService("Players").LocalPlayer.Team then
return player.Team ~= game:GetService("Players").LocalPlayer.Team
else
-- Se não houver sistema de times, considera todos como inimigos (exceto você)
return player ~= localPlayer
end
end

local function resetTeamHitboxes()
for _, player in ipairs(game.Players:GetPlayers()) do
if player ~= localPlayer and player.Character and teamOriginalSizes[player.Name] then
for partName, originalSize in pairs(teamOriginalSizes[player.Name]) do
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
teamOriginalSizes = {}
teamPlayersAfetados = 0
TeamPlayersLabel:Set("Inimigos Afetados: "..teamPlayersAfetados)
end

TeamTab:CreateSlider({
Name = "Tamanho da Hitbox (Inimigos)",
Range = {2, 130},
Increment = 1,
Suffix = "x",
CurrentValue = teamHitboxSize,
Callback = function(Value)
teamHitboxSize = Value
end,
})

TeamTab:CreateToggle({
Name = "Ativar Hitbox Expandida (Apenas Inimigos)",
CurrentValue = false,
Callback = function(Value)
teamHitboxAtivo = Value

if teamHitboxAtivo then  
        task.spawn(function()  
            while teamHitboxAtivo do  
                local count = 0  
                for _, player in ipairs(game.Players:GetPlayers()) do  
                    if isEnemy(player) and player.Character and player.Character:FindFirstChild("Humanoid") then  
                        local root = player.Character:FindFirstChild("HumanoidRootPart")  
                        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")  
                        if root and myRoot then  
                            local distance = (root.Position - myRoot.Position).Magnitude  
                            if not limitarDistancia or distance <= 800 then  
                                local parts = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}  
                                for _, partName in ipairs(parts) do  
                                    local part = player.Character:FindFirstChild(partName)  
                                    if part and part:IsA("BasePart") then  
                                        if not teamOriginalSizes[player.Name] then  
                                            teamOriginalSizes[player.Name] = {}  
                                        end  
                                        if not teamOriginalSizes[player.Name][partName] then  
                                            teamOriginalSizes[player.Name][partName] = part.Size  
                                        end  
                                        part.Size = Vector3.new(teamHitboxSize, teamHitboxSize, teamHitboxSize)  
                                        part.Transparency = 0.90  
                                        part.Material = Enum.Material.ForceField  
                                        part.CanCollide = false  
                                        count = count + 1  
                                    end  
                                end  
                            else  
                                if teamOriginalSizes[player.Name] then  
                                    for partName, originalSize in pairs(teamOriginalSizes[player.Name]) do  
                                        local part = player.Character:FindFirstChild(partName)  
                                        if part and part:IsA("BasePart") then  
                                            part.Size = originalSize  
                                            part.Transparency = 0  
                                            part.Material = Enum.Material.Plastic  
                                            part.CanCollide = true  
                                        end  
                                    end  
                                    teamOriginalSizes[player.Name] = nil  
                                end  
                            end  
                        end  
                    end  
                end  
                teamPlayersAfetados = math.floor(count/4)  
                TeamPlayersLabel:Set("Inimigos Afetados: "..teamPlayersAfetados)  
                task.wait(1)  
            end  
        end)  
    else  
        resetTeamHitboxes()  
    end  
end,

})

TeamTab:CreateSection("Controle de Inimigos")

TeamTab:CreateToggle({
Name = "Puxar Inimigos pra Frente",
CurrentValue = false,
Callback = function(Value)
puxarInimigos = Value

if puxarInimigos then  
        task.spawn(function()  
            while puxarInimigos do  
                for _, player in ipairs(game.Players:GetPlayers()) do  
                    if isEnemy(player) and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and   
                       localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then  
                        player.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)  
                    end  
                end  
                task.wait(0.2)  
            end  
        end)  
    end  
end,

})

-- Quarta Aba: Explicação das Funções
local ExplanationTab = Window:CreateTab("Explicação das Funções", 4483362459)

ExplanationTab:CreateSection("Descrição das Funções")

ExplanationTab:CreateLabel("Este script adiciona várias funcionalidades para manipular a hitbox dos jogadores e interagir com eles:")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Tamanho da Hitbox:")
ExplanationTab:CreateLabel("Ajusta o tamanho das hitboxes dos jogadores. Pode ser configurado entre 2x e 130x de tamanho.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Ativar Hitbox Expandida:")
ExplanationTab:CreateLabel("Ao ativar, as hitboxes dos jogadores ficam maiores, facilitando os acertos.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Selecionar Jogador Alvo:")
ExplanationTab:CreateLabel("Permite escolher um jogador específico para aplicar a hitbox expandida. Atualiza automaticamente quando jogadores entram/saem.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Hitbox (Team):")
ExplanationTab:CreateLabel("Modo que afeta apenas jogadores inimigos, ignorando membros do seu time. Inclui opção para puxar apenas inimigos.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Limitar Hitbox a 800 Studs:")
ExplanationTab:CreateLabel("Só expande a hitbox de jogadores que estejam a até 800 studs de distância.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Puxar Jogadores pra Frente:")
ExplanationTab:CreateLabel("Puxa jogadores inimigos para perto de você, facilitando o ataque.")
