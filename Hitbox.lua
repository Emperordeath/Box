-- Verifica os usuÃ¡rios alvos
local LocalPlayer = game.Players.LocalPlayer
local allowedUsers = {8433408926, 8589764157, 8622229549} -- IDs dos usuÃ¡rios que NÃƒO serÃ£o kickados (vocÃª e o outro usuÃ¡rio)

if not table.find(allowedUsers, LocalPlayer.UserId) then
   LocalPlayer:Kick("Estamos em manutenção By: DeathTeam")
   return -- Para a execuÃ§Ã£o do script
end

-- Carrega o Rayfield
local _q9w3z = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- CriaÃ§Ã£o da janela principal
local _x2k7m = _q9w3z:CreateWindow({
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

-- Home Tab
local _h4j8p = _x2k7m:CreateTab("InÃ­cio", 4483362457)
_h4j8p:CreateSection("Sobre o Script")
_h4j8p:CreateLabel("Criado por: Deathbringer ðŸ‡®ðŸ‡¹")
_h4j8p:CreateLabel("Este script serÃ¡ atualizado frequentemente!")
_h4j8p:CreateLabel("Fique atento Ã s novas funÃ§Ãµes e melhorias.")

_h4j8p:CreateSection("âš ï¸ Avisos Importantes")
_h4j8p:CreateLabel("âš ï¸ Muitos jogos podem detectar alteraÃ§Ãµes de hitbox.")
_h4j8p:CreateLabel("âš ï¸ Existe risco de expulsÃ£o ou banimento.")
_h4j8p:CreateLabel("âš™ï¸ Um sistema de bypass estÃ¡ em desenvolvimento e serÃ¡ adicionado em futuras atualizaÃ§Ãµes.")

-- Scripts Tab
local _t5r1v = _x2k7m:CreateTab("Scripts", 4483362458)
_t5r1v:CreateSection("ConfiguraÃ§Ãµes de Hitbox")

local _z8n4b = 10
local _p6m2y = false
local _k3f7w = false
local _j9d5q = false
local _g2t8x = false
local _r4c1l = nil
local _m7v3s = {}
local _y1b9p = game.Players.LocalPlayer
local _e5h6u = 0

local _n3q2j = _t5r1v:CreateLabel("Jogadores Afetados: 0")

local function _u4i8k()
   for _, _pl in ipairs(game.Players:GetPlayers()) do
      if _pl ~= _y1b9p and _pl.Character and _m7v3s[_pl.Name] then
         for _pn, _os in pairs(_m7v3s[_pl.Name]) do
            local _pt = _pl.Character:FindFirstChild(_pn)
            if _pt and _pt:IsA("BasePart") then
               _pt.Size = _os
               _pt.Transparency = 0
               _pt.Material = Enum.Material.Plastic
               _pt.CanCollide = true
            end
         end
      end
   end
   _m7v3s = {}
   _e5h6u = 0
   _n3q2j:Set("Jogadores Afetados: " .. _e5h6u)
end

_t5r1v:CreateSlider({
   Name = "Tamanho da Hitbox",
   Range = {2, 130},
   Increment = 1,
   Suffix = "x",
   CurrentValue = _z8n4b,
   Callback = function(_val)
      _z8n4b = _val
   end,
})

local function _f2l9r()
   local _pnl = {"Todos"}
   for _, _pl in ipairs(game.Players:GetPlayers()) do
      if _pl ~= _y1b9p then
         table.insert(_pnl, _pl.Name)
      end
   end
   return _pnl
end

local _w6x3m
task.spawn(function()
   while not _w6x3m do
      _w6x3m = _t5r1v:CreateDropdown({
         Name = "Selecionar Jogador Alvo",
         Options = _f2l9r(),
         CurrentOption = "Todos",
         Callback = function(_opt)
            if _opt == "Todos" then
               _g2t8x = false
               _r4c1l = nil
            else
               _g2t8x = true
               _r4c1l = _opt
            end
         end,
      })
      wait(1)
   end
end)

task.spawn(function()
   while task.wait(5) do
      if _w6x3m then
         _w6x3m:Refresh(_f2l9r(), true)
      end
   end
end)

game.Players.PlayerAdded:Connect(function()
   if _w6x3m then
      _w6x3m:Refresh(_f2l9r(), true)
   end
end)

game.Players.PlayerRemoving:Connect(function()
   if _w6x3m then
      _w6x3m:Refresh(_f2l9r(), true)
   end
end)

_t5r1v:CreateToggle({
   Name = "Ativar Hitbox Expandida",
   CurrentValue = false,
   Callback = function(_val)
      _p6m2y = _val
      if _p6m2y then
         task.spawn(function()
            while _p6m2y do
               local _cnt = 0
               for _, _pl in ipairs(game.Players:GetPlayers()) do
                  if (not _g2t8x or (_g2t8x and _pl.Name == _r4c1l)) and
                     _pl ~= _y1b9p and _pl.Character and _pl.Character:FindFirstChild("Humanoid") then
                     local _rt = _pl.Character:FindFirstChild("HumanoidRootPart")
                     local _mrt = _y1b9p.Character and _y1b9p.Character:FindFirstChild("HumanoidRootPart")
                     if _rt and _mrt then
                        local _dst = (_rt.Position - _mrt.Position).Magnitude
                        if not _j9d5q or _dst <= 800 then
                           local _pts = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
                           for _, _pn in ipairs(_pts) do
                              local _pt = _pl.Character:FindFirstChild(_pn)
                              if _pt and _pt:IsA("BasePart") then
                                 if not _m7v3s[_pl.Name] then
                                    _m7v3s[_pl.Name] = {}
                                 end
                                 if not _m7v3s[_pl.Name][_pn] then
                                    _m7v3s[_pl.Name][_pn] = _pt.Size
                                 end
                                 _pt.Size = Vector3.new(_z8n4b, _z8n4b, _z8n4b)
                                 _pt.Transparency = 0.90
                                 _pt.Material = Enum.Material.ForceField
                                 _pt.CanCollide = false
                                 _cnt = _cnt + 1
                              end
                           end
                        else
                           if _m7v3s[_pl.Name] then
                              for _pn, _os in pairs(_m7v3s[_pl.Name]) do
                                 local _pt = _pl.Character:FindFirstChild(_pn)
                                 if _pt and _pt:IsA("BasePart") then
                                    _pt.Size = _os
                                    _pt.Transparency = 0
                                    _pt.Material = Enum.Material.Plastic
                                    _pt.CanCollide = true
                                 end
                              end
                              _m7v3s[_pl.Name] = nil
                           end
                        end
                     end
                  end
               end
               _e5h6u = math.floor(_cnt / 4)
               _n3q2j:Set("Jogadores Afetados: " .. _e5h6u)
               task.wait(1)
            end
         end)
      else
         _u4i8k()
      end
   end,
})

_t5r1v:CreateToggle({
   Name = "Limitar Hitbox a 800 Studs",
   CurrentValue = false,
   Callback = function(_val)
      _j9d5q = _val
   end,
})

_t5r1v:CreateSection("Controle de Jogadores")

_t5r1v:CreateToggle({
   Name = "Puxar Jogadores pra Frente",
   CurrentValue = false,
   Callback = function(_val)
      _k3f7w = _val
      if _k3f7w then
         task.spawn(function()
            while _k3f7w do
               for _, _pl in ipairs(game.Players:GetPlayers()) do
                  if (not _g2t8x or (_g2t8x and _pl.Name == _r4c1l)) and
                     _pl ~= _y1b9p and _pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart") and
                     _y1b9p.Character and _y1b9p.Character:FindFirstChild("HumanoidRootPart") then
                     _pl.Character.HumanoidRootPart.CFrame = _y1b9p.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)
                  end
               end
               task.wait(0.2)
            end
         end)
      end
   end,
})

-- Novo botÃ£o para ativar o Fly
_t5r1v:CreateButton({
   Name = "Ativar Fly",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/Emperordeath/Add.fly/refs/heads/main/Add.fly.lua'))()
         _q9w3z:Notify({
            Title = "Fly Ativado",
            Content = "O script de Fly foi executado com sucesso!",
            Duration = 5,
            Image = 4483362458,
            Actions = {
               Ignore = {
                  Name = "OK",
                  Callback = function()
                     -- AÃ§Ã£o opcional ao clicar em "OK"
                  end
               }
            }
         })
      end)
   end,
})

