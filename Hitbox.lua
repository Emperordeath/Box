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
local Tab = Window:CreateTab("Hitbox", 4483362458)

Tab:CreateSection("Configurações de Hitbox")

local hitboxSize = 10
local hitboxAtivo = false
local puxarJogadores = false
local limitarDistancia = false
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
task.spawn(function()
while hitboxAtivo do
local count = 0
for _, player in ipairs(game.Players:GetPlayers()) do
if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
local root = player.Character:FindFirstChild("HumanoidRootPart")
local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if root and myRoot then
local distance = (root.Position - myRoot.Position).Magnitude
if not limitarDistancia or distance <= 4000 then
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
Name = "Limitar Hitbox a 4000 Studs",
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
if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
player.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)
end
end
task.wait(0.2)
end
end)
end
end,
})

-- Terceira Aba: Explicação das Funções
local ExplanationTab = Window:CreateTab("Explicação das Funções", 4483362459)

ExplanationTab:CreateSection("Descrição das Funções")

ExplanationTab:CreateLabel("Este script adiciona várias funcionalidades para manipular a hitbox dos jogadores e interagir com eles:")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Tamanho da Hitbox:")
ExplanationTab:CreateLabel("Ajusta o tamanho das hitboxes dos jogadores. Pode ser configurado entre 2x e 50x de tamanho.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Ativar Hitbox Expandida:")
ExplanationTab:CreateLabel("Ao ativar, as hitboxes dos jogadores ficam maiores, facilitando os acertos.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Limitar Hitbox a 4000 Studs:")
ExplanationTab:CreateLabel("Só expande a hitbox de jogadores que estejam a até 4000 studs de distância.")

ExplanationTab:CreateLabel("")

ExplanationTab:CreateLabel("Puxar Jogadores pra Frente:")
ExplanationTab:CreateLabel("Puxa jogadores inimigos para perto de você, facilitando o ataque.")
