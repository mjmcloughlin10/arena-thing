local menu = script.Parent
local rstorage = game:GetService("ReplicatedStorage")
local enemies_left = rstorage:WaitForChild("Enemies Left")
menu.Enabled = (enemies_left.Value <= 0)
enemies_left.Changed:Connect(function(value)
	menu.Enabled = (enemies_left.Value <= 0)
end)