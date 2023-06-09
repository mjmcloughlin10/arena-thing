local rstorage = game:GetService("ReplicatedStorage")
local enemies = {
	["zombie"] = rstorage:WaitForChild("Drooling Zombie"),
	["spider"] = rstorage:WaitForChild("Enemy Spider"),
	["knight"] = rstorage:WaitForChild("NPC")
}
local arena = workspace:WaitForChild("Arena")

local pos, size = arena:GetBoundingBox()
local width = size.X
local height = size.Y
local depth = size.Z

function spawn_enemy(enemy)
	local clone = enemy:Clone()
	local x = math.random(-width/2, width/2)
	local y = math.random(-height/2, height/2)
	local z = math.random(-depth/2, depth/2)
	
	clone:PivotTo(pos + Vector3.new(x,y,z))
	clone.Parent = workspace
end

local waves = {
	{
		{"zombie", 10},
	},
	{
		{"spider", 4},
		{"zombie", 6},
	},	
	{
		{"knight", 100},
		{"spider", 8},
		{"zombie", 200}
	}
}

local start_wave = rstorage:WaitForChild("Start Wave")
local wave_number = rstorage:WaitForChild("Wave Number")
local enemies_left = rstorage:WaitForChild("Enemies Left")

function do_wave(x)
	enemies_left.Value = 0
	for i, item in pairs(waves[wave_number.Value]) do
		local name = item[1]
		local count = item[2]
		while count > 0 do
			spawn_enemy(enemies[name])
			enemies_left.Value = enemies_left.Value + 1
			wait(0.1)
			count = count - 1
		end
	end
	wave_number.Value = wave_number.Value + 1
end

start_wave.OnServerEvent:Connect(do_wave)
workspace.ChildRemoved:Connect(function(child)
	print(child)
	if child.Name == "Drooling Zombie" or 
		child.Name == "Enemy Spider" or
		child.Name == "NPC" then
		enemies_left.Value = enemies_left.Value - 1
	end
end)