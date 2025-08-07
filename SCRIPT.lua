local RS = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local lp = players.LocalPlayer

-- Modules contenant les données de seeds et gears
local seeds = require(RS.Data.SeedData)
local gears = require(RS.Data.GearData)

-- Remotes pour acheter
local buySeedRemote = RS.GameEvents.BuySeedStock
local buyGearRemote = RS.GameEvents.BuyGearStock

-- UI des shops
local seedShopUI = lp.PlayerGui:WaitForChild("Seed_Shop").Frame.ScrollingFrame
local gearShopUI = lp.PlayerGui:WaitForChild("Gear_Shop").Frame.ScrollingFrame

-- Fonction pour acheter disponibles
local function buyAllSeatedItems(requireData, shopUI, remoteInvoke)
    for name, _ in pairs(requireData) do
        for _, itemFrame in ipairs(shopUI:GetChildren()) do
            if itemFrame.Name == name then
                local stockText = itemFrame:FindFirstChild("Main_Frame")
                    and itemFrame.Main_Frame:FindFirstChild("Stock_Text")
                if stockText then
                    local count = tonumber(stockText.Text:match("X(%d+) Stock")) or 0
                    if count > 0 then
                        remoteInvoke:InvokeServer(name)
                        wait(0.1)
                    end
                end
            end
        end
    end
end

-- Appel des fonctions
buyAllSeatedItems(seeds, seedShopUI, buySeedRemote)
buyAllSeatedItems(gears, gearShopUI, buyGearRemote)