-- BotÃ£o para "Quer ver o cÃ³digo novamente?"
_t5r1v:CreateButton({
   Name = "Quer ver o cÃ³digo novamente?",
   Callback = function()
      _q9w3z:Notify({
         Title = "CÃ³digo do Script",
         Content = "O cÃ³digo-fonte estÃ¡ disponÃ­vel em: https://raw.githubusercontent.com/Emperordeath/Box/refs/heads/main/Hitbox.lua. Abra no seu navegador para visualizar!",
         Duration = 10,
         Image = 4483362458,
         Actions = {
            Ignore = {
               Name = "OK",
               Callback = function()
                  -- AÃ§Ã£o opcional ao clicar em "OK"
               end
            }
         }
      })
   end,
})

-- Team Tab
local _b8v2n = _x2k7m:CreateTab("Hitbox (Team)", 4483362460)
_b8v2n:CreateSection("ConfiguraÃ§Ãµes de Hitbox por Time")

local _c6t4y = 10
local _d3m9j = false
local _f7p1q = false
local _l2s5x = {}
local _r8h6k = 0

local _v4n3w = _b8v2n:CreateLabel("Inimigos Afetados: 0")

local function _i5k9z(_pl)
   if game:GetService("Players").LocalPlayer.Team then
      return _pl.Team ~= game:GetService("Players").LocalPlayer.Team
   else
      return _pl ~= _y1b9p
   end
