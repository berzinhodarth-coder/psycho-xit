
-- language: Luau
-- file: PsychoXit.client.lua
-- Roblox Studio / LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui_parent = player:WaitForChild("PlayerGui")

local existing = gui_parent:FindFirstChild("PsychoXit")
if existing then existing:Destroy() end

local C = {
    bg = Color3.fromRGB(8, 14, 27),
    panel = Color3.fromRGB(16, 27, 46),
    item = Color3.fromRGB(23, 39, 63),
    blue = Color3.fromRGB(20, 132, 255),
    text = Color3.fromRGB(238, 245, 255),
    muted = Color3.fromRGB(145, 169, 201),
    green = Color3.fromRGB(48, 210, 140),
}

local gui = Instance.new("ScreenGui")
gui.Name = "PsychoXit"
gui.ResetOnSpawn = false
gui.Parent = gui_parent

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local main = make("Frame", {
    Size = UDim2.fromOffset(500, 355),
    Position = UDim2.new(0.5, -250, 0.5, -177),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
}, gui)
corner(main, 12)

make("UIStroke", {
    Color = C.blue,
    Thickness = 1.5,
    Transparency = 0.15,
}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
corner(header, 12)

make("TextLabel", {
    Position = UDim2.fromOffset(18, 8),
    Size = UDim2.new(1, -70, 0, 25),
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

local close = make("TextButton", {
    Position = UDim2.new(1, -43, 0, 12),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = C.item,
    Text = "×",
    TextColor3 = C.text,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
}, header)
corner(close, 8)
close.Activated:Connect(function() gui:Destroy() end)

local sidebar = make("Frame", {
    Position = UDim2.fromOffset(12, 70),
    Size = UDim2.new(0, 130, 1, -82),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
corner(sidebar, 9)

local content = make("Frame", {
    Position = UDim2.fromOffset(153, 70),
    Size = UDim2.new(1, -165, 1, -82),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
corner(content, 9)

local page_title = make("TextLabel", {
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
    Text = "Interface carregada",
    TextColor3 = C.green,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local body = make("Frame", {
    Position = UDim2.fromOffset(10, 70),
    Size = UDim2.new(1, -20, 1, -80),
    BackgroundTransparency = 1,
}, content)

local page_data = {
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

local enabled = {}
local active_page = "Dashboard"

local function render_page(name)
    active_page = name
    page_title.Text = name
    status.Text = "Selecione uma opção"
    status.TextColor3 = C.muted

    for _, child in ipairs(body:GetChildren()) do
        child:Destroy()
    end

    local layout = make("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, body)

    for index, option in ipairs(page_data[name]) do
        local button = make("TextButton", {
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundColor3 = C.item,
            Text = "",
            LayoutOrder = index,
            AutoButtonColor = true,
        }, body)
        corner(button, 7)

        make("TextLabel", {
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -65, 1, 0),
            BackgroundTransparency = 1,
            Text = option,
            TextColor3 = C.text,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, button)

        local function update()
            local on = enabled[option] == true
            button.BackgroundColor3 = on
                and Color3.fromRGB(16, 65, 110)
                or C.item
        end

        button.Activated:Connect(function()
            enabled[option] = not enabled[option]
            update()
            status.Text = option .. (
                enabled[option] and ": ON" or ": OFF"
            )
            status.TextColor3 = enabled[option]
                and C.green or C.muted
        end)

        update()
    end
end

local tabs = {"Dashboard", "Fishing", "Jobs", "ATM", "Settings"}

for index, name in ipairs(tabs) do
    local tab = make("TextButton", {
        Position = UDim2.fromOffset(8, 9 + (index - 1) * 43),
        Size = UDim2.new(1, -16, 0, 36),
        BackgroundColor3 = C.item,
        Text = name,
        TextColor3 = C.text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 11,
    }, sidebar)
    corner(tab, 7)

    tab.Activated:Connect(function()
        render_page(name)
    end)
end

render_page("Dashboard")
