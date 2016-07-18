os.loadAPI("libCFG")

local args = {...}
local loadedConfig = {}

--aconf <config file> <modify/add/remove> <entry> [value]
if not (#args < 3) then
	fileName = args[1]
	operation = args[2]
	key = args[3]
	if args[4] then value = args[4] end

	if operation == "modify" then
		if fs.exists(fileName) then
			loadedConfig = libCFG.readConfig(fileName)
			if not loadedConfig[key] then
				print("Key doesn't exist.")
			else
				loadedConfig[key] = value
				libCFG.writeConfig(fileName, loadedConfig)
			end
		else
			print("Config file doesn't exist!")
		end
	elseif operation == "add" then
		if fs.exists(fileName) then
			loadedConfig = libCFG.readConfig(fileName)
			if loadedConfig[key] then
				print("Key already exists.")
			else
				loadedConfig[key] = value
				libCFG.writeConfig(fileName, loadedConfig)
			end
		else
			print("Config file doesn't exist!")
		end
	elseif operation == "remove" then
		if fs.exists(fileName) then
			loadedConfig = libCFG.readConfig(fileName)
			if not loadedConfig[key] then
				print("Key doesn't exist.")
			else
				loadedConfig[key] = nil
				libCFG.writeConfig(fileName, loadedConfig)
			end
		else
			print("Config file doesn't exist!")
		end
	end
else
	print(shell.getRunningProgram() .. " <config file> <modify/add/remove> <entry> [value]")
end
loadedConfig = nil
