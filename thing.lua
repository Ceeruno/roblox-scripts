if script.ClassName == "Script" then
  local STEPS = 20 * 5
--local STUDS_PER_STEP = 1
local TIME_PER_STEP = 1 / 20
local PROJECTILE = Instance.new("Seat")
PROJECTILE.Anchored = true
PROJECTILE.Size = Vector3.new(1, 1, 1)

local Tool = Instance.new("Tool", game.Players.Misinformater.Backpack)
local Event = Instance.new("RemoteEvent", Tool)
Event.Name = "MouseEvent"
local Handle = Instance.new("Part", Tool)
Handle.Size = Vector3.new(1, 1, 1)
Handle.Name = "Handle"

Event.OnServerEvent:Connect(function(STUDS_PER_STEP, x, y, z)
	local Target = Vector3.new(x, y, z)
	print(typeof(Target))
	local projectile = PROJECTILE:Clone()
	projectile.Position = Handle.Position
	projectile.Parent = workspace
	projectile.Touched:Connect(function(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		if humanoid then
			--humanoid.Sit = true
			--task.wait(1)
			--humanoid.Jump = true
		end
	end)
	local direction = (Handle.Position - Target).Unit
	print(typeof(direction))
	for step = 1, STEPS, 1 do
		projectile.Position += direction * STUDS_PER_STEP
		task.wait(TIME_PER_STEP)
	end
	projectile:Destroy()
end)
  elseif script.ClassName == "LocalScript" then
  local Tool = owner.Backpack.Tool

local MouseEvent = Tool.MouseEvent

local Now = 0

Tool.Activated:Connect(function()
	Now = tick()
end)

Tool.Deactivated:Connect(function()
	local charge = tick() - Now
	print(charge)
	local position = game.Players.Misinformater:GetMouse().Hit.p
	MouseEvent:FireServer(charge, position.X, position.Y, position.Z)
end)
  end
