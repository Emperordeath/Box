local _sLuErFe = loadstring(game:HttpGet(('https://sirius.menu/rayfield'), true))()
local _FWDnwi = _sLuErFe:CreateWindow({
    Name = string.reverse("xobtiH | buH htaeD"),
    LoadingTitle = string.reverse("buH htaeD"),
    LoadingSubtitle = string.reverse("htaeDrorepmEmaI|regnirBhtaeD :yB"),
    ConfigurationSaving = {
        Enabled = true,
        FolderName = string.reverse("sgifnoCbuHhtaeD"),
        FileName = string.reverse("gifnoCxobtiH")
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
})

local _BZoGHa = _FWDnwi:CreateTab(string.reverse("oínicnI"), 4483362457)
_BZoGHa:CreateSection("Sobre o Script")
_BZoGHa:CreateLabel("Criado por: Deathbringer 🇮🇹")
_BZoGHa:CreateLabel("Este script será atualizado frequentemente!")
_BZoGHa:CreateLabel("Fique atento às novas funções e melhorias.")

_BZoGHa:CreateSection("⚠️ Avisos Importantes")
_BZoGHa:CreateLabel("⚠️ Muitos jogos podem detectar alterações de hitbox.")
_BZoGHa:CreateLabel("⚠️ Existe risco de expulsão ou banimento.")
_BZoGHa:CreateLabel("⚙️ Um sistema de bypass está em desenvolvimento e será adicionado em futuras atualizações.")

local _MAUIee = _FWDnwi:CreateTab(string.reverse("stpircS"), 4483362458)
_MAUIee:CreateSection("Configurações de Hitbox")

local _A1, _A2, _A3, _A4, _A5, _A6 = 10, false, false, false, {}, game.Players.LocalPlayer
local _A7 = 0
local _Lbl = _MAUIee:CreateLabel("Jogadores Afetados: 0")

local function _XFRKZp()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= _A6 and p.Character and _A5[p.Name] then
            for part, sz in pairs(_A5[p.Name]) do
                local prt = p.Character:FindFirstChild(part)
                if prt and prt:IsA("BasePart") then
                    prt.Size, prt.Transparency, prt.Material, prt.CanCollide = sz, 0, Enum.Material.Plastic, true
                end
            end
        end
    end
    _A5, _A7 = {}, 0
    _Lbl:Set("Jogadores Afetados: ".._A7)
end

_MAUIee:CreateSlider({
    Name = "Tamanho da Hitbox",
    Range = {2, 130},
    Increment = 1,
    Suffix = "x",
    CurrentValue = _A1,
    Callback = function(v) _A1 = v end
})

_MAUIee:CreateToggle({
    Name = "Ativar Hitbox Expandida",
    CurrentValue = false,
    Callback = function(state)
        _A2 = state
        if _A2 then
            task.spawn(function()
                while _A2 do
                    local _count = 0
                    for _, plr in ipairs(game.Players:GetPlayers()) do
                        if plr ~= _A6 and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                            local root = plr.Character:FindFirstChild("HumanoidRootPart")
                            local myRoot = _A6.Character and _A6.Character:FindFirstChild("HumanoidRootPart")
                            if root and myRoot then
                                local dist = (root.Position - myRoot.Position).Magnitude
                                if not _A4 or dist <= 800 then
                                    for _, pn in ipairs({"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}) do
                                        local pt = plr.Character:FindFirstChild(pn)
                                        if pt and pt:IsA("BasePart") then
                                            _A5[plr.Name] = _A5[plr.Name] or {}
                                            _A5[plr.Name][pn] = _A5[plr.Name][pn] or pt.Size
                                            pt.Size = Vector3.new(_A1, _A1, _A1)
                                            pt.Transparency = 0.9
                                            pt.Material = Enum.Material.ForceField
                                            pt.CanCollide = false
                                            _count += 1
                                        end
                                    end
                                else
                                    if _A5[plr.Name] then
                                        for _p, _sz in pairs(_A5[plr.Name]) do
                                            local _pp = plr.Character:FindFirstChild(_p)
                                            if _pp and _pp:IsA("BasePart") then
                                                _pp.Size, _pp.Transparency, _pp.Material, _pp.CanCollide = _sz, 0, Enum.Material.Plastic, true
                                            end
                                        end
                                        _A5[plr.Name] = nil
                                    end
                                end
                            end
                        end
                    end
                    _A7 = math.floor(_count / 4)
                    _Lbl:Set("Jogadores Afetados: ".._A7)
                    task.wait(1)
                end
            end)
        else
            _XFRKZp()
        end
    end
})

_MAUIee:CreateToggle({
    Name = "Limitar Hitbox a 800 Studs",
    CurrentValue = false,
    Callback = function(v) _A4 = v end
})

_MAUIee:CreateSection("Controle de Jogadores")

_MAUIee:CreateToggle({
    Name = "Puxar Jogadores pra Frente",
    CurrentValue = false,
    Callback = function(v)
        _A3 = v
        if _A3 then
            task.spawn(function()
                while _A3 do
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= _A6 and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and _A6.Character and _A6.Character:FindFirstChild("HumanoidRootPart") then
                            p.Character.HumanoidRootPart.CFrame = _A6.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end
})

local _eexZ = _FWDnwi:CreateTab(string.reverse("sõnçuF saõçacilpxE"), 4483362459)

_eexZ:CreateSection("Descrição das Funções")
_eexZ:CreateLabel("Este script adiciona várias funcionalidades para manipular a hitbox dos jogadores e interagir com eles:")
_eexZ:CreateLabel("")
_eexZ:CreateLabel("Tamanho da Hitbox:")
_eexZ:CreateLabel("Ajusta o tamanho das hitboxes dos jogadores. Pode ser configurado entre 2x e 130x de tamanho.")
_eexZ:CreateLabel("")
_eexZ:CreateLabel("Ativar Hitbox Expandida:")
_eexZ:CreateLabel("Ao ativar, as hitboxes dos jogadores ficam maiores, facilitando os acertos.")
_eexZ:CreateLabel("")
_eexZ:CreateLabel("Limitar Hitbox a 800 Studs:")
_eexZ:CreateLabel("Só expande a hitbox de jogadores que estejam a até 800 studs de distância.")
_eexZ:CreateLabel("")
_eexZ:CreateLabel("Puxar Jogadores pra Frente:")
_eexZ:CreateLabel("Puxa jogadores inimigos para perto de você, facilitando o ataque.")
