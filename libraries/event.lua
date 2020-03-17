local event = {}

function event.add(name, id, func)
	local events = event[name]

	if not events then
		events = {}
		event[name] = events
	end
	
	events[id] = func or id

	return id
end

function event.remove(name, id)
	local events = event[name]
	
	if events then
		events[id] = nil	
	end
end

function event.run(name, ...)
	local events = event[name]

	if not events then
		return
	end

	for id, object in pairs(events) do
		if type(object) == "table" then
			local func = object[name]
			
			if func then
				func(object, ...)
			end
		else
			object(...)	
		end
	end
end

return event