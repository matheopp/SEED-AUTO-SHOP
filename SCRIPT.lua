local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local shopService = ReplicatedStorage:WaitForChild("ShopService")
local seedShop = shopService:WaitForChild("SeedShop")
local buySeedsEvent = shopService:WaitForChild("BuySeedEvent")

for _, seed in ipairs(seedShop:GetChildren()) do
    if seed:IsA("Folder") or seed:IsA("ModuleScript") then continue end
    local seedName = seed.Name
    buySeedsEvent:FireServer(seedName)
    wait(0.1)
end
