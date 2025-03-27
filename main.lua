local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local humanoid = character:FindFirstChildOfClass("Humanoid")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local humanoid = character:WaitForChild("Humanoid")







-- Anti-cheat: Remove all doors and seats (but not car seats) in the prison
for _, obj in ipairs(workspace:GetDescendants()) do
    -- Remove all doors
    if string.find(obj.Name:lower(), "door") then
        obj:Destroy()
    end

    -- Remove all seats that are not part of cars
    if obj:IsA("Seat") and not obj.Parent:FindFirstChild("VehicleSeat") then
        obj:Destroy()
    end
end

-- Prevent fall damage and disable platform stand
humanoid.PlatformStand = true

-- Smooth move function
local function smoothMove(target, speed)
    local startPos = hrp.Position
    local distance = (target - startPos).Magnitude
    local duration = distance / speed
    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
        task.wait()
    end
    hrp.CFrame = CFrame.new(target)
end

-- Pathfinding function
local function pathfindTo(destination)
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentJumpHeight = 7,
        AgentMaxSlope = 45,
    })
    path:ComputeAsync(hrp.Position, destination)

    if path.Status ~= Enum.PathStatus.Success then
        warn("Pathfinding failed. Status: " .. tostring(path.Status))
        return
    end

    local waypoints = path:GetWaypoints()
    for _, waypoint in ipairs(waypoints) do
        local targetPos = waypoint.Position
        smoothMove(targetPos, 100)  -- Default speed is 50
        task.wait(0.1)
    end
end



-- Perform floating movement to target (Camaro)
local function floatToTarget(targetPosition, speed)
    smoothMove(Vector3.new(targetPosition.X, hrp.Position.Y, targetPosition.Z), speed)
    wait(2)  -- Wait after floating
end

-- Move DOWN by a specific distance (drop)
local function moveDown(dropDistance)
    local startPos = hrp.Position
    local targetPos = startPos - Vector3.new(0, dropDistance, 0)
    local dropSpeed = 350 -- studs per second
    local distance = (targetPos - startPos).Magnitude
    local duration = distance / dropSpeed
    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        task.wait()
    end
    hrp.CFrame = CFrame.new(targetPos)
end


-- Monitoring function for player coordinates
local function monitorPlayerCoordinates()
    local allowedDeviation = 5  -- Allow a small deviation (10 studs)
    local lastPosition = hrp.Position

    while true do
        task.wait(1)  -- Check every second

        local currentPosition = hrp.Position
        local deviation = (currentPosition - lastPosition).Magnitude

        if deviation > allowedDeviation then
            -- If player has deviated significantly, reset character
            warn("Player is deviating from expected position. Resetting character...")
            player:LoadCharacter()  -- Reset the player's character
            lastPosition = hrp.Position  -- Reset the position tracking
        end
    end
end

-- Float to coordinates (3197.66, 63.25, -4654.25)
local function floatToSpecificCoords()
    -- Get current position of the player
    local currentPosition = hrp.Position
    -- Set the target coordinates
    local targetPosition = Vector3.new(3197.66, 63.25, -4654.25)

    -- Adjust the target position if it’s not matching exactly (this could be due to player’s current height or Z axis)
    local adjustedTarget = Vector3.new(targetPosition.X, currentPosition.Y, targetPosition.Z)

    -- Perform the float movement using smooth move
    smoothMove(adjustedTarget, 30)  -- Move at speed of 500
end

