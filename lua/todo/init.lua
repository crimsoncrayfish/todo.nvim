local M = {}

M.DB = {}

M.setup = function()
	M.DB = require("todo.todo_db")
	M.DB.setup()
end

M.add = function(...)
	M.DB.append(...)
end

M.delete = function(...)
	M.DB.delete(...)
end

M.complete = function(...)
	M.DB.complete(...)
end

M.read = function()
	M.DB.print_state(false)
end
M.dbg = function()
	M.DB.print_state(true)
end

M.update = function()
	-- TODO: function to update a task
end

return M
