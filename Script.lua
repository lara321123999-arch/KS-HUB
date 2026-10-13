-- Script Gk Reach - Rayfield UI
-- Criador: Lara
-- Key: Gk01

-- ========== KEY SYSTEM ==========
local KEY_CORRETA = "Gk01"
local keyAceita = false

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "GkKeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.5
bg.Parent = keyGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 220)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local kc = Instance.new("UICorner")
kc.CornerRadius = UDim.new(0, 12)
kc.Parent = keyFrame

local ks = Instance.new("UIStroke")
ks.Color = Color3.fromRGB(255, 255, 255)
ks.Thickness = 2
ks.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 45)
keyTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyTitle.Text = "🔐 Gk Reach - Key"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 16
keyTitle.Parent = keyFrame

local ktc = Instance.new("UICorner")
ktc.CornerRadius = UDim.new(0, 12)
ktc.Parent = keyTitle

local keyInfo = Instance.new("TextLabel")
keyInfo.Size = UDim2.new(1, 0, 0, 25)
keyInfo.Position = UDim2.new(0, 0, 0, 55)
keyInfo.BackgroundTransparency = 1
keyInfo.Text = "Digite a Key para acessar"
keyInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
keyInfo.Font = Enum.Font.Gotham
keyInfo.TextSize = 13
keyInfo.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 40)
keyBox.Position = UDim2.new(0.075, 0, 0, 90)
keyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
keyBox.PlaceholderText = "Digite a Key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.GothamBold
keyBox.TextSize = 14
keyBox.Parent = keyFrame

local kbc = Instance.new("UICorner")
kbc.CornerRadius = UDim.new(0, 8)
kbc.Parent = keyBox

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.85, 0, 0, 40)
keyBtn.Position = UDim2.new(0.075, 0, 0, 145)
keyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
keyBtn.Text = "CONFIRMAR"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.Font = Enum.Font.GothamBlack
keyBtn.TextSize = 14
keyBtn.Parent = keyFrame

local kbc2 = Instance.new("UICorner")
kbc2.CornerRadius = UDim.new(0, 8)
kbc2.Parent = keyBtn

local keyErr = Instance.new("TextLabel")
keyErr.Size = UDim2.new(1, 0, 0, 20)
keyErr.Position = UDim2.new(0, 0, 0, 195)
keyErr.BackgroundTransparency = 1
keyErr.Text = ""
keyErr.TextColor3 = Color3.fromRGB(255, 50, 50)
keyErr.Font = Enum.Font.GothamBold
keyErr.TextSize = 12
keyErr.Parent = keyFrame

local function checarKey()
    if keyBox.Text == KEY_CORRETA then
        keyAceita = true
        keyBtn.Text = "✅ KEY CORRETA!"
        keyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(0.5)
        keyGui:Destroy()
        print("✅ Key correta!")
    else
        keyErr.Text = "❌ Key incorreta!"
        keyBox.Text = ""
    end
end

keyBtn.MouseButton1Click:Connect(checarKey)
keyBox.FocusLost:Connect(function(enter)
    if enter then checarKey() end
end)

repeat task.wait(0.1) until keyAceita

-- ========== RAYFIELD UI ==========
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Gk Reach",
    Icon = 0,
    LoadingTitle = "Gk Reach",
    LoadingSubtitle = "by Lara",
    Theme = "Default",
    ToggleUIKeybind = Enum.KeyCode.RightControl,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "GkReach"
    },
    KeySystem = false
})

-- ========== SERVIÇOS ==========
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

-- ========== CONFIG ==========
local CONFIG = {
    reach = 10,
    showReachSphere = true,
    autoSecondTouch = true,
    scanCooldown = 1.5,
    ballNames = {
        "TPS", "ESA", "MRS", "PRS", "MPS", "SSS", "AIFA", "RBZ",
        "RSF", "VEF", "SAML"
    }
}

local balls = {}
local lastRefresh = 0
local reachSphere
local ballSet = {}

