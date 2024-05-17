--[[Services]]
local Players = Game:GetService("Players")

--[[Instances]]
local Player = Players.Misinformater
local Mouse = Player:GetMouse()
local Tool = Player.Backpack.Tool
local Handle = Tool.Handle
local RemoteEvent = Tool.RemoteEvent

--[[Events]]
Tool.Activated:Connect(function()
		RemoteEvent:FireServer(Handle.Position, Mouse.Hit.Position)
end)