-- Main function to perform all actions
local function performActions()
    
    
    humanoid.PlatformStand = true

    local upwardDistance = 100
    local upwardSpeed = 350 -- studs per second
    local startPos = hrp.Position
    local targetPos = startPos + Vector3.new(0, upwardDistance, 0)
    local duration = upwardDistance / upwardSpeed
    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        task.wait()
    end
    hrp.CFrame = CFrame.new(targetPos)

    -- Restore normal physics
    humanoid.PlatformStand = false


    -- Step 3: Find helicopter
    
    local speed = 50 -- Movement speed (studs per second)
    local minDistanceToStop = 3 -- Stop early if close enough
    


    

    -- Find the nearest "Heli"
    local function findNearestHeli()
        local nearestHeli = nil
        local minDistance = math.huge
    
        for _, vehicle in pairs(workspace.Vehicles:GetChildren()) do
            -- Check if vehicle name contains "Heli"
            if vehicle.Name:find("Heli") then
                print("Helicopter found:", vehicle.Name)
                local seat = vehicle:FindFirstChild("Seat")
                if seat then
                    local distance = (hrp.Position - seat.Position).Magnitude
    
                    if distance < minDistance then
                        minDistance = distance
                        nearestHeli = vehicle
                    end
                end
            else
                -- Debug: Print non-"Heli" vehicles
                print("Non-helicopter vehicle detected:", vehicle.Name)
            end
        end
    
        return nearestHeli
    end
    


    
    -- Smoothly move player to the target position
    local function smoothMove(target)
        local startPos = hrp.Position
        local distance = (target - startPos).Magnitude

        -- Stop early if already close
        if distance < minDistanceToStop then return end
        
        local duration = distance / speed
        local startTime = tick()
    
        while tick() - startTime < duration do
            local alpha = (tick() - startTime) / duration
            hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
            RunService.Heartbeat:Wait() -- Optimize for smooth movement
        end
    
        hrp.CFrame = CFrame.new(target) -- Final position adjustment
    end
    
    -- Attempt to enter the helicopter up to 3 times
    local function attemptEnterHeli(seat)
        local attempts = 0
        while attempts < 3 do
            for _, v in pairs(CircleAction.Specs) do
                if v.Part and v.Part == seat then
                    print("Attempting to enter the helicopter seat...")
                    v:Callback(true) -- Try entering the helicopter seat
                    attempts = attempts + 1
                    task.wait(1) -- Wait a second before retrying
                    if attempts >= 3 then
                        print("Max attempts reached.")
                        return
                    end
                end
            end
            task.wait(0.5) -- Small delay before trying again
        end
    end
    
    -- Move to the "Heli" and enter it
    local function moveToHeliAndEnter()
        local heli = findNearestHeli()
        
        if heli and heli:FindFirstChild("Seat") then
            local seat = heli.Seat
            local targetPos = seat.Position + Vector3.new(0, 5, 0) -- Hover slightly above seat
    
            print("Gliding towards the helicopter...")
            smoothMove(targetPos)
            task.wait(0.5) -- Small delay before entry
    
            -- Attempt to enter the helicopter up to 3 times
            attemptEnterHeli(seat)
        else
            local PathfindingService = game:GetService("PathfindingService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local hrp = character:WaitForChild("HumanoidRootPart")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local RunService = game:GetService("RunService")
            local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local humanoid = character:WaitForChild("Humanoid")
            
            
            
            
            
            
            
            -- Anti-cheat: Remove all doors and seats (but not car seats) in the prison
            for _, obj in ipairs(workspace:GetDescendants()) do
                -- Remove all doors
                if string.find(obj.Name:lower(), "door") then
                    obj:Destroy()
                end
            
                -- Remove all seats that are not part of cars
                if obj:IsA("Seat") and not obj.Parent:FindFirstChild("VehicleSeat") then
                    obj:Destroy()
                end
            end
            
            -- Prevent fall damage and disable platform stand
            humanoid.PlatformStand = true
            
            -- Smooth move function
            local function smoothMove(target, speed)
                local startPos = hrp.Position
                local distance = (target - startPos).Magnitude
                local duration = distance / speed
                local startTime = tick()
            
                while tick() - startTime < duration do
                    local alpha = (tick() - startTime) / duration
                    hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
                    task.wait()
                end
                hrp.CFrame = CFrame.new(target)
            end
            
            -- Pathfinding function
            local function pathfindTo(destination)
                local path = PathfindingService:CreatePath({
                    AgentRadius = 2,
                    AgentHeight = 5,
                    AgentCanJump = true,
                    AgentJumpHeight = 7,
                    AgentMaxSlope = 45,
                })
                path:ComputeAsync(hrp.Position, destination)
            
                if path.Status ~= Enum.PathStatus.Success then
                    warn("Pathfinding failed. Status: " .. tostring(path.Status))
                    return
                end
            
                local waypoints = path:GetWaypoints()
                for _, waypoint in ipairs(waypoints) do
                    local targetPos = waypoint.Position
                    smoothMove(targetPos, 100)  -- Default speed is 50
                    task.wait(0.1)
                end
            end
            
            
            
            -- Perform floating movement to target (Camaro)
            local function floatToTarget(targetPosition, speed)
                smoothMove(Vector3.new(targetPosition.X, hrp.Position.Y, targetPosition.Z), speed)
                wait(2)  -- Wait after floating
            end
            
            -- Move DOWN by a specific distance (drop)
            local function moveDown(dropDistance)
                local startPos = hrp.Position
                local targetPos = startPos - Vector3.new(0, dropDistance, 0)
                local dropSpeed = 350 -- studs per second
                local distance = (targetPos - startPos).Magnitude
                local duration = distance / dropSpeed
                local startTime = tick()
            
                while tick() - startTime < duration do
                    local alpha = (tick() - startTime) / duration
                    hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
                    task.wait()
                end
                hrp.CFrame = CFrame.new(targetPos)
            end
            
            
            -- Monitoring function for player coordinates
            local function monitorPlayerCoordinates()
                local allowedDeviation = 5  -- Allow a small deviation (10 studs)
                local lastPosition = hrp.Position
            
                while true do
                    task.wait(1)  -- Check every second
            
                    local currentPosition = hrp.Position
                    local deviation = (currentPosition - lastPosition).Magnitude
            
                    if deviation > allowedDeviation then
                        -- If player has deviated significantly, reset character
                        warn("Player is deviating from expected position. Resetting character...")
                        player:LoadCharacter()  -- Reset the player's character
                        lastPosition = hrp.Position  -- Reset the position tracking
                    end
                end
            end
            
            -- Float to coordinates (3197.66, 63.25, -4654.25)
            local function floatToSpecificCoords()
                -- Get current position of the player
                local currentPosition = hrp.Position
                -- Set the target coordinates
                local targetPosition = Vector3.new(3197.66, 63.25, -4654.25)
            
                -- Adjust the target position if it’s not matching exactly (this could be due to player’s current height or Z axis)
                local adjustedTarget = Vector3.new(targetPosition.X, currentPosition.Y, targetPosition.Z)
            
                -- Perform the float movement using smooth move
                smoothMove(adjustedTarget, 30)  -- Move at speed of 500
            end
            
            -- Main function to perform all actions
            local function performActions()
                
                
                humanoid.PlatformStand = true
            
                local upwardDistance = 100
                local upwardSpeed = 350 -- studs per second
                local startPos = hrp.Position
                local targetPos = startPos + Vector3.new(0, upwardDistance, 0)
                local duration = upwardDistance / upwardSpeed
                local startTime = tick()
            
                while tick() - startTime < duration do
                    local alpha = (tick() - startTime) / duration
                    hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
                    task.wait()
                end
                hrp.CFrame = CFrame.new(targetPos)
            
                -- Restore normal physics
                humanoid.PlatformStand = false
            
            
                -- Step 3: Find helicopter
                
                local speed = 50 -- Movement speed (studs per second)
                local minDistanceToStop = 3 -- Stop early if close enough
                
            
            
                
            
                -- Find the nearest "Heli"
                local function findNearestHeli()
                    local nearestHeli = nil
                    local minDistance = math.huge
                
                    for _, vehicle in pairs(workspace.Vehicles:GetChildren()) do
                        -- Check if vehicle name contains "Heli"
                        if vehicle.Name:find("Heli") then
                            print("Helicopter found:", vehicle.Name)
                            local seat = vehicle:FindFirstChild("Seat")
                            if seat then
                                local distance = (hrp.Position - seat.Position).Magnitude
                
                                if distance < minDistance then
                                    minDistance = distance
                                    nearestHeli = vehicle
                                end
                            end
                        else
                            -- Debug: Print non-"Heli" vehicles
                            print("Non-helicopter vehicle detected:", vehicle.Name)
                        end
                    end
                
                    return nearestHeli
                end
                
            
            
                
                -- Smoothly move player to the target position
                local function smoothMove(target)
                    local startPos = hrp.Position
                    local distance = (target - startPos).Magnitude
            
                    -- Stop early if already close
                    if distance < minDistanceToStop then return end
                    
                    local duration = distance / speed
                    local startTime = tick()
                
                    while tick() - startTime < duration do
                        local alpha = (tick() - startTime) / duration
                        hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
                        RunService.Heartbeat:Wait() -- Optimize for smooth movement
                    end
                
                    hrp.CFrame = CFrame.new(target) -- Final position adjustment
                end
                
                -- Attempt to enter the helicopter up to 3 times
                local function attemptEnterHeli(seat)
                    local attempts = 0
                    while attempts < 3 do
                        for _, v in pairs(CircleAction.Specs) do
                            if v.Part and v.Part == seat then
                                print("Attempting to enter the helicopter seat...")
                                v:Callback(true) -- Try entering the helicopter seat
                                attempts = attempts + 1
                                task.wait(1) -- Wait a second before retrying
                                if attempts >= 3 then
                                    print("Max attempts reached.")
                                    return
                                end
                            end
                        end
                        task.wait(0.5) -- Small delay before trying again
                    end
                end
                
                -- Move to the "Heli" and enter it
                local function moveToHeliAndEnter()
                    local heli = findNearestHeli()
                    
                    if heli and heli:FindFirstChild("Seat") then
                        local seat = heli.Seat
                        local targetPos = seat.Position + Vector3.new(0, 5, 0) -- Hover slightly above seat
                
                        print("Gliding towards the helicopter...")
                        smoothMove(targetPos)
                        task.wait(0.5) -- Small delay before entry
                
                        -- Attempt to enter the helicopter up to 3 times
                        attemptEnterHeli(seat)
                    else
                    warn("No heli found")
                    end
                end
            
            
            
            
            
            
            
                humanoid.PlatformStand = true
            
            
            
                for _, obj in ipairs(workspace:GetDescendants()) do
                    -- Remove all doors
                    if string.find(obj.Name:lower(), "door") then
                        obj:Destroy()
                    end
            
                    -- Remove all seats that are not part of cars
                    if obj:IsA("Seat") and not obj.Parent:FindFirstChild("VehicleSeat") then
                        obj:Destroy()
                    end
                end
                -- Your smooth movement function
                local function smoothMove(target)
                    local startPos = hrp.Position
                    local distance = (target - startPos).Magnitude
            
                    if distance < 1 then return end -- Stop if already close
            
                    local duration = distance / 50
                    local startTime = tick()
            
                    while tick() - startTime < duration do
                        local alpha = (tick() - startTime) / duration
                        hrp.CFrame = CFrame.new(startPos:Lerp(target, alpha))
                        RunService.Heartbeat:Wait()
                    end
            
                    hrp.CFrame = CFrame.new(target)
                end
            
                -- Use your movement method
                local function floatToTarget(targetPosition, speed)
                    smoothMove(Vector3.new(targetPosition.X, hrp.Position.Y, targetPosition.Z))
                    task.wait(2) -- Wait after floating
                end
                humanoid.PlatformStand = true
                -- Move the player up by 100 studs first, then move to the target
                local function moveUpAndThenFloat()
                    local upTarget = hrp.Position + Vector3.new(0, 100, 0) -- Move up by 100 studs
                    print("Moving up by 100 studs...")
                    smoothMove(upTarget) -- Move the player up
            
                    task.wait(1) -- Wait after moving up
            
                    -- Now move to the final target if the player is not seated
                    if not humanoid.SeatPart then
                        print("❌ Player is NOT seated! Floating to target...")
                        floatToTarget(Vector3.new(-1167, 65, -1563), 50)
                    else
                        print("✅ Player is seated. No movement needed.")
                    end
                end
            
                -- Run the move once
                task.wait(2) -- Allow character loading
                moveUpAndThenFloat()
            
                
            
            
            
                
                
            
            
                
                -- Run the script to move & enter the helicopter
                moveToHeliAndEnter()
                
            
            
            
                -- Step 5: Make helicopter rise 500 studs
                humanoid.PlatformStand = true
            
                local upwardDistance = 1000
                local upwardSpeed = 350 -- studs per second
                local startPos = hrp.Position
                local targetPos = startPos + Vector3.new(0, upwardDistance, 0)
                local duration = upwardDistance / upwardSpeed
                local startTime = tick()
            
                while tick() - startTime < duration do
                    local alpha = (tick() - startTime) / duration
                    hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
                    task.wait()
                end
                hrp.CFrame = CFrame.new(targetPos)
            
                -- Restore normal physics
                humanoid.PlatformStand = false
            
                -- Step 6: Float while in Camaro to coordinates (3000, 500, -4600)
                floatToTarget(Vector3.new(3000, 500, -4600), 350)  -- Speed set to 500
            
                -- Step 7: Drop down to coordinates (3000, 65, -4600)
                moveDown(955)  -- Drop 435 studs down
                task.wait(1)
                
            
                local player = game:GetService("Players").LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            
                -- Step 8: Float to coordinates (3106, 65, -4605)
                floatToTarget(Vector3.new(3106, 65, -4605), 50)  -- Speed set to 500
                task.wait(1)
                -- Step 9: Move up by 5 studs (add 5 studs in Y)
                smoothMove(Vector3.new(3106, 70, -4605), 50)
                task.wait(1)
                -- Step 10: Float to coordinates (3200, 70, -4605)
                floatToTarget(Vector3.new(3200, 70, -4605), 50)  -- Speed set to 500
                task.wait(1)
                -- Step 11: Float to coordinates (3197.66, 63.25, -4654.25)
                floatToSpecificCoords()
            end
            
            -- Start monitoring player coordinates in a separate thread
            spawn(monitorPlayerCoordinates)
            
            -- Perform all actions in sequence
            performActions()
        end
    end


    
    



    
    


    
    -- Run the script to move & enter the helicopter
    moveToHeliAndEnter()
    



    -- Step 5: Make helicopter rise 500 studs
    humanoid.PlatformStand = true

    local upwardDistance = 1000
    local upwardSpeed = 350 -- studs per second
    local startPos = hrp.Position
    local targetPos = startPos + Vector3.new(0, upwardDistance, 0)
    local duration = upwardDistance / upwardSpeed
    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        hrp.CFrame = CFrame.new(startPos:Lerp(targetPos, alpha))
        task.wait()
    end
    hrp.CFrame = CFrame.new(targetPos)

    -- Restore normal physics
    humanoid.PlatformStand = false

    -- Step 6: Float while in Camaro to coordinates (3000, 500, -4600)
    floatToTarget(Vector3.new(3000, 500, -4600), 350)  -- Speed set to 500

    -- Step 7: Drop down to coordinates (3000, 65, -4600)
    moveDown(955)  -- Drop 435 studs down
    task.wait(1)
    

    local player = game:GetService("Players").LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    -- Step 8: Float to coordinates (3106, 65, -4605)
    floatToTarget(Vector3.new(3106, 65, -4605), 50)  -- Speed set to 500
    task.wait(1)
    -- Step 9: Move up by 5 studs (add 5 studs in Y)
    smoothMove(Vector3.new(3106, 70, -4605), 50)
    task.wait(1)
    -- Step 10: Float to coordinates (3200, 70, -4605)
    floatToTarget(Vector3.new(3200, 70, -4605), 50)  -- Speed set to 500
    task.wait(1)
    -- Step 11: Float to coordinates (3197.66, 63.25, -4654.25)
    floatToSpecificCoords()
end

-- Start monitoring player coordinates in a separate thread
spawn(monitorPlayerCoordinates)

-- Perform all actions in sequence
performActions()
