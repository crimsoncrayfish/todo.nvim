local M = {}
require("todo.task-model")
M.tasks = {}

M.setup = function()
	M._read()
end

M.add = function(description, index)
	local newTask = Task:new(description)
	table.insert(M.tasks, index, newTask)
	M._save_state()
end

M.append = function(description)
	local newTask = Task:new(description)
	M.tasks[#M.tasks + 1] = newTask
	M._save_state()
	newTask = nil
end
M.delete = function(index)
	table.remove(M.tasks, index)
	M._save_state()
end

M.complete = function(index)
	local updated = M.tasks[index]
	updated.is_complete = true
	M.tasks[index] = updated
	M._save_state()
end

M.update = function()
	-- TODO: function to update a task
end

M.print_count = function()
	print(#M.tasks)
end

M.print_state = function(raw)
	if raw then
		P(M.tasks)
		return
	end
	local rows = {}
	for _, value in ipairs(M.tasks) do
		table.insert(rows, Task.ToRow(value))
	end
	P(rows)
end

M._save_state = function()
	local rows = {}
	for _, v in ipairs(M.tasks) do
		table.insert(rows, v:ToRow())
	end
	M._write(rows)
end

M._read = function()
	if M._file_exists(M._get_location()) then
		for line in io.lines(M._get_location()) do
			M.tasks[#M.tasks + 1] = TaskFromRow(line)
		end
	else
		M.tasks = {}
	end
end

M._write = function(rows)
	local f = io.open(M._get_location(), "w")
	if f == nil then
		print("failed to open/create file")
		return
	end
	for _, v in next, rows do
		local _, err = f:write(v .. "\n")
		if err ~= nil then
			print("failed to write to file")
			print(err)
			return
		end
	end
	f:close()
end

M._get_location = function()
	return vim.fn.stdpath("data") .. "/todo/db.json"
end

M._file_exists = function(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

return M