for _, n in ipairs(CONFIG.ballNames) do
    ballSet[n] = true
end

-- ========== FUNÇÕES REACH ==========
local function refreshBalls(force)
    if not force and tick() - lastRefresh < CONFIG.scanCooldown then return end
    lastRefresh = tick()
    table.clear(balls)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and ballSet[v.Name] then
            balls[#balls + 1] = v
        end
    end
end

local function getValidParts(char)
    local parts = {}
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            parts[#parts + 1] = v
        end
    end
    return parts
end

local function updateReachSphere()
    if not CONFIG.showReachSphere then
        if reachSphere then reachSphere:Destroy() end
        reachSphere = nil
        return
    end
    if not reachSphere then
        reachSphere = Instance.new("Part")
        reachSphere.Name = "GkReachSphere"
        reachSphere.Shape = Enum.PartType.Ball
        reachSphere.Anchored = true
        reachSphere.CanCollide = false
        reachSphere.Transparency = 0.8
        reachSphere.Material = Enum.Material.ForceField
        reachSphere.Color = Color3.fromRGB(0, 0, 0)
        reachSphere.Parent = Workspace
        RunService.RenderStepped:Connect(function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                reachSphere.Position = hrp.Position
            end
        end)
    end
    reachSphere.Size = Vector3.new(CONFIG.reach * 2, CONFIG.reach * 2, CONFIG.reach * 2)
end

local function processTouch()
    local char = player.Character
    if not char then return end
    for _, part in ipairs(getValidParts(char)) do
        for _, ball in ipairs(balls) do
            if ball and ball.Parent then
                if (ball.Position - part.Position).Magnitude <= CONFIG.reach then
                    pcall(function()
                        firetouchinterest(ball, part, 0)
                        firetouchinterest(ball, part, 1)
                    end)
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if CONFIG.autoSecondTouch then
        processTouch()
    end
end)

task.spawn(function()
    while true do
        refreshBalls(false)
        task.wait(CONFIG.scanCooldown)
    end
end)

-- ========== ABA REACH ==========
local Tab = Window:CreateTab("Reach", 4483362458)

Tab:CreateSection("Configurações")

Tab:CreateToggle({
    Name = "Ativar Reach",
    CurrentValue = true,
    Flag = "ReachToggle",
    Callback = function(value)
        CONFIG.autoSecondTouch = value
        if value then
            updateReachSphere()
        end
    end
})

Tab:CreateToggle({
    Name = "Mostrar Esfera do Reach",
    CurrentValue = true,
    Flag = "SphereToggle",
    Callback = function(value)
        CONFIG.showReachSphere = value
        updateReachSphere()
    end
})

Tab:CreateSlider({
    Name = "Alcance do Reach",
    Range = {1, 10},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 10,
    Flag = "ReachSlider",
    Callback = function(value)
        CONFIG.reach = value
        updateReachSphere()
    end
})

Tab:CreateSection("Controles Rápidos")

Tab:CreateButton({
    Name = "➖ Diminuir Reach",
    Callback = function()
        CONFIG.reach = math.max(1, CONFIG.reach - 1)
        updateReachSphere()
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Reach: " .. CONFIG.reach,
            Duration = 2,
            Image = 4483362458
        })
    end
})

Tab:CreateButton({
    Name = "➕ Aumentar Reach",
    Callback = function()
        CONFIG.reach = math.min(10, CONFIG.reach + 1)
        updateReachSphere()
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Reach: " .. CONFIG.reach,
            Duration = 2,
            Image = 4483362458
        })
    end
})

-- ========== ABA SKYBOX (NOVA) ==========
local TabSky = Window:CreateTab("Skybox", 4483362458)
TabSky:CreateSection("🌌 Skyboxes")

local SkyList = {
    "Vaporwave",
    "Neon City",
    "Aurora",
    "Cherry Blossom",
    "Golden Hour",
    "Deep Space",
    "Minecraft Dia",
    "Minecraft Nether",
    "Minecraft End",
    "Minecraft Noite",
    "Minecraft Amanhecer",
    "Minecraft Tormenta",
    "Galaxy",
    "Red Neon",
    "Purple Neon",
    "Ocean",
    "Sunset",
    "Cyber",
    "Normal"
}

