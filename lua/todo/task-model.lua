Task = { description = "", is_complete = false, due_on = os.date() }

function Task:new(description, is_complete, due_on)
	local o = {}

	setmetatable(o, { __index = self })

	o.description = description

	if is_complete == nil then
		o.is_complete = false
	else
		o.is_complete = is_complete
	end

	if due_on == nil then
		o.due_on = os.date()
	else
		o.due_on = due_on
	end

	return o
end

function Task:ToRow()
	return self.description .. "|" .. tostring(self.is_complete) .. "|" .. self.due_on
end

function TaskFromRow(row)
	local items = {}
	for item in string.gmatch(row, "([^|]+)") do
		table.insert(items, item)
	end

	return Task:new(items[1], items[2], items[3])
end
