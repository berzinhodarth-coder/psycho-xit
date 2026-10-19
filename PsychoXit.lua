
--[[
    PSYCHO XIT
    Interface Luau para Roblox
    GitHub: berzinhodarth-coder/psycho-xit
    Compatibilidade: depende das APIs disponíveis no ambiente
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = Players.LocalPlayer
if not player then
    warn("[Psycho Xit] Jogador local indisponível.")
    return
end

local playerGui = player:WaitForChild("PlayerGui", 15)
if not playerGui then
    warn("[Psycho Xit] PlayerGui não encontrado.")
    return
end

-- Remover uma versão anterior da interface
local oldGui = playerGui:FindFirstChild("PsychoXit")
if oldGui then
    oldGui:Destroy()
end

-- Paleta visual
local C = {
    bg = Color3.fromRGB(8, 14, 27),
    panel = Color3.fromRGB(16, 27, 46),
    item = Color3.fromRGB(23, 39, 63),
    blue = Color3.fromRGB(20, 132, 255),
    blueDark = Color3.fromRGB(16, 65, 110),
    text = Color3.fromRGB(238, 245, 255),
    muted = Color3.fromRGB(145, 169, 201),
    green = Color3.fromRGB(48, 210, 140),
    red = Color3.fromRGB(255, 92, 105),
}

local function make(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function addCorner(object, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius),
    }, object)
end

-- Janela principal
local gui = make("ScreenGui", {
    Name = "PsychoXit",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    DisplayOrder = 100,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(500, 355),
    Position = UDim2.new(0.5, -250, 0.5, -177),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)
addCorner(main, 12)

make("UIStroke", {
    Color = C.blue,
    Thickness = 1.5,
    Transparency = 0.15,
}, main)

-- Cabeçalho
local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
addCorner(header, 12)

make("TextLabel", {
    Position = UDim2.fromOffset(18, 7),
    Size = UDim2.new(1, -75, 0, 27),
    BackgroundTransparency = 1,
    Text = "PSYCHO XIT",
    TextColor3 = C.blue,
    Font = Enum.Font.GothamBold,
    TextSize = 23,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

make("TextLabel", {
    Position = UDim2.fromOffset(19, 34),
    Size = UDim2.new(1, -80, 0, 16),
    BackgroundTransparency = 1,
    Text = "BLOCKSPIN  /  FARM HUB",
    TextColor3 = C.muted,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local closeButton = make("TextButton", {
    Name = "Close",
    Position = UDim2.new(1, -43, 0, 12),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = C.item,
    Text = "×",
    TextColor3 = C.text,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
}, header)
addCorner(closeButton, 8)

-- Barra lateral
local sidebar = make("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(12, 70),
    Size = UDim2.new(0, 130, 1, -82),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
addCorner(sidebar, 9)

-- Área de conteúdo
local content = make("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(153, 70),
    Size = UDim2.new(1, -165, 1, -82),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, main)
addCorner(content, 9)

local pageTitle = make("TextLabel", {
    Position = UDim2.fromOffset(14, 10),
    Size = UDim2.new(1, -28, 0, 28),
    BackgroundTransparency = 1,
    Text = "Dashboard",
    TextColor3 = C.text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local status = make("TextLabel", {
    Position = UDim2.fromOffset(14, 40),
    Size = UDim2.new(1, -28, 0, 22),
    BackgroundTransparency = 1,
    Text = "Psycho Xit carregado",
    TextColor3 = C.green,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, content)

local body = make("ScrollingFrame", {
    Name = "Options",
    Position = UDim2.fromOffset(10, 70),
    Size = UDim2.new(1, -20, 1, -80),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.blue,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, body)

make("UIPadding", {
    PaddingBottom = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 4),
}, body)

-- Páginas e controles visuais
local pages = {
    Dashboard = {
        "Auto Fishing",
        "Auto Deposit",
        "Auto Job",
    },
    Fishing = {
        "Auto Cast",
        "Auto Reel",
        "Auto Bait",
    },
    Jobs = {
        "Steak House",
        "Shelf Stocker",
        "Janitor",
        "Farming",
    },
    ATM = {
        "Auto Deposit",
        "ATM Notifications",
    },
    Settings = {
        "Show Status",
        "Compact Mode",
    },
}

local tabs = {
    "Dashboard",
    "Fishing",
    "Jobs",
    "ATM",
    "Settings",
}

local enabled = {}
local tabButtons = {}
local optionButtons = {}
local currentPage = "Dashboard"

local function setStatus(message, color)
    status.Text = message
    status.TextColor3 = color or C.muted
end

local function updateOption(option)
    local isOn = enabled[option] == true
    local button = optionButtons[option]

    if button then
        button.BackgroundColor3 = isOn and C.blueDark or C.item

        local indicator = button:FindFirstChild("Indicator")
        if indicator then
            indicator.Text = isOn and "ON" or "OFF"
            indicator.TextColor3 = isOn and C.green or C.muted
        end
    end
end

local function renderPage(pageName)
    if not pages[pageName] then
        return
    end

    currentPage = pageName
    pageTitle.Text = pageName
    setStatus("Controles visuais — " .. pageName)

    for _, child in ipairs(body:GetChildren()) do
        if child:IsA("GuiObject") and child.Name == "OptionButton" then
            child:Destroy()
        end
    end

    optionButtons = {}

    for index, option in ipairs(pages[pageName]) do
        local button = make("TextButton", {
            Name = "OptionButton",
            Size = UDim2.new(1, -2, 0, 36),
            BackgroundColor3 = C.item,
            Text = "",
            LayoutOrder = index,
            AutoButtonColor = true,
        }, body)
        addCorner(button, 7)

        make("TextLabel", {
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -70, 1, 0),
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = C.text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, button)

        local indicator = make("TextLabel", {
            Name = "Indicator",
            Position = UDim2.new(1, -49, 0, 0),
            Size = UDim2.fromOffset(42, 36),
            BackgroundTransparency = 1,
            Text = enabled[option] and "ON" or "OFF",
            TextColor3 = enabled[option] and C.green or C.muted,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Center,
        }, button)

        optionButtons[option] = button
        updateOption(option)

        button.Activated:Connect(function()
            enabled[option] = not enabled[option]
            updateOption(option)

            setStatus(
                option .. (enabled[option] and ": ON" or ": OFF"),
                enabled[option] and C.green or C.muted
            )

            -- Os botões são visuais.
            -- Nenhuma automação do jogo está conectada aqui.
        end)
    end
end

-- Navegação
for index, tabName in ipairs(tabs) do
    local tab = make("TextButton", {
        Name = tabName .. "Tab",
        Position = UDim2.fromOffset(8, 9 + (index - 1) * 43),
        Size = UDim2.new(1, -16, 0, 36),
        BackgroundColor3 = C.item,
        Text = tabName,
        TextColor3 = C.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 11,
        AutoButtonColor = true,
        LayoutOrder = index,
    }, sidebar)
    addCorner(tab, 7)

    tabButtons[tabName] = tab

    tab.Activated:Connect(function()
        for name, button in pairs(tabButtons) do
            button.BackgroundColor3 =
                name == tabName and C.blueDark or C.item
        end

        renderPage(tabName)
    end)
end

-- Arrastar a janela pelo cabeçalho
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Fechar e inicializar
closeButton.Activated:Connect(function()
    gui:Destroy()
end)

for name, button in pairs(tabButtons) do
    button.BackgroundColor3 = name == "Dashboard" and C.blueDark or C.item
end

renderPage("Dashboard")
print("[Psycho Xit] Interface inicializada.")
