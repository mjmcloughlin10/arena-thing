local label = script.Parent
local rstorage = game:GetService("ReplicatedStorage")
local wave_number = rstorage:WaitForChild("Wave Number")
label.Text = "Next Wave: "..wave_number.Value
wave_number.Changed:Connect(function(value)
	label.Text = "Next Wave: "..wave_number.Value
end)