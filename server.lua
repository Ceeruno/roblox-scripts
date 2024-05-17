--[[Constants]]
local STEPS = 20
local STUDS_PER_STEP = 2
local TIME_PER_STEP = 1 / 8

-- [[Services]]
local Players = game:GetService("Players")

--[[Instances]]
local Player = Players.Misinformater
local Projectile = Instance.new("Part")
Projectile.Size = Vector3.new(1, 1, 1)
Projectile.Anchored = true
Projectile.CanCollide = false
local Tool = Instance.new("Tool")
local Handle = Instance.new("Part")
Handle.Name = "Handle"
Handle.Size = Vector3.new(1, 1, 1)
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Parent = Tool

--[[Events]]
RemoteEvent.OnServerEvent:Connect(function(caller, origin, target)
    local direction = (target - origin).Unit
    
    local projectile = Projectile:Clone()
    projectile.Position = origin
    projectile.Parent = workspace

    projectile.Touched:Connect(function(hit)
        local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")

        if humanoid and humanoid.Health > 0 and not Players:GetPlayerFromCharacter(Hit.Parent) then
          humanoid.Health -= 10
        end
    end)
    
    for step = 1, STEPS, 1 do
      projectile.Position += direction * STUDS_PER_STEP
      
      task.wait(TIME_PER_STEP)
    end
    projectile:Destroy()
end)

Tool.Parent = Player.Backpack
