--CC Getopt-- by Admicos (os.loadAPI edition)

-- nil getopt.help(string programDescription, table optionsTable) !INTERNAL!
function help(desc, options)
	local helpStr = fs.getName(shell.getRunningProgram()) .. " -- " .. desc .. "\n"
	.. "USAGE: " .. fs.getName(shell.getRunningProgram()) .. " [options] [args]\n"

	for k, v in pairs(options) do
		helpStr = helpStr .. "\n--" .. k .. " (-" .. v[2] .. ")"
		if v[3] ~= nil then
			helpStr = helpStr .. " [" .. v[3] .. "]"
		end
		helpStr = helpStr .. ": " .. v[1]
	end

	textutils.pagedPrint(helpStr)
end

-- table or nil getopt.init(string programDescription, table optionsTable, table args)
-- NOTE: In optionsTable, you can't have --help or -h because getopt creates them for you.
function init(desc, options, args)
	local _resTbl = {}
	local _isArg = false
	local _optCnt = 1

	for i, v in ipairs(args) do
		if v == "-h" or v == "--help" then
			_resTbl = {}
			getopt.help(desc, options)

			return nil
		end

		if v:sub(1, 1) == "-" then
			for j, x in pairs(options) do
				if v == "--" .. j or v == "-" .. x[2] then
					if x[3] ~= nil then
						_resTbl[j] = args[i + 1]
						_isArg = true
					else
						_resTbl[j] = true
					end
				end
			end
		elseif not _isArg then
			_resTbl["opt-" .. _optCnt] = v
			_optCnt = _optCnt + 1
		else
			_isArg = false
		end
	end

	return _resTbl
end

-- Example Program:

-- os.loadAPI("getopt")
-- local _optionsExample = {
-- 	["color"] = {"Should it be colored", "c", nil},
-- 	["number"] = {"How many times should it print", "n", "num"},
-- }
--
-- local tbl = getopt.init("Prints text with color", _optionsExample, { ... })
--
-- if tbl ~= nil then
-- 	if tbl["color"] then term.setTextColor(colors.orange) end
-- 	for i = 1, tonumber(tbl["number"]) do
-- 		print(tbl["opt-1"])
-- 	end
-- end

--Valid example arguments: --number 5 -c hello world