-- ========== IDs DAS SKYBOXES ==========
local SkyIDs = {
    ["Vaporwave"] = {
        Bk = "rbxassetid://71038245996193",
        Dn = "rbxassetid://71038245996193",
        Ft = "rbxassetid://71038245996193",
        Lf = "rbxassetid://71038245996193",
        Rt = "rbxassetid://71038245996193",
        Up = "rbxassetid://71038245996193"
    },
    ["Neon City"] = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454299",
        Ft = "rbxassetid://159454299",
        Lf = "rbxassetid://159454299",
        Rt = "rbxassetid://159454299",
        Up = "rbxassetid://159454299"
    },
    ["Aurora"] = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064107",
        Ft = "rbxassetid://12064107",
        Lf = "rbxassetid://12064107",
        Rt = "rbxassetid://12064107",
        Up = "rbxassetid://12064107"
    },
    ["Cherry Blossom"] = {
        Bk = "rbxassetid://570557514",
        Dn = "rbxassetid://570557514",
        Ft = "rbxassetid://570557514",
        Lf = "rbxassetid://570557514",
        Rt = "rbxassetid://570557514",
        Up = "rbxassetid://570557514"
    },
    ["Golden Hour"] = {
        Bk = "rbxassetid://1876545003",
        Dn = "rbxassetid://1876545003",
        Ft = "rbxassetid://1876545003",
        Lf = "rbxassetid://1876545003",
        Rt = "rbxassetid://1876545003",
        Up = "rbxassetid://1876545003"
    },
    ["Deep Space"] = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454299",
        Ft = "rbxassetid://159454299",
        Lf = "rbxassetid://159454299",
        Rt = "rbxassetid://159454299",
        Up = "rbxassetid://159454299"
    },
    ["Minecraft Dia"] = {
        Bk = "rbxassetid://570557514",
        Dn = "rbxassetid://570557514",
        Ft = "rbxassetid://570557514",
        Lf = "rbxassetid://570557514",
        Rt = "rbxassetid://570557514",
        Up = "rbxassetid://570557514"
    },
    ["Minecraft Nether"] = {
        Bk = "rbxassetid://264095257",
        Dn = "rbxassetid://264095257",
        Ft = "rbxassetid://264095257",
        Lf = "rbxassetid://264095257",
        Rt = "rbxassetid://264095257",
        Up = "rbxassetid://264095257"
    },
    ["Minecraft End"] = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064107",
        Ft = "rbxassetid://12064107",
        Lf = "rbxassetid://12064107",
        Rt = "rbxassetid://12064107",
        Up = "rbxassetid://12064107"
    },
    ["Minecraft Noite"] = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064107",
        Ft = "rbxassetid://12064107",
        Lf = "rbxassetid://12064107",
        Rt = "rbxassetid://12064107",
        Up = "rbxassetid://12064107"
    },
    ["Minecraft Amanhecer"] = {
        Bk = "rbxassetid://1876545003",
        Dn = "rbxassetid://1876545003",
        Ft = "rbxassetid://1876545003",
        Lf = "rbxassetid://1876545003",
        Rt = "rbxassetid://1876545003",
        Up = "rbxassetid://1876545003"
    },
    ["Minecraft Tormenta"] = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064107",
        Ft = "rbxassetid://12064107",
        Lf = "rbxassetid://12064107",
        Rt = "rbxassetid://12064107",
        Up = "rbxassetid://12064107"
    },
    ["Galaxy"] = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454299",
        Ft = "rbxassetid://159454299",
        Lf = "rbxassetid://159454299",
        Rt = "rbxassetid://159454299",
        Up = "rbxassetid://159454299"
    },
    ["Red Neon"] = {
        Bk = "rbxassetid://1876545003",
        Dn = "rbxassetid://1876545003",
        Ft = "rbxassetid://1876545003",
        Lf = "rbxassetid://1876545003",
        Rt = "rbxassetid://1876545003",
        Up = "rbxassetid://1876545003"
    },
    ["Purple Neon"] = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454299",
        Ft = "rbxassetid://159454299",
        Lf = "rbxassetid://159454299",
        Rt = "rbxassetid://159454299",
        Up = "rbxassetid://159454299"
    },
    ["Ocean"] = {
        Bk = "rbxassetid://1931125436",
        Dn = "rbxassetid://1931125436",
        Ft = "rbxassetid://1931125436",
        Lf = "rbxassetid://1931125436",
        Rt = "rbxassetid://1931125436",
        Up = "rbxassetid://1931125436"
    },
    ["Sunset"] = {
        Bk = "rbxassetid://1876545003",
        Dn = "rbxassetid://1876545003",
        Ft = "rbxassetid://1876545003",
        Lf = "rbxassetid://1876545003",
        Rt = "rbxassetid://1876545003",
        Up = "rbxassetid://1876545003"
    },
    ["Cyber"] = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454299",
        Ft = "rbxassetid://159454299",
        Lf = "rbxassetid://159454299",
        Rt = "rbxassetid://159454299",
        Up = "rbxassetid://159454299"
    },
}

