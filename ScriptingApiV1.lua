ScriptingAPI = {}

--// Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

--// Variables
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local Camera = Workspace.CurrentCamera

ScriptingAPI.GetPlayers = function()
    return Players:GetPlayers()
end

ScriptingAPI.GetClient = function()
    return Client
end

ScriptingAPI.GetTool = function()
    return Client.Character:FindFirstChildWhichIsA("Tool")
end

ScriptingAPI.GetMousePosition = function()
    return UserInputService:GetMouseLocation()
end

ScriptingAPI.Difference = function(First, Second)
    return (First - Second)
end

ScriptingAPI.Notify = function(Title2, Text2, Duration2)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = Title2,
        Text = Text2,
        Duration = Duration2
    })
end

ScriptingAPI.GetClosestPlayerToMouse = function(UseFOV, Radius)
    local Target
    local Closest = UseFOV and Radius or math.huge

    for Index, Player in pairs(Players:GetPlayers()) do
        if Player ~= Client and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            PartPos, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
            Magnitude = (Vector2.new(PartPos.X, PartPos.Y) - UserInputService:GetMouseLocation()).Magnitude

            if Magnitude < Closest and OnScreen then
                Target = Player
                Closest = Magnitude
            end
        end
    end
    return Target
end

return ScriptingAPI