end

local function _o7g2r()
   for _, _pl in ipairs(game.Players:GetPlayers()) do
      if _pl ~= _y1b9p and _pl.Character and _l2s5x[_pl.Name] then
         for _pn, _os in pairs(_l2s5x[_pl.Name]) do
            local _pt = _pl.Character:FindFirstChild(_pn)
            if _pt and _pt:IsA("BasePart") then
               _pt.Size = _os
               _pt.Transparency = 0
               _pt.Material = Enum.Material.Plastic
               _pt.CanCollide = true
            end
         end
      end
   end
   _l2s5x = {}
   _r8h6k = 0
   _v4n3w:Set("Inimigos Afetados: " .. _r8h6k)
end

_b8v2n:CreateSlider({
   Name = "Tamanho da Hitbox (Inimigos)",
   Range = {2, 130},
   Increment = 1,
   Suffix = "x",
   CurrentValue = _c6t4y,
   Callback = function(_val)
      _c6t4y = _val
   end,
})

_b8v2n:CreateToggle({
   Name = "Ativar Hitbox Expandida (Apenas Inimigos)",
   CurrentValue = false,
   Callback = function(_val)
      _d3m9j = _val
      if _d3m9j then
         task.spawn(function()
            while _d3m9j do
               local _cnt = 0
               for _, _pl in ipairs(game.Players:GetPlayers()) do
                  if _i5k9z(_pl) and _pl.Character and _pl.Character:FindFirstChild("Humanoid") then
                     local _rt = _pl.Character:FindFirstChild("HumanoidRootPart")
                     local _mrt = _y1b9p.Character and _y1b9p.Character:FindFirstChild("HumanoidRootPart")
                     if _rt and _mrt then
                        local _dst = (_rt.Position - _mrt.Position).Magnitude
                        if not _j9d5q or _dst <= 800 then
                           local _pts = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
                           for _, _pn in ipairs(_pts) do
                              local _pt = _pl.Character:FindFirstChild(_pn)
                              if _pt and _pt:IsA("BasePart") then
                                 if not _l2s5x[_pl.Name] then
                                    _l2s5x[_pl.Name] = {}
                                 end
                                 if not _l2s5x[_pl.Name][_pn] then
                                    _l2s5x[_pl.Name][_pn] = _pt.Size
                                 end
                                 _pt.Size = Vector3.new(_c6t4y, _c6t4y, _c6t4y)
                                 _pt.Transparency = 0.90
                                 _pt.Material = Enum.Material.ForceField
                                 _pt.CanCollide = false
                                 _cnt = _cnt + 1
                              end
                           end
                        else
                           if _l2s5x[_pl.Name] then
                              for _pn, _os in pairs(_l2s5x[_pl.Name]) do
                                 local _pt = _pl.Character:FindFirstChild(_pn)
                                 if _pt and _pt:IsA("BasePart") then
                                    _pt.Size = _os
                                    _pt.Transparency = 0
                                    _pt.Material = Enum.Material.Plastic
                                    _pt.CanCollide = true
                                 end
                              end
                              _l2s5x[_pl.Name] = nil
                           end
                        end
                     end
                  end
               end
               _r8h6k = math.floor(_cnt / 4)
               _v4n3w:Set("Inimigos Afetados: " .. _r8h6k)
               task.wait(1)
            end
         end)
      else
         _o7g2r()
      end
   end,
})