-- ========== FUNÇÃO APLICAR SKY ==========
local skyOriginal = nil

local function salvarSkyOriginal()
    if skyOriginal then return end
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        skyOriginal = {
            Bk = sky.SkyboxBk, Dn = sky.SkyboxDn, Ft = sky.SkyboxFt,
            Lf = sky.SkyboxLf, Rt = sky.SkyboxRt, Up = sky.SkyboxUp
        }
    end
end

local function SetSky(nome)
    pcall(function()
        salvarSkyOriginal()
        
        if nome == "Normal" then
            local sky = Lighting:FindFirstChildOfClass("Sky")
            if sky then
                if skyOriginal then
                    sky.SkyboxBk = skyOriginal.Bk
                    sky.SkyboxDn = skyOriginal.Dn
                    sky.SkyboxFt = skyOriginal.Ft
                    sky.SkyboxLf = skyOriginal.Lf
                    sky.SkyboxRt = skyOriginal.Rt
                    sky.SkyboxUp = skyOriginal.Up
                else
                    sky.SkyboxBk = ""
                    sky.SkyboxDn = ""
                    sky.SkyboxFt = ""
                    sky.SkyboxLf = ""
                    sky.SkyboxRt = ""
                    sky.SkyboxUp = ""
                end
            end
            return
        end
        
        local ids = SkyIDs[nome]
        if not ids then return end
        
        local sky = Lighting:FindFirstChildOfClass("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        
        sky.SkyboxBk = ids.Bk
        sky.SkyboxDn = ids.Dn
        sky.SkyboxFt = ids.Ft
        sky.SkyboxLf = ids.Lf
        sky.SkyboxRt = ids.Rt
        sky.SkyboxUp = ids.Up
    end)
end

-- ========== BOTÕES DE SKY ==========
for _, nome in ipairs(SkyList) do
    TabSky:CreateButton({
        Name = "🌌 " .. nome,
        Callback = function()
            SetSky(nome)
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "🌌 Sky: " .. nome,
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end

TabSky:CreateSection("Controle")

TabSky:CreateButton({
    Name = "🔄 RESETAR SKY",
    Callback = function()
        SetSky("Normal")
        Rayfield:Notify({
            Title = "Gk Reach",
            Content = "Sky restaurada!",
            Duration = 2,
            Image = 4483362458
        })
    end
})

-- Slider de horário
TabSky:CreateSlider({
    Name = "Horário do Dia",
    Range = {0, 24},
    Increment = 0.5,
    Suffix = "h",
    CurrentValue = 14,
    Flag = "ClockTimeSlider",
    Callback = function(value)
        pcall(function()
            Lighting.ClockTime = value
        end)
    end
})

-- ========== ABA TRAIL PLAYER ==========
local TabTrail = Window:CreateTab("Trail Player", 4483362458)
TabTrail:CreateSection("Player Trail")

local TRAIL_CORES = {
    {Color3.fromRGB(255, 255, 255), "Branco"},
    {Color3.fromRGB(200, 200, 200), "Cinza Claro"},
    {Color3.fromRGB(130, 130, 130), "Cinza"},
    {Color3.fromRGB(30, 30, 30), "Preto"},
    {Color3.fromRGB(255, 50, 50), "Vermelho"},
    {Color3.fromRGB(160, 0, 0), "Vermelho Escuro"},
    {Color3.fromRGB(255, 105, 180), "Rosa"},
    {Color3.fromRGB(220, 20, 60), "Carmesim"},
    {Color3.fromRGB(255, 182, 193), "Rosa Bebê"},
    {Color3.fromRGB(255, 20, 147), "Rosa Choque"},
    {Color3.fromRGB(255, 140, 0), "Laranja Escuro"},
    {Color3.fromRGB(255, 165, 0), "Laranja"},
    {Color3.fromRGB(255, 215, 0), "Dourado"},
    {Color3.fromRGB(255, 255, 0), "Amarelo"},
    {Color3.fromRGB(173, 255, 47), "Verde Neon"},
    {Color3.fromRGB(50, 205, 50), "Verde Limão"},
    {Color3.fromRGB(0, 180, 0), "Verde"},
    {Color3.fromRGB(0, 100, 0), "Verde Escuro"},
    {Color3.fromRGB(0, 255, 127), "Verde Água"},
    {Color3.fromRGB(64, 224, 208), "Turquesa"},
    {Color3.fromRGB(0, 210, 210), "Ciano Claro"},
    {Color3.fromRGB(0, 180, 255), "Ciano"},
    {Color3.fromRGB(30, 100, 255), "Azul"},
    {Color3.fromRGB(0, 0, 180), "Azul Escuro"},
    {Color3.fromRGB(75, 0, 130), "Índigo"},
    {Color3.fromRGB(148, 0, 211), "Roxo"},
    {Color3.fromRGB(200, 0, 200), "Magenta"},
    {Color3.fromRGB(238, 130, 238), "Lavanda"},
    {Color3.fromRGB(139, 69, 19), "Marrom"},
    {Color3.fromRGB(192, 192, 192), "Prata"},
    {Color3.fromRGB(0, 255, 255), "Ciano Neon"},
    {Color3.fromRGB(255, 255, 255), "Branco Neon"},
    {Color3.fromRGB(57, 255, 20), "Verde Elétrico"},
    {Color3.fromRGB(255, 165, 0), "Âmbar"},
}

local playerTrailOn = false
local pTrailColor = Color3.fromRGB(255, 255, 255)
local pAtt0, pAtt1, pTrail = nil, nil, nil

local function buildPlayerTrail()
    local c = player.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if pAtt0 and pAtt0.Parent then pAtt0:Destroy() end
    if pAtt1 and pAtt1.Parent then pAtt1:Destroy() end
    pAtt0 = Instance.new("Attachment", hrp)
    pAtt0.Position = Vector3.new(0, 1, 0)
    pAtt1 = Instance.new("Attachment", hrp)
    pAtt1.Position = Vector3.new(0, -1, 0)
    pTrail = Instance.new("Trail", hrp)
    pTrail.Attachment0 = pAtt0
    pTrail.Attachment1 = pAtt1
    pTrail.Color = ColorSequence.new(pTrailColor)
    pTrail.Lifetime = 0.7
    pTrail.MinLength = 0
    pTrail.FaceCamera = true
    pTrail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
end

local function destroyPlayerTrail()
    if pAtt0 and pAtt0.Parent then pAtt0:Destroy() end
    if pAtt1 and pAtt1.Parent then pAtt1:Destroy() end
    pAtt0, pAtt1, pTrail = nil, nil, nil
end

TabTrail:CreateToggle({
    Name = "✨ Player Trail",
    CurrentValue = false,
    Flag = "PlayerTrailToggle",
    Callback = function(v)
        playerTrailOn = v
        if v then
            buildPlayerTrail()
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "✨ Player Trail ATIVADO!",
                Duration = 2,
                Image = 4483362458
            })
        else
            destroyPlayerTrail()
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "🔴 Player Trail desativado!",
                Duration = 2,
                Image = 4483362458
            })
        end
    end
})

