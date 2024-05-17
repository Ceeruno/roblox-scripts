--[[Constants]]
local STEPS = 20
local STUDS_PER_STEP = 2
local TIME_PER_STEP = 1 / 8

-- [[Services]]
local Players = game:GetService("Players")

--[[Instances]]
local Player
local Projectile = Instance.new("Part")
Projectile.Size = Vector3.new(1, 1, 1)
Projectile.Anchored = true
Projectile.CanCollide = false
local Tool = Instance.new("Tool")
local Handle = Instance.new("Part")
Handle.Name = "Handle"
Handle.Size = Vector3.new(1, 1, 1)
Handle.Parent = Tool
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Parent = Tool

--[[Events]]
Player.Chatted:Connect(function(text)
		local splitText = text:split(' ')

		if splitText[1] == '.SPS' then
			STUDS_PER_SECOND = tonumber(splitText[2])
		elseif splitText[1] == '.S' then
			STEPS = tonumber(splitText[2])
		elseif splitText[1] == 'TPS' then
			TIME_PER_STEP = tonumber(splitText[2])
		end
end)

RemoteEvent.OnServerEvent:Connect(function(caller, origin, target)
        local direction = (target - origin).Unit
        
        local projectile = Projectile:Clone()
        projectile.Position = origin
        projectile.Parent = workspace
        
        projectile.Touched:Connect(function(hit)
                local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
                
                if humanoid and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(hit.Parent) then
                    humanoid.Health -= 10

                    projectile:Destroy()

                    return
                end
        end)
        
        for step = 1, STEPS, 1 do
            projectile.Position += direction * STUDS_PER_STEP
            
            task.wait(TIME_PER_STEP)
        end
        projectile:Destroy()
        
        return
end)

Handle.Position = Vector3.new(0, 10, 0)
Tool.Equipped:Connect(function()
	Player = Players:GetPlayerFromCharacter(Tool.Parent)
end)
Tool.Parent = workspace
