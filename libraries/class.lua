local class = function(...)
	local super_classes = {...}
	local class = {}
	
	setmetatable(class, class)
	
	class.__index = function(t, k)
		if k == "init" or k == "new" then
			return nil	
		end
		
		local value = rawget(class, k)
		
		if value then
			t[k] = value
			return value
		end
		
		for i = 1, #super_classes do
			local super_class = super_classes[i]
			local value = super_class[k]
			
			if value then
				t[k] = value
				return value	
			end
		end
	end
	
	function class.new(...)
		local object = setmetatable({}, class)
		
		if class.init then
			class.init(object, ...)	
		end
		
		return object
	end
	
	return class
end

return class

--https://repl.it/Ln52/3  Old Version
--https://repl.it/repls/IdealisticHilariousOwl  New Version