_b8v2n:CreateSection("Controle de Inimigos")

_b8v2n:CreateToggle({
   Name = "Puxar Inimigos pra Frente",
   CurrentValue = false,
   Callback = function(_val)
      _f7p1q = _val
      if _f7p1q then
         task.spawn(function()
            while _f7p1q do
               for _, _pl in ipairs(game.Players:GetPlayers()) do
                  if _i5k9z(_pl) and _pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart") and
                     _y1b9p.Character and _y1b9p.Character:FindFirstChild("HumanoidRootPart") then
                     _pl.Character.HumanoidRootPart.CFrame = _y1b9p.Character.HumanoidRootPart.CFrame * CFrame.new(3, 0, -5)
                  end
               end
               task.wait(0.2)
            end
         end)
      end
   end,
})

-- Explanation Tab
local _a3e9t = _x2k7m:CreateTab("ExplicaÃ§Ã£o das FunÃ§Ãµes", 4483362459)
_a3e9t:CreateSection("DescriÃ§Ã£o das FunÃ§Ãµes")
_a3e9t:CreateLabel("Este script adiciona vÃ¡rias funcionalidades para manipular a hitbox dos jogadores e interagir com eles:")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Tamanho da Hitbox:")
_a3e9t:CreateLabel("Ajusta o tamanho das hitboxes dos jogadores. Pode ser configurado entre 2x e 130x de tamanho.")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Ativar Hitbox Expandida:")
_a3e9t:CreateLabel("Ao ativar, as hitboxes dos jogadores ficam maiores, facilitando os acertos.")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Selecionar Jogador Alvo:")
_a3e9t:CreateLabel("Permite escolher um jogador especÃ­fico para aplicar a hitbox expandida. Atualiza automaticamente quando jogadores entram/saem.")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Hitbox (Team):")
_a3e9t:CreateLabel("Modo que afeta apenas jogadores inimigos, ignorando membros do seu time. Inclui opÃ§Ã£o para puxar apenas inimigos.")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Limitar Hitbox a 800 Studs:")
_a3e9t:CreateLabel("SÃ³ expande a hitbox de jogadores que estejam a atÃ© 800 studs de distÃ¢ncia.")
_a3e9t:CreateLabel("")
_a3e9t:CreateLabel("Puxar Jogadores pra Frente:")
_a3e9t:CreateLabel("Puxa jogadores inimigos para perto de vocÃª, facilitando o ataque.")