TabTrail:CreateColorPicker({
    Name = "Cor do Trail",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "TrailColor",
    Callback = function(v)
        pTrailColor = v
        if pTrail then
            pTrail.Color = ColorSequence.new(v)
        end
    end
})

player.CharacterAdded:Connect(function()
    if playerTrailOn then
        task.wait(0.5)
        buildPlayerTrail()
    end
end)

-- Cores rápidas
TabTrail:CreateSection("Cores Rápidas")

for _, corData in ipairs(TRAIL_CORES) do
    TabTrail:CreateButton({
        Name = corData[2],
        Callback = function()
            pTrailColor = corData[1]
            if pTrail then
                pTrail.Color = ColorSequence.new(corData[1])
            end
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "Cor: " .. corData[2],
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end
-- ========== ABA CELEBRAÇÃO ==========
local TabCeleb = Window:CreateTab("Celebração", 4483362458)
TabCeleb:CreateSection("🎉 Celebrações (Gamepass)")

local celebs = {
    {"✨ Siiuu", "Sii"},
    {"✨ Siiuu Duplo", "DoubleSii"},
    {"🧘 Calm Down", "Calm"},
    {"🤸 Salto pra Trás", "Backflip"},
    {"🤸 Salto pra Frente", "Frontflip"},
    {"🧘 Meditação", "Meditation"},
    {"📯 Vuvuzela", "Vuvuzela"},
    {"🎪 Malabarismo", "Juggle"},
    {"😴 O Cochilo", "Nap"},
    {"⚽ Bola na Cabeça", "HeadStall"},
}

for _, c in ipairs(celebs) do
    TabCeleb:CreateButton({
        Name = c[1],
        Callback = function()
            pcall(function()
                game:GetService("ReplicatedStorage").Celebration:FireServer(c[2])
            end)
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "✨ " .. c[1] .. " ativada!",
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end
-- ========== FOLLOW BALL + BOTÃO FLUTUANTE ==========
-- Criador: Lara

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game.Workspace

-- NOMES DAS BOLAS DO TCS
local ballSet = {
    ["TPS"] = true, ["ESA"] = true, ["MRS"] = true, ["PRS"] = true,
    ["MPS"] = true, ["SSS"] = true, ["AIFA"] = true, ["RBZ"] = true,
    ["RSF"] = true, ["VEF"] = true, ["SAML"] = true, ["Ball"] = true,
    ["Bola"] = true
}

local followEnabled = false

-- ========== CRIAR GUI ==========
local FloatGui = Instance.new("ScreenGui")
FloatGui.Name = "GkFloatGui"
FloatGui.ResetOnSpawn = false
FloatGui.DisplayOrder = 9999
FloatGui.Parent = player:WaitForChild("PlayerGui")

-- ========== BOTÃO FLUTUANTE ==========
local FloatBtn = Instance.new("TextButton")
FloatBtn.Size = UDim2.new(0, 140, 0, 42)
FloatBtn.Position = UDim2.new(0.83, 0, 0.20, 0)
FloatBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FloatBtn.BackgroundTransparency = 0.1
FloatBtn.Text = "⚽ FOLLOW: OFF"
FloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatBtn.Font = Enum.Font.GothamBlack
FloatBtn.TextSize = 12
FloatBtn.AutoButtonColor = false
FloatBtn.BorderSizePixel = 0
FloatBtn.Parent = FloatGui
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(0, 10)

local FloatStroke = Instance.new("UIStroke", FloatBtn)
FloatStroke.Color = Color3.fromRGB(0, 255, 255)
FloatStroke.Thickness = 1.5
FloatStroke.Transparency = 0.2

-- ========== ARRASTAR ==========
local dragging = false
local dragStart, startPos, dragInput, moved

FloatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        moved = false
        dragStart = input.Position
        startPos = FloatBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then 
                dragging = false 
            end
        end)
    end
end)

FloatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            moved = true
            FloatBtn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end
end)

-- ========== TOGGLE ==========
FloatBtn.MouseButton1Click:Connect(function()
    if not moved then
        followEnabled = not followEnabled
        if followEnabled then
            FloatBtn.Text = "⚽ FOLLOW: ON"
            FloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            FloatStroke.Color = Color3.fromRGB(0, 255, 100)
        else
            FloatBtn.Text = "⚽ FOLLOW: OFF"
            FloatBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            FloatStroke.Color = Color3.fromRGB(0, 255, 255)
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum:Move(Vector3.zero, false) end
        end
    end
end)

-- ========== FUNÇÕES ==========
local function getNearestBall()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local nearest, bestDist = nil, math.huge
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and ballSet[obj.Name] then
            local d = (obj.Position - hrp.Position).Magnitude
            if d < bestDist then
                bestDist = d
                nearest = obj
            end
        end
    end
    return nearest
end

local function isManualMoving()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.MoveDirection.Magnitude > 0.05 then return true end
    return UserInputService:IsKeyDown(Enum.KeyCode.W)
        or UserInputService:IsKeyDown(Enum.KeyCode.A)
        or UserInputService:IsKeyDown(Enum.KeyCode.S)
        or UserInputService:IsKeyDown(Enum.KeyCode.D)
end

-- ========== LOOP ==========
RunService.RenderStepped:Connect(function()
    if not followEnabled then return end
    if isManualMoving() then return end
    
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    
    local ball = getNearestBall()
    if not ball then return end
    
    local delta = ball.Position - hrp.Position
    local dir = Vector3.new(delta.X, 0, delta.Z)
    
    if dir.Magnitude > 1.5 then
        hum:Move(dir.Unit, false)
    else
        hum:Move(Vector3.zero, false)
    end
end)

print("✅ FOLLOW BALL carregado! Botão ⚽ no canto")

-- ========== ABA COR DO CAMPO ==========
local TabCampo = Window:CreateTab("Cor do Campo", 4483362458)
TabCampo:CreateSection("🌱 Escolha uma Cor")

-- ========== VARIÁVEIS ==========
local OriginalGrassParts = {}
local OriginalTerrainGrassColor = nil
local Terrain = Workspace:FindFirstChildOfClass("Terrain")

-- ========== VERIFICAR SE É LINHA BRANCA ==========
local function IsWhiteLine(part)
    if not part or not part:IsA("BasePart") then return false end
    local c = part.Color
    if c.R > 0.85 and c.G > 0.85 and c.B > 0.85 then return true end
    local n = string.lower(part.Name)
    for _, word in ipairs({"line", "linha", "white", "branco", "mark", "marca"}) do
        if string.find(n, word, 1, true) then return true end
    end
    local s = part.Size
    if s.X < 3 or s.Z < 3 then return true end
    return false
end

-- ========== VERIFICAR SE É GRAMA ==========
local function IsGrassPart(part)
    if not part or not part:IsA("BasePart") then return false end
    if IsWhiteLine(part) then return false end
    if part.Size.X < 15 or part.Size.Z < 15 then return false end
    if not part.Anchored then return false end
    if part.Material == Enum.Material.Grass then return true end
    local n = string.lower(part.Name)
    for _, word in ipairs({"grass", "grama", "campo", "field", "pitch", "turf", "ground", "lawn"}) do
        if string.find(n, word, 1, true) then return true end
    end
    local c = part.Color
    return part.Size.X >= 30 and part.Size.Z >= 30 and c.G > c.R * 1.10 and c.G > c.B * 1.10
end

-- ========== APLICAR COR NA GRAMA ==========
local function ApplyGrass(color)
    if Terrain then
        pcall(function()
            if not OriginalTerrainGrassColor then
                OriginalTerrainGrassColor = Terrain:GetMaterialColor(Enum.Material.Grass)
            end
            Terrain:SetMaterialColor(Enum.Material.Grass, color)
        end)
    end
    for _, v in ipairs(Workspace:GetDescendants()) do
        if IsGrassPart(v) then
            if OriginalGrassParts[v] == nil then
                OriginalGrassParts[v] = v.Color
            end
            pcall(function() v.Color = color end)
        end
    end
end

-- ========== RESETAR GRAMA ==========
local function RestoreGrass()
    if Terrain and OriginalTerrainGrassColor then
        pcall(function()
            Terrain:SetMaterialColor(Enum.Material.Grass, OriginalTerrainGrassColor)
        end)
    end
    for part, color in pairs(OriginalGrassParts) do
        if part and part.Parent then
            pcall(function() part.Color = color end)
        end
    end
    OriginalGrassParts = {}
    Rayfield:Notify({
        Title = "Gk Reach",
        Content = "✅ Campo restaurado!",
        Duration = 2,
        Image = 4483362458
    })
end

-- ========== CORES DISPONÍVEIS ==========
local GRASS_PRESETS = {
    {"🔵 Azul", Color3.fromRGB(20, 90, 255)},
    {"💠 Azul Gelo", Color3.fromRGB(70, 190, 255)},
    {"💜 Roxo", Color3.fromRGB(120, 40, 200)},
    {"🟣 Violeta", Color3.fromRGB(170, 60, 255)},
    {"🔴 Vermelho", Color3.fromRGB(210, 35, 35)},
    {"❤️ Crimson", Color3.fromRGB(115, 15, 25)},
    {"🌸 Rosa", Color3.fromRGB(255, 75, 170)},
    {"🟠 Laranja", Color3.fromRGB(255, 120, 25)},
    {"🌟 Dourado", Color3.fromRGB(220, 175, 35)},
    {"⚫ Preto", Color3.fromRGB(20, 20, 20)},
    {"🔷 Ciano", Color3.fromRGB(25, 220, 215)},
    {"🍋 Lime", Color3.fromRGB(120, 255, 25)},
    {"💚 Verde Neon", Color3.fromRGB(0, 255, 70)},
    {"💗 Magenta", Color3.fromRGB(255, 0, 150)},
    {"🌺 Coral", Color3.fromRGB(255, 127, 80)},
    {"🌌 Índigo", Color3.fromRGB(75, 0, 130)},
    {"🟤 Marrom", Color3.fromRGB(139, 69, 19)},
    {"⚙️ Cinza", Color3.fromRGB(128, 128, 128)},
    {"🔘 Cinza Escuro", Color3.fromRGB(60, 60, 60)},
    {"🌈 Arco-Íris", Color3.fromRGB(255, 100, 200)},
}

-- ========== BOTÕES DAS CORES ==========
for _, c in ipairs(GRASS_PRESETS) do
    TabCampo:CreateButton({
        Name = c[1],
        Callback = function()
            ApplyGrass(c[2])
            Rayfield:Notify({
                Title = "Gk Reach",
                Content = "🌱 Cor aplicada: " .. c[1],
                Duration = 2,
                Image = 4483362458
            })
        end
    })
end

-- ========== BOTÃO RESETAR ==========
TabCampo:CreateSection("Controle")

TabCampo:CreateButton({
    Name = "🔄 RESETAR CAMPO",
    Callback = function()
        RestoreGrass()
    end
})
-- ========== INIT ==========
refreshBalls(true)
updateReachSphere()

Rayfield:Notify({
    Title = "Gk Reach",
    Content = "✅ Script carregado!",
    Duration = 3,
    Image = 4483362458
})

print("✅ Gk Reach carregado!")
