-- landscaping.lua
-- A landscaping and gardening service 

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

-- Define constants related to landscaping tasks
local WEED_PICKING = "Weed Picking"
local PRUNING = "Pruning"
local MULCHING = "Mulching"
local EDGING = "Edging"
local FERTILIZING = "Fertilizing"
local SOIL_TILLING = "Soil Tilling"

-------------------------------------------------------------------------------
-- Helper Functions
-------------------------------------------------------------------------------

-- A function to check if a task is related to landscaping
-- 
-- @param task - The task to check
--
-- @return true if the task is related to landscaping
--		   false otherwise
local function is_landscaping_task(task) 
	if task == WEED_PICKING or 
	   task == PRUNING or 
	   task == MULCHING or 
	   task == EDGING or 
	   task == FERTILIZING or 
	   task == SOIL_TILLING then
		return true
	end
	return false
end

-- A function to check if a landscaping task is complete
-- 
-- @param task - The task to check
--
-- @return true if the task is complete
--		   false otherwise
local function is_task_complete(task) 
	if task.status == "complete" then
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- Classes
-------------------------------------------------------------------------------

-- Define a class for landscaping tasks
local LandscapingTask = {}

-- Initialize a landscaping task
-- 
-- @param name - The name of the task
-- @param description - A description of the task
--
-- @return The newly initialized landscaping task
function LandscapingTask:new(name, description) 
	local tbl = {name = name, 
				 description = description,
				 status = "incomplete"}
	return setmetatable(tbl, {__index = LandscapingTask})
end

-- Mark a landscaping task as complete
function LandscapingTask:complete() 
	self.status = "complete"
end

-------------------------------------------------------------------------------
-- Landscaping and Gardening Service
-------------------------------------------------------------------------------

-- A closure for the service
local landscaping_service = (function() 
	local open = true
	local tasks = {}

	-- Add a landscaping task to the service
	-- 
	-- @param name - The name of the task
	-- @param description - A description of the task
	local function add_task(name, description)
		-- Only add if task is related to landscaping
		if is_landscaping_task(name) then 
			table.insert(tasks, LandscapingTask:new(name, description))
		end
	end

	-- Close the service
	-- 
	-- @return true if the service was successfully closed
	--		   false otherwise
	local function close_service() 
		-- Check if all tasks have been completed
		local all_completed = true
		for _, task in ipairs(tasks) do 
			if not is_task_complete(task) then 
				all_completed = false
				break
			end
		end

		if all_completed then 
			open = false
			return true
		end

		return false
	end

	-- Return the public methods of the service
	return {
		add_task = add_task, 
		close_service = close_service
	}
end)()

-- Usage

-- Add some tasks
landscaping_service.add_task(WEED_PICKING, "Pick weeds from flower beds.")
landscaping_service.add_task(EDGING, "Edge the flower beds.")
landscaping_service.add_task(MULCHING, "Put down fresh mulch in the flower beds.")

-- Mark the tasks as complete
for _, task in ipairs(tasks) do 
	task:complete()
end

-- Close the service
if landscaping_service.close_service() then 
	print("Landscaping and gardening service has been closed successfully.")
end