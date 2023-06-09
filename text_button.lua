local button = script.Parent
local menu = button.Parent

local rstorage = game:GetService("ReplicatedStorage")
local start_wave = rstorage:WaitForChild("Start Wave")

button.Activated:Connect(function(x,y)
	start_wave:FireServer()
end)